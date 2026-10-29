# SPDX-License-Identifier: AGPL-3.0-or-later
# Copyright (C) 2026 Gamunu Balagalla

cask "smudge" do
  version "0.1.0"
  sha256 "990dc664c95eaacaeec82a93de474bf60afe5ddcf2a9632108acae5595c152a9"

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

  uninstall pkgutil: "io.github.gamunu.smudge",
            delete:  [
              "/Applications/Smudge.app",
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
