# vimrc_ye_cfg



```
           _                                        
    __   _(_)_ __ ___  _ __ ___       _____  __     
    \ \ / / | '_ ` _ \| '__/ __|____ / _ \ \/ /     
     \ V /| | | | | | | | | (_|_____|  __/>  <      
      \_/ |_|_| |_| |_|_|  \___|     \___/_/\_\     
                                                    
```
I used to frequently use the spf13-vim toolkit, which offered a wide range of features.
However, the spf13-vim toolkit was quite heavy and had a slow startup time. 
This led me to the idea of optimizing and streamlining it, 
resulting in my own customized Vim configuration: vimrc-ex. 
The main highlight of this configuration is the incorporation of Vim's Timer functionality, 
which greatly enhances the loading speed.

# Install
```
cd vimrc_ye_cfg

./install.sh
```


# Requirements
To make all the plugins work, specifically [neocomplete](https://github.com/Shougo/neocomplete.vim), you need [vim with lua](https://github.com/Shougo/neocomplete.vim#requirements).

If you are working with C language, you need to install the ctags and cscope tools.

It is better to use vim8.x or later, although vim7.4 is also supported.



# Common Commands

执行命令之前，先按“ESC”。

Before running the command, press ESC.

| Command                           | description描述                              | 插件                                                         |
| --------------------------------- | -------------------------------------------- | ------------------------------------------------------------ |
| `Ctrl-E` （or `:NERDTreeToggle`） | NERD tree（开关左侧文件树）                  | [nerdtree](https://github.com/yakoye/vimrc_ye_cfg/tree/main/vim/pack/vendor/opt/nerdtree) |
| `,E`   (or `:NERDTreeFind`)       | NERDTree Find（定位到文件树中位置）          | [nerdtree](https://github.com/yakoye/vimrc_ye_cfg/tree/main/vim/pack/vendor/opt/nerdtree) |
| `,t`                              | open/close Tagbar (开关Tagbar函数列表等)     | [tagbar](https://github.com/yakoye/vimrc_ye_cfg/tree/main/vim/pack/vendor/opt/tagbar) |
| `Ctrl-P`                          | open LeaderF (or Ctrlp) (搜索文件)           | [LeaderF](https://github.com/yakoye/vimrc_ye_cfg/tree/main/vim/pack/vendor/opt/LeaderF)、[ctrlp.vim](https://github.com/yakoye/vimrc_ye_cfg/tree/main/vim/pack/vendor/opt/ctrlp.vim) |
| `Ctrl-P ` ↓`Ctrl-P`               | open LeaderF Preview file (预览文件)         | [LeaderF](https://github.com/yakoye/vimrc_ye_cfg/tree/main/vim/pack/vendor/opt/LeaderF) |
| `Ctrl-]`                          | jump define (跳到定义位置，会自动上下分屏)   | cscope，ctags                                                |
| `Ctrl-o`                          | jump back (跳回来)                           |                                                              |
| `,k` （小写k）                    | Word highlighting（关键字着色（最多12个））  | [vim-interestingwords](https://github.com/yakoye/vimrc_ye_cfg/tree/main/vim/pack/vendor/opt/vim-interestingwords) |
| `,K`  (大写K)                     | Clear every word highlight（取消关键字着色） | [vim-interestingwords](https://github.com/yakoye/vimrc_ye_cfg/tree/main/vim/pack/vendor/opt/vim-interestingwords) |
| `,b`                              | easymotion-prev(before) (定位光标之前内容)   | [vim-easymotion](https://github.com/yakoye/vimrc_ye_cfg/tree/main/vim/pack/vendor/opt/vim-easymotion) |
| `,n`                              | easymotion-next  (定位光标之后内容)          | [vim-easymotion](https://github.com/yakoye/vimrc_ye_cfg/tree/main/vim/pack/vendor/opt/vim-easymotion) |



# .bashr or .cshrc

To facilitate the use of the cscope, ctags, and find commands, you can add the following configuration to.bashr or.cshrc

after run command `source .bashrc` or`source .cshrc`

为了方便使用cscope、ctags、find等命令，可以在.bashr 或 .cshrc中加入如下配置。

之后再执行命令`source .bashrc`或`source .cshrc`

```
#######  .bashrc  ####### 

# tag generate
alias tgg='echo "tag generate ..."; ctags -R *; find `pwd` -name "*.[ch]" -o -name "*.cpp" > cscope.files; cscope -Rbq; echo "Finish."'
# tag clean
alias tgc='echo "tag cleaned"; rm cscope.* tags'

alias grep-c='grep $1 -rn --include="*.c" --include="*.h" --include="*.hpp" --include="*.cpp" --include="*.cxx" --include="*.cc" --include="Makefile*"'
alias grep-p='grep $1 -rn --include="*.py"'
alias grep-g='grep $1 -rn --include="*.peg"'
alias find-c='find . -name "*.h" -o -name "*.c"'



####### .cshrc  ####### 
# tag generate
alias tgg 'echo "tag generate ..."; ctags -R *; find `pwd` -name "*.[ch]" -o -name "*.cpp" > cscope.files; cscope -Rbq; echo "Finish."'
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



## Update

2023-06-16 10:38:16
