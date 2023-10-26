local Window = Rayfield:CreateWindow({
   Name = "DBU",
   LoadingTitle = "DBU Script",
   LoadingSubtitle = "by Spec",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = DBU, 
      FileName = "DBU Hub"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true 
   },
   KeySystem = false,
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided",
      FileName = "Key",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"Hello"}
   }
})
 

local MainTab = Window:CreateTab("Main")

local plr = game.Players.LocalPlayer
local RunService = game:GetService('RunService')
local questRemote = game:GetService("ReplicatedStorage").Package.Events.Qaction 
local punchRemote = game:GetService("ReplicatedStorage").Package.Events.p
local equipRemote = game:GetService("ReplicatedStorage").Package.Events.equipskill
local rebirthRemote = game:GetService("ReplicatedStorage").Package.Events.reb
 
local Settings = {Tables = {Forms = {'Ultra Ego','SSJB4','True God of Creation','True God of Destruction','Super Broly','LSSJG','LSSJ4','SSJG4','LSSJ3','SSJ5','Mystic Kaioken','LSSJ Kaioken','SSJ2 Kaioken','SSJBUI','LBSSJ4','SSJR3','SSJB3','God of Destruction','God of Creation','Jiren Ultra Instinct', 'Mastered Ultra Instinct','Godly SSJ2','Evil SSJ','Blue Evolution','Dark Rose','Kefla SSJ2','SSJ Berserker','True Rose', 'SSJB Kaioken','SSJ Rose', 'SSJ Blue','Corrupt SSJ','SSJ Rage','SSJG','SSJ4','Mystic','LSSJ','SSJ3','Spirit SSJ','SSJ2 Majin','SSJ2','SSJ Kaioken','SSJ','FSSJ','Kaioken'}};Variables = {Farm = false}}
setmetatable(Settings, {__index = function() warn('f') end})
 
local StackForms = {'Godly SSJ2','Mystic','SSJ3'}
 
local function returnQuest(boolean)
    local quest = getrenv()._G.x.GetRecommendedQuest(game.Players.LocalPlayer)
    if (boolean) and quest:find('Vills Planet') then 
        local args = {
    [1] = "Vills Planet"
}
 
game:GetService("ReplicatedStorage"):WaitForChild("Package"):WaitForChild("Events"):WaitForChild("TP"):InvokeServer(unpack(args))
    else
    if (boolean) and quest:find('Kito') then
    local args = {
    [1] = "Earth"
}
 
game:GetService("ReplicatedStorage"):WaitForChild("Package"):WaitForChild("Events"):WaitForChild("TP"):InvokeServer(unpack(args))
    else
        return quest
        end
    end 
end 
local function transform()
    pcall(function()
        for i,v in pairs(Settings.Tables.Forms) do
            if equipRemote:InvokeServer(v) then
                break
            end
        end
        repeat wait()
            if plr:WaitForChild("Status"):WaitForChild("SelectedTransformation").Value ~= plr.Status.Transformation.Value then
                game:GetService("ReplicatedStorage"):WaitForChild("Package"):WaitForChild("Events"):WaitForChild("ta"):InvokeServer()
            end
        until game.Players.LocalPlayer.Status.SelectedTransformation.Value == game.Players.LocalPlayer.Status.Transformation.Value
    end)
end
 
 
 
 
local function stacktransform()
    pcall(function()
        for i,v in pairs(StackForms) do
        print(v)
            if equipRemote:InvokeServer(v) then
                break
            end
        end
 
            plr.Character:WaitForChild("Humanoid"):ChangeState(15)
            wait(5.7)
            repeat 
            game:WaitForChild("ReplicatedStorage"):WaitForChild("Package"):WaitForChild("Events"):WaitForChild("ta"):InvokeServer()
            wait()
            until game.Players.LocalPlayer.Character.Humanoid.Health > 0
            wait(4)
            transform()
    end)
 
end
 
RunService.RenderStepped:Connect(function()
    if Settings.Variables.Farm then 
        plr.Character:WaitForChild('Humanoid'):ChangeState(11)
    end 
end)
 
Rayfield:Notify({
   Title = "DBU Script Loaded",
   Content = "Time to exploit",
   Duration = 5,
   Image = 4483362458,
   Actions = {
      Ignore = {
         Name = "Okay!",
         Callback = function()
         print("The user tapped Okay!")
      end
   },
},
})
 
local Autofarm = MainTab:CreateToggle({
	Name = 'Rebirth-Farm',
    CurrentValue = false,
    Flag = "Toggle10",
    Callback = function(bool)
    _G.Autofarm = not _G.Autofarm
        Settings.Variables.Farm = bool 
        while bool and wait() and _G.Autofarm == true do 
            if (not plr.PlayerGui:WaitForChild("Main"):WaitForChild("MainFrame"):WaitForChild("Frames"):WaitForChild("Quest"):WaitForChild("Nop").Visible and bool) then
                for i,v in next, workspace.Living:GetChildren() do 
                    if (v.Name == returnQuest(true) or v.Name == game:GetService("ReplicatedStorage").Package.Quests[returnQuest(true)].Objective.Value) and not plr.PlayerGui.Main.MainFrame.Frames.Quest.Nop.Visible and v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') and v.Humanoid.Health > 0 then 
                        repeat wait()
                            pcall(function() plr.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,0,2) end)
                            punchRemote:FireServer('Blacknwhite27',1)
                        until not v or not v:FindFirstChild('Humanoid') or not v:FindFirstChild('HumanoidRootPart') or v.Humanoid.Health <= 0 or not Settings.Variables.Farm or plr.PlayerGui:WaitForChild('Main').MainFrame.Frames.Quest.Nop.Visible
                    end 
                end 
            else 
                pcall(function() questRemote:InvokeServer(workspace.Others.NPCs[returnQuest(true)]) end)
            end 
        end 
    end
})

