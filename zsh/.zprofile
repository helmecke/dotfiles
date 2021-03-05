if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
  exec sway
  # exec sway -d 2> ~/sway.log
fi
