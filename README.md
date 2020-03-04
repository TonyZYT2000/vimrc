# vimrc
ZYT's .vimrc!

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
