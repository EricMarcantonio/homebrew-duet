# homebrew-duet

Homebrew tap for [Duet](https://github.com/EricMarcantonio/duet) — play your Mac's audio
on two pairs of Bluetooth headphones at once, each with its own volume.

```sh
brew install --cask EricMarcantonio/duet/duet
```

Use that tap-qualified name. Homebrew's core tap already ships a cask called `duet`
(Duet Display, the iPad-as-a-second-screen tool), so a bare `brew install --cask duet`
installs that app instead of this one.

## What you get

- `Duet.app` in `/Applications`, universal (Apple Silicon + Intel), macOS 11 or later.
- Duet is not notarized yet: the first launch needs **right-click › Open**, or
  **System Settings › Privacy & Security › Open Anyway**.
- Allow the Bluetooth prompt on first run, or Duet cannot see your headphones.

## Upgrading

```sh
brew upgrade --cask duet
```

Duet's own **Check for updates** button tells you when a newer release exists, and shows
this command when it detects that you installed through Homebrew.

## Uninstalling

```sh
brew uninstall --cask duet      # keeps your settings
brew uninstall --zap --cask duet # also removes ~/Library/Application Support/Duet,
                                 # ~/Library/Logs/Duet and the WebKit/cache leftovers
```

## Maintaining this tap

`Casks/d/duet.rb` is a byte-for-byte copy of
[`packaging/homebrew/duet.rb`](https://github.com/EricMarcantonio/duet/blob/main/packaging/homebrew/duet.rb)
in the main repository. On every release, regenerate the digest there and copy it over:

```sh
cd ~/dev/duet && scripts/update-cask.sh v0.4.0
cp packaging/homebrew/duet.rb ../homebrew-duet/Casks/d/duet.rb
```

A stale digest fails closed — Homebrew refuses to install a zip whose sha256 does not
match — so a forgotten copy is a loud error, never a wrong binary.
