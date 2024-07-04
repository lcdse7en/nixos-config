{ pkgs, ... }:
let
in
{
  logoutlaunch = pkgs.writeShellScriptBin "logoutlauch" ''
    #// Check if wlogout is already running
    if pgrep -x "wlogout" > /dev/null
    then
        pkill -x "wlogout"
        exit 0
    fi

    #// set file variables

    scrDir=`dirname "$(realpath "$0")"`
    source $scrDir/globalcontrol.sh
    [ -z "${1}" ] || wlogoutStyle="${1}"
    wLayout="${confDir}/wlogout/layout_${wlogoutStyle}"
    wlTmplt="${confDir}/wlogout/style_${wlogoutStyle}.css"

    if [ ! -f "${wLayout}" ] || [ ! -f "${wlTmplt}" ] ; then
        echo "ERROR: Config ${wlogoutStyle} not found..."
        wlogoutStyle=1
        wLayout="${confDir}/wlogout/layout_${wlogoutStyle}"
        wlTmplt="${confDir}/wlogout/style_${wlogoutStyle}.css"
    fi

    #// detect monitor res

    x_mon=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .width')
    y_mon=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .height')
    hypr_scale=$(hyprctl -j monitors | jq '.[] | select (.focused == true) | .scale' | sed 's/\.//')

    #// scale config layout and style

    case "${wlogoutStyle}" in
        1)  wlColms=6
            export mgn=$(( y_mon * 28 / hypr_scale ))
            export hvr=$(( y_mon * 23 / hypr_scale )) ;;
        2)  wlColms=2
            export x_mgn=$(( x_mon * 35 / hypr_scale ))
            export y_mgn=$(( y_mon * 25 / hypr_scale ))
            export x_hvr=$(( x_mon * 32 / hypr_scale ))
            export y_hvr=$(( y_mon * 20 / hypr_scale )) ;;
    esac

    #// scale font size

    export fntSize=$(( y_mon * 2 / 100 ))

    #// detect wallpaper brightness

    [ -f "${cacheDir}/wall.dcol" ] && source "${cacheDir}/wall.dcol"
    [ "${dcol_mode}" == "dark" ] && export BtnCol="white" || export BtnCol="black"

    #// eval hypr border radius

    export active_rad=$(( hypr_border * 5 ))
    export button_rad=$(( hypr_border * 8 ))

    #// eval config files

    wlStyle="$(envsubst < $wlTmplt)"

    #// launch wlogout

    wlogout -b "${wlColms}" -c 0 -r 0 -m 0 --layout "${wLayout}" --css <(echo "${wlStyle}") --protocol layer-shell
  '';
  cliphist = pkgs.writeShellScriptBin "cliphist" ''
    #// set variables

    scrDir=$(dirname "$(realpath "$0")")
    source $scrDir/globalcontrol.sh
    roconf="${confDir}/rofi/clipboard.rasi"

    #// set rofi scaling

    [[ "${rofiScale}" =~ ^[0-9]+$ ]] || rofiScale=10
    r_scale="configuration {font: \"JetBrainsMono Nerd Font ${rofiScale}\";}"
    wind_border=$((hypr_border * 3 / 2))
    elem_border=$([ $hypr_border -eq 0 ] && echo "5" || echo $hypr_border)

    #// evaluate spawn position

    readarray -t curPos < <(hyprctl cursorpos -j | jq -r '.x,.y')
    readarray -t monRes < <(hyprctl -j monitors | jq '.[] | select(.focused==true) | .width,.height,.scale,.x,.y')
    readarray -t offRes < <(hyprctl -j monitors | jq -r '.[] | select(.focused==true).reserved | map(tostring) | join("\n")')
    monRes[2]="$(echo "${monRes[2]}" | sed "s/\.//")"
    monRes[0]="$(( ${monRes[0]} * 100 / ${monRes[2]} ))"
    monRes[1]="$(( ${monRes[1]} * 100 / ${monRes[2]} ))"
    curPos[0]="$(( ${curPos[0]} - ${monRes[3]} ))"
    curPos[1]="$(( ${curPos[1]} - ${monRes[4]} ))"

    if [ "${curPos[0]}" -ge "$((${monRes[0]} / 2))" ] ; then
        x_pos="east"
        x_off="-$(( ${monRes[0]} - ${curPos[0]} - ${offRes[2]} ))"
    else
        x_pos="west"
        x_off="$(( ${curPos[0]} - ${offRes[0]} ))"
    fi

    if [ "${curPos[1]}" -ge "$((${monRes[1]} / 2))" ] ; then
        y_pos="south"
        y_off="-$(( ${monRes[1]} - ${curPos[1]} - ${offRes[3]} ))"
    else
        y_pos="north"
        y_off="$(( ${curPos[1]} - ${offRes[1]} ))"
    fi

    r_override="window{location:${x_pos} ${y_pos};anchor:${x_pos} ${y_pos};x-offset:${x_off}px;y-offset:${y_off}px;border:${hypr_width}px;border-radius:${wind_border}px;} wallbox{border-radius:${elem_border}px;} element{border-radius:${elem_border}px;}"

    #// clipboard action

    case "${1}" in
    c|-c|--copy)
        cliphist list | rofi -dmenu -theme-str "entry { placeholder: \"Copy...\";}" -theme-str "${r_scale}" -theme-str "${r_override}" -config "${roconf}" | cliphist decode | wl-copy
        ;;
    d|-d|--delete)
        cliphist list | rofi -dmenu -theme-str "entry { placeholder: \"Delete...\";}" -theme-str "${r_scale}" -theme-str "${r_override}" -config "${roconf}" | cliphist delete
        ;;
    w|-w|--wipe)
        if [ $(echo -e "Yes\nNo" | rofi -dmenu -theme-str "entry { placeholder: \"Clear Clipboard History?\";}" -theme-str "${r_scale}" -theme-str "${r_override}" -config "${roconf}") == "Yes" ] ; then
            cliphist wipe
        fi
        ;;
    *)
        echo -e "cliphist.sh [action]"
        echo "c -c --copy    :  cliphist list and copy selected"
        echo "d -d --delete  :  cliphist list and delete selected"
        echo "w -w --wipe    :  cliphist wipe database"
        exit 1
        ;;
    esac
  '';
  wbarconfgen = pkgs.writeShellScriptBin "wbarconfgen" ''
    # read control file and initialize variables

    export scrDir="$(dirname "$(realpath "$0")")"
    source "${scrDir}/globalcontrol.sh"
    waybar_dir="${confDir}/waybar"
    modules_dir="$waybar_dir/modules"
    conf_file="$waybar_dir/config.jsonc"
    conf_ctl="$waybar_dir/config.ctl"

    readarray -t read_ctl < $conf_ctl
    num_files="${#read_ctl[@]}"
    switch=0

    # update control file to set next/prev mode

    if [ $num_files -gt 1 ]
    then
        for (( i=0 ; i<$num_files ; i++ ))
        do
            flag=`echo "${read_ctl[i]}" |
    cut - d '|' - f 1`
    if [ $flag -eq 1 ] && [ "$1" == "n" ];
  then
  nextIndex = $
    (((i + 1) % $num_files))
      switch=1
  break;

  elif [ $flag -eq 1 ] && [ "$1" == "p" ] ; then
  nextIndex = $
    ((i - 1))
      switch=1
  break;
  fi
    done
    fi

    if [ $switch -eq 1 ] ; then
    update_ctl = "${read_ctl[nextIndex]}"
    reload_flag=1
  sed -i "s/^1/0/g" $conf_ctl
  awk -F '|' -v cmp="$update_ctl" '{OFS=FS} {if($0==cmp) $1=1;
  print$0}' $conf_ctl > $waybar_dir/tmp && mv $waybar_dir/tmp $conf_ctl
  fi

  # overwrite config from header module

  export set_sysname = `hostnamectl hostname`
    export
    w_position=`grep '^1|' $conf_ctl | cut -d '|' -f 3`

  case ${w_position} in
  left) export hv_pos="width";
  export r_deg = 90;
  ;
  right) export hv_pos = "width";
  export r_deg = 270;
  ;
  *) export hv_pos = "height";
  export r_deg = 0;
  ;
  esac

    export w_height = `grep '^1|' $conf_ctl | cut - d '|' - f 2`
    if [ -z $w_height ];
  then
  y_monres = `cat /sys/class/drm/ * /modes | head - 1 | cut - d 'x' - f 2`
    export
    w_height=$(( y_monres*2/100 ))
  fi

  export i_size=$(( w_height*6/10 ))
  if [ $i_size -lt 12 ];
  then
  export i_size = "12"
    fi

    export
    i_theme="$(grep 'gsettings set org.gnome.desktop.interface icon-theme' "${hydeThemeDir}/hypr.theme" | awk -F "'" '{print $((NF - 1))}')"
  export i_task=$(( w_height*6/10 ))
  if [ $i_task -lt 16 ];
  then
  export i_task = "16"
    fi

    envsubst < $modules_dir/header.jsonc > $conf_file

  # module generator function

  gen_mod()
  {
  local pos=$1
  local col=$2
  local mod=""

  mod=`grep '^1|' $conf_ctl | cut -d '|' -f ${col}`
  mod="${mod//(/"custom/l_end"}"
  mod="${mod//)/"custom/r_end"}"
  mod="${mod//[/"custom/sl_end"}"
  mod="${mod//]/"custom/sr_end"}"
  mod="${mod//\{/"custom/rl_end"}"
    mod="${mod//\}/"custom/rr_end"}"
  mod="${mod// /"\",\""}"

  echo -e "\t\"modules-${pos}\": [\"custom/padd\",\"${mod}\",\"custom/padd\"]," >> $conf_file
  write_mod=`echo $write_mod $mod`
  }

  # write positions for modules

  echo -e "\n\n// positions generated based on config.ctl //\n" >> $conf_file
  gen_mod left 4
  gen_mod center 5
  gen_mod right 6

  # copy modules/*.jsonc to the config

  echo -e "\n\n// sourced from modules based on config.ctl //\n" >> $conf_file
  echo "$write_mod" | sed 's/","/\n/g;
  s/ /\n/g' | awk -F '/' '{print $NF}' | awk -F '#' '{print $1}' | awk '!x[$0]++' | while read mod_cpy
  do
  if [ -f $modules_dir/$mod_cpy.jsonc ] ; then
  envsubst < $modules_dir/$mod_cpy.jsonc >> $conf_file
  fi
  done

  cat $modules_dir/footer.jsonc >> $conf_file

  # generate style

  $scrDir/wbarstylegen.sh

  # restart waybar

  if [ "$reload_flag" == "1" ] ; then
  killall waybar
  waybar --config ${waybar_dir}/config.jsonc --style ${waybar_dir}/style.css > /dev/null 2>&1 &
  fi
  '';

  themeswitch = pkgs.writeShellScriptBin "themeswitch" ''
  #// set variables

  scrDir = "$(dirname "$(realpath "$0") ")"
    source "${scrDir}/globalcontrol.sh"
    [ -z "${hydeTheme}" ] && echo "ERROR: unable to detect theme" && exit 1
    get_themes

    #// define functions

    Theme_Change
    ()
      {
        local x_switch = $1
          for
          i in ${!thmList[@]};
        do
          if [ "${thmList[i]}" == "${hydeTheme}" ] ; then
          if [ "${x_switch}" == 'n' ] ; then
          setIndex = $(
          ((i + 1) % ${#thmList[@]} ))
            elif [ "${x_switch}" == 'p' ] ; then
        setIndex=$(( i - 1 ))
        fi
        themeSet="${thmList[setIndex]}"
        break
        fi
        done
        }

        #// evaluate options

        while getopts "nps:" option;
        do
          case $option in

          n ) # set next theme
          Theme_Change n
          export xtrans = "grow";
        ;

        p ) # set previous theme
        Theme_Change p
        export xtrans = "outer";
        ;

        s ) # set selected theme
        themeSet = "$OPTARG";
        ;

        * ) # invalid option
        echo "... invalid option ..."
        echo "$(basename "${0}") -[option]"
        echo "n : set next theme"
        echo "p : set previous theme"
        echo "s : set input theme"
        exit 1 ;;
        esac
        done

        #// update control file

        if ! $(echo "${thmList[@]}" | grep -wq "${themeSet}") ; then
        themeSet = "${hydeTheme}"
          fi

          set_conf "hydeTheme" "${themeSet}"
          echo ":: applying theme :: \"${themeSet}\""
          export
          reload_flag=1
        source "${scrDir}/globalcontrol.sh"

        #// hypr

        sed '1d' "${hydeThemeDir}/hypr.theme" > "${confDir}/hypr/themes/theme.conf"
        gtkTheme="$(grep 'gsettings set org.gnome.desktop.interface gtk-theme' "${hydeThemeDir}/hypr.theme" | awk -F "'" '{print $((NF - 1))}')"
        gtkIcon="$(grep 'gsettings set org.gnome.desktop.interface icon-theme' "${hydeThemeDir}/hypr.theme" | awk -F "'" '{print $((NF - 1))}')"

        #// qtct

        sed -i "/^icon_theme=/c\icon_theme=${gtkIcon}" "${confDir}/qt5ct/qt5ct.conf"
        sed -i "/^icon_theme=/c\icon_theme=${gtkIcon}" "${confDir}/qt6ct/qt6ct.conf"

        #// gtk3

        sed -i "/^gtk-theme-name=/c\gtk-theme-name=${gtkTheme}" $confDir/gtk-3.0/settings.ini
        sed -i "/^gtk-icon-theme-name=/c\gtk-icon-theme-name=${gtkIcon}" $confDir/gtk-3.0/settings.ini

        #// gtk4

        if [ -d /run/current-system/sw/share/themes ];
        then
        themeDir = /run/current-system/sw/share/themes
          else
          themeDir=~/.themes
          fi
          rm -rf "${confDir}/gtk-4.0"
          ln -s "${themeDir}/${gtkTheme}/gtk-4.0" "${confDir}/gtk-4.0"

          #// flatpak GTK

          if pkg_installed flatpak;
        then
        if [ "${enableWallDcol}" -eq 0 ] ; then
        flatpak --user override --env = GTK_THEME="${gtkTheme}"
        flatpak --user override --env=ICON_THEME="${gtkIcon}"
        else
        flatpak --user override --env=GTK_THEME="Wallbash-Gtk"
        flatpak --user override --env=ICON_THEME="${gtkIcon}"
        fi
        fi

        #// wallpaper

        "${scrDir}/swwwallpaper.sh" -s "$(readlink "${hydeThemeDir}/wall.set")"
        '';
}
