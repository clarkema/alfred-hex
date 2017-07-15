# Hex.pm for Alfred

There are quite a few Alfred workflows out there to search [hex.pm](https://hex.pm) for Elixir and Erlang modules — this is my take.

Why bother?  Most of the other workflows out there either just provide a simple search shortcut, or rely on an external helper, or both.  I wanted a self-contained tool that would take me to most of the sites of interest related to a package, and generate a Mix dependency tuple for the latest version.  Because I'm super lazy.

## Features

 * Simple Ruby script embedded in the workflow, using just the system Ruby
   and standard library.  No need to install Node or Elixir helpers.
 * `h {query}` to search hex.pm
 * Select a result to go to the hex.pm page for that package.
 * Copying a result gets you the Mix dependency tuple for the latest version
 * Shift-select to go to the hex.pm page _and_ copy the dependency tuple to your clipboard
 * Alt-select to go to the project's Github page, if it has one
 * Ctrl-select to go to the project's documentation on hexdocs.pm.

## Caveats

The hex.pm API doesn't seem to provide an explicit documentation link, so we calculate where the hexdocs.pm documentation _should_ be.  This won't work for Erlang packages, and you'll get a 404.

The shift-select feature to visit a package's hex.pm page and copy its version tuple to the clipboard depends on functionality introduced in Alfred 3.4.1.  This is currently in pre-release.
