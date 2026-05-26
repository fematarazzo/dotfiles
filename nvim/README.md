# nvim

Minimal Neovim setup. No plugin manager. LSP for the languages I touch
most as a platform engineer.

## install

The config is symlinked by `stow`. You also need the LSP servers below.
Install only what you use — `init.lua` checks if each binary exists
before starting the LSP, so missing ones are silently skipped.

### vendored plugins (once)

```sh
mkdir -p ~/.config/nvim/vendor && cd ~/.config/nvim/vendor
git clone https://github.com/tpope/vim-fugitive
git clone https://github.com/tpope/vim-commentary
git clone https://github.com/tpope/vim-surround
```

### LSP servers

| language    | server                 | install                                                     |
|-------------|------------------------|-------------------------------------------------------------|
| Go          | gopls                  | `go install golang.org/x/tools/gopls@latest`                |
| Python      | pyright                | `pipx install pyright`                                      |
| YAML        | yaml-language-server   | `npm i -g yaml-language-server`                             |
| Bash        | bash-language-server   | `npm i -g bash-language-server`                             |
| TOML        | taplo                  | `cargo install taplo-cli --features lsp`                    |
| JSON        | vscode-json-language-server | `npm i -g vscode-langservers-extracted`                |
| Terraform   | terraform-ls           | apt: `terraform-ls`, or HashiCorp release binary            |
| Dockerfile  | docker-langserver      | `npm i -g dockerfile-language-server-nodejs`                |
| Markdown    | marksman               | release binary from `artempyanykh/marksman`                 |
| Lua         | lua-language-server    | apt: `lua-language-server`, or release binary               |

Most of these are also available via apt on Debian/Ubuntu — check with
`apt search <name>` first. The system package, when available, beats
npm/cargo for Hufflepuff stability.

## per-filetype settings (ftplugin/)

Loaded automatically by Neovim when you open a file of that type:

| file               | what it does                                  |
|--------------------|-----------------------------------------------|
| `yaml.lua`         | 2-space indent, no '#' unindent               |
| `markdown.lua`     | wrap on, spell on, j/k as visual lines        |
| `json.lua`         | 2-space indent, no conceal                    |
| `toml.lua`         | 2-space indent                                |
| `sh.lua`           | 4-space indent                                |
| `terraform.lua`    | 2-space indent                                |
| `go.lua`           | tabs (gofmt convention)                       |