local AutoTransform = MainTab:CreateToggle({
    Name = 'Auto-Transform',
    CurrentValue = false,
    Flag = "Toggle3",
    Callback = function(bool)
    _G.Autoform = not _G.Autoform
        pcall(function()
            while bool and wait() and _G.Autoform == true do 
                transform()
            end
        end)
    end 
})
 
 
 
 
 
local AutoRebirth = MainTab:CreateToggle({
    Name = 'Rebirth',
    CurrentValue = false,
    Flag = "Toggle4",
    Callback = function(bool)
    _G.rebirth = not _G.rebirth
        while bool and wait() and _G.rebirth == true do 
            rebirthRemote:InvokeServer()
        end 
    end 
})
 
local AutoCharge = MainTab:CreateToggle({
    Name = 'Auto-Charge',
    CurrentValue = false,
    Flag = "Toggle5",
    Callback = function(bool) 
    _G.Autocharge = not _G.Autocharge
        while bool and wait() and _G.Autocharge == true do 
            game:GetService("ReplicatedStorage").Package.Events.cha:InvokeServer('Blacknwhite27')
        end
    end 
})
 
local AutoVolley = MainTab:CreateToggle({
    Name = 'Auto Energy Volley/Mach Kick',
    CurrentValue = false,
    Flag = "Toggle6",
    Callback = function(bool) 
    _G.AutoEnergy = not _G.AutoEnergy
        while bool and wait() and _G.AutoEnergy == true and plr.Character and plr.Status do
                    local args2 = {
            [1] = "Energy Volley"
        } 
 
        game:GetService("ReplicatedStorage"):WaitForChild("Package"):WaitForChild("Events"):WaitForChild("equipskill"):InvokeServer(unpack(args2))
        equipRemote:InvokeServer("Mach Kick")
       if plr.Character:WaitForChild("Stats"):WaitForChild("Ki").Value > (plr.Character:WaitForChild("Stats"):WaitForChild("Ki").MaxValue * .35) then
       local args = {
    [1] = "Energy Volley",
    [2] = {
        ["FaceMouse"] = false
    },
    [3] = "Blacknwhite27"
}
 
game:GetService("ReplicatedStorage"):WaitForChild("Package"):WaitForChild("Events"):WaitForChild("voleys"):InvokeServer(unpack(args))
 
local args3 = {
    [1] = "Mach Kick",
    [2] = "Blacknwhite27",
}
 
game:GetService("ReplicatedStorage"):WaitForChild("Package"):WaitForChild("Events"):WaitForChild("mel"):InvokeServer(unpack(args3))
            end
        end
    end 
})
wait(0.5)local ba=Instance.new("ScreenGui")
local ca=Instance.new("TextLabel")local da=Instance.new("Frame")
local _b=Instance.new("TextLabel")local ab=Instance.new("TextLabel")ba.Parent=game.CoreGui
ba.ZIndexBehavior=Enum.ZIndexBehavior.Sibling;ca.Parent=ba;ca.Active=true
ca.BackgroundColor3=Color3.new(0.176471,0.176471,0.176471)ca.Draggable=true
ca.Position=UDim2.new(0.698610067,0,0.098096624,0)ca.Size=UDim2.new(0,370,0,52)
ca.Font=Enum.Font.SourceSansSemibold;ca.Text="Anti AFK Script"ca.TextColor3=Color3.new(0,1,1)
ca.TextSize=22;da.Parent=ca
da.BackgroundColor3=Color3.new(0.196078,0.196078,0.196078)da.Position=UDim2.new(0,0,1.0192306,0)
da.Size=UDim2.new(0,370,0,107)_b.Parent=da
_b.BackgroundColor3=Color3.new(0.176471,0.176471,0.176471)_b.Position=UDim2.new(0,0,0.800455689,0)
_b.Size=UDim2.new(0,370,0,21)_b.Font=Enum.Font.Arial;_b.Text="made by ur mom "
_b.TextColor3=Color3.new(0,1,1)_b.TextSize=20;ab.Parent=da
ab.BackgroundColor3=Color3.new(0.176471,0.176471,0.176471)ab.Position=UDim2.new(0,0,0.158377,0)
ab.Size=UDim2.new(0,370,0,44)ab.Font=Enum.Font.ArialBold;ab.Text="Status: Active"
ab.TextColor3=Color3.new(0,1,1)ab.TextSize=20;local bb=game:service'VirtualUser'
game:service'Players'.LocalPlayer.Idled:connect(function()
bb:CaptureController()bb:ClickButton2(Vector2.new())
ab.Text="Roblox tried to kick u but i kicked him instead"wait(2)ab.Text="Status : Active"end)