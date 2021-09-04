return {
  install_script = [[
  os=$(uname -s | tr "[:upper:]" "[:lower:]")

  case $os in
  linux)
  platform="linux"
  ;;
  darwin)
  platform="macos"
  ;;
  esac

  julia --project=~/.julia/environments/nvim-lspconfig -e 'using Pkg; Pkg.add("LanguageServer")'
  ]],
  default_config = {
    filetypes = { 'julia'},
  }
}
