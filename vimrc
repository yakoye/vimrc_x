" -------------------------------------------------"
"                                                  "
"              _                                   "
"       _   __(_)___ ___  __________     _  __     "
"      | | / / / __ `__ \/ ___/ ___/    | |/_/     "
"      | |/ / / / / / / / /  / /__     _>  <       "
"      |___/_/_/ /_/ /_/_/   \___/____/_/|_|       "
"                               /_____/            "
"                                                  "
"                                                  "
"                 Name:   vimrc_x                  " 
"                 Author: yepengyu                 "
"                 Date:   2021-12-12               "
"                 Refer:  spf13-vim                "
" -------------------------------------------------"
" 
" It is better to use vim8.x or later, although vim7.x is also supported.
" 
" Environment {

    " Identify platform {
        silent function! OSX()
            return has('macunix')
        endfunction
        silent function! LINUX()
            return has('unix') && !has('macunix') && !has('win32unix')
        endfunction
        silent function! WINDOWS()
            return  (has('win32') || has('win64'))
        endfunction
    " }

    " Basics {
        set nocompatible        " Must be first line
        if !WINDOWS()
            set shell=/bin/sh
        endif
    " }

    " Windows Compatible {
        " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
        " across (heterogeneous) systems easier.
        if WINDOWS()
          set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
        endif
    " }
    
    " Arrow Key Fix {
        " https://github.com/spf13/spf13-vim/issues/780
        if &term[:4] == "xterm" || &term[:5] == 'screen' || &term[:3] == 'rxvt'
            inoremap <silent> <C-[>OC <RIGHT>
        endif
    " }
    set clipboard=exclude:.*    "Do not connect to X server, vim -X
" }

    filetype plugin indent on   " Automatically detect file types.
    syntax on                   " Syntax highlighting
    scriptencoding utf-8

    set encoding=utf-8
    set termencoding=utf-8
    set fileencoding=utf-8
    set fileencodings=ucs-bom,utf-8,chinese,taiwan,japan,korea

    "leader key, <leader> = ','
    let mapleader = ','

    set background=dark         " Assume a dark background
    " Allow to trigger background
    function! ToggleBG()
        let s:tbg = &background
        " Inversion
        if s:tbg == "dark"
            set background=light
        else
            set background=dark
        endif
    endfunction
    noremap <leader>bg :call ToggleBG()<CR>

    " color {
    if isdirectory(expand("~/.vim/colors"))
        "color desert
        color PaperColor
        "color xian
        "color Monokai
        "color monokai-chris
        "color PapayaWhip
        "color anotherdart
        "color darkBlue
        "color molokai
        "color solarized
    else
        color desert
    endif
    " }

    if has('gui_running')
        set guioptions-=T           " Remove the toolbar
        set lines=40                " 40 lines of text instead of 24
        set mouse=a                 " Automatically enable mouse usage
        set mousehide               " Hide the mouse cursor while typing
        if LINUX() && has("gui_running")
            set guifont=Andale\ Mono\ Regular\ 12,Menlo\ Regular\ 11,Consolas\ Regular\ 12,Courier\ New\ Regular\ 14
        elseif OSX() && has("gui_running")
            set guifont=Andale\ Mono\ Regular:h12,Menlo\ Regular:h11,Consolas\ Regular:h12,Courier\ New\ Regular:h14
        elseif WINDOWS() && has("gui_running")
            set guifont=Andale_Mono:h10,Menlo:h10,Consolas:h10,Courier_New:h10
        endif
        "set guifont=Andale\ Mono\ Regular\ 12,Menlo\ Regular\ 11,Consolas\ Regular\ 12,Courier\ New\ Regular\ 14
    else
        "set mouse=a
        if &term == 'xterm' || &term == 'xterm-color' || &term == 'screen'
            set t_Co=256            " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
        endif
        "set term=builtin_ansi       " Make arrow and other keys work
    endif

    if has('cmdline_info')
        set ruler                   " Show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
        set showcmd                 " Show partial commands in status line and
                                    " Selected characters/lines in visual mode
    endif

    " Instead of reverting the cursor to the last position in the buffer, we
    " set it to the first line when editing a git commit message
    au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

    " http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
    " Restore cursor to file position in previous editing session
    " To disable this, add the following to your .vimrc.before.local file:
    "   let g:ypy_no_restore_cursor = 1
    if !exists('g:ypy_no_restore_cursor')
        function! ResCur()
            if line("'\"") <= line("$")
                silent! normal! g`"
                return 1
            endif
        endfunction

        augroup resCur
            autocmd!
            autocmd BufWinEnter * call ResCur()
        augroup END
    endif

    "set autowrite                       " Automatically write a file when leaving a modified buffer
    set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
    set foldmethod=indent               " indent, manual, expr, marker, syntax, diff
    set nofoldenable                    " When off, all folds are open.
    set foldnestmax=10                  " Sets the maximum nesting of folds for the "indent" and "syntax" methods.
    set virtualedit=onemore             " Allow for cursor beyond last character
    set history=1000                    " Store a ton of history (default is 20)
    "set spell                           " Spell checking on
    set nospell                           " Spell checking on
    set hidden                          " Allow buffer switching without saving
    set iskeyword-=.                    " '.' is an end of word designator
    set iskeyword-=#                    " '#' is an end of word designator
    set iskeyword-=-                    " '-' is an end of word designator
        
    if has('statusline')
        set laststatus=2

        " Broken down into easily includeable segments
        set statusline=%<%f\                     " Filename
        set statusline+=%w%h%m%r                 " Options
        if (v:version > 704)
            if !exists('g:override_ypy_pack/vendor/opts')
                set statusline+=%{fugitive#statusline()} " Git Hotness
            endif
        endif
        set statusline+=\ [%{&ff}/%Y]            " Filetype
        set statusline+=\ [%{getcwd()}]          " Current dir
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif

    set backspace=indent,eol,start  " Backspace for dummies
    set linespace=0                 " No extra spaces between rows
    set number                      " Line numbers on
    set showmatch                   " Show matching brackets/parenthesis
    set incsearch                   " Find as you type search
    set hlsearch                    " Highlight search terms
    set winminheight=0              " Windows can be 0 line high
    set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present
    set wildmenu                    " Show list instead of just completing
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
    set scrolljump=1                " Lines to scroll when cursor leaves screen
    set scrolloff=1                 " Minimum lines to keep above and below cursor
    set list
    "set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
    set listchars=tab:\ \   " Highlight problematic whitespace
    
    " '50     file mark, recent opened file is 50.
    " <50     Registers, Maximum number of lines saved for each register.
    " /50     Search String History, Maxmum number of items in the search pattern history to be saved.
    " :50     Command Line History, number is 50
    " h       Disable the effect of 'hlsearch' when loading the viminfo file.
    " r$TEMP: Removable media. Don't save TEMP info.
    " s10     Maximum size of an item in KBytes, 10KB
    " n/tmp/.viminfo
    " setviminfofile=/tmp/.viminfo
    "set viminfo='50,<50,/50,:50,h,r$TEMP:,s10,/tmp/pengyu/.viminfo
    set viminfo='50,<50,/50,:50,h,r$TEMP:,s10

    "au WinEnter * set cursorline nocursorcolumn  "cursorline, nocursorline,  cursorcolumn, nocursorcolumn
    set cursorline cursorcolumn
    augroup cch
        autocmd! cch
        autocmd WinLeave * set nocursorline nocursorcolumn
        autocmd WinEnter * set cursorline cursorcolumn
    augroup END

    set tabpagemax=15               " Only show 15 tabs
    set showmode                    " Display the current mode

" Formatting {
    set nowrap                      " Do not wrap long lines
    set autoindent                  " Indent at the same level of the previous line
    set shiftwidth=4                " Use indents of 4 spaces
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=4                   " An indentation every four columns
    set softtabstop=4               " Let backspace delete indent
    set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
    set splitright                  " Puts new vsplit windows to the right of the current
    set splitbelow                  " Puts new split windows to the bottom of the current
    "set matchpairs+=<:>            " Match, to be used with %
    set pastetoggle=<F12>           " pastetoggle (sane indentation on .. 
" }

" Key (re)Mappings {
    " Easier moving in tabs and windows
    " The lines conflict with the default digraph mapping of <C-K>
    " If you prefer that functionality, add the following to your
    " .vimrc.before.local file:
    let g:ypy_no_easyWindows = 1
    if !exists('g:ypy_no_easyWindows')
        map <C-J> <C-W>j<C-W>_
        map <C-K> <C-W>k<C-W>_
        map <C-L> <C-W>l<C-W>_
        map <C-H> <C-W>h<C-W>_
    endif

    " Wrapped lines goes down/up to next row, rather than next line in file.
    noremap j gj
    noremap k gk

    " End/Start of line motion keys act relative to row/wrap width in the
    " presence of `:set wrap`, and relative to line for `:set nowrap`.
    " Default vim behaviour is to act relative to text line in both cases
    " If you prefer the default behaviour, add the following to your
    " .vimrc.before.local file:
    let g:ypy_no_wrapRelMotion = 1
    if !exists('g:ypy_no_wrapRelMotion')
        " Same for 0, home, end, etc
        function! WrapRelativeMotion(key, ...)
            let vis_sel=""
            if a:0
                let vis_sel="gv"
            endif
            if &wrap
                execute "normal!" vis_sel . "g" . a:key
            else
                execute "normal!" vis_sel . a:key
            endif
        endfunction

        " Map g* keys in Normal, Operator-pending, and Visual+select
        noremap $ :call WrapRelativeMotion("$")<CR>
        noremap <End> :call WrapRelativeMotion("$")<CR>
        noremap 0 :call WrapRelativeMotion("0")<CR>
        noremap <Home> :call WrapRelativeMotion("0")<CR>
        noremap ^ :call WrapRelativeMotion("^")<CR>
        " Overwrite the operator pending $/<End> mappings from above
        " to force inclusive motion with :execute normal!
        onoremap $ v:call WrapRelativeMotion("$")<CR>
        onoremap <End> v:call WrapRelativeMotion("$")<CR>
        " Overwrite the Visual+select mode mappings from above
        " to ensure the correct vis_sel flag is passed to function
        vnoremap $ :<C-U>call WrapRelativeMotion("$", 1)<CR>
        vnoremap <End> :<C-U>call WrapRelativeMotion("$", 1)<CR>
        vnoremap 0 :<C-U>call WrapRelativeMotion("0", 1)<CR>
        vnoremap <Home> :<C-U>call WrapRelativeMotion("0", 1)<CR>
        vnoremap ^ :<C-U>call WrapRelativeMotion("^", 1)<CR>
    endif

    " The following two lines conflict with moving to top and
    " bottom of the screen
    " If you prefer that functionality, add the following to your
    " .vimrc.before.local file:
    let g:ypy_no_fastTabs = 1
    if !exists('g:ypy_no_fastTabs')
        map <S-H> gT
        map <S-L> gt
    endif

    " Stupid shift key fixes
    if !exists('g:ypy_no_keyfixes')
        if has("user_commands")
            command! -bang -nargs=* -complete=file E e<bang> <args>
            command! -bang -nargs=* -complete=file W w<bang> <args>
            command! -bang -nargs=* -complete=file Wq wq<bang> <args>
            command! -bang -nargs=* -complete=file WQ wq<bang> <args>
            command! -bang Wa wa<bang>
            command! -bang WA wa<bang>
            command! -bang Q q<bang>
            command! -bang QA qa<bang>
            command! -bang Qa qa<bang>
        endif

        cmap Tabe tabe
    endif

    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$

    " Code folding options
    nmap <leader>f0 :set foldlevel=0<CR>
    nmap <leader>f1 :set foldlevel=1<CR>
    nmap <leader>f2 :set foldlevel=2<CR>
    nmap <leader>f3 :set foldlevel=3<CR>
    nmap <leader>f4 :set foldlevel=4<CR>
    nmap <leader>f5 :set foldlevel=5<CR>
    nmap <leader>f6 :set foldlevel=6<CR>
    nmap <leader>f7 :set foldlevel=7<CR>
    nmap <leader>f8 :set foldlevel=8<CR>
    nmap <leader>f9 :set foldlevel=9<CR>

    " Most prefer to toggle search highlighting rather than clear the current
    " search results. To clear search highlighting rather than toggle it on
    " and off, add the following to your .vimrc.before.local file:
    let g:ypy_clear_search_highlight = 1
    if exists('g:ypy_clear_search_highlight')
        nmap <silent> <leader>/ :nohlsearch<CR>
    else
        nmap <silent> <leader>/ :set invhlsearch<CR>
    endif


    " Find merge conflict markers
    map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

    " Shortcuts
    " Change Working Directory to that of the current file
    cmap cwd lcd %:p:h
    cmap cd. lcd %:p:h

    " Visual shifting (does not exit Visual mode)
    vnoremap < <gv
    vnoremap > >gv
    
    " Select Ctrl-C to copy
    vmap <C-c> "+y

    " Allow using the repeat operator with a visual selection (!)
    " http://stackoverflow.com/a/8064607/127816
    vnoremap . :normal .<CR>

    " For when you forget to sudo.. Really Write the file.
    cmap w!! w !sudo tee % >/dev/null

    " Some helpers to edit mode
    " http://vimcasts.org/e/14
    cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
    map <leader>ew :e %%
    map <leader>es :sp %%
    map <leader>ev :vsp %%
    map <leader>et :tabe %%

    " Adjust viewports to the same size
    map <Leader>= <C-w>=

    " Map <Leader>ff to display all lines with keyword under cursor
    " and ask which one to jump to
    nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

    " Easier horizontal scrolling
    map zl zL
    map zh zH

    " Easier formatting
    nnoremap <silent> <leader>q gwip

    " FIXME: Revert this f70be548
    " fullscreen mode for GVIM and Terminal, need 'wmctrl' in you PATH
    map <silent> <F11> :call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")<CR>

    map <F9> :w<CR>
    nnoremap <leader>w :w<CR>
" }


" NerdTree {
    if isdirectory(expand("~/.vim/pack/vendor/opt/nerdtree"))
        map <C-e> :NERDTreeToggle<CR>
        map <leader>e :NERDTreeFind<CR>
        nmap <leader>nt :NERDTreeFind<CR>

        let NERDTreeShowBookmarks=1
        let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
        let NERDTreeChDirMode=0
        let NERDTreeQuitOnOpen=0
        let NERDTreeMouseMode=2
        let NERDTreeShowHidden=1
        let NERDTreeKeepTreeInNewTab=1
        let NERDTreeAutoCenter=1
        let NERDTreeAutoCenterThreshold=3
        let g:nerdtree_tabs_open_on_gui_startup=0
        let g:nerdtree_tabs_open_on_console_startup=0
        let g:nerdtree_tabs_smart_startup_focus=2
        let g:nerdtree_tabs_on_new_tab=1
        let g:nerdtree_tabs_autoclose=0
    endif
" }

" TagBar {
    if isdirectory(expand("~/.vim/pack/vendor/opt/tagbar/"))
        "autocmd VimEnter *Tagbar
        let g:tagbar_autofocus = 1
        let g:tagbar_width = 40
        let g:tagbar_autoclose = 0
        let g:tagbar_sort = 0              " 0 = order by file location; 1 = order by name
        let g:tagbar_map_togglesort = "s"  " troggle sort order between name and file order
        let g:tagbar_autoshowtag = 1
        nnoremap <silent> <leader>t :TagbarToggle<CR>
    endif
"}

" OmniComplete {
    " To disable omni complete, add the following to your .vimrc.before.local file:
    let g:ypy_no_omni_complete = 1
    if !exists('g:ypy_no_omni_complete')
        if has("autocmd") && exists("+omnifunc")
            autocmd Filetype *
                \if &omnifunc == "" |
                \setlocal omnifunc=syntaxcomplete#Complete |
                \endif
        endif

        hi Pmenu  guifg=#000000 guibg=#F8F8F8 ctermfg=black ctermbg=Lightgray
        hi PmenuSbar  guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan ctermbg=lightgray cterm=NONE
        hi PmenuThumb  guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermbg=darkcyan cterm=NONE

        " Some convenient mappings
        " if opened, it will cause problem with the <Esc>/<UP>/<Down> to A/B/C/D
        inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
        if exists('g:ypy_map_cr_omni_complete')
            inoremap <expr> <CR>     pumvisible() ? "\<C-y>" : "\<CR>"
        endif
        inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
        inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
        inoremap <expr> <C-d>      pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
        inoremap <expr> <C-u>      pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

        " Automatically open and close the popup menu / preview window
        au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
        set completeopt=menu,preview,longest
    endif
" }

" Ctags {
    set tags=./tags;/,~/.vimtags

    " Make tags placed in .git/tags file available in all levels of a repository
    let gitroot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
    if gitroot != ''
        let &tags = &tags . ',' . gitroot . '/.git/tags'
    endif
    
    "<C-]> jump new split. not new buffers
    nnoremap <silent> <C-LeftMouse> :winc ]<CR>
    nnoremap <silent> <C-Bslash> :vertical winc ]<CR>  " Same as: <Ctrl-\>
" }

" ctrlp {
if (v:version < 800)
    if isdirectory(expand("~/.vim/pack/vendor/opt/ctrlp.vim/"))
        let g:ctrlp_working_path_mode = 'ra'
        nnoremap <silent> <D-t> :CtrlP<CR>
        nnoremap <silent> <D-r> :CtrlPMRU<CR>
        let g:ctrlp_custom_ignore = {
            \ 'dir':  '\.git$\|\.hg$\|\.svn$',
            \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }

        if executable('ag')
            let s:ctrlp_fallback = 'ag %s --nocolor -l -g ""'
        elseif executable('ack-grep')
            let s:ctrlp_fallback = 'ack-grep %s --nocolor -f'
        elseif executable('ack')
            let s:ctrlp_fallback = 'ack %s --nocolor -f'
        " On Windows use "dir" as fallback command.
        "elseif WINDOWS()
        "    let s:ctrlp_fallback = 'dir %s /-n /b /s /a-d'
        else
            let s:ctrlp_fallback = 'find %s -type f'
        endif
        if exists("g:ctrlp_user_command")
            unlet g:ctrlp_user_command
        endif
        let g:ctrlp_user_command = {
            \ 'types': {
                \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
                \ 2: ['.hg', 'hg --cwd %s locate -I .'],
            \ },
            \ 'fallback': s:ctrlp_fallback
        \ }

        if isdirectory(expand("~/.vim/pack/vendor/opt/ctrlp-funky/"))
            " CtrlP extensions
            let g:ctrlp_extensions = ['funky']

            "funky
            nnoremap <Leader>fu :CtrlPFunky<Cr>
        endif
    endif
endif
"}

" LeaderF {
if (v:version >= 800)
    if isdirectory(expand("~/.vim/pack/vendor/opt/LeaderF/"))
        " don't show the help in normal mode
        let g:Lf_HideHelp = 1
        let g:Lf_UseCache = 0
        let g:Lf_UseVersionControlTool = 0
        let g:Lf_IgnoreCurrentBufferName = 1
        let g:Lf_StlColorscheme = 'Powerline' "popup  powerline  solarized  onedark one
        let g:Lf_AutoResize = 1
        let g:Lf_WindowHeight = 0.30
        let g:Lf_MruEnableFrecency = 1
        let g:Lf_QuickSelect = 1

        " Set patterns for LeaderF to ignore specific directories and file types
        let g:Lf_WildIgnore = {
            \ 'dir': ['.git', '.hg', '.svn'],
            \ 'file': ['*.o', '*.a', '*.d', '*.i', '*.s', '*.bc', '*.so', '*.pyc', '*.swp', '*.class']
            \ }
        
        " Configure LeaderF to ignore certain files and directories specifically for the Most Recently Used (MRU) functionality
        let g:Lf_MruWildIgnore = {
            \ 'dir': ['.git', '.hg', '.svn'],
            \ 'file': ['*.o', '*.a', '*.d', '*.i', '*.s', '*.bc', '*.so', '*.pyc', '*.swp', '*.class']
            \}

        " Difference from g:Lf_WildIgnore:
        " g:Lf_WildIgnore is used for general file and directory ignoring across all LeaderF functionalities,
        " such as file searching, whereas g:Lf_MruWildIgnore and g:Lf_MruFileExclude specifically tailor
        " what appears in the MRU list, impacting only the MRU functionality.

        " popup mode
        let g:Lf_WindowPosition = 'popup'
        let g:Lf_PopupColorscheme = 'onedark'
        let g:Lf_PopupPosition = [5, 0]
        let g:Lf_PreviewInPopup = 1
        let g:Lf_PopupPreviewPosition = 'cursor'
        let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" }
        let g:Lf_PreviewResult = {
                \ 'File': 0,
                \ 'Buffer': 0,
                \ 'Mru': 0,
                \ 'Tag': 0,
                \ 'BufTag': 1,
                \ 'Function': 1,
                \ 'Line': 0,
                \ 'Colorscheme': 0,
                \ 'Rg': 0,
                \ 'Gtags': 0
                \}

        "let g:Lf_ShortcutF = "<leader>ff"
        let g:Lf_ShortcutF = '<C-p>'
        nnoremap <Leader>m :LeaderfMru<CR>

        let g:Lf_ShortcutB = '<C-b>'
        let g:Lf_CommandMap = {'<C-K>': ['<Up>'], '<C-J>': ['<Down>']}
        
        noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
        noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
        noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
        noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>

        noremap <C-B> :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR>
        noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>
        " search visually selected text literally
        xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>
        noremap go :<C-U>Leaderf! rg --recall<CR>

        " should use `Leaderf gtags --update` first
        let g:Lf_GtagsAutoGenerate = 0
        let g:Lf_Gtagslabel = 'native-pygments'
        noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
        noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
        noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
        noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
        noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>
        
        let g:Lf_WindowPosition = 'popup'
        let g:Lf_PreviewInPopup = 1
        " Show icons, icons are shown by default
        let g:Lf_ShowDevIcons = 1
        " For GUI vim, the icon font can be specify like this, for example
        let g:Lf_DevIconsFont = "DroidSansM Nerd Font Mono"
        " If needs
        set ambiwidth=double
    endif
endif
" }

" vim-airline {
    " Set configuration options for the statusline plugin vim-airline.
    " Use the powerline theme and optionally enable powerline symbols.
    " To use the symbols , , , , , , and .in the statusline
    " segments add the following to your .vimrc.before.local file:
    "   let g:airline_powerline_fonts=1
    " If the previous symbols do not render for you then install a
    " powerline enabled font.
    nnoremap <C-tab> :bn<CR>     " Ctrl-tab
    nnoremap <C-s-tab> :bp<CR>   " Ctrl-Shift-tab

    " open vertical split buffer [Number], command: [:vb N] => left|right
    " and other command: [:sb N] => up/down
    cabbrev vb vert sb

    let g:airline#extensions#tabline#formatter = 'unique_tail'
    let g:airline#extensions#tabline#enabled=1
    let g:airline#extensions#tabline#show_splits = 1
    let g:airline#extensions#tabline#show_buffers = 1
    let g:airline#extensions#tabline#buffer_nr_show = 1
    let g:airline#extensions#tabline#show_tabs = 1
    let g:airline#extensions#tabline#show_tab_nr = 1
    let g:airline#extensions#tabline#exclude_preview = 1
    let g:airline#extensions#tabline#tab_nr_type = 1
    let g:airline#extensions#gutentags#enabled = 1


    " See `:echo g:airline_theme_map` for some more choices
    " Default in terminal vim is 'dark'
    if isdirectory(expand("~/.vim/pack/vendor/start/vim-airline-themes/"))
        "if !exists('g:airline_theme')
        "    let g:airline_theme = 'solarized'
        "endif
        "if !exists('g:airline_powerline_fonts')
            " Use the default set of separators with a few customizations
        "    let g:airline_left_sep='›'  " Slightly fancier than '>'
        "    let g:airline_right_sep='‹' " Slightly fancier than '<'
        "endif
    endif
" }
"
" vim-bufferline {
    "denotes bufferline should automatically echo to the command bar
    let g:bufferline_echo = 0
" }


" NerdCommenter {
    if isdirectory(expand("~/.vim/pack/vendor/opt/nerdcommenter/"))
        let g:NERDAltDelims_c = 1
        let g:NERDAltDelims_cpp = 1
        let g:NERDAltDelims_h = 1
    endif
" }


" neocomplete {
    if isdirectory(expand("~/.vim/pack/vendor/opt/neocomplete.vim/"))
        let g:acp_enableAtStartup = 0
        let g:neocomplete#enable_at_startup = 1
        let g:neocomplete#enable_smart_case = 1
        let g:neocomplete#enable_auto_delimiter = 1
        let g:neocomplete#max_list = 15
        let g:neocomplete#force_overwrite_completefunc = 1


        " Define dictionary.
        let g:neocomplete#sources#dictionary#dictionaries = {
                    \ 'default' : '',
                    \ 'vimshell' : $HOME.'/.vimshell_hist',
                    \ 'scheme' : $HOME.'/.gosh_completions'
                    \ }

        " Define keyword.
        if !exists('g:neocomplete#keyword_patterns')
            let g:neocomplete#keyword_patterns = {}
        endif
        let g:neocomplete#keyword_patterns['default'] = '\h\w*'

        " Plugin key-mappings {
            " These two lines conflict with the default digraph mapping of <C-K>
            if !exists('g:ypy_no_neosnippet_expand')
                imap <C-k> <Plug>(neosnippet_expand_or_jump)
                smap <C-k> <Plug>(neosnippet_expand_or_jump)
            endif
            if exists('g:ypy_noninvasive_completion')
                inoremap <CR> <CR>
                " <ESC> takes you out of insert mode
                inoremap <expr> <Esc>   pumvisible() ? "\<C-y>\<Esc>" : "\<Esc>"
                " <CR> accepts first, then sends the <CR>
                inoremap <expr> <CR>    pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
                " <Down> and <Up> cycle like <Tab> and <S-Tab>
                inoremap <expr> <Down>  pumvisible() ? "\<C-n>" : "\<Down>"
                inoremap <expr> <Up>    pumvisible() ? "\<C-p>" : "\<Up>"
                " Jump up and down the list
                inoremap <expr> <C-d>   pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
                inoremap <expr> <C-u>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"
            else
                " <C-k> Complete Snippet
                " <C-k> Jump to next snippet point
                imap <silent><expr><C-k> neosnippet#expandable() ?
                            \ "\<Plug>(neosnippet_expand_or_jump)" : (pumvisible() ?
                            \ "\<C-e>" : "\<Plug>(neosnippet_expand_or_jump)")
                smap <TAB> <Right><Plug>(neosnippet_jump_or_expand)

                inoremap <expr><C-g> neocomplete#undo_completion()
                inoremap <expr><C-l> neocomplete#complete_common_string()
                "inoremap <expr><CR> neocomplete#complete_common_string()

                " <CR>: close popup
                " <s-CR>: close popup and save indent.
                if (v:version > 704)
                    inoremap <expr><s-CR> pumvisible() ? neocomplete#smart_close_popup()."\<CR>" : "\<CR>"
                endif

                function! CleverCr()
                    if pumvisible()
                        if neosnippet#expandable()
                            let exp = "\<Plug>(neosnippet_expand) <C-k>"
                            return exp . neocomplete#smart_close_popup()
                        else
                            return neocomplete#smart_close_popup()
                        endif
                    else
                        return "\<CR>"
                    endif
                endfunction

                " <CR> close popup and save indent or expand snippet
                imap <expr> <CR> CleverCr()
                " <C-h>, <BS>: close popup and delete backword char.
                inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
                inoremap <expr><C-y> neocomplete#smart_close_popup()
            endif
            " <TAB>: completion.
            inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
            inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"

            " Courtesy of Matteo Cavalleri

            function! CleverTab()
                if pumvisible()
                    return "\<C-n>"
                endif
                let substr = strpart(getline('.'), 0, col('.') - 1)
                let substr = matchstr(substr, '[^ \t]*$')
                if strlen(substr) == 0
                    " nothing to match on empty string
                    return "\<Tab>"
                else
                    " existing text matching
                    if neosnippet#expandable_or_jumpable()
                        return "\<Plug>(neosnippet_expand_or_jump)"
                    else
                        return neocomplete#start_manual_complete()
                    endif
                endif
            endfunction

            imap <expr> <Tab> CleverTab()
        " }

        " Enable heavy omni completion.
        if !exists('g:neocomplete#sources#omni#input_patterns')
            let g:neocomplete#sources#omni#input_patterns = {}
        endif
        "let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
        let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
        let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
        let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
        "let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
    endif
" }

" vim-interestingwords {
    if isdirectory(expand("~/.vim/pack/vendor/opt/vim-interestingwords/"))
        " max support words number is 12.
        let g:interestingWordsGUIColors = ['#8CCBEA', '#A4E57E', '#FFDB72', '#FF7272', '#FFB3FF', '#9999FF', '#B5F5EC', '#FFFDD0', '#BAE637', '#D0BFFF', '#50E3C2', '#FCC419']
        " Term 256bit color see:
        " open ~/.vim/pack/vendor/opt/vim-interestingwords/Xterm_256color_chart.svg
        "   use chrome or firefox open
        " or open URL: https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg
        let g:interestingWordsTermColors = ['154', '121', '211', '137', '214', '222', '051', '063', '022', '226', '199', '033']
        let g:interestingWordsRandomiseColors = 1 
    endif
" }

" syntastic
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    let g:syntastic_enable_signs = 1
    let g:syntastic_error_symbol='✗'
    let g:syntastic_warning_symbol='►'    
    let g:syntastic_check_on_open = 1
    "let g:syntastic_auto_jump = 1
    let g:syntastic_check_on_wq = 0
    let g:syntastic_enable_highlighting=1
    
    let g:syntastic_always_populate_loc_list = 0
    let g:syntastic_auto_loc_list = 0
    let g:syntastic_loc_list_height = 5

    let g:syntastic_cpp_remove_include_errors = 1
    let g:syntastic_cpp_checkers = ['gcc']
    let g:syntastic_cpp_compiler = 'gcc'
    let g:syntastic_cpp_compiler_options = '-std=c++11'


" }

" Rainbow {
    if isdirectory(expand("~/.vim/pack/vendor/opt/rainbow/"))
        let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
    endif
"}

" Fugitive {
    if isdirectory(expand("~/.vim/pack/vendor/opt/vim-fugitive/"))
        nnoremap <silent> <leader>gs :Git status<CR>
        nnoremap <silent> <leader>gd :Git diff<CR>
        nnoremap <silent> <leader>gc :Git commit<CR>
        nnoremap <silent> <leader>gb :Git blame<CR>
        nnoremap <silent> <leader>gl :Git log<CR>
        nnoremap <silent> <leader>gp :Git push<CR>
        nnoremap <silent> <leader>gr :Git read<CR>
        nnoremap <silent> <leader>gw :Git write<CR>
        nnoremap <silent> <leader>ge :Git edit<CR>
        " Mnemonic _i_nteractive
        nnoremap <silent> <leader>gi :Git add -p %<CR>
        nnoremap <silent> <leader>gg :SignifyToggle<CR>
    endif
"}

" Tabularize {
    if isdirectory(expand("~/.vim/pack/vendor/opt/tabular/"))
        nmap <Leader>a& :Tabularize /&<CR>
        vmap <Leader>a& :Tabularize /&<CR>
        nmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
        vmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
        nmap <Leader>a=> :Tabularize /=><CR>
        vmap <Leader>a=> :Tabularize /=><CR>
        nmap <Leader>a: :Tabularize /:<CR>
        vmap <Leader>a: :Tabularize /:<CR>
        nmap <Leader>a:: :Tabularize /:\zs<CR>
        vmap <Leader>a:: :Tabularize /:\zs<CR>
        nmap <Leader>a, :Tabularize /,<CR>
        vmap <Leader>a, :Tabularize /,<CR>
        nmap <Leader>a,, :Tabularize /,\zs<CR>
        vmap <Leader>a,, :Tabularize /,\zs<CR>
        nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
        vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
    endif
" }

" Session List {
    set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
    if isdirectory(expand("~/.vim/pack/vendor/opt/sessionman.vim/"))
        nmap <leader>sl :SessionList<CR>
        nmap <leader>ss :SessionSave<CR>
        nmap <leader>sc :SessionClose<CR>
    endif
" }

" easymotion {
    if isdirectory(expand("~/.vim/pack/vendor/opt/vim-easymotion/"))
        nmap <leader>b <Plug>(easymotion-b)
        nmap <leader>n <Plug>(easymotion-w)
    endif
" }

" vim-floaterm {
    if isdirectory(expand("~/.vim/pack/vendor/opt/vim-floaterm/"))
        "Enable shortcut key support
        let g:floaterm_keymap_enabled = 1
        
        "Set the default terminal type (e.g., bash, zsh, powershell, etc.)
        let g:floaterm_default_term = 'bash'
        
        "Set the size of the floating terminal window and position
        " Type Number (number of columns) or Float (between 0 and 1). If Float, the width is relative to &columns. Default: 0.6
        let g:floaterm_width = 0.8
        let g:floaterm_height = 0.3
        "let g:floaterm_wintype = 'float'
        let g:floaterm_position = 'center'
        let g:floaterm_wintype = 'split'
        let g:floaterm_position = 'belowright'

        " Set the opacity of the floating terminal to 80%
        let g:floaterm_opencmd = 'silent !kitty @ --to=unix:/tmp/mykitty new-window --cwd=current'
        let g:floaterm_opener = 'drop'
        "Set the terminal title
        let g:floaterm_title = 'floaterm($1/$2)'
        "let g:floaterm_title = 'Floating Terminal'

        "Open a terminal automatically on startup
        let g:floaterm_auto_open = 1
        
        "Set the terminal background transparency (0-100, 0 being fully transparent, 100 being opaque)
        let g:floaterm_transparency = 10
        
        "Set the terminal font
        let g:floaterm_font = 'Fira Code Retina'
        
        "Set the terminal color scheme (requires a compatible terminal emulator)
        let g:floaterm_color_scheme = 'dracula'
        
        "Map a shortcut key for opening a new terminal
        nnoremap <leader>ft :FloatermNew<CR>
        nnoremap <silent> <F7> :FloatermToggle<CR>
        tnoremap <silent> <F7> <C-\><C-n>:FloatermToggle<CR>
    endif
" }

" vim-startify {
    if isdirectory(expand("~/.vim/pack/vendor/start/vim-startify"))

        " Display the Startify interface upon Vim start if no files were specified
        autocmd VimEnter * if !argc() | Startify | endif

    "    " Set the number of most recently used files to display in the Startify list
        let g:startify_files_number = 10

    "    " Customize the Startify interface title
    "    let g:startify_custom_header = 'echo split("Welcome to Vim", "\n")'

    "    " Add bookmarks to Startify
        let g:startify_bookmarks = [
              \ { 'i': '~/.vimrc' },
              \ { 'z': '~/.zshrc' }
              \ ]

    "    " Set the directory where Startify sessions are stored
        let g:startify_session_dir = '~/.vimsessions'

    "    " Automatically save the session when exiting Vim
        let g:startify_session_persistence = 1

    "    " Disable Unicode art in the Startify interface
        let g:startify_fortune_use_unicode = 0

    "    " Customize the layout of the Startify list
    "    let g:startify_lists = [
    "          \ { 'type': 'sessions',  'header': ['   Sessions']       },
    "          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
    "          \ { 'type': 'files',     'header': ['   Recent Files']   },
    "          \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
    "          \ { 'type': 'commands',  'header': ['   Commands']       }
    "          \ ]

    endif
" }

" Automatically insert file header when creating new .c, .h, .sh, .java files   
" 'normal G' Automatically move cursor to end of file after creating a new file
" AutoInsertFileHeaderInformation {
    
    " If you want to use it, remove the following comments
    " autocmd BufNewFile *.cpp,*.c,*.h,*.sh,*.java,*.py call SetFileTitle() | execute 'normal! G'
    
    " Define function SetTitle to automatically insert file header   
    function! SetFileTitle()
        "If the file type is '.sh', open new.py, use :set `filetype?`, check "filetype
        if &filetype == 'sh' || &filetype == 'python'
            call setline(1,          "\#########################################################################")
            call append(line("."),   "\# File Name: ".expand("%"))
            call append(line(".")+1, "\# Author: ****")
            call append(line(".")+2, "\# Email: ****@****.com")
            call append(line(".")+3, "\# Created Time: ".strftime("%c"))
            call append(line(".")+4, "\#########################################################################")
        elseif &filetype == 'cpp' || &filetype == 'c' || &filetype == 'java'
            call setline(1,          "/*************************************************************************")
            call append(line("."),   "    > File Name: ".expand("%"))
            call append(line(".")+1, "    > Author: ****")
            call append(line(".")+2, "    > Email: ****@****.com")
            call append(line(".")+3, "    > Created Time: ".strftime("%c"))
            call append(line(".")+4, " ************************************************************************/")
            call append(line(".")+5, "")
        endif
        
        if &filetype == 'sh'
            call append(line(".")+5, "\#!/bin/bash")
            call append(line(".")+6, "")
        elseif &filetype == 'cpp'
            call append(line(".")+6, "#include<iostream>")
            call append(line(".")+7, "using namespace std;")
            call append(line(".")+8, "")
        elseif &filetype == 'c'
            call append(line(".")+6, "#include<stdio.h>")
            call append(line(".")+7, "")
        endif  
    " Automatically move cursor to end of file after creating a new file  
    " autocmd BufNewFile *.cpp,*.c,*.h,*.sh,*.java,*.py execute 'normal! G'
    endfunc
" }

let g:LargeFile = 10      " gather than 10MB

nnoremap <silent> <F9> : let @+=expand('%:p')<CR>
nnoremap <silent> <F10> : let @+=expand('%')<CR>

let $BASH_ENV = "~/.vim/.vim_bash_env"
map tgg :!tgg <C-V><C-J> :e<CR>


" backup / undofile 
set backup                  " Backups are nice ...
"set backupext=.bk           " String which is appended to a file name
"set backupdir=~/.vimbackup/
"set backupskip=~/.vimbackup/
if has('persistent_undo')
    set undofile                " So is persistent undo ...
    set undolevels=1000         " Maximum number of changes that can be undone
    set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
endif

"swp file
"set directory=~/.vimswap/


" Initialize directories {
function! InitializeDirectories()
    let parent = $HOME
    let prefix = 'vim'
    let dir_list = {
                \ 'backup': 'backupdir',
                \ 'views': 'viewdir',
                \ 'swap': 'directory' }

    if has('persistent_undo')
        let dir_list['undo'] = 'undodir'
    endif

    " To specify a different directory in which to place the vimbackup,
    " vimviews, vimundo, and vimswap files/directories, add the following to
    " your .vimrc.before.local file:
    "   let g:ypy_consolidated_directory = <full path to desired directory>
    "   eg: let g:ypy_consolidated_directory = $HOME . '/.vim/'
    if exists('g:ypy_consolidated_directory')
        let common_dir = g:ypy_consolidated_directory . prefix
    else
        let common_dir = parent . '/.' . prefix
    endif

    for [dirname, settingname] in items(dir_list)
        let directory = common_dir . dirname . '/'
        if exists("*mkdir")
            if !isdirectory(directory)
                call mkdir(directory)
            endif
        endif
        if !isdirectory(directory)
            echo "Warning: Unable to create backup directory: " . directory
            echo "Try: mkdir -p " . directory
        else
            let directory = substitute(directory, " ", "\\\\ ", "g")
            exec "set " . settingname . "=" . directory
        endif
    endfor
endfunction
call InitializeDirectories()
" }


" KeyMap
"
" tagbar  -------------->  [,t] (function list)
"
" ctrlp   -------------->  [C-p] (Ctrl-p, search file name)
"
" nerdcommenter  ------->  [,cc] (single line)
"                          [,ci] (multi lines)
"                          [,cu] (cancel commenter)
"                          [,c ] (_ space, switch and or cancel)
"                          [,ca] (switch // or /* */)
"
" vim-eaysmotion  ------>  [,,w] (up,   Jump up to file position)
"                          [,,b] (down, Jump down to file position)
"
" vim-interestingwords ->  [,k] (Highlight, or Clear every word highlight ), Navigate highlighted words with 'n' and 'N'
"                          [n]  (Navigate highlighted words, down)
"                          [N]  (Navigate highlighted words, up)
"
" 
" vim-fugitive --------->  [:G] (or :Git , how to use :Git)
"                          [:Git commit] ()
"                          [:Git diff] ()
"                          [:Git status] ()
"                          [:Git blame] ()
"                          [:Git mergetool] ()

" vim-startuptime ------>  :StartupTime
"                          help vim-startuptime

" version < 800, 8.0 or 704, 7,4
if (v:version < 800)
    call plug#begin()
        Plug 'preservim/nerdtree'
        "Plug 'scrooloose/nerdtree' "old
        Plug 'majutsushi/tagbar'
        Plug 'jistr/vim-nerdtree-tabs'
        "Plug 'Yggdroot/LeaderF'
        Plug 'ctrlpvim/ctrlp.vim'
        Plug 'tacahiroy/ctrlp-funky'
        Plug 'vim-airline/vim-airline'
        Plug 'vim-airline/vim-airline-themes'
        Plug 'scrooloose/nerdcommenter'
        Plug 'bling/vim-bufferline'
        Plug 'plugged/autoload_cscope.vim'
        Plug 'plugged/vim-interestingwords'
        Plug 'Shougo/neocomplete.vim'
        Plug 'Shougo/neosnippet'
        Plug 'Shougo/neosnippet-snippets'
        Plug 'honza/vim-snippets'
        Plug 'hari-rangarajan/CCTree'
        Plug 'dstein64/vim-startuptime'
        Plug 'ludovicchabant/vim-gutentags'
        "Plug 'junegunn/vim-slash'
        Plug 'mileszs/ack.vim'
        Plug 'voldikss/vim-floaterm'
        Plug 'mhinz/vim-startify'
    call plug#end()
endif

" version >=800, version 8.0
if (v:version >= 800)
"{
    function! PackLoadAll(Timer)
        packadd nerdtree
        packadd tagbar
        packadd vim-nerdtree-tabs
        packadd LeaderF
        "packadd ctrlp.vim
        "packadd ctrlp-funky
        packadd undotree
        packadd nerdcommenter
        "packadd vim-bufferline
        packadd vim-easymotion
        packadd vim-surround
        "packadd syntastic
        packadd auto-pairs
        packadd vim-interestingwords
        packadd rainbow
        packadd vim-repeat
        packadd neocomplete.vim
        packadd neoinclude.vim
        packadd neosnippet
        packadd neosnippet-snippets
        packadd vim-multiple-cursors
        packadd vim-fugitive
        packadd tabular
        packadd vim-snippets
        packadd sessionman.vim
        packadd CCTree
        packadd vim-startuptime
        packadd vim-gutentags
        "packadd vim-slash   "Automatically clears search highlight when cursor is moved
        packadd ack.vim
        packadd vim-floaterm
        packadd vim-startify
        "packadd vim-preview   "in start/
    endfunction

    noremap <Leader>pp :call PackLoadAll(1)<CR>

    let Timer = timer_start(600, 'PackLoadAll')
    endif
"}

