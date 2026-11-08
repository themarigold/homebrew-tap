class DailyBriefing < Formula
  desc "Resumption-focused morning briefing from your local git history, BYO AI"
  homepage "https://github.com/norn-app/daily-briefing"
  version "0.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/norn-app/daily-briefing/releases/download/v0.3.0/daily-briefing-darwin-arm64"
      sha256 "486889c60cffd670da1d508272e940a068c842afac6877c75c470123d001c874"
    end
    on_intel do
      url "https://github.com/norn-app/daily-briefing/releases/download/v0.3.0/daily-briefing-darwin-x64"
      sha256 "79c3025f6249895897a43ea3de15f71a4b5eacd8ca65929c76fe3d8f2af9c4d4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/norn-app/daily-briefing/releases/download/v0.3.0/daily-briefing-linux-arm64"
      sha256 "59ba7e54dc8cfa7524cb14e258d5127597d469716f4f08f136fddc37bec04da0"
    end
    on_intel do
      url "https://github.com/norn-app/daily-briefing/releases/download/v0.3.0/daily-briefing-linux-x64"
      sha256 "26824940c3194e3952a0e85f9ed9275341202ad996cabab8131a8399126e77c7"
    end
  end

  def install
    binary = Dir["daily-briefing-*"].first
    bin.install binary => "daily-briefing"
  end

  test do
    assert_equal "0.3.0", shell_output("#{bin}/daily-briefing --version").strip
  end
end
