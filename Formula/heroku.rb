require "language/node"

class Heroku < Formula
  desc "Command-line client for the cloud PaaS"
  homepage "https://cli.heroku.com"
  # heroku should only be updated every 10 releases on multiples of 10
  url "https://registry.npmjs.org/heroku/-/heroku-7.0.40.tgz"
  sha256 "a3ea3dec224e1e9dce60f286d2effe6ab01ac2df146b60215b07617368b2300a"
  head "https://github.com/heroku/cli.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "c9e504fdb3f98211324ce56dec0ec7e03d7bb66b21ff4539183aa9b116accd33" => :high_sierra
    sha256 "8bcbd972991ed3481a82763373a5f7f810e473941e4210f2228fceb3e4a200be" => :sierra
    sha256 "b5bdccdb857e161b3583952933fb0022b661b07f4a4a3409ec16f4ea6914cddf" => :el_capitan
  end

  depends_on "node"

  def install
    inreplace "bin/run", "#!/usr/bin/env node",
                         "#!#{Formula["node"].opt_bin}/node"
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    system bin/"heroku", "version"
  end
end
