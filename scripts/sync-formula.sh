#!/usr/bin/env bash
# Regenerates Formula/daily-briefing.rb from the latest daily-briefing release.
# Zero-credential by design: reads the PUBLIC release API, writes only this repo.
# Idempotent — exits 0 with no change when the formula already matches.
set -euo pipefail
cd "$(dirname "$0")/.."

REPO="norn-app/daily-briefing"
TAG=$(curl -fsSL "https://api.github.com/repos/$REPO/releases/latest" | sed -n 's/.*"tag_name": *"\([^"]*\)".*/\1/p' | head -1)
[ -n "$TAG" ] || { echo "could not resolve latest release tag" >&2; exit 1; }
VERSION="${TAG#v}"

SUMS=$(curl -fsSL "https://github.com/$REPO/releases/download/$TAG/SHA256SUMS")
sha() { echo "$SUMS" | grep " daily-briefing-$1\$" | awk '{print $1}'; }
for p in darwin-arm64 darwin-x64 linux-arm64 linux-x64; do
  [ -n "$(sha "$p")" ] || { echo "missing $p in SHA256SUMS for $TAG" >&2; exit 1; }
done

cat > Formula/daily-briefing.rb <<RUBY
class DailyBriefing < Formula
  desc "Resumption-focused morning briefing from your local git history, BYO AI"
  homepage "https://github.com/$REPO"
  version "$VERSION"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/$REPO/releases/download/$TAG/daily-briefing-darwin-arm64"
      sha256 "$(sha darwin-arm64)"
    end
    on_intel do
      url "https://github.com/$REPO/releases/download/$TAG/daily-briefing-darwin-x64"
      sha256 "$(sha darwin-x64)"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/$REPO/releases/download/$TAG/daily-briefing-linux-arm64"
      sha256 "$(sha linux-arm64)"
    end
    on_intel do
      url "https://github.com/$REPO/releases/download/$TAG/daily-briefing-linux-x64"
      sha256 "$(sha linux-x64)"
    end
  end

  def install
    binary = Dir["daily-briefing-*"].first
    bin.install binary => "daily-briefing"
  end

  test do
    assert_equal "$VERSION", shell_output("#{bin}/daily-briefing --version").strip
  end
end
RUBY
ruby -c Formula/daily-briefing.rb >/dev/null
echo "formula now at $VERSION"
