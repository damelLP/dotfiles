-- XMonad core
import XMonad
import qualified XMonad.StackSet as W

-- Hooks
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import qualified XMonad.Hooks.EwmhDesktops as Ewm
import XMonad.Hooks.ManageHelpers

-- Utils
import XMonad.Util.NamedScratchpad
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)

-- Actions
import XMonad.Actions.WindowNavigation

-- Layout
import XMonad.Layout.Named
import XMonad.Layout.Grid
import XMonad.Layout.NoBorders
import XMonad.Layout.Fullscreen
import XMonad.Layout.Gaps
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances

-- System
import System.IO
import System.Exit

main = do
  myConfigWithNav <- withWindowNavigation (xK_k, xK_h, xK_j, xK_l) $ myConfig
  xmonad =<< statusBar myBar myPP toggleStrutsKey myConfigWithNav
        

myConfig = def { terminal   = myTerminal
              , manageHook = myManageHook
              , handleEventHook = myEventHook
              , layoutHook = myLayoutHook 
              , startupHook = setWMName "LG3D"
              , focusedBorderColor = "#2E9AFE"
              , normalBorderColor = "#000000"
              , modMask    = modm
              } `additionalKeys` myKeys

-- Mod key
modm = mod4Mask

-- Key binding for toggling bar
toggleStrutsKey XConfig {XMonad.modMask = modm} = (modm, xK_b)

-- command for xmobar
myBar = "xmobar"

-- Custom PP
myPP = xmobarPP { ppVisible = xmobarColor "#404040" ""
                , ppCurrent = xmobarColor "#DF7401" ""
                , ppTitle = xmobarColor "#FFB6B0" ""
                , ppUrgent = xmobarColor "#900000" "" . wrap "[" "]"
                }
-- Key bindings
myKeys = [ 
	((modm .|. shiftMask, xK_l), spawn "xlock -mode matrix")
	, ((modm, xK_g), spawn "google-chrome-stable")
	, ((modm, xK_p), spawn "yegonesh")
	, ((modm, xK_f), sendMessage $ Toggle FULL)
	, ((modm, xK_Return), spawn myTerminal)
	, ((modm .|. shiftMask, xK_comma), sendMessage Shrink)
	, ((modm .|. shiftMask, xK_period), sendMessage Expand)
	, ((modm .|. shiftMask, xK_x), io (exitWith ExitSuccess))
	, ((modm .|. shiftMask, xK_q), kill)
	, ((modm .|. shiftMask, xK_u), spawn "shutdown now" )
	, ((modm .|. controlMask, xK_t), namedScratchpadAction scratchpads "htop")
	, ((modm , xK_v), namedScratchpadAction scratchpads "vpn")
        ]

-- my terminal
myTerminal = "urxvt"

-- My Hooks

-- Manage
myManageHook = composeAll
   [ manageDocks 
   , namedScratchpadManageHook scratchpads 
   , isFullscreen  --> (doF W.focusDown <+> doFullFloat)
   ]

-- add gaps
-- addGaps = gaps [(U,18), (R,23), (L, 20), (D, 20)]

-- Layout
myLayoutHook 
  = smartBorders 
  $ avoidStruts 
  $ mkToggle (FULL ?? EOT) 
  $ layoutHook def 

-- Events
myEventHook = composeAll
  [ Ewm.fullscreenEventHook
  ]


-- , NS "vpn" "airvpn" (title =? "vpn") (customFloating $ W.RationalRect (1/6) (1/6) (2/3) (2/3))
scratchpads = [ NS "htop" "urxvt -e htop" (title =? "htop") defaultFloating
	]

