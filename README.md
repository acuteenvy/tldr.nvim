# tldr.nvim

[![CI](https://img.shields.io/github/actions/workflow/status/acuteenvy/tldr.nvim/ci.yml?label=CI&logo=github&labelColor=363a4f&logoColor=d9e0ee)](https://github.com/acuteenvy/tldr.nvim/actions/workflows/ci.yml)
[![license](https://img.shields.io/github/license/acuteenvy/tldr.nvim?color=b4befe&labelColor=363a4f)](/LICENSE)
[![matrix](https://img.shields.io/matrix/tldr-pages%3Amatrix.org?logo=matrix&color=94e2d5&logoColor=d9e0ee&labelColor=363a4f&label=tldr-pages%20matrix)](https://matrix.to/#/#tldr-pages:matrix.org)

Preview [tldr pages](https://github.com/tldr-pages/tldr) using a client directly in Neovim.

## Installation

> [!NOTE]
> tldr.nvim requires a tldr client that implements the [tldr client specification](https://github.com/tldr-pages/tldr/blob/main/CLIENT-SPECIFICATION.md) on your `$PATH`.

[lazy.nvim](https://github.com/folke/lazy.nvim)
```lua
{
    "acuteenvy/tldr.nvim",
    config = function()
        require("tldr").setup()
    end
}
```

## Usage

Running `:Tldr` opens a floating window with the output of `tldr --color always --render` on the current file. Press `q` or `Esc` to close it.
