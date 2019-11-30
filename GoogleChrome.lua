--
-- Created by IntelliJ IDEA.
-- Author: Tor-Martin Holen 
-- Email: tormartin.holen@gmail.com
-- Date: 30-Nov-19
-- Time: 13:13
--
-- Author: Tor-Martin Holen (tormartin.holen@gmail.com)

-- DEFINED GLOBAL VARIABLES USED IN ALL THE CODE -----------------------------------

-- shorthands for event and argument
e = nil
a = nil

-- Variables used to measure time
runtime = nil
prevRuntime = nil


pressLimit = {0,140,220,450,750,1600}
-- The indexes of the array obove is used as intervals.
-- When a click is within the first interval function A is run,
-- if it is within the second interval function B is run, ... and so on.


-- Array constants for different event-types that could be used in the event functions
mBtn = {"MOUSE_BUTTON_PRESSED", "MOUSE_BUTTON_RELEASED"}
mKey = {"M_PRESSED", "M_RELEASED"}
gKey = {"G_PRESSED", "G_RELEASED"}

-- Variables for cycling functions, f.ex swapping a key between CTRL, ALT & Shift
count = 1 -- OnSwappableEvent

-- ----------------------------------------------------------------------------------

-- This is where you define your profile.
function RunProfile()
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
    OnTimedEvent(gKey,6, {"lctrl", "j"},{"lctrl", "h"})

    -- G602 Mouse
    -- Mouse G3 (Scroll Wheel)
    OnTimedEvent(mBtn, 3,{"CycleDPI"}, {"lctrl","t"}, {"lgui", "e"}, {"lgui","q"})
    --	OnTimedEvent(mBtn, 3,{""}, {"lctrl","t"}, {"lgui", "e"}, {"lgui","q"})
    -- Mouse G4-G6 (Bottom Row)
    -- OnTimedEvent(mBtn, 4,{"lgui","tab"},{"lgui","lctrl","right"}, {"lgui","lctrl","left"})
    OnHoldEvent(mBtn, 4,{"lalt","tab"},{"lalt"})
    --OnRegularEvent(mBtn, 5, {"lctrl"}) -- Control key
    --OnToggleModifierEvent(mBtn, 5,{"lctrl"},{"lshift"},{"lalt"})
    OnSwappableEvent(mBtn, 5, {"lctrl"},{"lshift"},{"lalt"}) -- Control key
    OnTimedEvent(mBtn, 6, {"lctrl","w"}, {"lctrl","lshift","t"}, {"lctrl","lshift","q"}, {"lalt","f4"}) -- Close tab, Re-open tab, Quit Chrome, Close window
    --OnTimedEvent(mBtn, 6, {"lalt","d"}, {"lctrl","lshift","t"}, {"lctrl","lshift","q"}, {"lalt","f4"}) -- Close tab, Re-open tab, Quit Chrome, Close window

    -- Mouse G7-G9 (Upper Row)
    OnTimedEvent(mBtn, 7, {"lgui", "right"},{"lgui","up"},{"lgui","down"},{"lgui","left"}) -- Move window: right, up, down
    --OnTimedMacroEvent(mBtn,7,
    --	{{"lctrl","left"}, {"lctrl","lshift","right"}, {"lctrl","c"}, {"lalt","d"}, {"lctrl","v"}, {"lalt","enter"}}
    --)
    OnTimedEvent(mBtn, 8, {"lctrl","tab"}, {"lctrl","lshift","tab"}, {"lgui"}) -- Next Tab, Previous Tab
    OnTimedEvent(mBtn, 9, {"lalt","left"}, {"lalt","right"}, {"lalt","up"}) -- Tab backwards, Tab Forwards, Directory up

    MusicControl()
end
-- ----------------------------------------------------------------------------------
-- Standard Event Listener the logitech software provides ---------------------------
function OnEvent(event, arg)
    -- Prevent the need for "event" and "arg" as parameters in different event functions
    e = event
    a = arg
    runtime = GetRunningTime() -- Used in events that require timing
    OutputLogMessage("event = %s, arg = %s\n", e, a)


    RunProfile()
end
-- -----------------------------------------------------------------------------------

-- Utility function for setting the gKey 1 select text from the cursor to the line end or start, or the entire line.
-- gKey 2 copies the selected text in attion to selecting as gKey1.
function TextControl()
    OnTimedMacroEvent(gKey,1,
        {{"home"},{"lshift","end"}},
        {{"lshift","end"}},
        {{"lshift","home"}})
    OnTimedMacroEvent(gKey,2,
        {{"home"},{"lshift","end"},{"lctrl","c"}},
        {{"lshift","end"},{"lctrl","c"}},
        {{"lshift","home"},{"lctrl","c"}}
    )
end

-- Utility functions for controlling music from mKey 10 (play/pause) & 11 (next/prev track)
function MusicControl()
    -- Mouse G10-11 (Left Top Buttons)
    OnTimedEvent(mBtn, 10, {"media_play_pause"}, {"lgui", "1"}) -- Play/Pause, start chrome
    OnTimedEvent(mBtn, 11, {"media_next_track"}, {"media_prev_track"}) -- Next Song, Prev Song
end

-- Event functions --------------------------------------------------------

-- Works like a normal keycombo use this for shourtcuts such as CTRL + SHIFT + S
function OnRegularEvent(wantedEvent, wantedArg, keys)
    if (e == wantedEvent[1] and a == wantedArg) then
        PressAll(keys)
    end

    if (e == wantedEvent[2] and a == wantedArg) then
        ReleaseAll(keys)
    end
