# This module is NOT imported into the NixOS config,
# it is only used by the agenix CLI to determine which
# keys to use to encrypt secrets.
let
  # my public key
  users = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDVcLPqZWtV/+YikTyOrZWzCfNnD7aDN6RAXyQ5789n6QpPEL5l8pdSqjgbEEKA70MJc9zhNHrJ2pxnzN+mLvDvNx/MfiMiYOIM+KBVSkq7c+8tm6dVaBvzZ0qWRp9xBidVK7+jS8MfTOjqGIVF9uLLit8v6eNK7ZCqXHHaTyWuVucbmWk0DA0FLEfY8GYs23J+zbR/K9eHgP4rCIs6jbSubCatNXx2a4/IwwyDZIzN7Hdzc9PdzyDFLRw62Bf5EXpeAwJEJ5iQBe1r223+1mCdas1W3OJQ8vM1BZTR3+CMS55afTNlZ7qiQ/PT6efUxAvYuPWnzzq3wT23AttfyB5gAGB4E/mZeEnKABd/DvYvzJWms/upZYbocB8iurYVoTVIAVTQT+q9+KYpqLgsCLNHJAIkWjVzejayXIW0r4dIXr7W3OTy+ZxrNN+CpowtlWy3C0WPn44lW1lQaArn4uzVm7Yrzc8O9gFZYKbhLFElCxts2LXOS9ZKgoqCkt/bafE= se7en@nixos"
  ];
  # server host key
  systems = [ "" ];
in {
  "mullvad_wireguard.age".publicKeys = users ++ systems;
  "homepage.age".publicKeys = users ++ systems;
  "wireguard_server.age".publicKeys = users ++ systems;
}
