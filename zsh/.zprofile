if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
  export XKB_DEFAULT_LAYOUT=de
  export XKB_DEFAULT_VARIANTS=nodeadkeys
  export XKB_DEFAULT_MODEL=pc101
  export XKB_DEFAULT_OPTIONS=ctrl:nocaps
  exec sway
fi
