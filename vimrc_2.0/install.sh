#!/usr/bin/env bash
# Date: 2023-06-12 / Updated: 跨平台Vim插件自动安装 (适配 vendor/opt 目录)
# Author: yakoye 

set -euo pipefail

# ===================== 核心配置 =====================
PLUGINS=(
"startify|mhinz/vim-startify"                             # LoadStartify()
    "LeaderF|Yggdroot/LeaderF"                            # LoadLeaderF()
    "nerdtree|preservim/nerdtree"                         # LoadNerdtree()
    "tagbar|preservim/tagbar"                             # LoadTagbar()
    "vim-illuminate|RRethy/vim-illuminate"                # LoadIilluminate()
    "vim-dict|skywind3000/vim-dict"                       # LoadVimdict()
    "VimAutoPop|vim-scripts/autocomplpop"                 # LoadAutoComplPop()
    "VimAutoPopMenu|skywind3000/vim-auto-popmenu"         # LoadVimAutoPopmenu()
    "vim-interestingwords|lfv89/vim-interestingwords"     # LoadVimInterestingwords()
    "nerdcommenter|preservim/nerdcommenter"               # LoadNerdcommenter()
    "VisIncr|vim-scripts/VisIncr"                         # LoadVisIncr()
    "fuzzbox|vim-fuzzbox/fuzzbox.vim"                     # LoadFuzzbox()
    "tabular|godlygeek/tabular"                           # LoadTabular()
    "vim-easymotion|easymotion/vim-easymotion"            # LoadEasymotion()
    "vim-gutentags|ludovicchabant/vim-gutentags"          # LoadGutentags()
    "vim-bookmarks|MattesGroeger/vim-bookmarks"           # LoadBookmarks()
    "rainbow|luochen1990/rainbow"                         # LoadRainbow()
    "asyncrun.vim|skywind3000/asyncrun.vim"               # LoadAsyncrun()
    "terminalhelp.vim|skywind3000/vim-terminal-help"      # LoadTerminalhelp()
    "colorizer|lilydjwg/colorizer"                        # LoadColorizer()
)

curt_path=$(cd "$(dirname "$0")" && pwd)
today=$(date +%Y%m%d_%s)

# ===================== 跨平台系统级路径判断 =====================
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" || "$OSTYPE" == "win32" ]]; then
    VIM_CONFIG_DIR="$HOME/vimfiles"
    VIM_RC="$HOME/_vimrc"
else
    VIM_CONFIG_DIR="$HOME/.vim"
    VIM_RC="$HOME/.vimrc"
fi

# 统一管理在你当前工程下的 opt 目录
PLUGIN_INSTALL_DIR="$curt_path/vim/pack/vendor/opt"

# ===================== 依赖检查 =====================
check_git() {
    if ! command -v git &> /dev/null; then
        echo "❌ 错误：未检测到 git，请先安装 git 后再运行脚本！"
        exit 1
    fi
}

# ===================== 核心：下载与更新逻辑 =====================
install_or_update_plugins() {
    echo -e "\n====================================="
    echo "🚀 开始同步 Vim 插件 (下载 / 更新)..."
    echo "🎯 目标路径: $PLUGIN_INSTALL_DIR"
    echo "====================================="

    mkdir -p "$PLUGIN_INSTALL_DIR"
    cd "$PLUGIN_INSTALL_DIR" || exit 1

    for plugin in "${PLUGINS[@]}"; do
        IFS='|' read -r dir repo <<< "$plugin"
        
        # 判断：如果目录存在，则执行 git pull 更新
        if [[ -d "$dir" ]]; then
            echo "🔄 [$dir] 已存在，正在拉取最新代码..."
            # 使用 git -C 直接在目标目录下执行 pull，避免频繁 cd 切换
            git -C "$dir" pull --ff-only || echo "⚠️ [$dir] 更新失败，请检查网络。"
        else
            # 如果目录不存在，则执行 git clone 下载
            echo "⬇️  正在下载全新插件：$repo"
            # git clone --depth=1 "https://github.com/$repo.git" "$dir" || echo "❌ [$dir] 下载失败！"
            git clone --depth=1 "git@github.com:$repo.git" "$dir" || echo "❌ [$dir] 下载失败！"
        fi
    done

    cd - > /dev/null || exit 1
}

# ===================== 主执行逻辑 =====================
main() {
    check_git
    echo "====================================="
    echo "📦 Vim 跨平台环境部署与更新工具"
    echo "🖥️ 当前系统：$OSTYPE"
    echo "====================================="

    # 1. 备份系统自带的旧配置（如果是我们建立的软链接，则不备份，直接覆盖）
    if [[ -e "$VIM_CONFIG_DIR" && ! -L "$VIM_CONFIG_DIR" ]]; then
        mv "$VIM_CONFIG_DIR" "${VIM_CONFIG_DIR}_$today"
        echo "🗄️ 系统旧的 $VIM_CONFIG_DIR 目录已备份"
    fi
    
    if [[ -e "$VIM_RC" && ! -L "$VIM_RC" ]]; then
        mv "$VIM_RC" "${VIM_RC}_$today"
        echo "🗄️ 系统旧的 $VIM_RC 文件已备份"
    fi

    # 2. 执行下载或更新
    install_or_update_plugins

    # 3. 建立/刷新软链接
    echo -e "\n🔗 正在刷新软链接..."
    ln -snf "$curt_path/vimrc" "$VIM_RC"
    ln -snf "$curt_path/vim" "$VIM_CONFIG_DIR"

    echo -e "\n====================================="
    echo "🎉 部署/更新全部完成！"
    echo "====================================="
}

main