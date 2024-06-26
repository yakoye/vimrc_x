# vimrc_x



```bash
              _                                   
       _   __(_)___ ___  __________     _  __     
      | | / / / __ `__ \/ ___/ ___/    | |/_/     
      | |/ / / / / / / / /  / /__     _>  <       
      |___/_/_/ /_/ /_/_/   \___/____/_/|_|       
                               /_____/            
                                                    
```
I used to frequently use the spf13-vim toolkit, which offered a wide range of features.
However, the spf13-vim toolkit was quite heavy and had a slow startup time. 
This led me to the idea of optimizing and streamlining it, 
resulting in my own customized Vim configuration: vimrc_x. 
The main highlight of this configuration is the incorporation of Vim's Timer functionality, 
which greatly enhances the loading speed.

# Install
```
cd vimrc_x

./install.sh
```


# Requirements
To make all the plugins work, specifically [neocomplete](https://github.com/Shougo/neocomplete.vim), you need [vim with lua](https://github.com/Shougo/neocomplete.vim#requirements).

If you are working with C language, you need to install the ctags and cscope tools.

It is better to use vim8.x or later, although vim7.4 is also supported.



# Common Commands

执行命令之前，先按“ESC”。

Before running the command, press ESC.

| Command                           | description描述                                              | 插件                                                         |
| --------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| `Ctrl-e` （or `:NERDTreeToggle`） | NERD tree（开关左侧文件树）                                  | [nerdtree](https://github.com/yakoye/vimrc_x/tree/main/vim/pack/vendor/opt/nerdtree) |
| `,e   (or `:NERDTreeFind`)        | NERDTree Find（定位到文件树中位置）                          | [nerdtree](https://github.com/yakoye/vimrc_x/tree/main/vim/pack/vendor/opt/nerdtree) |
| `,t`                              | open/close Tagbar (开关Tagbar函数列表等)                     | [tagbar](https://github.com/yakoye/vimrc_x/tree/main/vim/pack/vendor/opt/tagbar) |
| `Ctrl-p`                          | open LeaderF (or Ctrlp) (搜索文件)                           | [LeaderF](https://github.com/yakoye/vimrc_x/tree/main/vim/pack/vendor/opt/LeaderF)、[ctrlp.vim](https://github.com/yakoye/vimrc_x/tree/main/vim/pack/vendor/opt/ctrlp.vim) |
| `Ctrl-p ` ↓`Ctrl-p`               | open LeaderF Preview file (向下选中并预览文件)               | [LeaderF](https://github.com/yakoye/vimrc_x/tree/main/vim/pack/vendor/opt/LeaderF) |
| `Ctrl-]`                          | jump define (跳到定义位置，会自动上下分屏)                   | cscope，ctags                                                |
| `Ctrl-o` or `Ctrl-t`              | jump back (跳回来)                                           |                                                              |
| `,k` （用小写k）                  | Word highlighting（关键字着色（最多12个））                  | [vim-interestingwords](https://github.com/yakoye/vimrc_x/tree/main/vim/pack/vendor/opt/vim-interestingwords) |
| `,K`  (用大写K)                   | Clear every word highlight（取消关键字着色）                 | [vim-interestingwords](https://github.com/yakoye/vimrc_x/tree/main/vim/pack/vendor/opt/vim-interestingwords) |
| `,b`                              | easymotion-prev(before) (定位光标之前内容，快速跳转)，向上跳↑ | [vim-easymotion](https://github.com/yakoye/vimrc_x/tree/main/vim/pack/vendor/opt/vim-easymotion) |
| `,n`                              | easymotion-next  (定位光标之后内容，快速跳转)，向下跳↓       | [vim-easymotion](https://github.com/yakoye/vimrc_x/tree/main/vim/pack/vendor/opt/vim-easymotion) |
| `,ci`                             | 多行注释                                                     | [nerdcommenter](https://github.com/yakoye/vimrc_x/tree/main/vim/pack/vendor/opt/nerdcommenter) |
| `,cc`                             | 单行注释                                                     | [nerdcommenter](https://github.com/yakoye/vimrc_x/tree/main/vim/pack/vendor/opt/nerdcommenter) |
| `,ca`                             | 切换注释格式                                                 | [nerdcommenter](https://github.com/yakoye/vimrc_x/tree/main/vim/pack/vendor/opt/nerdcommenter) |
| `,cu`                             | 取消注释                                                     | [nerdcommenter](https://github.com/yakoye/vimrc_x/tree/main/vim/pack/vendor/opt/nerdcommenter) |
| `,cA`                             | 行尾注释                                                     | [nerdcommenter](https://github.com/yakoye/vimrc_x/tree/main/vim/pack/vendor/opt/nerdcommenter) |
| `,c空格`                          | 注释/取消注释                                                | [nerdcommenter](https://github.com/yakoye/vimrc_x/tree/main/vim/pack/vendor/opt/nerdcommenter) |



# vim 自带命令用法

## 自动补全（Insertion-Completion）
在[插入模式](https://link.zhihu.com/?target=http%3A//yyq123.github.io/learn-vim/learn-vi-42-InsertMode.html)下，利用自动补全（[Insertion-Completion](https://link.zhihu.com/?target=http%3A//vimcdoc.sourceforge.net/doc/insert.html%23ins-completion)）功能，vim能够根据正在输入的字符，查找匹配的关键字并显示在弹出菜单（popup menu）中。通过选择匹配项，可以补全输入的部分关键字甚至整行文本。
帮助命令：`help ins-completion`

要使用自动补全功能，确保在Vim中启用了相关的选项。你可以在Vim的配置文件（通常是`~/.vimrc`）中添加相关设置，例如启用`set complete`选项来开启关键字补全。

| 快捷键                         | 名称                                                        | 说明                                                         | 帮助                  |
| ------------------------------ | ----------------------------------------------------------- | ------------------------------------------------------------ | --------------------- |
| Ctrl-x **Ctrl-l**              | 整行补全（Whole lines）                                     |                                                              | `:h compl-whole-line` |
| Ctrl-P                         | 关键字，向上                                                | 搜索当前文件中已经出现过的关键字，并进行补全，相关选项‘complete’。这对于补全已经输入过的变量名、函数名等非常有用。 | `:h usr_24.txt` |
| Ctrl-N                         | 关键字补全，向下                                            | 同上                                                         | `:h usr_24.txt` |
| Ctrl-x **Ctrl-p**或 **Ctrl-n** | 当前文件内关键字补全（Keyword local completion）            | 同上，`:set iskeyword`, 对于C程序`:set iskeyword="a-z,A-Z,48-57,_,.,-,>"` | `:h compl-current` |
| Ctrl-x **Ctrl-k**              | 字典补全（Dictionary completion）                           | `set dictionary+=/usr/share/dict/words`                      | `:h compl-dictionary` |
| Ctrl-x **Ctrl-t**              | 词典补全（Thesaurus completion）                            | `:set thesaurus+=/home/mythesaurus.txt`                      | `:h compl-tag` |
| Ctrl-x **Ctrl-i**              | 当前文件及其包含的文件关键字补全（Path pattern completion） | `:set include+=/home/include.txt`                             | `:h compl-keyword` |
| Ctrl-x **Ctrl-]**              | 标签补全（Tag completion）                                  | 如果使用了标签（tag）文件（例如使用ctags生成的标签文件），可以使用`Ctrl-]`命令来跳转到标签定义处。在输入过程中，按下`Ctrl-X Ctrl-]`可以进行标签补全，Vim会根据已知的标签进行匹配并提供补全选项。 | `:h compl-tag` |
| Ctrl-x **Ctrl-f**              | 文件名补全（File name completion）                          | Vim会根据当前路径和已知的文件名进行匹配，并提供候选项供选择。 | `:h compl-whole-line` |
| Ctrl-x **Ctrl-d**              | 定义或宏定义补全（definitions or macros completion）        | 'define'选项定义的正则表达式默认为“^\s*#\s*define”，将查找以“define”语法定义的宏。您可以使用`:set define?`命令，查看当前的'define'选项设置。 | `:h compl-define` |
| Ctrl-x **Ctrl-v**              | Vim命令补全（Command-line completion）                      | 将匹配Vim命令，以便在您开发Vim脚本时加速代码录入。           | `:h compl-vim` |
| Ctrl-x **Ctrl-u**              | 用户自定义补全（User defined completion）                   | 将由`'completefunc'`选项指定的自定义函数来进行匹配。         | `:h compl-function` |
| Ctrl-x **Ctrl-s**              | 拼写建议补全（Spelling completion）                         | 将根据[拼写检查](https://link.zhihu.com/?target=http%3A//yyq123.github.io/learn-vim/learn-vi-24-SpellCheck.html)给出补全建议。需要打开拼写检查特性`:set spell` | `:h compl-spelling` |
| Ctrl-x **Ctrl-o**              | 全能补全（Omni completion）                                 | 将由'omnifunc'选项指定的自定义函数来进行匹配。Vim将通过$VIMRUNTIME/autoload/{filetype}complete.vim文件来实现全能补全特性，现在支持8种语言，包括C, (X)HTML with CSS, JavaScript, PHP, Python, Ruby, SQL和XML。 | `:h comp-omni` |

## 折叠（fold）

帮助`:help fold`

| 按键 | 说明                                            |      |
| ---- | ----------------------------------------------- | ---- |
| `zf` | 创建折叠，选中多行，再按zf（选中创建，同`:fo`） |      |
| `zd` | 删除折叠                                        |      |
| `zE` | 删除所有折叠                                    |      |
| `zo` | 展开                                            |      |
| `zc` | 折叠                                            |      |
| `za` | 展开/折叠 切换                                  |      |
| `zR` | 全部展开                                        |      |
| `zM` | 全部折叠                                        |      |
| `zj` | 移动到下一折叠处                                |      |
| `zk` | 移动到上一折叠处                                |      |





# .bashr or .cshrc

To facilitate the use of the cscope, ctags, and find commands, you can add the following configuration to.bashr or.cshrc

after run command `source .bashrc` or`source .cshrc`

为了方便使用cscope、ctags、find等命令，可以在.bashr 或 .cshrc中加入如下配置。

之后再执行命令`source .bashrc`或`source .cshrc`

```
#######  .bashrc  ####### 

# tag generate
alias tgg='echo "tag generate ..."; ctags -R *; find /usr/include `pwd` -name "*.[ch]" -o -name "*.cpp" > cscope.files; cscope -bkq -i cscope.files; echo "Finish."'
# tag clean
alias tgc='echo "tag cleaned"; rm cscope.* tags'

alias grep-c='grep $1 -rn --include="*.c" --include="*.h" --include="*.hpp" --include="*.cpp" --include="*.cxx" --include="*.cc" --include="Makefile*"'
alias grep-p='grep $1 -rn --include="*.py"'
alias grep-g='grep $1 -rn --include="*.peg"'
alias find-c='find . -name "*.h" -o -name "*.c"'



####### .cshrc  ####### 
# tag generate
alias tgg 'echo "tag generate ..."; ctags -R *; find /usr/include `pwd` -name "*.[ch]" -o -name "*.cpp" > cscope.files; cscope -bkq -i cscope.files; echo "Finish."'
# tag clean
alias tgc 'echo "tag cleaned"; rm cscope.* tags'

alias grep-c 'grep $1 -rn --include="*.c" --include="*.h" --include="*.hpp" --include="*.cpp" --include="*.cxx" --include="*.cc" --include="Makefile*"'
alias grep-p 'grep $1 -rn --include="*.py"'
alias grep-g 'grep $1 -rn --include="*.peg"'
alias find-c 'find . -name "*.h" -o -name "*.c"'

```





# Refer

- [spf13/spf13-vim: The ultimate vim distribution](https://github.com/spf13/spf13-vim)

- [PaperColor theme](https://github.com/NLKNguyen/papercolor-theme)

- [256 Colors Cheat Sheet - Xterm, HEX, RGB, HSL](https://www.ditig.com/256-colors-cheat-sheet)

- [插件帮助help](https://blog.csdn.net/BjarneCpp/article/details/80608706)

## Update

2023-06-16 10:38:16
