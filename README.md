# fools.nvim

## Introduction

This is my personal configuration. This config based on ['kickstart.nvim'](https://github.com/nvim-lua/kickstart.nvim).
In this config, I will keep track on changes and planned changes on this config. This config planned to be :

* Simple
* Modular
* Fast
* Flexible

**NOT** a Neovim distribution, but instead quick to go configuration.

## Installation

Installation pretty similar with['kickstart.nvim'](https://github.com/nvim-lua/kickstart.nvim).
Please take a look over there for more further detail.

Neovim's configurations are located under the following paths, depending on your OS:

| OS | PATH |
| :- | :--- |
| Linux, MacOS | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim` |
| Windows (cmd)| `%userprofile%\AppData\Local\nvim\` |
| Windows (powershell)| `$env:USERPROFILE\AppData\Local\nvim\` |

### Install fools.nvim

Clone fools.nvim:

<details><summary> Linux and Mac </summary>

```sh
# This is left from kickstart. I will changes this after move this to a new repo.
git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

</details>

<details><summary> Windows </summary>

If you're using `cmd.exe`:

```
git clone https://github.com/nvim-lua/kickstart.nvim.git %userprofile%\AppData\Local\nvim\ 
```

If you're using `powershell.exe`

```
git clone https://github.com/nvim-lua/kickstart.nvim.git $env:USERPROFILE\AppData\Local\nvim\ 
```

</details>

### Post Installation

Start Neovim

```sh
nvim
```

That's it! Lazy will install all the plugins you have. Use `:Lazy` to view
current plugin status.

Try to read through the `init.lua` file on ['kickstart.nvim'](https://github.com/nvim-lua/kickstart.nvim)
for information about extending and exploring Neovim.

### Getting Started

See [Effective Neovim: Instant IDE](https://youtu.be/stqUbv-5u2s), covering the
previous version. Note: The install via init.lua is outdated, please follow the
install instructions in this file instead. An updated video is coming soon.

### Recommended Steps

[Fork](https://docs.github.com/en/get-started/quickstart/fork-a-repo) this repo
(so that you have your own copy that you can modify) and then installing you
can install to your machine using the methods above.

> **NOTE**  
> Your fork's url will be something like this: `https://github.com/<your_github_username>/kickstart.nvim.git`

#### Examples of adding popularly requested plugins

NOTE: You'll need to uncomment the line in the init.lua that turns on loading custom plugins.

<details>
  <summary>Adding autopairs</summary>

This will automatically install [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs) and enable it on startup. For more information, see documentation for [lazy.nvim](https://github.com/folke/lazy.nvim).

In the file: `lua/custom/plugins/autopairs.lua`, add:

```lua
-- File: lua/custom/plugins/autopairs.lua

return {
  "windwp/nvim-autopairs",
  -- Optional dependency
  dependencies = { 'hrsh7th/nvim-cmp' },
  config = function()
    require("nvim-autopairs").setup {}
    -- If you want to automatically add `(` after selecting a function or method
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    local cmp = require('cmp')
    cmp.event:on(
      'confirm_done',
      cmp_autopairs.on_confirm_done()
    )
  end,
}
```

</details>
<details>
  <summary>Adding a file tree plugin</summary>

This will install the tree plugin and add the command `:Neotree` for you. You can explore the documentation at [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) for more information.

In the file: `lua/custom/plugins/filetree.lua`, add:

```lua
-- Unless you are still migrating, remove the deprecated commands from v1.x
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

return {
  "nvim-neo-tree/neo-tree.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  config = function ()
    require('neo-tree').setup {}
  end,
}
```

</details>

## TODO

This is the list of what needs to be done. I will update what I planned in the future and what I is already done in this section.

- [x] Add [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) and [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim).
- [ ] Add  snippet helper [benfowler/telescope-luasnip.nvim](https://github.com/benfowler/telescope-luasnip.nvim).
- [x] Add debugger with [mfussenegger/nvim-dap](https://github.com/mfussenegger/nvim-dap) and [rcarriga/nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui).
- [x] Add [folke/which-key.nvim](https://github.com/folke/which-key.nvim) for keybinding preview.
- [x] Add greeter page with [goolord/alpha-nvim](https://github.com/goolord/alpha-nvim).
- [x] Add git integration. I use [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim), [kdheepak/lazygit.nvim](https://github.com/kdheepak/lazygit.nvim), and [sindrets/diffview.nvim](https://github.com/sindrets/diffview.nvim)
- [X] Use [echasnovski/mini.nvim](https://github.com/echasnovski/mini.nvim) for statusline and pairs autocomplete..
