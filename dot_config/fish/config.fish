if status is-interactive
    # Commands to run in interactive sessions can go here

    set fish_greeting ""

    switch (uname)
        case Darwin
            eval "$(/opt/homebrew/bin/brew shellenv)"
    end

    abbr -a -g ls ls -laG

    fish_add_path ~/.config/bin

    set -U fish_key_bindings fish_vi_key_bindings

    set -Ux EDITOR nvim

    set -Ux HOMEBREW_NO_ENV_HINTS true
    function starship_transient_prompt_func
        starship module character
    end

    starship init fish | source
    enable_transience
    direnv hook fish | source

    alias vim="nvim"
    alias e="emacs -nw"
    alias pd="podman"
    alias pc="podman-compose"
    alias pcu="podman-compose up -d"
    alias pcd="podman-compose down"
    alias pdl="podman logs"
    alias nconf="nvim ~/.config/nvim"
    alias n="nvim"
end
