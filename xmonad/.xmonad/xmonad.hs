{-import XMonad

main = xmonaddef
  {terminal = "urxvt"
  , modMask = mod4Mask
  , borderWidth = 3
  }
-}

-- XMonad core
import XMonad
import qualified XMonad.StackSet as W

-- Hooks
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import qualified XMonad.Hooks.EwmhDesktops as Ewm
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.Minimize

-- Utils
import XMonad.Util.NamedScratchpad
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.SpawnOnce

-- Actions
import XMonad.Actions.Navigation2D
import XMonad.Actions.Minimize

-- Layout
import XMonad.Layout.Named
import XMonad.Layout.GridVariants
import XMonad.Layout.NoBorders
import XMonad.Layout.Fullscreen
import XMonad.Layout.Gaps
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.BoringWindows 
import XMonad.Layout.Minimize 

-- System
import System.IO
import System.Exit

main = do
  -- adds custom window navigation        (Up,   Left, Down, Right)

  -- binds everything to xmonad 
  xmonad =<< statusBar myBar myPP toggleStrutsKey myConfigWithNav
        
myConfigWithNav = myNavs myConfig

-- Define Xmonad config
myConfig = def { terminal   = myTerminal
              , manageHook = myManageHook
              , handleEventHook = myEventHook
              , layoutHook = myLayoutHook 
              , startupHook = myStartupHook
              , focusedBorderColor = "#2E9AFE"
              , normalBorderColor = "#000000"
              , modMask    = modm
              } `additionalKeys` myKeys

-- Mod key
modm = mod4Mask

-- define window navigation
myNavs config = withNavigation2DConfig def
   $ additionalNav2DKeys (xK_k, xK_h, xK_j, xK_l) 
                        myNavMask 
                        False
   $ additionalNav2DKeys (xK_Up, xK_Left, xK_Down, xK_Right) 
                        myNavMask 
                        False
   $ config

-- Mask for activating the nav keys
myNavMask = [(modm, windowGo), 
             (modm .|. shiftMask, windowSwap)]

-- Key binding for toggling bar
toggleStrutsKey XConfig {XMonad.modMask = modm} = (modm, xK_b)

-- command for statusBar
myBar = "xmobar"

-- Custom PP
myPP = xmobarPP { ppVisible = xmobarColor "#404040" ""
                , ppCurrent = xmobarColor "#DF7401" ""
                , ppTitle = xmobarColor "#FFB6B0" ""
                , ppUrgent = xmobarColor "#900000" "" . wrap "[" "]"
                }
-- Key bindings
myKeys = [ 
        -- launch apps
          ((modm .|. mod1Mask, xK_l), spawn "xlock -mode matrix")
        , ((modm, xK_p), spawn "yegonesh")
        , ((modm, xK_Return), spawn myTerminal)

        -- interact with currentWindow
        , ((modm, xK_f), sendMessage $ Toggle FULL)
        , ((modm, xK_m), withFocused minimizeWindow)
        , ((modm .|. shiftMask, xK_m), withLastMinimized maximizeWindowAndFocus)
        , ((modm .|. shiftMask, xK_comma), sendMessage Shrink)
        , ((modm .|. shiftMask, xK_period), sendMessage Expand)

        -- control xmonad
        , ((modm .|. shiftMask, xK_x), io (exitWith ExitSuccess))
        , ((modm .|. shiftMask, xK_q), kill)
        , ((modm .|. shiftMask, xK_u), spawn "shutdown now" )

        -- scratchpads
        , ((modm .|. controlMask, xK_t), namedScratchpadAction scratchpads "htop")
        , ((modm , xK_v), namedScratchpadAction scratchpads "vpn")
        ]

-- my 
myTerminal = "urxvt"

-- Startup Hook
myStartupHook = composeAll
  [setWMName "LG3D"
  , spawnOnce "xmodmap ~/.Xmodmap" 
  ]

-- Manage Hook
myManageHook = composeAll
   [ manageDocks 
   , namedScratchpadManageHook scratchpads 
   , isFullscreen  --> (doF W.focusDown <+> doFullFloat)
   ]

-- add gaps
-- addGaps = gaps [(U,18), (R,23), (L, 20), (D, 20)]

-- Layout Hook
myLayoutHook 
   = boringWindows
   $ smartBorders 
   $ avoidStruts 
   $ minimize 
   $ mkToggle (FULL ?? EOT) 
   $ layoutHook def

-- Event Hook
myEventHook = composeAll
  [ Ewm.fullscreenEventHook
  , minimizeEventHook
  ]

-- , NS "vpn" "airvpn" (title =? "vpn") (customFloating $ W.RationalRect (1/6) (1/6) (2/3) (2/3))
scratchpads = [ 
      NS "htop" "urxvt -e htop" (title =? "htop") defaultFloating
    ]
