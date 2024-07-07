{ inputs, pkgs, ... }:
pkgs.mkShell {
  buildInputs = with pkgs; [ cargo rustup rustc toolchain rust-analyzer ];

}
