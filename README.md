# vimrc
ZYT's .vimrc!

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

Then in vim, run ``:PlugInstall`` and all set!

## Plugins

- [elze/vim-json](https://github.com/elzr/vim-json): Better JSON highlighting.

- [tomasr/molokai](https://github.com/tomasr/molokai): Molokai color theme.

- [ap/vim-css-color](https://github.com/ap/vim-css-color): Highlight color values.

- [majutsushi/tagbar](https://github.com/majutsushi/tagbar): Browse tags!
    - [Excuberant Ctag](http://ctags.sourceforge.net/) required.
    - Mapped to `Alt+T`.

- [tpope/vim-fugitive](https://github.com/tpope/vim-fugitive): Git integration.
    - Enter `:G` for `git status`!. Then, press `g?` for more commands.

- [tpope/vim-surround](https://github.com/tpope/vim-surround): Change surrounding symbols easily.

- [joshdick/onedark.vim](https://github.com/joshdick/onedark.vim): Onedark color theme.

- [raimondi/delimitmate](https://github.com/Raimondi/delimitMate): Automatic closing.

- [sheerun/vim-polyglot](https://github.com/sheerun/vim-polyglot): Language pack.

- [itchyny/lightline.vim](https://github.com/itchyny/lightline.vim): Beautiful status line.

- [airblade/vim-gitgutter](https://github.com/airblade/vim-gitgutter): Show differences on side.

- [wlangstroth/vim-racket](https://github.com/wlangstroth/vim-racket): Racket support.

- [scrooloose/nerdcommenter](https://github.com/preservim/nerdcommenter): Commet blocks of codes easily!
    - Type `\cc` to comment out the line.
    - Use visual mode to select a block of code, and type `\cc` to comment the block.
    - Use visual mode to select a block of code, and type `\cu` to uncomment.

- [terryma/vim-smooth-scroll](https://github.com/terryma/vim-smooth-scroll): Make scrolling in vim smooth.

- [easymotion/vim-easymotion](https://github.com/easymotion/vim-easymotion): Move cursor around easily.

- [skywind3000/vim-terminal-help](https://github.com/skywind3000/vim-terminal-help): Nice terminal integration.
    - Mapped to `Alt+=`.

- [scrooloose/nerdtree](https://github.com/preservim/nerdtree): A tree explorer on side.
    - Mapped to `Alt+E`.

- [jistr/vim-nerdtree-tabs](https://github.com/jistr/vim-nerdtree-tabs): Put NERDTree in tabs.

- [ivalkeen/nerdtree-execute](https://github.com/ivalkeen/nerdtree-execute): Execute the file selected in NERDTree.
    - In NERDTree, press `m` to open up menu, and then press `x`.
