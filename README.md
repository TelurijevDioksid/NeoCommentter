# NeoCommentter

A simple comment plugin written in lua for Neovim.

## Installation

__packer__

```lua
 use("TelurijevDioksid/NeoCommentter")
```

__vim-plug__

```vim
Plug "TelurijevDioksid/NeoCommentter"
```

## Usage

Plugin works both in normal and visual mode. It has 3 functionalities: comment, uncomment and toggle comments. You can use them by calling the functions

```lua
require("NeoCommentter").comment()
require("NeoCommentter").uncomment()
require("NeoCommentter").toggle_comment()
```

Plugin will automatically detect the language based on the file extension. If desired language is not supported, you can easily add it by passing adequate table to the setup method.

```lua
require("NeoCommentter").setup({
    ["your_lang"] = {
        first_comment = "/*",
        last_comment = "*/"
    },
    ["your_lang_2"] = {
        first_comment = "//",
        last_comment = ""
    }:
})
```

If language based on file extension is not supported, plugin will use default comment which is `//`.

### Creating custom mappings example:

```lua
vim.keymap.set("v", "<leader>cc", require("nvim-commenter").toggle_comment)
vim.keymap.set("n", "<leader>cc", require("nvim-commenter").toggle_comment)
```

