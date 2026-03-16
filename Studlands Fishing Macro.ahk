#SingleInstance Force
#Requires AutoHotkey v2.0 
#MaxThreadsPerHotkey 3
#Warn

SendMode("Input")

CoordMode("Pixel", "Screen")
CoordMode("Mouse", "Screen")
CoordMode("ToolTip", "Screen")


MinigameEdgeX1 := 560*(A_ScreenWidth/1920)
MinigameEdgeY1 := 128*(A_ScreenHeight/1080)
MinigameEdgeX2 := 1290*(A_ScreenWidth/1920)
MinigameEdgeY2 := 805*(A_ScreenHeight/1080)

RodSlotX1 := 960*(A_ScreenWidth/1920)
RodSlotY1 := 940*(A_ScreenHeight/1080)
RodSlotX2 := 1040*(A_ScreenWidth/1920)
RodSlotY2 := 1020*(A_ScreenHeight/1080)

MinigameClicksX1 := 360*(A_ScreenWidth/1920)
MinigameClicksY1 := 450*(A_ScreenHeight/1080)
MinigameClicksX2 := 550*(A_ScreenWidth/1920)
MinigameClicksY2 := 515*(A_ScreenHeight/1080)

MacroMonitorY := 250*(A_ScreenHeight/1080)

MsgBox("--------------------------------------------------------------------------------------------`n                                    IMPORTANT PLEASE READ`n--------------------------------------------------------------------------------------------`n`n   VERY IMPORTANT, Requires AHK V2`n`n    - Rod MUST be in the 5th slot`n`n    - It is recommended to lower graphics quality to reduce lag `n`n    - Roblox MUST be in WINDOWED FULLSCREEN`n`n    - Revert any color changes that could potentially break the macro`n`n--------------------------------------------------------------------------------------------`n`nMade by @TartsYummy on YT", "Studlands Feeshin Macro :O")
; One jackass of a msg Box :sob:

ToolTip("Studlands Fishing Macro`n`nF1 : Start`nF2 : Reload`nF3 : Exit`n`nState : Idle`n`nMade by : Tarts", 0, MacroMonitorY)

