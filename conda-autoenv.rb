class CondaAutoenv < Formula
    desc "Ensure the correct conda environment is activated based on .condaenv files"
    homepage "https://github.com/leopoldw/conda-autoenv"
    url "https://github.com/leopoldw/conda-autoenv/archive/v1.1.0.tar.gz"
    sha256 "replace_with_actual_sha256_after_uploading"
    license "MIT"
  
    def install
      system "./preinstall.sh" or odie "Pre-installation script failed. Aborting installation!"

      bin.install "conda-autoenv.sh"
    chmod "+x", bin/"conda-autoenv.sh"
    end

  end
  