end


--This one is poorly implemented, should be improved
-- Currently woks for two arguments where the scond key is released instantly,
-- f.ex: alt+tab, where tab is released - In windows this shows the open windows in a desktop.
function OnHoldEvent(wantedEvent, wantedArg, ...)
    if (e == wantedEvent[1] and a == wantedArg) then
        PressKey(arg[1][1])
        PressKey(arg[1][2])
        ReleaseKey(arg[1][2])
    end

    if (e == wantedEvent[2] and a == wantedArg) then
        ReleaseKey(arg[2][1])
    end
end

-- For a short key press it swaps the key with the next in the supplied arguments, note it will trigger the key therefore it is usefull for keys that work like modifiers.
-- A long press will keep the key active.
-- Check if documentation is correct.
function OnToggleModifierEvent(wantedEvent, wantedArg, ...)
    SetPrevRuntimeAtKeydownEvent(wantedEvent, wantedArg)

    if (e == wantedEvent[2] and a == wantedArg) then
        local result = runtime - prevRuntime
        OutputLogMessage("\nClick duration: %s\n",result)

        for i=2,(table.getn(arg)+1) do
            if result >= pressLimit[i-1] and result < pressLimit[i] and arg[i-1] then
                local index = i-1
                local key = arg[index]
                if IsModifierPressed(key) then
                    ReleaseKey(arg[i-1])
                else
                    PressKey(arg[i-1])
                end

            end
        end
    end
end

function OnSwappableEvent(wantedEvent, wantedArg, ...)
    if (e == wantedEvent[1] and a == wantedArg) then
        prevRuntime = runtime
        PressAll(arg[count])
    end

    if (e == wantedEvent[2] and a == wantedArg) then
        ReleaseAll(arg[count])
        local result = runtime - prevRuntime
        OutputLogMessage("\nClick duration: %s\n",result)
        if (result < pressLimit[2])then
            if(count < table.getn(arg)) then
                count = count + 1
                -- local ls = count * 80; -- Light strength
                -- DimBacklights(ls, 25)
                OutputLogMessage("Count: %s\n\n", count)
            else
                count = 1
                OutputLogMessage("Count: %s\n\n", count)
            end
        end

    end
end

function TypeText(text)
    PressAndReleaseKey("a", "b")
end

function OnTimedEvent(wantedEvent, wantedArg, ...) -- Variable arguments requires at least one array of key strings (max 3 arrays)
    SetPrevRuntimeAtKeydownEvent(wantedEvent, wantedArg)

    if (e == wantedEvent[2] and a == wantedArg) then
        local result = runtime - prevRuntime
        OutputLogMessage("\nClick duration: %s\n",result)

        for i=2,(table.getn(arg)+1) do
            if result >= pressLimit[i-1] and result < pressLimit[i] and arg[i-1] then

                --Add more clauses to this if statement if more functions is available
                if(Contained(arg[i-1],"CycleDPI")) then
                    CycleDPI()
                else
                    PressAndReleaseAll(arg[i-1])
                end

                OutputLogMessage("Arg index selected: %s\n\n", i-1)
                break
            end
        end
    end
end

function OnMacroEvent(wantedEvent, wantedArg, ...)
    if (e == wantedEvent[2] and a == wantedArg) then
        RunMacroLogic(arg)
    end
end

function OnTimedMacroEvent(wantedEvent, wantedArg, ...)
    SetPrevRuntimeAtKeydownEvent(wantedEvent, wantedArg)

    if (e == wantedEvent[2] and a == wantedArg) then
        local result = runtime - prevRuntime
        OutputLogMessage("\nClick duration: %s\n",result)

        for i=2,(table.getn(arg)+1) do
            if result >= pressLimit[i-1] and result < pressLimit[i] and arg[i-1] then
                RunMacroLogic(arg[i-1])
                OutputLogMessage("Arg index selected: %s\n\n", i-1)
                break
            end
        end
    end
end

function SetPrevRuntimeAtKeydownEvent(wantedEvent, wantedArg)
    if (e == wantedEvent[1] and a == wantedArg) then
        prevRuntime = runtime
    end
end

-- Miscellaneous functions
function PressAndReleaseAll(keys)
    PressAll(keys)
    ReleaseAll(keys)
end

function PressAll(keys)
    for i = 1,table.getn(keys) do
        if keys[i] then
            PressKey(keys[i])
            Sleep(2)
        end
    end
end

function ReleaseAll(keys)
    for i = 1,table.getn(keys) do
        if keys[i] then
            ReleaseKey(keys[i])
            Sleep(2)
        end
    end
end

function RunMacroLogic(keys)
    for i = 1,table.getn(keys) do
        PressAndReleaseAll(keys[i])
        Sleep(100)
    end
end

function DimBacklights(initalStrength, finalStrength)
    for i = initalStrength, finalStrength, -1 do
        SetBacklightColor(i,i,i,"kb")
        Sleep(2)
    end
end

function Contained(set,value)
    for _,v in pairs(set) do
        if v == value then
            return true
        end
    end
end

-- Functions; usable in OnTimedEvent()
-- Use SetMouseDPITable({a,b,c,...}) for values that differ from default
dpiCycle = 3 -- default DPI value
dpiCycleMax = 5 -- Max number of different cycling values
function CycleDPI()
    if(dpiCycle < dpiCycleMax) then
        dpiCycle = dpiCycle + 1
    else
        dpiCycle = 1
    end
    SetMouseDPITableIndex(dpiCycle)
end