F1::
{
    ToolTip("Studlands Fishing Macro`n`nF1 : Start`nF2 : Reload`nF3 : Exit`n`nState : Running`n`nMade by : Tarts", 0, MacroMonitorY)
    Sleep(400)

    loop{

        LastCast := 0

        loop {

            MouseMove(MinigameEdgeX1, MinigameEdgeY1)
            rodEquipped := PixelSearch(&RodEqX, &RodEqY, RodSlotX1, RodSlotY1, RodSlotX2, RodSlotY2, 0x005500, 1)

            if rodEquipped
            {
                ToolTip("Studlands Fishing Macro`n`nF1 : Start`nF2 : Reload`nF3 : Exit`n`nState : Runnning`n Task : Casting`n`nMade by : Tarts", 0, MacroMonitorY)
                Sleep(1000)
                Click
                break
            }
            else
            {
                if (A_TickCount - LastCast < 3000){
                    continue
                }
                ToolTip("Studlands Fishing Macro`n`nF1 : Start`nF2 : Reload`nF3 : Exit`n`nState : Runnning`n Task : ALT Casting`n`nMade by : Tarts", 0, MacroMonitorY)
                Sleep(400)
                Send("{4}")
                Sleep(400)
                Send("{5}")
                Sleep(1200)
                Click
                ; long ass timing cuz it's ping reliant, keep it generous yo
                LastCast := A_TickCount
                break
            }

            Sleep(10)
        }


        ; Wait for minigame
        ; 0x067C80 - Color for swamp
        ; 0x3B87E3 - Color for Cherry Pond
        ; 0x0655B5 - Color for the Deep sea
        ; 0x00CE4A - Cacti Field Pond
        ; 0x0260BE - The Beach

        ; Fuck the color up there, found a better detection method, might do something with the colors tho
        MinigameCheck := A_TickCount

        ; Check for the "Fish" Clicks too indicate that the minigame is present. While false, it keeps checking
        ToolTip("Studlands Fishing Macro`n`nF1 : Start`nF2 : Reload`nF3 : Exit`n`nState : Runnning`n Task : Minigame Checking`n`nMade by : Tarts", 0, MacroMonitorY)

        while !PixelSearch( &mingameStartX, &mingameStartY, MinigameClicksX1, MinigameClicksY1, MinigameClicksX2, MinigameClicksY2, 0xFFFFFF , 3)
            {
                Sleep(50)

                if (A_TickCount - MinigameCheck > 30000){
                    ToolTip("Studlands Fishing Macro`n`nF1 : Start`nF2 : Reload`nF3 : Exit`n`nState : Runnning`n Task : Restarting, took too long`n`nMade by : Tarts", 0, MacroMonitorY)
                    continue 2
                }
            }
        
        
        ; after we get dat white click bar, we found the minigame, we now wait for feesh to appear to then start
        ToolTip("Studlands Fishing Macro`n`nF1 : Start`nF2 : Reload`nF3 : Exit`n`nState : Runnning`n Task : Found Minigame, waiting too start`n`nMade by : Tarts", 0, MacroMonitorY)

        while !PixelSearch( &MinigameStartX, &MinigameStartY, MinigameEdgeX1, MinigameEdgeY1, MinigameEdgeX2, MinigameEdgeY2, 0xFFFFFF, 10) && !PixelSearch( &MinigameStartX, &MinigameStartY, MinigameEdgeX1, MinigameEdgeY1, MinigameEdgeX2, MinigameEdgeY2, 0xA5A5A5, 10){
            Sleep(20)
        }
        
        ;found feesh, meaning game has started yo
        ToolTip("Studlands Fishing Macro`n`nF1 : Start`nF2 : Reload`nF3 : Exit`n`nState : Runnning`n Task : Minigame Started`n`nMade by : Tarts", 0, MacroMonitorY)
        sleep(20)

        NoFishCheck := A_TickCount

        loop{        

            if PixelSearch( &FishNumX, &FishNumY, MinigameEdgeX1, MinigameEdgeY1, MinigameEdgeX2, MinigameEdgeY2, 0xFFFFFF, 10) && PixelSearch( &FishX, &FishY, FishNumX-20, FishNumY-20, FishNumX+20, FishNumY+20, 0xA5A5A5, 10){

                MouseMove(FishNumX, FishNumY)
                Sleep(76)
                ToolTip("Studlands Fishing Macro`n`nF1 : Start`nF2 : Reload`nF3 : Exit`n`nState : Runnning`n`nTask : Maybe Feesh hmm`n`nMade by : Tarts", 0, MacroMonitorY)
            
                if  PixelSearch(&CorrectFishX, &CorrectFishY, FishNumX-40, FishNumY-40, FishNumX+40, FishNumY+40, 0x8C8C8C, 10) && PixelSearch(&FishNumCheckX, &FishNumCheckY, FishNumX-40, FishNumY-40, FishNumX+40, FishNumY+40, 0xFFFFFF, 10){

                    ToolTip("Studlands Fishing Macro`n`nF1 : Start`nF2 : Reload`nF3 : Exit`n`nState : Runnning`nTask : Found Feesh :O`n at X : " FishNumCheckX ", Y : " FishNumCheckY "`n`nMade by : Tarts", 0, MacroMonitorY)
                    Click(FishNumCheckX, FishNumCheckY)
                    NoFishCheck := A_TickCount
                    Sleep(25)
                    continue
                    
                }

                else{
                    MouseMove(MinigameEdgeX1, MinigameEdgeY1)
                }
            
            }

            if PixelSearch( &RodEqX, &RodEqY, RodSlotX1, RodSlotY1, RodSlotX2, RodSlotY2, 0x005500, 1){
                        ToolTip("Studlands Fishing Macro`n`nF1 : Start`nF2 : Reload`nF3 : Exit`n`nState : Runnning`n Task : Minigame ended restarting loop`n`nMade by : Tarts", 0, MacroMonitorY)
                        continue 2
            }

            Sleep(15)
        }
        
    }

}


F3::
{
    ToolTip("Studlands Fishing Macro`n`nF1 : Start`nF2 : Reload`nF3 : Exit`n`nState : Exiting`n`nMade by : Tarts", 0, MacroMonitorY)
    Sleep(670)
    ExitApp
}

F2::
{
    ToolTip("Studlands Fishing Macro`n`nF1 : Start`nF2 : Reload`nF3 : Exit`n`nState : Reloading`n`nMade by : Tarts", 0, MacroMonitorY)
    Sleep(670)
    Reload
}
