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

### method 1:
`./install.sh`


### method 2:
```
mv ~/.vimrc ~/.vimrc.old
mv ~/.vim ~/.vim.old
cp -r .vim ~
cp vimrc-ex ~/.vimrc
```

# Requirements
To make all the plugins work, specifically [neocomplete](https://github.com/Shougo/neocomplete.vim), you need [vim with lua](https://github.com/Shougo/neocomplete.vim#requirements).
If you are working with C language, you need to install the ctags and cscope tools.



# Refer

- [spf13/spf13-vim: The ultimate vim distribution](https://github.com/spf13/spf13-vim)

- [PaperColor theme](https://github.com/NLKNguyen/papercolor-theme)

- [256 Colors Cheat Sheet - Xterm, HEX, RGB, HSL](https://www.ditig.com/256-colors-cheat-sheet)