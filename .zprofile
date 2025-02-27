case ${OSTYPE} in
  # macOS
  darwin*)
    #source ~/.zprofile.macos
    ;;
  linux*)
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    # need `ps -ww` to get non-truncated command for matching
    # use square brackets to generate a regex match for the process we want but that doesn't match the grep command running it!
    ;;
esac

