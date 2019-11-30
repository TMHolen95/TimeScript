# TimeScript

A utility script for Logitech input devices. This script initially made a few years ago, only recently uploaded. 

The script (TimeScript.lua) contains functions for allowing the "G-keys" or "M-keys" on the input devices to have more than one function. 

### How to use the functions
* OnRegularEvent(gKey/mKey, number, {"lctrl","c"}) 
* OnTimedEvent(gKey/mKey, number, ...)
* OnSwappableEvent(gKey/mKey, number, ...) 

1st param - (All functions): gKey/mKey specifies if it is a keyboard or mouse button that will be used

2nd param - (All functions): number specifing which gKey/mKey the function applies to. </br>

3rd param - OnRegularEvent: the key combo to press </br> 
ex: OnRegularEvent(mBtn, 5, {"lctrl"}) </br>

3+ params - OnTimedEvent: the key combos to press </br>
ex: OnTimedEvent(mBtn, 8, {"lctrl","tab"}, {"lctrl","lshift","tab"}, {"lgui"}) </br> 

Next Tab (Chrome), Previous Tab (Chrome), left windows btn </br>
3+ params - OnSwappableEvent: the keys to hold on a long press, short press toggles between them (ex: {"lctrl", "lshift", "lalt"})

### Setting intervals for timed events:
pressLimit = {0,140,220,450,750,1600}
0-140ms corresponds to the first keys in a OnTimedEvent function such as {"lctrl","tab"} in the example. </br>
140-220  would corresponds to {"lctrl","lshift","tab"} </br>
and so on... Note that if nothing is specified for a interval then nothing happens.

### To use the script
* Try to modify the ProfileDefault() function according to your preferences
* Paste the script into Logitech Gaming Software to use it.

#### Note that there are a few more functions that don't work properly yet:
OnHoldEvent </br>
OnMacroEvent </br>
OnTimedMacroEvent </br>


The script's default profiles is configured for my Logitech G602 mouse according to my personal preference
