# gamunu/homebrew-tap

Homebrew casks for [Smudge](https://github.com/gamunu/smudge), a Mac driver and status app for HP printers.

    brew tap gamunu/tap
    brew trust gamunu/tap
    brew install --cask smudge

Recent Homebrew versions refuse casks from third-party taps until you trust the tap.

Homebrew installs the package with Apple's `installer` command, so there is no "could not verify" prompt. The app updates itself, and `brew upgrade` works too.

A workflow checks for new Smudge releases every hour and bumps the cask.
