
# To learn more about how to use Nix to configure your environment,
# see: https://developers.google.com/idx/guides/customize-idx-env
{ pkgs, ... }: {
  # Which nixpkgs channel to use.
  channel = "stable-24.05"; # or "unstable"

  # Use https://search.nixos.org/packages to find packages
  packages = [
    pkgs.nodejs_20
    pkgs.nodePackages.nodemon
    pkgs.flutter
    pkgs.clang
    pkgs.cmake
    pkgs.ninja-build
    pkgs.pkg-config
    pkgs.libgtk-3-dev
  ];

  # Sets environment variables in the workspace
  env = {};

  idx = {
    # Search for the extensions you want on https://open-vsx.org/ and use "publisher.id"
    extensions = [
      # "vscodevim.vim"
    ];

    # Enable previews
    previews = {
      enable = true;
      previews = {
        web = {
          # Run "flutter run -d web --web-port $PORT" and show it in IDX's web preview panel
          command = [
            "flutter"
            "run"
            "-d"
            "web"
            "--web-port"
            "$PORT"
          ];
          manager = "web";
          env = {
            # Environment variables to set for your server
            PORT = "$PORT";
          };
        };
      };
    };

    # Workspace lifecycle hooks
    workspace = {
      # Runs when a workspace is first created
      onCreate = {
        # Install dependencies and build web app
        flutter-pub-get = "flutter pub get";
        flutter-build-web = "flutter build web --release";
      };

      # Runs when the workspace is (re)started
      onStart = {
        # Start the flutter web
        flutter-run-web = "flutter run -d web";
      };
    };
  };
}