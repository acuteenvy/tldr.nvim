# tldr.nvim

[![CI](https://img.shields.io/github/actions/workflow/status/acuteenvy/tldr.nvim/ci.yml?label=CI&logo=github&labelColor=363a4f&logoColor=d9e0ee)](https://github.com/acuteenvy/tldr.nvim/actions/workflows/ci.yml)
[![license](https://img.shields.io/github/license/acuteenvy/tldr.nvim?color=b4befe&labelColor=363a4f)](/LICENSE)
[![matrix](https://img.shields.io/matrix/tldr-pages%3Amatrix.org?logo=matrix&color=94e2d5&logoColor=d9e0ee&labelColor=363a4f&label=tldr-pages%20matrix)](https://matrix.to/#/#tldr-pages:matrix.org)

Preview [tldr pages](https://github.com/tldr-pages/tldr) using a client directly in Neovim.

![screenshot](https://github.com/acuteenvy/tldr.nvim/assets/126529524/2a0e9a35-cb99-4572-aed1-70b057cdfc6a)

## Installation

> [!NOTE]
> tldr.nvim requires a tldr client on your `$PATH`.

### [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
    "acuteenvy/tldr.nvim",
    cmd = "Tldr",
    config = function()
        require("tldr").setup()
    end
}
```

## Configuration

`setup()` accepts some options. This is the default configuration:

```lua
require("tldr").setup({
    -- Arguments passed to the tldr client to render a page.
    -- tldr.nvim adds the path to the page after these arguments.
    client_args = "--color always --render",
    window = {
        -- Dimensions of the tldr window. Can be either a fixed value (an integer greater than 1)
        -- or a percentage of the screen height/width (a float from 0 to 1).
        height = 0.8,
        width = 0.8,
        -- The border of the tldr window. Accepts the same values as nvim_open_win().
        -- https://neovim.io/doc/user/api.html#nvim_open_win()
        border = "single",
    },
})
```

## Usage

Running `:Tldr` opens a floating window with the output of `tldr <configured_args> <path/to/current/file>`. Press `q` or `Esc` to close it.
