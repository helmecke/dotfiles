command! Greview :execute ':Git! diff --staged' | :redraw!
command! Gclean :execute ':Git! branch --merged | grep -v \* | xargs git branch -D' | :redraw!
command! Gmaster :execute ':Git checkout master | Gpull | Gclean'
command! W :execute ':silent w !sudo tee % > /dev/null' | :edit!
