class Kf5Khtml < Formula
  desc "KHTML APIs"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.44/portingAids/khtml-5.44.0.tar.xz"
  sha256 "f7f5b8d64e93815a65a4491b7bb5deb4846357e815c168d4310060ee1848f0ea"

  head "git://anongit.kde.org/khtml.git"

  depends_on "cmake" => :build
  depends_on "gperf" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "openssl@1.1"
  depends_on "jpeg"
  depends_on "giflib"
  depends_on "libpng"
  depends_on "zlib"
  depends_on "KDE-mac/kde/kf5-kjs"
  depends_on "KDE-mac/kde/kf5-kparts"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end

  def caveats; <<~EOS
    You need to take some manual steps in order to make this formula work:
      ln -sf "$(brew --prefix)/share/kf5" "$HOME/Library/Application Support"
      ln -sf "$(brew --prefix)/share/kservices5" "$HOME/Library/Application Support"
    EOS
  end
end
