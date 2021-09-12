class GroovyAT2 < Formula
  desc "Java-based scripting language"
  homepage "https://www.groovy-lang.org/"
  url "https://groovy.jfrog.io/ui/api/v1/download?repoKey=dist-release-local&path=groovy-zips%252Fapache-groovy-binary-2.5.9.zip"
  # url "https://groovy.jfrog.io/native/dist-release-local/groovy-zips/apache-groovy-binary-2.5.9.zip"
  sha256 "fea7dc321a3029c47ffa4aa165055d2bcc78bc280fac4e70ac131c717e45b89b"

  livecheck do
    url "https://groovy.jfrog.io/artifactory/dist-release-local/groovy-zips/"
    regex(/href=.*?apache-groovy-binary[._-]v?(\d+(?:\.\d+)+)\.zip/i)
  end

  bottle :unneeded

  keg_only :versioned_formula

  # Groovy 2.5 requires JDK8+ to build and JDK7 is the minimum version of the JRE that we support.
  depends_on "openjdk@8"

  def install
    # Don't need Windows files.
    rm_f Dir["bin/*.bat"]

    libexec.install "bin", "conf", "lib"
    bin.install_symlink Dir["#{libexec}/bin/*"] - ["#{libexec}/bin/groovy.ico"]
  end

  def caveats
    <<~EOS
      You should set GROOVY_HOME:
        export GROOVY_HOME=#{opt_libexec}
    EOS
  end

  test do
    system "#{bin}/grape", "install", "org.activiti", "activiti-engine", "5.16.4"
  end
end