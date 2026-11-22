cask "duet" do
  version "0.3.0"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  url "https://github.com/EricMarcantonio/duet/releases/download/v#{version}/Duet-macOS.zip",
      verified: "github.com/EricMarcantonio/duet/"
  name "Duet"
  desc "Play audio on two pairs of Bluetooth headphones, each with its own volume"
  homepage "https://github.com/EricMarcantonio/duet"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  app "Duet.app"

  uninstall quit: "app.duet.Duet"

  zap trash: [
    "~/Library/Application Support/Duet",
    "~/Library/Caches/app.duet.Duet",
    "~/Library/Logs/Duet",
    "~/Library/WebKit/app.duet.Duet",
  ]

  caveats <<~EOS
    Duet is not notarized: the first launch needs right-click › Open, or
    System Settings › Privacy & Security › Open Anyway.
    Allow Bluetooth access when macOS asks, or Duet can't see your headphones.
  EOS
end
