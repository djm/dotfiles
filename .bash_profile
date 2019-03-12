[[ -r ~/.bashrc ]] && . ~/.bashrc

# To stop clang errors thanks to Xcode updates.
# https://langui.sh/2014/03/10/wunused-command-line-argument-hard-error-in-future-is-a-harsh-mistress/
export ARCHFLAGS="-Wno-error=unused-command-line-argument-hard-error-in-future"

export PATH="$HOME/.cargo/bin:$PATH"
