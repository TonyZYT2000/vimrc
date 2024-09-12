# vimrc

ZYT's .vimrc!

![vimrc](https://s1.ax1x.com/2020/03/12/8VBpVI.png)

## Setup

Install [vim-plug](https://github.com/junegunn/vim-plug) to get plugins I use.

- Unix
    ```bash
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    ```

- Windows (Powershell)
    ```powershell
    md ~\vimfiles\autoload
    $uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    (New-Object Net.WebClient).DownloadFile(
      $uri,
      $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(
        "~\vimfiles\autoload\plug.vim"
      )
    )
    ```

Create soft link  in user directory.

- Unix

    ```bash
    ln -s ./.vimrc ~/.vimrc
    ```

- Windows

    ```power
    New-Item -ItemType SymbolicLink -Target .\.vimrc -Path ~\.vimrc 
    ```

Then in vim, run ``:PlugInstall`` and all set!

## Plugins

- [elze/vim-json](https://github.com/elzr/vim-json): Better JSON highlighting.
- [tomasr/molokai](https://github.com/tomasr/molokai): Molokai color theme.
- [ap/vim-css-color](https://github.com/ap/vim-css-color): Highlight color values.
- [junegunn/fzf.vim](https://github.com/junegunn/fzf.vim): Fuzzy search in vim!
    - Fuzzy file search mapped to `Ctrl+P`.
    - `Ctrl+j/k` to move between results.
    - `Ctrl+t` to open search result in new tab.
    - `Ctrl+x` to open search result in horizontal split window.
    - `Ctrl+v` to open search result in vertical split window.
- [mhinz/vim-signify](https://github.com/mhinz/vim-signify): Show git diff in sign column.
- [majutsushi/tagbar](https://github.com/majutsushi/tagbar): Browse tags!
    - [Exuberant Ctags](http://ctags.sourceforge.net/) required.
    - Mapped to `Alt+T`.
- [tpope/vim-fugitive](https://github.com/tpope/vim-fugitive): Git integration.
    - Enter `:G` for `git status`!. Then, press `g?` for more commands.
- [tpope/vim-surround](https://github.com/tpope/vim-surround): Change surrounding symbols easily.
    - Type `cs{old}{new}` to change surrounding from old char to new char.
- [luochen1990/rainbow](https://github.com/luochen1990/rainbow): Rainbow parentheses. Useful for Lisp!
- [joshdick/onedark.vim](https://github.com/joshdick/onedark.vim): Onedark color theme.
- [raimondi/delimitmate](https://github.com/Raimondi/delimitMate): Automatic closing.
- [sheerun/vim-polyglot](https://github.com/sheerun/vim-polyglot): Language pack.
- [wakatime/vim-wakatime](https://github.com/wakatime/vim-wakatime): WakaTime coding time counter.
- [itchyny/lightline.vim](https://github.com/itchyny/lightline.vim): Beautiful status line.
- [wlangstroth/vim-racket](https://github.com/wlangstroth/vim-racket): Racket support.
- [voldikss/vim-translator](https://github.com/voldikss/vim-translator): Translate text in vim to Chinese.
    - Type `<Space>tt` to translate current word in command line.
    - Type `<Space>tw` to translate current word in a pop-up window.
    - Type `<Space>tr` to replace current word with translation.
- [scrooloose/nerdcommenter](https://github.com/preservim/nerdcommenter): Commet blocks of codes easily!
    - Type `<Space>cc` to comment out the line.
    - Type `<Space>cu` to uncomment the line.
    - Type `<Space>cs` to comment in a block.
    - Type `<Space>c$` to comment from cursor to end of line.
    - Type `<Space>cA` to add a comment block at end of line and enter insert mode.
    - Type `<Space>c<Space>` to toggle comment status of the line.
    - Use visual mode to select multiple lines of code, and type `<Space>cc` to comment each line.
    - Use visual mode to select multiple lines of code, and type `<Space>cs` to comment lines as a block.
    - Use visual mode to select a block of code, and type `<Space>cu` to uncomment the block
- [terryma/vim-smooth-scroll](https://github.com/terryma/vim-smooth-scroll): Make scrolling in vim smooth.
- [easymotion/vim-easymotion](https://github.com/easymotion/vim-easymotion): Move cursor around easily.
    - Type `s{char}{char}` to search for 2 characters and move to them.
    - Type `<Space><Space>f{char}` to search for 1 character and move to them.
    - Type `<Space><Space>w` to move to a word.
    - Type `<Space><Space>L` to move to a line.
    - Type `<Space><Space>h` to move left with EasyMotion.
    - Type `<Space><Space>j` to move down with EasyMotion.
    - Type `<Space><Space>k` to move up with EasyMotion.
    - Type `<Space><Space>l` to move right with EasyMotion.
- [skywind3000/vim-terminal-help](https://github.com/skywind3000/vim-terminal-help): Nice terminal integration.
    - Mapped to `Alt+=`.
    - Type `Ctrl+\ Ctrl+N` to enter normal mode in terminal.
- [scrooloose/nerdtree](https://github.com/preservim/nerdtree): A tree explorer on side.
    - Mapped to `Alt+E`.
- [ivalkeen/nerdtree-execute](https://github.com/ivalkeen/nerdtree-execute): Execute the file selected in NERDTree.
    - In NERDTree, press `m` to open up menu, and then press `x`.
