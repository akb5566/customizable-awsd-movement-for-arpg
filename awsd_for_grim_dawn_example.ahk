; WASD Movement Script for any ARPG games with customizable keybinds
;
; DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
; Version 2, December 2004
;
; Copyright (C) 2069 Your Mom
;
; Everyone is permitted to copy and distribute verbatim or modified
; copies of this license document, and changing it is allowed as long
; as the name is changed.
;
; DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
; TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
;
; 0. You just DO WHAT THE FUCK YOU WANT TO.

#Requires AutoHotkey v2
InstallKeybdHook 1, 1
InstallMouseHook
CoordMode "Mouse", "Screen"
SetKeyDelay 0

; Custimization starts here. Please read the comments and adjust the values as needed.
; Custimization starts here. Please read the comments and adjust the values as needed.
; Custimization starts here. Please read the comments and adjust the values as needed.
; Custimization starts here. Please read the comments and adjust the values as needed.
; Custimization starts here. Please read the comments and adjust the values as needed.

; The name of the window that this script should target. e.g. "Grim Dawn", "Last Epoch"
windowName := "Grim Dawn"

; For the following keybind values, please refer to
; https://www.autohotkey.com/docs/v2/lib/Send.htm#keynames

; The keybinds for your intended WASD movement, can be customized by the user
; Make sure that these keys are NOT binded in-game.
keyNorth := "w"
keySouth := "s"
keyWest := "a"
keyEast := "d"
keyJump := "Space"

; The keybinds for in-game movement, should be EXACTLY THE SAME as the in-game settings
; Instead of set the following keys to the in-game movement keys, its probably easier/better to set the in-game keybinds to these keys
keyInGameMove := "[" ; In-game "movement" key
keyInGameJump := "]" ; In-game "jump" key. DO NOT USE THE SAME KEY AS 'keyJump' above,

; The keybinds for your intended Skills buttons, can be customized by the user
; Make sure that these keys are NOT binded in-game.
keySkill1 := "q"
keySkill2 := "e"
keySkill3 := "XButton1" ; Mouse button 4 / Mouse side button
keySkill4 := "XButton2" ; Mouse button 5 / Mouse side button
keySkill5 := "RButton" ; Right mouse button
keySkill6 := "MButton"
keySkill7 := "r"
keySkill8 := ''  ; Empty string means no keybind. e.g. Last Epoch only has 5 skills.
keySkill9 := ''

; The keybinds for in-game Skills buttons, should be EXACTLY THE SAME as the in-game settings
; Instead of set the following keys to the in-game movement keys, its probably easier/better to set the in-game keybinds to these keys
keyInGameSkill1 := "4" ; In-game "Skill1" key, DO NOT USE THE SAME KEY AS ANY OF THE 'keySkill' above
keyInGameSkill2 := "5" ; In-game "Skill2" key, DO NOT USE THE SAME KEY AS ANY OF THE 'keySkill' above
keyInGameSkill3 := "6" ; In-game "Skill3" key, DO NOT USE THE SAME KEY AS ANY OF THE 'keySkill' above
keyInGameSkill4 := "7" ; In-game "Skill4" key, DO NOT USE THE SAME KEY AS ANY OF THE 'keySkill' above
keyInGameSkill5 := "8" ; In-game "Skill5" key, DO NOT USE THE SAME KEY AS ANY OF THE 'keySkill' above
keyInGameSkill6 := "9" ; In-game "Skill6" key, DO NOT USE THE SAME KEY AS ANY OF THE 'keySkill' above
keyInGameSkill7 := "0" ; In-game "Skill7" key, DO NOT USE THE SAME KEY AS ANY OF THE 'keySkill' above
keyInGameSkill8 := "-" ; In-game "Skill8" key, DO NOT USE THE SAME KEY AS ANY OF THE 'keySkill' above
keyInGameSkill9 := "=" ; In-game "Skill9" key, DO NOT USE THE SAME KEY AS ANY OF THE 'keySkill' above

; Customize the following values to fit your game/monitor/screen resolution.

; Some games don't put their character at the "center" of the screen, it might be 10 pixels to the top, etc. So we need to add some offset to the axis.
xOffset := 0
yOffset := 30

; The distance the mouse should move when the player moves.
; Increase this value if your character has high movement speed.
xDistance := 340
yDistance := 140

; In Last Epoch, the character can only move "Direct East" when the mouse is click at the "bottom right" instead of the "direct right" of the character model (EHG plz fix). So we need to add some offset to the above 'yMoveOffset' to make AWSD move as expected. HOWEVER, in Last Epoch the character can only jump at "direct right" when the mouse is at the "direct right" of the character, so now we need to remove the offset when jumping...(EHG plz fix)

; tl;dr: set this to true if Last Epoch. Set it to false if Grim Dawn.
isLastEpochJump := false
lastEpochJumpOffset := -55

; The buffer time before the script "return" your mouse to the original cursor position, in milliseconds. You should start with 0, then increase this value accordingly.
; e.g In Last Epoch Multiplayer you might need to increase this value to 1~5. On the other hand, In Grim Dawn single player, the game is more responsive, so you probably can get away with 0.
bufferBeforeReturnMouse := 0

; The buffer time before the script detect and simulate the next move, in milliseconds. Set this value higher if your character cast the skill at the wrong position (temporary AWSD position).
bufferBeforeNextDetect := 15

