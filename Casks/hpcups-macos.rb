# SPDX-License-Identifier: AGPL-3.0-or-later
# Copyright (C) 2026 Gamunu Balagalla

cask "hpcups-macos" do
  version "0.1.0"
  sha256 "990dc664c95eaacaeec82a93de474bf60afe5ddcf2a9632108acae5595c152a9"

  url "https://github.com/gamunu/hpcups-macos/releases/download/v#{version}/hpcups-macos-#{version}.pkg"
  name "hpcups-macos"
  desc "HP printer driver built from HPLIP, with a status and maintenance app"
  homepage "https://github.com/gamunu/hpcups-macos"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :tahoe

  pkg "hpcups-macos-#{version}.pkg"

  uninstall pkgutil: "io.github.hpcups-macos",
            delete:  [
              "/Applications/hpcups Status.app",
              "/Library/Printers/hpcups-macos",
              "/Library/Printers/PPDs/Contents/Resources/HP DeskJet 2300 series (hpcups-macos).ppd.gz",
              "/Library/Printers/PPDs/Contents/Resources/hpcups-macos",
            ]

  zap trash: [
    "~/Library/Caches/io.github.gamunu.hpcups-status",
    "~/Library/HTTPStorages/io.github.gamunu.hpcups-status",
    "~/Library/Preferences/io.github.gamunu.hpcups-status.plist",
  ]

  caveats <<~EOS
    Add the printer in System Settings > Printers & Scanners and set Use
    to the "..., hpcups-macos" driver. Printer queues are not removed on
    uninstall; remove them with: sudo lpadmin -x <queue name>
  EOS
end
