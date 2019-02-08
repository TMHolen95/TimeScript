--
-- Created by IntelliJ IDEA.
-- User: dogsh
-- Date: 08-Feb-19
-- Time: 11:46
-- To change this template use File | Settings | File Templates.
--
-- Author: Tor-Martin Holen (tormartin.holen@gmail.com)
profiles = {1,2,3}
profileNames = {"Default", "Programming","Paladins"}
activeProfile = 1

function OnEvent(event, arg)
    -- Prevent the need for "event" and "arg" as parameters in different event functions
    e = event
    a = arg
    runtime = GetRunningTime() -- Used in events that reuire timing
    OutputLogMessage("event = %s, arg = %s\n", e, a)

    ProfileRunner()
    --ProfileDefault()
    --ProfilePaladins()
end

-- Array constants for different event-types that could be used in the event functions
mBtn = {"MOUSE_BUTTON_PRESSED", "MOUSE_BUTTON_RELEASED"}
mKey = {"M_PRESSED", "M_RELEASED"}
gKey = {"G_PRESSED", "G_RELEASED"}

-- The Array's inverval between the different elements decides which function will be run, see OnTimedEvent
-- pressLimit = {0,220,500,800,1200,2000} -- Old limits [0,220>, [220,500> , [500,800>, [800,1200>
pressLimit = {0,140,220,450,750,1600}

-- Variables for cycling functions
count = 1 -- OnSwappableEvent

-- Profile Runner
function ProfileRunner()
    if (activeProfile == profiles[1]) then
        ProfileDefault()
    elseif(activeProfile == profiles[2]) then
        ProfileProgramming()
    elseif(activeProfile == profiles[3]) then
        ProfilePaladins()
    end
end

-- Profile Changer
function CheckProfileChangeEvent(wantedEvent, wantedArg)
    if (e == wantedEvent[1] and a == wantedArg) then
        ChangeProfile()
    end
end

function ChangeProfile()
    if(activeProfile < table.getn(profiles)) then
        activeProfile = activeProfile + 1
    else
        activeProfile = profiles[1]
    end
    OutputLogMessage("Profile Swapped to %s\n", profileNames[activeProfile])
end

function ProfileDefault()
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
    --	OnTimedEvent(mBtn, 3,{""}, {"lctrl","t"}, {"lgui", "e"}, {"lgui","q"})
    -- Mouse G4-G6 (Bottom Row)
    -- OnTimedEvent(mBtn, 4,{"lgui","tab"},{"lgui","lctrl","right"}, {"lgui","lctrl","left"})
    OnHoldEvent(mBtn, 4,{"lalt","tab"},{"lalt"})
    OnRegularEvent(mBtn, 5, {"lctrl"}) -- Control key
    --OnToggleModifierEvent(mBtn, 5,{"lctrl"},{"lshift"},{"lalt"})
    --OnSwappableEvent(mBtn, 5, {"lctrl"},{"lshift"},{"lalt"}) -- Control key
    OnTimedEvent(mBtn, 6, {"lctrl","w"}, {"lctrl","lshift","t"}, {"lctrl","lshift","q"}, {"lalt","f4"}) -- Close tab, Re-open tab, Quit Chrome, Close window

    -- Mouse G7-G9 (Upper Row)
    OnTimedEvent(mBtn, 7, {"lgui", "right"},{"lgui","up"},{"lgui","down"},{"lgui","left"}) -- Move window: right, up, down
    --OnTimedMacroEvent(mBtn,7,
    --	{{"lctrl","left"}, {"lctrl","lshift","right"}, {"lctrl","c"}, {"lalt","d"}, {"lctrl","v"}, {"lalt","enter"}}
    --)
    OnTimedEvent(mBtn, 8, {"lctrl","tab"}, {"lctrl","lshift","tab"}, {"lgui"}) -- Next Tab, Previous Tab
    OnTimedEvent(mBtn, 9, {"lalt","left"}, {"lalt","right"}, {"lalt","up"}) -- Tab backwards, Tab Forwards, Directory up

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
    OnTimedEvent(gKey,3, {"ChangeProfile"})
    OnTimedEvent(gKey,4)
    OnTimedEvent(gKey,5)
    OnTimedEvent(gKey,6)

    -- G602 Mouse
    -- Mouse G3 (Scroll Wheel)
    OnTimedEvent(mBtn, 3, {"CycleDPI"})

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
    OnTimedEvent(gKey,3, {"ChangeProfile"})
    OnTimedEvent(gKey,4)
    OnTimedEvent(gKey,5)
    OnTimedEvent(gKey,6)

    -- G602 Mouse
    -- Mouse G3 (Scroll Wheel)
    OnTimedEvent(mBtn, 3,{"CycleDPI"})

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

function MusicControl()
    -- Mouse G10-11 (Left Top Buttons)
    OnTimedEvent(mBtn, 10, {"media_play_pause"}, {"lgui", "1"}) -- Play/Pause, start chrome
    OnTimedEvent(mBtn, 11, {"media_next_track"}, {"media_prev_track"}) -- Next Song, Prev Song
end

-- Event functions
function OnRegularEvent(wantedEvent, wantedArg, keys)
    if (e == wantedEvent[1] and a == wantedArg) then
        PressAll(keys)
    end

    if (e == wantedEvent[2] and a == wantedArg) then
        ReleaseAll(keys)
    end
end


--This one is poorly implemented, should be improved
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

function OnToggleModifierEvent(wantedEvent, wantedArg, ...)
    if (e == wantedEvent[1] and a == wantedArg) then
        prevRuntime = runtime
    end

    if (e == wantedEvent[2] and a == wantedArg) then
        result = runtime - prevRuntime
        OutputLogMessage("\nClick duration: %s\n",result)

        for i=2,(table.getn(arg)+1) do
            if result >= pressLimit[i-1] and result < pressLimit[i] and arg[i-1] then
                index = i-1
                key = arg[index]
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
        result = runtime - prevRuntime
        OutputLogMessage("\nClick duration: %s\n",result)
        if (result < pressLimit[2])then
            if(count < table.getn(arg)) then
                count = count + 1
                OutputLogMessage("Count: %s\n\n", count)
            else
                count = 1
                OutputLogMessage("Count: %s\n\n", count)
            end
        end
        ls = count * 80; -- Light strength
        DimBacklights(ls, 25)
    end
end

--[[
function OnTimedTypeEvent(wantedEvent, wantedArg, ...)
	if (e == wantedEvent[1] and a == wantedArg) then
		prevRuntime = runtime
	end

	if (e == wantedEvent[2] and a == wantedArg) then
		result = runtime - prevRuntime
    		OutputLogMessage("\nClick duration: %s\n",result)

		for i=2,(table.getn(arg)+1) do
			if result >= pressLimit[i-1] and result < pressLimit[i] then
				for j=0,(table.getn(arg[i-1]+1) do
					if j=0 and arg[i-1][0] != nil then
						--Add more clauses to this if statement if more functions is available
						if(Contained(arg[i-1],"CycleDPI")) then
							CycleDPI()
						elseif(Contained(arg[i-1], "ChangeProfile")) then
							ChangeProfile()
						else
							PressAndReleaseAll(arg[i-1])
						end
					else
						TypeText(arg[i-1][j])
					end
				end


				OutputLogMessage("Arg index selected: %s\n\n", i-1)
				break
			end
		end
	end
end
--]]

function TypeText(text)
    PressAndReleaseKey("a", "b")
end

function OnTimedEvent(wantedEvent, wantedArg, ...) -- Variable arguments requires at least one array of key strings (max 3 arrays)
    if (e == wantedEvent[1] and a == wantedArg) then
        prevRuntime = runtime
    end

    if (e == wantedEvent[2] and a == wantedArg) then
        result = runtime - prevRuntime
        OutputLogMessage("\nClick duration: %s\n",result)

        for i=2,(table.getn(arg)+1) do
            if result >= pressLimit[i-1] and result < pressLimit[i] and arg[i-1] then

                --Add more clauses to this if statement if more functions is available
                if(Contained(arg[i-1],"CycleDPI")) then
                    CycleDPI()
                elseif(Contained(arg[i-1], "ChangeProfile")) then
                    ChangeProfile()
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
    if (e == wantedEvent[1] and a == wantedArg) then
        prevRuntime = runtime
    end

    if (e == wantedEvent[2] and a == wantedArg) then
        result = runtime - prevRuntime
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

-- Miscellaneous functions
function PressAndReleaseAll(keys)
    PressAll(keys)
    ReleaseAll(keys)
end

function PressAll(keys)
    for i = 1,table.getn(keys) do
        if keys[i] then
            PressKey(keys[i])
        end
    end
end

function ReleaseAll(keys)
    for i = 1,table.getn(keys) do
        if keys[i] then
            ReleaseKey(keys[i])
        end
    end
end

function RunMacroLogic(keys)
    for i = 1,table.getn(keys) do
        PressAndReleaseAll(keys[i])
        Sleep(500)
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
