local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
game.StarterGui:SetCore("SendNotification", {Title = "Injection Done", Text = "Floppy Menu Injected!", Icon = "rbxassetid://505845268", Duration = 5, Button1 = "Okay"})

local fshrgclr = Color3.fromRGB(255,255,255)
local fshrg = 10
local character = game:GetService("Players").LocalPlayer.Character
local spotLight = Instance.new("SpotLight")
local tpservice= game:GetService("TeleportService")
local zeezy = game:GetService("Players").LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local PlaceID = game.PlaceId
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local File = pcall(function()
    AllIDs = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
end)
if not File then
    table.insert(AllIDs, actualHour)
    writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
end


local colors = {
    SchemeColor = Color3.fromRGB(255,128,0),
    Background = Color3.fromRGB(38, 40, 45),
    Header = Color3.fromRGB(0, 0, 0),
    TextColor = Color3.fromRGB(255,255,255),
    ElementColor = Color3.fromRGB(20, 20, 20)
}

local Window = Library.CreateLib("  V1.4.2                      FLOPPY MENU BY LOGORKILL", colors)

function teleport(loc)
    bLocation = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    if game.Players.LocalPlayer.Character.Humanoid.Sit then
        game.Players.LocalPlayer.Character.Humanoid.Sit = false
    end
    wait()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = loc
end

function TPReturner()
    local Site;
    if foundAnything == "" then
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
    else
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
    end
    local ID = ""
    if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
        foundAnything = Site.nextPageCursor
    end
    local num = 0;
    for i,v in pairs(Site.data) do
        local Possible = true
        ID = tostring(v.id)
        if tonumber(v.maxPlayers) > tonumber(v.playing) then
            for _,Existing in pairs(AllIDs) do
                if num ~= 0 then
                    if ID == tostring(Existing) then
                        Possible = false
                    end
                else
                    if tonumber(actualHour) ~= tonumber(Existing) then
                        local delFile = pcall(function()
                            delfile("NotSameServers.json")
                            AllIDs = {}
                            table.insert(AllIDs, actualHour)
                        end)
                    end
                end
                num = num + 1
            end
            if Possible == true then
                table.insert(AllIDs, ID)
                wait()
                pcall(function()
                    writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                    wait()
                    game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                end)
                wait(4)
            end
        end
    end
end

function switchServer()
    while wait() do
        pcall(function()
            TPReturner()
            if foundAnything ~= "" then
                TPReturner()
            end
        end)
    end
end

function instantwin()
    teleport(CFrame.new(130, 18, -1224))
end

function zeezyAirjump()
    if infj == true then
	    zeezy.Character:FindFirstChildOfClass'Humanoid':ChangeState("Seated")
	    wait()
	    zeezy.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
    end
end

local Tab = Window:NewTab("MAIN")
local Tab0 = Window:NewTab("TELEPORT")
local Tab1 = Window:NewTab("MISC")
local Tab2 = Window:NewTab("OTHER")


