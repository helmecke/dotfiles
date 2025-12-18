import XMonad
import XMonad.Util.EZConfig
import XMonad.Util.Ungrab

-- actions
import XMonad.Actions.DynamicWorkspaces

-- layouts
import XMonad.Layout.ThreeColumns

-- layout modifiers
import XMonad.Layout.Magnifier

-- hooks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog

-- Utils
import Control.Monad.IO.Class (liftIO)
import System.Posix.Env (putEnv)

import XMonad.Prompt

myTerminal = "kitty"
myEditor = "nvim"

-- new XPConfig (for shell prompt, tab bars, etc)
myXPConfig = def {
  font = "xft:MesloLGM Nerd Font:size=11",
  height = 40}

myLayout = tiled ||| Mirror tiled ||| Full ||| threeCol
  where
    threeCol = magnifiercz' 1.3 $ ThreeColMid nmaster delta ratio
    tiled    = Tall nmaster delta ratio
    nmaster  = 1
    ratio    = 1/2
    delta    = 3/100
myKeymap = [
      ("M-r", spawn "rofi -show")
    , ("M-S-r", spawn "if type xmonad; then xmonad --recompile && xmonad --restart; else xmessage xmonad not in \\$PATH: \"$PATH\"; fi")
    , ("M-q"  , kill)
    , ("M-<Return>", spawn myTerminal)
    , ("M-w", selectWorkspace myXPConfig)
    , ("M-S-n", appendWorkspacePrompt myXPConfig)
    , ("M-S-d", removeWorkspace)
    ]

-- Hook ran before xmonad is actually started.
myStartupHook = do
  return ()
  mapM_ (liftIO . putEnv)
    [ "_JAVA_AWT_WM_NONREPARENTING=1"
    , "EDITOR=" ++ myEditor]
  mapM_ spawn
    [ "xrdb ~/.Xresources"
    , "xsetroot -cursor_name left_ptr"
    ]
  checkKeymap myConfig myKeymap

myConfig = def
     { modMask = mod4Mask
     , terminal = myTerminal
     , layoutHook = myLayout
     , startupHook = myStartupHook
     }
  `additionalKeysP` myKeymap

-- The main function.
main = xmonad =<< statusBar myBar myPP toggleBarKeyBiding myConfig

-- Command to launch the bar.
myBar = "xmobar"

-- Bar's pretting printing configuration,
myPP = xmobarPP { ppVisible = xmobarColor "#404040" ""
                , ppCurrent = xmobarColor "#DF7401" ""
                , ppTitle = xmobarColor "#FFB6B0" ""
                , ppUrgent = xmobarColor "#900000" "" . wrap "[" "]"
                }

-- Key binding to toggle the bar.
toggleBarKeyBiding XConfig {XMonad.modMask = modMask} = (modMask, xK_b)
