Step 2. Installing nix-darwin

Instead of using darwin-installer, you can just run darwin-rebuild switch to install nix-darwin. As darwin-rebuild won't be installed in your PATH yet, you can use the following command:

nix run nix-darwin -- switch --flake ~/.config/nix-darwin

Step 3. Using nix-darwin

After installing, you can run darwin-rebuild to apply changes to your system:

darwin-rebuild switch --flake ~/.config/nix-darwin

https://nix-community.github.io/home-manager/options.xhtml

https://daiderd.com/nix-darwin/manual/index.html#opt-homebrew.onActivation