; Press this button to reload script, for quick testing
; For example, you first custimize the parameters above, press F8 to reload the script, then test the changes in-game. Trial and error until you find the values that work best for your game/monitor/screen resolution.
f9:: Reload

; Press this button to exit this script, or just right click and exit this script from the system tray
f10:: exitapp

; Show the following message box when this script first starts
; MsgBox "WARNING: Please open this script in a text editor and customize the parameters to fit your game/monitor/screen resolution. You can comment out this line after you have found the values that work best for you."

; Final Note:
; We handle move/jump before skill casting. In some rare cases (<10%), the skill casting might not be evoked if the user is moving/jumping. But it's much better than casting at the wrong position (temporary AWSD position) since you just need to cast the skill again.
; For a more consistent experience, try to press the skill key 'longer' than usual. If you just 'tap' the skill key, you might experience more failed skill casting. Same goes for the jump key.

; Custimization ends here. Don't touch anything below if you don't know what you are doing.
; Custimization ends here. Don't touch anything below if you don't know what you are doing.
; Custimization ends here. Don't touch anything below if you don't know what you are doing.
; Custimization ends here. Don't touch anything below if you don't know what you are doing.
; Custimization ends here. Don't touch anything below if you don't know what you are doing.

xCenter := A_ScreenWidth / 2
yCenter := A_ScreenHeight / 2

arrMoveKeys := [keyNorth, keySouth, keyWest, keyEast,]
arrJumpKeys := [keyJump]

; Add more skill keys here if needed
arrSkillKeys := [keySkill1, keySkill2, keySkill3, keySkill4, keySkill5, keySkill6, keySkill7, keySkill8, keySkill9]
; Add more in-game skill keys here if needed
arrSkillInGameKeys := [keyInGameSkill1, keyInGameSkill2, keyInGameSkill3, keyInGameSkill4, keyInGameSkill5,
    keyInGameSkill6, keyInGameSkill7, keyInGameSkill8, keyInGameSkill9]

; Detect if the user's intended keybinds and in-game keybinds are the same
; We don't allow this or it will cause infinite loop
if (keyJump == keyInGameJump) {
    MsgBox "[ERROR] 'keyJump' cannot be the same as 'keyInGameJump'. Exiting script."
    ExitApp
}
for index1, key1 in arrSkillKeys {
    for index2, key2 in arrSkillInGameKeys {
        if (key1 == key2) {
            MsgBox "[ERROR] 'keySkill" index1 "' cannot be the same as 'keyInGameSkill" index2 "'. Exiting script."
            ExitApp
        }
    }
}

isKeyInArrayPressed(keys) {
    for index, key in keys {
        if key !== '' && GetKeyState(key)
            return index
    }
    return false
}

simulateButtonPress(key) {
    Send "{" key " down}"
    Sleep 1
    Send "{" key " up}"
}

loop {
    if (WinWaitActive(windowName)) {
        intendToMove := isKeyInArrayPressed(arrMoveKeys)
        intendToJump := isKeyInArrayPressed(arrJumpKeys)
        intendToUseSkillIndex := isKeyInArrayPressed(arrSkillKeys)

        if (intendToMove || intendToJump) {
            ; Store the original mouse position
            MouseGetPos(&oriX, &oriY)

            ; Init temporary variables
            tmpX := oriX
            tmpY := oriY
            isMovingHorizontally := false

            ; Detect the direction of the AWSD movement
            if GetKeyState(keyNorth) {
                tmpX := xCenter + xOffset
                tmpY := yCenter + yOffset - yDistance
            }
            else if GetKeyState(keySouth) {
                tmpX := xCenter + xOffset
                tmpY := yCenter + yOffset + yDistance
            }
            if GetKeyState(keyWest) {
                tmpX := xCenter + xOffset - xDistance
                tmpY := yCenter + yOffset

                if GetKeyState(keyNorth) {
                    tmpY -= yDistance
                }
                else if GetKeyState(keySouth) {
                    tmpY += yDistance
                } else {
                    isMovingHorizontally := true
                }
            }
            else if GetKeyState(keyEast) {
                tmpX := xCenter + xOffset + xDistance
                tmpY := yCenter + yOffset

                if GetKeyState(keyNorth) {
                    tmpY -= yDistance
                }
                else if GetKeyState(keySouth) {
                    tmpY += yDistance
                } else {
                    isMovingHorizontally := true
                }
            }

            ; Move the mouse to the AWSD position, then simulate the key press to move/jump
            BlockInput "MouseMove"
            Mousemove tmpX, tmpY, 0

            simulateButtonPress(keyInGameMove)

            if (intendToJump) {
                if (isLastEpochJump && isMovingHorizontally) {
                    ; Quick hack for Last Epoch horizontal jump. EHG plz fix.
                    Mousemove tmpX, tmpY + lastEpochJumpOffset, 0
                }
                simulateButtonPress(keyInGameJump)
            }

            Sleep bufferBeforeReturnMouse

            ; Return the mouse to the original position
            Mousemove oriX, oriY, 0
            BlockInput "MouseMoveOff"

            Sleep bufferBeforeNextDetect
        }

        ; Now we finished AWSD move/jump and returned the mouse to the original cursor position. We can detect if the user is trying to use a skill. The skill will be casted at the "user's mouse cursor position" instead of the temporary AWSD position when the character were moving.
        if (intendToUseSkillIndex) {
            simulateButtonPress(arrSkillInGameKeys[intendToUseSkillIndex])
        }

    }
}