local Section = Tab:NewSection("Main")
Section:NewButton("Instant Win", "Teleport to the finish line", function()
    instantwin()
end)
Section:NewButton("Item Bypass", "Give every items", function()
    game:GetService("ReplicatedStorage").Aero.AeroRemoteServices.InventoryHandler.AddItem:InvokeServer("Crowbar")
    game:GetService("ReplicatedStorage").Aero.AeroRemoteServices.InventoryHandler.AddItem:InvokeServer("Red Battery")
    game:GetService("ReplicatedStorage").Aero.AeroRemoteServices.InventoryHandler.AddItem:InvokeServer("Green Battery")
    game:GetService("ReplicatedStorage").Aero.AeroRemoteServices.InventoryHandler.AddItem:InvokeServer("Blue Battery")
    game:GetService("ReplicatedStorage").Aero.AeroRemoteServices.InventoryHandler.AddItem:InvokeServer("Orange Battery")
    game:GetService("ReplicatedStorage").Aero.AeroRemoteServices.InventoryHandler.AddItem:InvokeServer("Friend")
    game.StarterGui:SetCore("SendNotification", {Title="Item Bypass"; Text="You were given every items"; Duration=2;})

end)
Section:NewButton("Open doors", "Open every locked doors", function()
    game:GetService("ReplicatedStorage").Aero.AeroRemoteServices.DoorHandler.Toggle:InvokeServer(game:GetService("Workspace").Doors.GiftShop, true)
    game:GetService("ReplicatedStorage").Aero.AeroRemoteServices.DoorHandler.Toggle:InvokeServer(game:GetService("Workspace").Doors.SideDoor, true)
    game:GetService("ReplicatedStorage").Aero.AeroRemoteServices.DoorHandler.Toggle:InvokeServer(game:GetService("Workspace").Doors.PowerRoom, true)
    game:GetService("ReplicatedStorage").Aero.AeroRemoteServices.DoorHandler.Toggle:InvokeServer(game:GetService("Workspace").Doors.Door, true)
    game:GetService("ReplicatedStorage").Aero.AeroRemoteServices.DoorHandler.Toggle:InvokeServer(game:GetService("Workspace").Doors.HuggyDoor, true)
    game.StarterGui:SetCore("SendNotification", {Title="Doors Opened"; Text="Every locked doors are now open"; Duration=2;})
end)
Section:NewToggle("Infinite Jump", "Toogle the inifinite jump feature", function(state)
    if state then
        infj = true
        game.StarterGui:SetCore("SendNotification", {Title="Infinite Jump"; Text="Infinite has been activated"; Duration=1;})
    else
        infj = false
        game.StarterGui:SetCore("SendNotification", {Title="Infinite Jump"; Text="Infinite has been desactivated"; Duration=1;})
    end
end)
Section:NewSlider("SpeedHack", "Change speed value", 500, 16, function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

Section:NewLabel("Legit")
Section:NewToggle("Speed Boost", "Toogle the legit speedboost", function(state)
    if state then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 19
        game.StarterGui:SetCore("SendNotification", {Title="Legit Speed Boost"; Text="Legit speed boost has been activated"; Duration=1;})
    else
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
        game.StarterGui:SetCore("SendNotification", {Title="Legit Speed Boost"; Text="Legit speed boost has been desactivated"; Duration=1;})
    end
end)
Section:NewToggle("Anti AFK", "Toogle the Anti AFK exploit", function(state)
    if state then
        assert(firesignal, "Your exploit does not support firesignal.")
        game.StarterGui:SetCore("SendNotification", {Title="Anti AFK"; Text="Anti AFK has been activated"; Duration=1;})
        UserInputService.WindowFocusReleased:Connect(function()
            RunService.Stepped:Wait()
            pcall(firesignal, UserInputService.WindowFocused)
        end)
    else
        game.StarterGui:SetCore("SendNotification", {Title="Anti AFK"; Text="Anti AFK has been desactivated"; Duration=1;})
    end
end)
Section:NewToggle("Flashlight", "Toogle the flashlight feature", function(state)
    if state then
        spotLight.Enabled = true
        spotLight.Parent = character.HumanoidRootPart
        game.StarterGui:SetCore("SendNotification", {Title="Flashlight"; Text="Flashlight has been turned on"; Duration=1;})
    else
        spotLight.Enabled = false
        game.StarterGui:SetCore("SendNotification", {Title="Flashlight"; Text="Flashlight has been turned off"; Duration=1;})
    end
    while state do
        wait()
        spotLight.Range= fshrg
        spotLight.Color = fshrgclr
    end
end)
Section:NewSlider("Beam Range", "Change the flashlight range", 150, 10, function(s)
    print(s)
    print(fshrg)
    fshrg = s
    print(fshrg)
end)
Section:NewColorPicker("Beam Color", "Change the color of the flashlight beam", Color3.fromRGB(255,255,255), function(color)
    fshrgclr = color
end)

local Section0 = Tab0:NewSection("Zones")
Section0:NewDropdown("Locations", "Locations list", {"Waiting Room","Security Room Digit","Puzzle 1", "Puzzle 2", "Puzzle 3", "Puzzle 4"}, function(currentOption)
    locationSelectedC = currentOption
end)
Section0:NewButton("Teleport", "Teleport to the desired location", function()
    if locationSelectedC == "Waiting Room" then
        teleport(CFrame.new(-4, 114.85, -126))
    elseif locationSelectedC == "Security Room Digit" then
        teleport(CFrame.new(-30.5, 114.85, -230))
    elseif locationSelectedC == "Puzzle 1" then
        teleport(CFrame.new(40, 114.95, -197))
    elseif locationSelectedC == "Puzzle 2" then
        teleport(CFrame.new(52.25, 133.85, -307))
    elseif locationSelectedC == "Puzzle 3" then
        teleport(CFrame.new(65, 94.45, -528.5))
    elseif locationSelectedC == "Puzzle 4" then
        teleport(CFrame.new(30.75, 68.95, -710))
    game.StarterGui:SetCore("SendNotification", {Title="Teleported"; Text="You have been teleported !"; Duration=1;})
    end
end)
local Section0 = Tab0:NewSection("Lobby")
Section0:NewDropdown("Start areas", "Locations list", {"1 player","2 players","3 players", "4 players"}, function(currentOption)
    Sareas = currentOption
end)
Section0:NewButton("Teleport", "Teleport to the desired location", function()
    if Sareas == "1 player" then
        teleport(CFrame.new(-262.15, 9.77, -191.3754))
    elseif Sareas == "2 players" then
        teleport(CFrame.new(-262.15, 9.77, -151.2749))
    elseif Sareas == "3 players" then
        teleport(CFrame.new(-262.15, 9.77, -111.375))
    elseif Sareas == "4 players" then
        teleport(CFrame.new(-262.15, 9.77, -71.275))
    game.StarterGui:SetCore("SendNotification", {Title="Teleported"; Text="You have been teleported !"; Duration=1;})
    end
end)


local Section1 = Tab1:NewSection("Color Customization")
Section1:NewColorPicker("Text Color", "Change the color of the text", Color3.fromRGB(255,255,255), function(color)
    colors.TextColor = color
end)
Section1:NewColorPicker("Window Color", "Change the color of the window", Color3.fromRGB(0,0,0), function(color)
    colors.Header = color
end)
Section1:NewColorPicker("Background Color", "Change the color of the background", Color3.fromRGB(38,40,45), function(color)
    colors.Background = color
end)
Section1:NewColorPicker("Highlight Color", "Change the color of selected elements", Color3.fromRGB(255,128,0), function(color)
    colors.SchemeColor = color
end)
Section1:NewColorPicker("Options Color", "Change the color of options cells", Color3.fromRGB(20,20,20), function(color)
    colors.ElementColor = color
end)

Section1:NewLabel("Binds")
Section1:NewKeybind("Instant Win", "Change the keybind of the instant win feature", Enum.KeyCode.One, function()
    instantwin()
end)
Section1:NewKeybind("Toggle Infinite Jump", "Change the keybind to toggle the infinite jump", Enum.KeyCode.Two, function()
    if infj == true then
	    infj = false
    else
        infj = true
    end
end)

Section1:NewKeybind("Infinite Jump Bind", "Change the keybind of the infinite jump feature", Enum.KeyCode.Space, function()
    zeezyAirjump()
end)

Section1:NewLabel("Other")

Section1:NewKeybind("Menu Bind", "Change the keybind to open the menu", Enum.KeyCode.RightShift, function()
    Library:ToggleUI(true)
end)

local Section2 = Tab2:NewSection("Fun")
Section2:NewButton("Suicide", "Kill yourself", function()
    game:GetService("ReplicatedStorage").Aero.AeroRemoteServices.Respawns.KillSurvivor:InvokeServer()
end)

local Section2 = Tab2:NewSection("TP")
Section2:NewButton("Get Coords", "Print your pos in the console", function()
    print(tostring(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame))
end)
Section2:NewTextBox("Pos X", "Enter the X pos of the coords", function(txt)
	posX = txt
end)
Section2:NewTextBox("Pos Y", "Enter the Y pos of the coords", function(txt)
	posY = txt
end)
Section2:NewTextBox("Pos Z", "Enter the Z pos of the coords", function(txt)
	posZ = txt
end)
Section2:NewButton("Teleport", "Teleport to the X Y Z Coords", function()
    teleport(CFrame.new(tostring(posX), tostring(posY), tostring(posZ)))
    game.StarterGui:SetCore("SendNotification", {Title="Teleported"; Text="You have been teleported !"; Duration=1;})
end)

local Section2 = Tab2:NewSection("Server")
Section2:NewButton("Rejoin", "Join the server back", function()
    tpservice:Teleport(game.PlaceId, plr)
    game.StarterGui:SetCore("SendNotification", {Title="Server"; Text="Rejoin initiated"; Duration=3;})
end)
Section2:NewButton("Server Change", "Join another server", function()
    switchServer()
    game.StarterGui:SetCore("SendNotification", {Title="Server"; Text="Switch initiated"; Duration=3;})
end)
