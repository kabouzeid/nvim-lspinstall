local config = require"lspinstall/util".extract_config("denols")
config.default_config.cmd[1] = "./bin/deno"

return vim.tbl_extend('error', config, {
  install_script = [=[
  case $(uname -sm) in
    "Darwin x86_64") target="x86_64-apple-darwin" ;;
    "Darwin arm64") target="aarch64-apple-darwin" ;;
    *) target="x86_64-unknown-linux-gnu" ;;
  esac

  curl --fail --location --progress-bar --output "deno.zip" "https://github.com/denoland/deno/releases/latest/download/deno-${target}.zip"
  rm -rf "bin"
  mkdir "bin"
  unzip -d "bin" "deno.zip"
  rm "deno.zip"
  ]=]
})
