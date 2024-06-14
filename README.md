# intervention.nvim
Mark and Recall for neovim buffers. Fortifies Speed and Agility for those who have *journeyed far \'neath moon and star*.

## Overview

This is a neovim plugin to solve an annoyance I have when using other navigation methods and plugins.
When toggling a terminal or using go-to definition, I often want to be able to jump back to where I was in the previous file.
This plugin provides a `mark` and a `recall` function that do exactly that.

## Installation

With [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "GrammAcc/intervention.nvim"
}
```

## Usage

There is no configuration or setup for this plugin, and it does not add any keymaps.

Use as a regular lua module:

```lua
local lsp_zero = require('lsp-zero')
local intervention = require("intervention")

vim.keymap.set("n", "<leader>q", function() intervention:recall() end)

lsp_zero.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}
  vim.keymap.set("n", "<leader>g", function() intervention:mark() vim.lsp.buf.definition() end, opts)
end)
```

## Simple Terminal Toggle

I usually use terminals in vim for running the test suite in between changes, doing some exploration in
a REPL, or for a quick recompile. Depends on the language I'm working in at the time. In general, for my
workflow, I don't need a bunch of terminal windows or tabs, I generally just need one terminal that I
can keep open and toggle to/from quickly.

Intervention adds a simple helper function for toggling a single terminal without closing it and losing
its environment:

```lua
local intervention = require("intervention")

vim.keymap.set({"n","t"}, "<leader>t", function() intervention:toggle_term() end)
```

This will switch to a dedicated terminal buffer and record the current buffer with `mark()` so that
a second call to `toggle_term()` or a call to `recall()` will return you to where you were when
you opened the terminal without closing the terminal and losing its environment.

This will open a new terminal with an empty ":terminal" command the first time it is called
in each neovim session.

This does not mess with any of your other configuration related to terminals or interfere with
any of the behavior of neovim's terminal commands, so it should be compatible with any other plugins
you use for terminal navigation.

## Why not global marks?

Honestly, there isn't really much difference between using this plugin and just assigning a global mark wherever
you would call the `mark()` function. I just don't really like marks since they can be a pain to keep track of, and
I like having a simple function call for common tasks like toggling a terminal, so I prefer the interface in
this plugin over setting marks in my keymaps.
