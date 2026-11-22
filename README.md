# homebrew-duet

Homebrew tap for [Duet](https://github.com/EricMarcantonio/duet) — play your Mac's audio
on two pairs of Bluetooth headphones at once, each with its own volume.

```sh
brew install --cask EricMarcantonio/duet/duet
```

Homebrew 7 does not load casks from third-party taps until you trust them. If the
command above refuses, run this once first:

```sh
brew trust ericmarcantonio/duet
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

`Casks/d/duet.rb` is kept current by
[`.github/workflows/cask-repair.yml`](.github/workflows/cask-repair.yml). Every six hours —
and on demand via `workflow_dispatch` — it asks duet for its latest release, downloads
`Duet-macOS.zip`, and compares the real digest with the one pinned here. If a release
asset was rebuilt after it was pinned (which changes its digest and breaks
`brew install`), the workflow rewrites `version` and `sha256` in one commit and pushes to
`main`. A run with nothing to do makes no commit.

So the tap is the authoritative copy for installs; the cask in duet's
[`packaging/homebrew/duet.rb`](https://github.com/EricMarcantonio/duet/blob/main/packaging/homebrew/duet.rb)
is a mirror regenerated at release time with `scripts/update-cask.sh`. Nothing has to be
copied by hand any more. A stale digest still fails closed — Homebrew refuses to install a
zip whose sha256 does not match — and the repair is automatic within six hours.

To force a repair now:

```sh
gh workflow run cask-repair.yml --repo EricMarcantonio/homebrew-duet
gh run watch --repo EricMarcantonio/homebrew-duet
```

A digest is only ever pinned from a complete download: the byte count is checked against
the size the release reports, so a half-uploaded asset aborts the run instead of being
committed.
