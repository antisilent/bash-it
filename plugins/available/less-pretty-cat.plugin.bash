cite about-plugin
about-plugin 'pygmentize instead of cat to terminal if possible'

if $(command -v pygmentize &> /dev/null) ; then
  # get the full paths to binaries
  CAT_BIN=$(which cat)
  LESS_BIN=$(which less)

  # pigmentize cat and less outputs
  function cat()
  {
      about 'runs either pygmentize or cat on each file passed in'
      param '*: files to concatenate (as normally passed to cat)'
      example 'cat mysite/manage.py dir/text-file.txt'
      for var;
      do
          pygmentize "$var" 2>/dev/null || "$CAT_BIN" "$var";
      done
  }

  function less()
  {
      about 'it pigments the file passed in and passes it to less for pagination'
      param '$1: the file to paginate with less'
      example 'less mysite/manage.py'
      pygmentize -g $* | "$LESS_BIN" -R
  }
fi

export LESS="--RAW-CONTROL-CHARS"
export LESS_TERMCAP_mb=$(tput bold; tput setaf 2)                 # start blink
export LESS_TERMCAP_md=$(tput bold; tput setaf 6)                 # start bold
export LESS_TERMCAP_me=$(tput sgr0)                               # reset formatting attributes
export LESS_TERMCAP_so=$(tput bold; tput setaf 7; tput setab 2)   # start standout (reverse video)
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)                    # stop standout
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 3)      # start underline
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)                    # stop underline
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)
export LESS_TERMCAP_ZN=$(tput ssubm)
export LESS_TERMCAP_ZV=$(tput rsubm)
export LESS_TERMCAP_ZO=$(tput ssupm)
export LESS_TERMCAP_ZW=$(tput rsupm)
