# SPDX-License-Identifier: AGPL-3.0-or-later
# Copyright (C) 2026 Gamunu Balagalla

cask "smudge" do
  version "0.2.0"
  sha256 "0c6c3d9604e96c3a07c639b0e0b5c1d6f8455db1fcbfc55bfd5cc67147911713"

  url "https://github.com/gamunu/smudge/releases/download/v#{version}/smudge-#{version}.pkg"
  name "Smudge"
  desc "HP printer driver built from HPLIP, with a status and maintenance app"
  homepage "https://github.com/gamunu/smudge"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :tahoe

  pkg "smudge-#{version}.pkg"

  uninstall launchctl: "io.github.gamunu.smudge.firmware",
            pkgutil:   "io.github.gamunu.smudge",
            delete:    [
              "/Applications/Smudge.app",
              "/Library/LaunchDaemons/io.github.gamunu.smudge.firmware.plist",
              "/Library/Printers/smudge",
              "/Library/Printers/PPDs/Contents/Resources/HP DeskJet 2300 series (Smudge).ppd.gz",
              "/Library/Printers/PPDs/Contents/Resources/smudge",
            ]

  zap trash: [
    "~/Library/Caches/io.github.gamunu.smudge",
    "~/Library/HTTPStorages/io.github.gamunu.smudge",
    "~/Library/Preferences/io.github.gamunu.smudge.plist",
  ]

  caveats <<~EOS
    Add the printer in System Settings > Printers & Scanners and set Use
    to the "..., Smudge" driver. Printer queues are not removed on
    uninstall; remove them with: sudo lpadmin -x <queue name>
  EOS
end
