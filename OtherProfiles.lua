--
-- Created by IntelliJ IDEA.
-- Author: Tor-Martin Holen 
-- Email: ${EMAIL}
-- Date: 30-Nov-19
-- Time: 13:27
--

-- TODO: move these functions into its own file
-- TODO: rename the function to RunProfile()
-- TODO: Add the functions from GoogleChrome.lua except the existing RunProfile function into the newly created files.
function ProfileAdobeReader()
    -- G710 Keyboard
    -- M-Keys M1-M3
    OnTimedEvent(mKey,1)
    OnTimedEvent(mKey,2)
    OnTimedEvent(mKey,3)

    -- G-Keys G1-G6
    TextControl()
    OnTimedEvent(gKey,3, {"ChangeProfile"})
    OnTimedEvent(gKey,4)
    OnTimedEvent(gKey,5)
    OnTimedEvent(gKey,6, {"lctrl", "j"},{"lctrl", "h"})

    -- G602 Mouse
    -- Mouse G3 (Scroll Wheel)
    OnTimedEvent(mBtn, 3,{"CycleDPI"}, {"lctrl","t"}, {"lgui", "e"}, {"lgui","q"})
    OnHoldEvent(mBtn, 4,{"lalt","tab"},{"lalt"})
    OnRegularEvent(mBtn, 5, {"lctrl"}) -- Control key
    OnTimedEvent(mBtn, 6, {"lctrl","lshift", "h"}, {"lctrl","l"}) -- Auto Scroll,

    -- Mouse G7-G9 (Upper Row)
    OnTimedEvent(mBtn, 7, {"lgui", "right"},{"lgui","up"},{"lgui","down"},{"lgui","left"}) -- Move window: right, up, down
    OnTimedEvent(mBtn, 8, {"u"}, {"lctrl", "z"}, {"lctrl", "lshift", "z"}) -- Underline
    OnTimedEvent(mBtn, 9, {"h"}, {"s"}) -- Hand tool

    MusicControl()
end

function ProfileProgramming()
    -- G710 Keyboard
    -- M-Keys M1-M3
    OnTimedEvent(mKey,1)
    OnTimedEvent(mKey,2)
    OnTimedEvent(mKey,3)

    -- G-Keys G1-G6
    TextControl()
    OnTimedEvent(gKey,3, {"CycleDPI"})
    OnTimedEvent(gKey,4)
    OnTimedEvent(gKey,5)
    OnTimedEvent(gKey,6)

    -- G602 Mouse
    -- Mouse G3 (Scroll Wheel)
    OnTimedEvent(mBtn, 3,{"CycleDPI"}, {"lctrl","t"}, {"lgui", "e"}, {"lgui","q"})

    -- Mouse G4-G6 (Bottom Row)
    OnHoldEvent(mBtn, 4,{"lalt","tab"},{"lalt"})
    OnRegularEvent(mBtn, 5, {"lctrl"}) -- Control key
    OnTimedEvent(mBtn, 6, {"lctrl","spacebar"},{"lalt", "enter"}, {"lalt","insert"})

    -- Mouse G7-G9 (Upper Row)
    OnTimedMacroEvent(mBtn,7,
        {{"lctrl","left"}, {"lctrl","lshift","right"}, {"lctrl","c"}, {"lctrl","t"}, {"lctrl","v"}, {"enter"}}
    )
    -- OnTimedEvent(mBtn, 7, {"lgui", "right"},{"lgui","up"},{"lgui","down"}) -- Move window: right, up, down
    OnTimedEvent(mBtn, 8, {"lalt","right"}, {"lalt","left"}, {"lshift","lalt","right"})
    OnTimedEvent(mBtn, 9, {"lshift","lalt","left"})

    MusicControl()
end

function ProfilePaladins()
    -- G710 Keyboard
    -- M-Keys M1-M3
    OnTimedEvent(mKey,1)
    OnTimedEvent(mKey,2)
    OnTimedEvent(mKey,3)

    -- G-Keys G1-G6
    TextControl()
    OnTimedEvent(gKey,3, {"CycleDPI"})
    OnTimedEvent(gKey,4)
    OnTimedEvent(gKey,5)
    OnTimedEvent(gKey,6)

    -- G602 Mouse
    -- Mouse G3 (Scroll Wheel)
    OnTimedEvent(mBtn, 3,{"CycleDPI"}, {"lctrl","t"}, {"lgui", "e"}, {"lgui","q"})

    -- Mouse G4-G6 (Bottom Row)
    OnRegularEvent(mBtn, 4, {"tab"})
    OnRegularEvent(mBtn, 5, {"i"})
    OnRegularEvent(mBtn, 6, {"r"})

    -- Mouse G7-G9 (Upper Row)
    OnRegularEvent(mBtn, 7, {"q"})
    OnRegularEvent(mBtn, 8, {"e"})
    OnRegularEvent(mBtn, 9, {"f"})

    MusicControl()
end