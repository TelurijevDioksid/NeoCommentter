# nvim-commenter

A simple comment plugin written in lua for Neovim.

## Installation
If you are using _packer_
```lua
 use("TelurijevDioksid/nvim-commenter")
```

## Usage
Plugin works both in normal and visual mode. It has 3 functionalities: comment,
uncomment and toggle comments. You can use them by calling the functions
```lua
require("nvim-commenter").comment()
require("nvim-commenter").uncomment()
require("nvim-commenter").toggle_comment()
```

Plugin will automatically detect the language based on the file extension.
If desired language is not supported, you can easily add it by passing adequate
table to the setup method.
```lua
require("nvim-commenter").setup({
    ["your_lang"] = {
        first_comment = "/*",
        last_comment = "*/"
    },
    ["your_lang2"] = {
        first_comment = "//",
        last_comment = ""
    }:
})
```

Creating custom mappings example:
```lua
vim.keymap.set("v", "<C-k>", require("nvim-commenter").toggle_comment)
vim.keymap.set("n", "<C-k>", require("nvim-commenter").toggle_comment)
```

## Supported languages
C, Python, Lua, C++, JavaScript, TypeScript, HTML, CSS, Bash, Go, Rust
