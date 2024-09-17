class CondaAutoenv < Formula
    desc "Automatically manage conda environments based on .condaenv files"
    homepage "https://github.com/leopoldw/conda-autoenv"
    url "https://github.com/leopoldw/conda-autoenv/archive/v1.1.0.tar.gz"
    sha256 "replace_with_actual_sha256_after_uploading"
    license "MIT"
  
    def install
      system "./preinstall.sh" or odie "Pre-installation script failed. Aborting installation!"

      bin.install "conda-autoenv.sh"
    chmod "+x", bin/"conda-autoenv.sh"
    end
  
    # def caveats
    #   <<~EOS
    #     To enable conda-autoenv, add the following to your shell configuration file:
  
    #     if [ -f "$(brew --prefix)/opt/conda-autoenv/libexec/conda-autoenv.sh" ]; then
    #       source "$(brew --prefix)/opt/conda-autoenv/libexec/conda-autoenv.sh"
    #     fi
  
    #     Restart your shell or run `source ~/.bashrc` (or `~/.zshrc` for zsh) to apply the changes.
    #   EOS
    # end
  
    # test do
    #   assert_match "conda-autoenv version 1.1.0", shell_output("#{bin}/conda-autoenv --version")
    # end
  end
  