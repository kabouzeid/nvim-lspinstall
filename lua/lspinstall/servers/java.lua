local config = require'lspconfig'.jdtls.document_config
require'lspconfig/configs'.jdtls = nil -- important, immediately unset the loaded config again

config.default_config.cmd[1] = {"./jdtls.sh", vim.fn.expand('$HOME/.local/share/nvim/lspinstall/java/workspace/') .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')}

return vim.tbl_extend('error', config, {
  install_script = [[
  curl -L -o - http://download.eclipse.org/jdtls/snapshots/jdt-language-server-latest.tar.gz | tar xvz
  curl -L -o lombok.jar https://projectlombok.org/downloads/lombok.jar

  mkdir -p gradle

cat << EOF > gradle/build.gradle
task getHomeDir {
    println gradle.gradleHomeDir
}
EOF

cat << EOF > jdtls.sh
#!/usr/bin/env bash
OS=$(uname)

case \$OS in
  Linux)
    CONFIG="$HOME/.local/share/nvim/lspinstall/java/config_linux"
    ;;
  Darwin)
    CONFIG="$HOME/.local/share/nvim/lspinstall/java/config_mac"
    ;;
esac

WORKSPACE="$(pwd)/workspace"

# Check if Gradle is installed and if it is set the GRADLE_HOME environment variable.
if command -v gradle &>/dev/null; then
  export GRADLE_HOME="\$(cd $HOME/.local/share/nvim/lspinstall/java/gradle && gradle getHomeDir | grep -A1 'Configure project' | tail -n1)"
fi

JAR="$(find $HOME/.local/share/nvim/lspinstall/java/plugins/ -name 'org.eclipse.equinox.launcher_*.jar')"

if [ -z \${JAVA_HOME+x} ]; then 
  JAVA="\$(java -XshowSettings:properties -version 2>&1 > /dev/null | awk '/java.home/ { print \$3 }')/bin/java"
else
  JAVA="\${JAVA_HOME}/bin/java"
fi

mkdir -p \$WORKSPACE

"\${JAVA}" \\
  -Declipse.application=org.eclipse.jdt.ls.core.id1 \\
  -Dosgi.bundles.defaultStartLevel=4 \\
  -Declipse.product=org.eclipse.jdt.ls.core.product \\
  -Dlog.protocol=true \\
  -Dlog.level=ALL \\
  -Xms1g \\
  -Xmx2G \\
  -jar "\$JAR" \\
  -configuration "\$CONFIG" \\
  -data "\${1:-\$HOME/workspace}" \\
  --add-modules=ALL-SYSTEM \\
  --add-opens java.base/java.util=ALL-UNNAMED \\
  --add-opens java.base/java.lang=ALL-UNNAMED \\
  -javaageng:$(pwd)/lombok.jar \\
  -Xbootclasspath/p:$(pwd)/lombok.jar
EOF
chmod +x jdtls.sh
  ]]
})
