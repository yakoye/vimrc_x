#!/usr/bin/env bash
# Date: 2023-06-12 / Updated: 跨平台Vim插件自动安装 (直连原生目录，不替换 vimfiles)
# Author: yakoye 

set -euo pipefail

# ===================== 核心配置 =====================
PLUGINS=(
    "startify|mhinz/vim-startify"                             # LoadStartify()
    "LeaderF|Yggdroot/LeaderF"                                # LoadLeaderF()
    "nerdtree|preservim/nerdtree"                             # LoadNerdtree()
    "tagbar|preservim/tagbar"                                 # LoadTagbar()
    "vim-illuminate|RRethy/vim-illuminate"                    # LoadIilluminate()
    "vim-dict|skywind3000/vim-dict"                           # LoadVimdict()
    "VimAutoPop|vim-scripts/autocomplpop"                     # LoadAutoComplPop()
    "VimAutoPopMenu|skywind3000/vim-auto-popmenu"             # LoadVimAutoPopmenu()
    "vim-interestingwords|lfv89/vim-interestingwords"         # LoadVimInterestingwords()
    "nerdcommenter|preservim/nerdcommenter"                   # LoadNerdcommenter()
    "VisIncr|vim-scripts/VisIncr"                             # LoadVisIncr()
    "fuzzbox|vim-fuzzbox/fuzzbox.vim"                         # LoadFuzzbox()
    "tabular|godlygeek/tabular"                               # LoadTabular()
    "vim-easymotion|easymotion/vim-easymotion"                # LoadEasymotion()
    "vim-gutentags|ludovicchabant/vim-gutentags"              # LoadGutentags()
    "vim-bookmarks|MattesGroeger/vim-bookmarks"               # LoadBookmarks()
    "rainbow|luochen1990/rainbow"                             # LoadRainbow()
    "asyncrun.vim|skywind3000/asyncrun.vim"                   # LoadAsyncrun()
    "terminalhelp.vim|skywind3000/vim-terminal-help"          # LoadTerminalhelp()
    "colorizer|lilydjwg/colorizer"                            # LoadColorizer()
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

# 核心改变：直接将目标路径指向系统的真实目录，不再放到当前工程目录下！
PLUGIN_INSTALL_DIR="$VIM_CONFIG_DIR/pack/vendor/opt"

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

    # 如果系统的这个目录不存在，就新建它；存在的话里面原有的其他文件绝对安全
    mkdir -p "$PLUGIN_INSTALL_DIR"
    cd "$PLUGIN_INSTALL_DIR" || exit 1

    for plugin in "${PLUGINS[@]}"; do
        IFS='|' read -r dir repo <<< "$plugin"
        
        if [[ -d "$dir/.git" ]]; then
            echo "🔄 [$dir] 已存在，正在拉取最新代码..."
            git -C "$dir" pull --ff-only || echo "⚠️ [$dir] 更新失败，请检查网络。"
        else
            if [[ -d "$dir" ]]; then
                echo "🗑️  检测到损坏的插件文件夹 [$dir]，正在清理..."
                rm -rf "$dir"
            fi
            
            echo "⬇️  正在下载全新插件：$repo"
            git clone --depth=1 "git@github.com:$repo.git" "$dir" || echo "❌ [$dir] 下载失败！请检查 SSH 密钥或网络。"
        fi
    done

    cd - > /dev/null || exit 1
}

# ===================== 主执行逻辑 =====================
main() {
    check_git
    echo "====================================="
    echo "📦 Vim 跨平台环境部署与更新工具 (直连模式)"
    echo "🖥️ 当前系统：$OSTYPE"
    echo "====================================="

    # 【删除了原来粗暴备份/移动整个 vimfiles 的逻辑】
    
    # 仅仅备份 vimrc 文件（因为我们需要将其软链接到你的配置仓库）
    if [[ -e "$VIM_RC" && ! -L "$VIM_RC" ]]; then
        mv "$VIM_RC" "${VIM_RC}_$today"
        echo "🗄️ 系统旧的 $VIM_RC 文件已备份"
    fi
    # 仅仅创建 vimrc 的软链接，不再软链接整个文件夹
    echo -e "\n🔗 正在映射 vimrc 软链接..."
    ln -snf "$curt_path/vimrc" "$VIM_RC"

    # 执行下载或更新（直接在系统的真实 vimfiles 里操作）
    install_or_update_plugins

    echo -e "\n====================================="
    echo "🎉 部署/更新全部完成！"
    echo "✅ 你的 $VIM_CONFIG_DIR 目录依然完整，仅新增/更新了 pack 插件。"
    echo "====================================="
}

main