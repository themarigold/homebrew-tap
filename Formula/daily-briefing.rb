class DailyBriefing < Formula
  desc "Resumption-focused morning briefing from your local git history, BYO AI"
  homepage "https://github.com/themarigold/daily-briefing"
  version "0.1.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/themarigold/daily-briefing/releases/download/v0.1.1/daily-briefing-darwin-arm64"
      sha256 "47c079d043f32476fc951e2188e71326e4f9f1474584b1cc61e8b9092decec62"
    end
    on_intel do
      url "https://github.com/themarigold/daily-briefing/releases/download/v0.1.1/daily-briefing-darwin-x64"
      sha256 "050d2f3462ed6bb5bff60fdbeea801e099936662ef2c65af6327d152229d0640"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/themarigold/daily-briefing/releases/download/v0.1.1/daily-briefing-linux-arm64"
      sha256 "95c3df123f12003020c1ec58e6887f7d662b9683b27a7881a60e951d4f537e82"
    end
    on_intel do
      url "https://github.com/themarigold/daily-briefing/releases/download/v0.1.1/daily-briefing-linux-x64"
      sha256 "2ab263b3548f54f66a1c370f4e240914137c2c25e8719673156bf6a48cfe9ab4"
    end
  end

  def install
    binary = Dir["daily-briefing-*"].first
    bin.install binary => "daily-briefing"
  end

  test do
    assert_equal "0.1.1", shell_output("#{bin}/daily-briefing --version").strip
  end
end
