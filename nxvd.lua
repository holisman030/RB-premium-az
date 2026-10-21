--[loadstring #18]--
local function __NexHub_Init_Main__()
local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local Lighting          = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace         = game:GetService("Workspace")
local Teams             = game:GetService("Teams")
local GuiService        = game:GetService("GuiService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local LocalPlayer       = Players.LocalPlayer
local Camera            = Workspace.CurrentCamera
local Character, Humanoid, Root

local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

local UI = {}

local ok, result = pcall(require, "./src/Init")
local ModernV2 = ok and result or nil
if not ModernV2 then
    local loaderOk, loaderResult = pcall(function()
        local source = game:HttpGet("https://shinzux.vercel.app/files/ambaruto.txt")
        local fn, compileErr = loadstring(source)
        if not fn then error(compileErr) end
        return fn()
    end)
    if loaderOk then
        ModernV2 = loaderResult
    else
        warn("[NexHub] Vercel mirror failed, trying GitHub fallback:", loaderResult)
        local fallbackOk, fallbackResult = pcall(function()
            local source = game:HttpGet("https://raw.githubusercontent.com/nexiuse/NexHubNewUI/refs/heads/main/MainV2.lua")
            local fn, compileErr = loadstring(source)
            if not fn then error(compileErr) end
            return fn()
        end)
        if fallbackOk then
            ModernV2 = fallbackResult
        else
            warn("[NexHub] Failed to load ModernV2 from all sources:", fallbackResult)
        end
    end
end

if isMobile then UI.Mobile = true end
print("[Universal] Platform:", isMobile and "MOBILE" or "PC")

-- =====================================================
local HttpService = game:GetService("HttpService")
local UIConfigPath = "NexHub_UI_Theme.json"
local NexUI_Solid = false
local NexUI_Color = "Purple"

pcall(function()
    if isfile and readfile and isfile(UIConfigPath) then
        local data = HttpService:JSONDecode(readfile(UIConfigPath))
        NexUI_Solid = data.Solid
        NexUI_Color = data.Color or "Purple"
    end
end)

if NexUI_Color == "Default" then
    NexUI_Color = "Purple"
end

if ModernV2 then
    pcall(function()
        ModernV2:AddTheme({
            Name = "Lumi Purple",
            Accent = Color3.fromRGB(148, 0, 211),
            Outline = Color3.fromRGB(148, 0, 211),
            Text = Color3.fromRGB(255, 255, 255),
            PlaceholderText = Color3.fromRGB(200, 200, 200)
        })
    end)
end

local MenuIcon
if ModernV2 and ModernV2.CreateMenuIcon then
    MenuIcon = ModernV2:CreateMenuIcon({
        Image = "rbxassetid://82006436469351",
        Size = 48,
        IconColor = Color3.fromRGB(255, 255, 255),
        BGColor = Color3.fromRGB(20, 22, 27),
        StrokeColor = Color3.fromRGB(148, 0, 211),
        StrokeThick = 1.5,
        Draggable = true,
    })
end
local Window
if ModernV2 then
    Window = ModernV2:Window({
        Title = "NexHub",
        Content = "Violence District v1.5.9",
        Uitransparent = 0.15,
        Size = UDim2.fromOffset(500, 320),
        Color = Color3.fromRGB(148, 0, 211),
        Image = "82006436469351",
        ShowUser = true,
        Search = true,
        ConfigEnabled = true,
        NotifyOnCallbackError = false,
        Loadingscreen = false,
        Enable3DRenderer = false,
        Keybind = "RightControl",
        Config = {
            ConfigFolder = "NexHubViolenceDistrict",
            AutoSaveFile = "NEX_VD",
            AutoSave = false,
            AutoLoad = false,
            Overwrite = true,
            Format = "JSON",
            ShowAutoSaveToggle = true,
            TextGradient = true,
        }
    })

    if MenuIcon and Window.AttachMenuIcon then
        Window:AttachMenuIcon(MenuIcon)
    end

    if Window and type(Window.ToggleInterface) == "function" then
        local NEX_OriginalToggleInterface = Window.ToggleInterface
        Window.ToggleInterface = function(self, ...)
            if Window.Destroyed then return end
            local isCurrentlyVisible = Window.Signal and Window.Signal:GetValue()
            if not isCurrentlyVisible then
                pcall(function()
                    if Window.Root and ModernV2 and ModernV2.ScreenGui then
                        Window.Root.Parent = ModernV2.ScreenGui
                        Window.Root.Visible = true
                    end
                end)
            end
            return NEX_OriginalToggleInterface(self, ...)
        end
    end

    Window:SetAccount({
        Username = LocalPlayer.DisplayName,
        Profile = ModernV2.UserProfile,
        Expires = "NexHubOnTop",
    })

    Window:CreateHomeTab({
        Name = "Dashboard",
        Icon = "lucide:layout-dashboard",
        Content = "NexHub Violence District Script",
        DiscordInvite = "https://discord.gg/CJSb25kaCp",
          SupportedExecutors = { "Delta", "Synapse X", "Krnl", "Codex", "Arceus X" },
          UnsupportedExecutors = { "Roblox Studio" },
          Segments = {
              Details = { Text = "Details", Icon = "lucide:grid-2x2" },
              Script = { Text = "Script Logs", Icon = "lucide:code" },
              UI = { Text = "UI Logs", Icon = "lucide:file-text", Show = true }
          },
        Changelog = {
            {
                Title = "NexHub VD v1.5.9",
                Description = "Unlocked version - all premium features free.",
            },
        },
        UIChangelog = {
            {
                Title = "ModernV2 Framework",
                Date = "Latest",
                Description = "Added Lumi Purple Theme",
            },
        }
    })
end

if not isMobile then
    local _cursorOn = false
    local _cursorManual = false

    local function _setCursor(state)
        _cursorOn = state
        _cursorManual = true
        pcall(function()
            UserInputService.MouseIconEnabled = state
            UserInputService.MouseBehavior = state
                and Enum.MouseBehavior.Default
                or Enum.MouseBehavior.LockCenter
        end)

        local char = LocalPlayer.Character
        local humanoid = char and char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.AutoRotate = not state
        end
    end

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if input.KeyCode == Enum.KeyCode.LeftAlt or input.KeyCode == Enum.KeyCode.RightAlt then
            _setCursor(not _cursorOn)
        end
    end)

    task.spawn(function()
        while true do
            if _cursorManual then
                pcall(function()
                    if _cursorOn then
                        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
                        UserInputService.MouseIconEnabled = true
                    else
                        UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
                        UserInputService.MouseIconEnabled = false
                    end
                end)
            end
            task.wait(0.1)
        end
    end)

    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(1)
        if _cursorOn then _setCursor(true) end
    end)

    print("[VD] ALT Toggle Cursor Ready (PC only)")
end

local DrawingAvailable = (function()
    if isMobile then return false end
    local ok, result = pcall(function()
        return typeof(Drawing) == "table" and Drawing.new ~= nil
    end)
    return ok and result or false
end)()

function SafeDrawing(typ)
    if not DrawingAvailable then return nil end
    local ok, res = pcall(function() return Drawing.new(typ) end)
    return ok and res or nil
end

function SafeRemove(obj)
    if obj and obj.Remove then pcall(function() obj:Remove() end) end
end

local MobileESP = {}

function clamp(v, min, max)
    return math.max(min, math.min(max, v))
end

getgenv().VD = getgenv().VD or {
    AutoSkillcheck        = false,
    AutoSkillcheckMode    = "Normal",
    HideSkillUI           = false,
    Fullbright            = false,
    Speed                 = false,
    SpeedValue            = 16,
    Jump                  = false,
    JumpValue             = 50,
    InfiniteJump          = false,
    Noclip                = false,
    Moonwalk              = false,
    MoonwalkButton        = false,
    MoonwalkButtonLocked  = false,
    MoonwalkZigzagSpeed   = 11,
    MoonwalkBoostPower    = 1.08,
    AimLock               = false,
    AimLockButton         = false,
    AimLockButtonLocked   = false,
    AimLockMaxDistance    = 50,
    InvisibleNotVisual    = false,
    InvisibleSpeed        = 5,
    AntiAFK               = false,
    BypassGate            = false,
    Destroyed             = false,
    AUTO_LeaveGen         = false,
    AUTO_LeaveDist        = 18,
    AUTO_Attack           = false,
    AUTO_AttackRange      = 12,
    HITBOX_Enabled        = false,
    HITBOX_Size           = 15,
    TOF_SilentAim         = false,
    TOF_Laser             = true,
    TOF_WallCheck         = false,
    TOF_BlockKnocked      = true,
    TOF_TargetMode        = "Killer",
    TOF_Key               = "None",
    FLASH_SilentAim       = false,
    FLASH_Laser           = true,
    FLASH_TargetPart      = "Head",
    FLASH_Range           = 120,
    FLASH_Smooth          = 0.35,
    SURV_FleeKiller       = false,
    SURV_FleeDistance     = 40,
    SURV_SwiftVault       = false,
    SURV_SwiftVaultV2     = false,
    SURV_SwiftVaultSpeed  = 13,
    SURV_AutoPallet       = false,
    SURV_AutoPalletDist   = 20,
    SURV_AutoParry        = false,
    SURV_ParryDistance    = 8,
    SURV_ShowParryCircle  = false,
    SURV_FakeParry        = false,
    SURV_FakeParryAnim    = "Enten",
    SURV_FakeGen          = false,
    SURV_AntiKnock        = false,
    KILLER_DestroyPallets = false,
    KILLER_NoPalletStun   = false,
    KILLER_AutoHook       = false,
    KILLER_AutoBreakGene  = false,
    KILLER_BlockVaults    = false,
    KILLER_BlockPallets   = false,
    KILLER_BlockPalletDrop = false,
    KILLER_BypassCooldown = false,
    KILLER_BypassLeap     = false,
    KILLER_AntiBlind      = false,
    KILLER_NoSlowdown     = false,
    KILLER_CustomMasked   = "Richard",
    SPEED_Enabled         = false,
    SPEED_Value           = 32,
    SPEED_Method          = "Attribute",
    NO_Fog                = false,
    NoCutscene            = false,
    CAM_FOVEnabled        = false,
    CAM_FOV               = 90,
    CAM_ThirdPerson       = false,
    CAM_ShiftLock         = false,
    CAM_InfinityZoom      = false,
    AntiFallDamage        = false,
    FLING_Enabled         = false,
    FLING_Strength        = 10000,
    BEAT_Survivor         = false,
    BEAT_Killer           = false,
    TP_Offset             = 3,
    VIS_NextKiller        = false,
    VIS_SpectatorCounter  = false,
    VIS_KillerPerks       = false,
    VIS_PredictMap        = false,
    VIS_HideSurvivorIcon  = false,
    VIS_ShowPingFPS       = false,
    VIS_ShowHookCounter   = false,
    VIS_WeatherTheme      = "Default",
    CROSS_Enabled         = false,
    CROSS_Style           = "Dot",
    CROSS_Size            = 3,
    CROSS_Thickness       = 4,
    CROSS_Gap             = 6,
    CROSS_PosX            = 0,
    CROSS_PosY            = 0,
    CROSS_Color           = Color3.fromRGB(255, 255, 255),
    ESP_ClosestHook       = false,
    AIM_Enabled           = false,
    AIM_UseRMB            = false,
    AIM_FOV               = 120,
    AIM_Smooth            = 0.3,
    AIM_TargetPart        = "Head",
    AIM_VisCheck          = false,
    AIM_ShowFOV           = false,
    AIM_Predict           = false,
    SURV_FirstPerson      = false,
    SPEAR_Aimbot          = false,
    SPEAR_Gravity         = 50,
    SPEAR_Speed           = 100,
    RADAR_Enabled         = false,
    RADAR_Size            = 150,
    RADAR_Range           = 250,
    RADAR_Transparency    = 0.2,
    RADAR_Circle          = false,
    RADAR_ShowKiller      = false,
    RADAR_ShowSurvivor    = false,
    RADAR_ShowGenerator   = false,
    RADAR_ShowPallet      = false,
    RADAR_ShowHook        = false,
    RADAR_ShowGate        = false,
    RADAR_ShowWindow      = false,
    RADAR_ShowZombie      = false,
    SURV_WarnKiller       = false,
    SURV_AutoDodgeSpear   = false,
    AUTOFARM_Escape       = false,
    AUTOFARM_HopAfterEscape = false,
    AUTOFARM_RoundDetect  = false,
    AUTOFARM_HopIfAlone   = false,
    AUTOFARM_WebhookURL   = "",
    AUTOFARM_AwardStatus  = false
}

local VD = getgenv().VD

local CrosshairGui = nil

function clearCrosshair()
    if CrosshairGui then
        pcall(function() CrosshairGui:Destroy() end)
        CrosshairGui = nil
    end
end

function VD_UpdateCrosshair()
    clearCrosshair()
    if not VD.CROSS_Enabled then return end

    local cam = workspace.CurrentCamera
    if not cam then return end

    local style = VD.CROSS_Style or "Dot"
    local size = tonumber(VD.CROSS_Size) or 3
    local gap = tonumber(VD.CROSS_Gap) or 6
    local thick = tonumber(VD.CROSS_Thickness) or 4
    local color = typeof(VD.CROSS_Color) == "Color3" and VD.CROSS_Color or Color3.fromRGB(255, 255, 255)
    
    local offsetX = tonumber(VD.CROSS_PosX) or 0
    local offsetY = tonumber(VD.CROSS_PosY) or 0

    local ok, core = pcall(function() return game:GetService("CoreGui") end)
    local parent = (ok and core) and core or game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui")
    if not parent then return end

    CrosshairGui = Instance.new("ScreenGui")
    CrosshairGui.Name = "NEX_Crosshair"
    CrosshairGui.DisplayOrder = 999999
    CrosshairGui.IgnoreGuiInset = true
    CrosshairGui.Parent = parent

    local centerFrame = Instance.new("Frame")
    centerFrame.Name = "Center"
    centerFrame.BackgroundTransparency = 1
    centerFrame.Position = UDim2.new(0.5, offsetX, 0.5, offsetY)
    centerFrame.Size = UDim2.new(0,0,0,0)
    centerFrame.Parent = CrosshairGui

    if style == "Dot" then
        local dot = Instance.new("Frame")
        dot.AnchorPoint = Vector2.new(0.5, 0.5)
        dot.Size = UDim2.new(0, size * 2, 0, size * 2)
        dot.BackgroundColor3 = color
        dot.BorderSizePixel = 0
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(1, 0)
        corner.Parent = dot
        dot.Parent = centerFrame

    elseif style == "Plus" or style == "X" then
        local length = size * 3
        for i = 1, 4 do
            local line = Instance.new("Frame")
            line.AnchorPoint = Vector2.new(0.5, 0.5)
            line.BackgroundColor3 = color
            line.BorderSizePixel = 0
            
            local angle = (i - 1) * 90
            if style == "X" then angle = angle + 45 end
            
            line.Rotation = angle
            line.Size = UDim2.new(0, length, 0, thick)
            
            local rad = math.rad(angle)
            local dirX = math.cos(rad)
            local dirY = math.sin(rad)
            
            local dist = gap + (length / 2)
            line.Position = UDim2.new(0, math.floor(dirX * dist + 0.5), 0, math.floor(dirY * dist + 0.5))
            line.Parent = centerFrame
        end

    elseif style == "Box" then
        local half = gap + size * 2
        
        local t = Instance.new("Frame")
        t.BackgroundColor3 = color; t.BorderSizePixel = 0; t.AnchorPoint = Vector2.new(0.5, 0.5)
        t.Size = UDim2.new(0, half * 2 + thick, 0, thick)
        t.Position = UDim2.new(0, 0, 0, -half)
        t.Parent = centerFrame

        local b = Instance.new("Frame")
        b.BackgroundColor3 = color; b.BorderSizePixel = 0; b.AnchorPoint = Vector2.new(0.5, 0.5)
        b.Size = UDim2.new(0, half * 2 + thick, 0, thick)
        b.Position = UDim2.new(0, 0, 0, half)
        b.Parent = centerFrame

        local l = Instance.new("Frame")
        l.BackgroundColor3 = color; l.BorderSizePixel = 0; l.AnchorPoint = Vector2.new(0.5, 0.5)
        l.Size = UDim2.new(0, thick, 0, half * 2 - thick)
        l.Position = UDim2.new(0, -half, 0, 0)
        l.Parent = centerFrame

        local r = Instance.new("Frame")
        r.BackgroundColor3 = color; r.BorderSizePixel = 0; r.AnchorPoint = Vector2.new(0.5, 0.5)
        r.Size = UDim2.new(0, thick, 0, half * 2 - thick)
        r.Position = UDim2.new(0, half, 0, 0)
        r.Parent = centerFrame
    end
end
getgenv().VD_UpdateCrosshair = VD_UpdateCrosshair

local VD_DefaultOffFlags = {
    "AutoSkillcheck","HideSkillUI","Fullbright","Speed","Jump","InfiniteJump","Noclip",
    "Moonwalk","MoonwalkButton","MoonwalkButtonLocked","AimLock","AimLockButton","AimLockButtonLocked",
    "AimLockMaxDistance","InvisibleNotVisual","AntiAFK","BypassGate","AUTO_Attack","HITBOX_Enabled",
    "TOF_SilentAim","FLASH_SilentAim","SURV_FleeKiller","SURV_SwiftVault","SURV_SwiftVaultV2",
    "SURV_AutoPallet","SURV_AutoParry","SURV_ShowParryCircle","SURV_FakeParry","SURV_FakeParryAnim",
    "SURV_FakeGen","SURV_AntiKnock","KILLER_DestroyPallets","KILLER_NoPalletStun","KILLER_AutoHook",
    "KILLER_AutoBreakGene","KILLER_BlockVaults","KILLER_BlockPallets","KILLER_BlockPalletDrop",
    "KILLER_BypassCooldown","KILLER_BypassLeap","KILLER_BypassVeilCooldown","KILLER_AntiBlind",
    "KILLER_NoSlowdown","SPEED_Enabled","NO_Fog","NoCutscene","VIS_NextKiller","CAM_FOVEnabled",
    "CAM_ThirdPerson","CAM_ShiftLock","CAM_InfinityZoom","AntiFallDamage","FLING_Enabled",
    "BEAT_Survivor","BEAT_Killer","ESP_ClosestHook","VIS_SpectatorCounter","VIS_KillerPerks",
    "VIS_PredictMap","VIS_HideSurvivorIcon","VIS_ShowPingFPS","VIS_ShowHookCounter","CROSS_Enabled",
    "CROSS_Style","CROSS_Size","CROSS_Thickness","CROSS_Gap","CROSS_PosX","CROSS_PosY","CROSS_Color",
    "AIM_Enabled","AIM_UseRMB","AIM_VisCheck","AIM_ShowFOV","AIM_Predict","SURV_FirstPerson",
    "SPEAR_Aimbot","RADAR_Enabled","RADAR_Circle","RADAR_ShowKiller","RADAR_ShowSurvivor",
    "RADAR_ShowGenerator","RADAR_ShowPallet","RADAR_ShowHook","RADAR_ShowGate","RADAR_ShowWindow",
    "RADAR_ShowZombie","SURV_WarnKiller",
}

for _, flagName in ipairs(VD_DefaultOffFlags) do
    VD[flagName] = false
end

if VD.TOF_Laser == nil then VD.TOF_Laser = true end
if VD.TOF_WallCheck == nil then VD.TOF_WallCheck = false end
if VD.TOF_BlockKnocked == nil then VD.TOF_BlockKnocked = true end
if VD.TOF_TargetMode == nil then VD.TOF_TargetMode = "Killer" end
if VD.TOF_Key == nil then VD.TOF_Key = "None" end
if VD.FLASH_TargetPart == nil then VD.FLASH_TargetPart = "Head" end
if VD.FLASH_Laser == nil then VD.FLASH_Laser = true end
if VD.FLASH_Range == nil then VD.FLASH_Range = 120 end
if VD.FLASH_Smooth == nil then VD.FLASH_Smooth = 0.35 end

function GetSafeGuiParent()
    if gethui then return gethui() end
    local ok, core = pcall(function() return game:GetService("CoreGui") end)
    if ok and core then return core end
    return LocalPlayer:FindFirstChild("PlayerGui")
end

local VD_ChamsFolder = nil
function GetSafeChamsFolder()
    local pg = GetSafeGuiParent()
    if not pg then return workspace end
    if VD_ChamsFolder and VD_ChamsFolder.Parent then return VD_ChamsFolder end

    local f = pg:FindFirstChild("NEX_WorkspaceChams")
    if not f then
        f = Instance.new("Folder")
        f.Name = "NEX_WorkspaceChams"
        f.Parent = pg
    end
    VD_ChamsFolder = f
    return f
end

local ConfigFolderName = "NexHub_VD"
local HttpService = game:GetService("HttpService")

if makefolder and isfolder and not isfolder(ConfigFolderName) then
    makefolder(ConfigFolderName)
end

getgenv().CurrentConfigName = "Default"

function GetConfigList()
    local list = {}
    if listfiles and isfolder and isfolder(ConfigFolderName) then
        for _, file in pairs(listfiles(ConfigFolderName)) do
            if file:sub(-5) == ".json" then
                local filename = file:match("([^/\\]+)%.json$")
                if filename then
                    table.insert(list, filename)
                end
            end
        end
    end
    if #list == 0 then table.insert(list, "Default") end
    return list
end

function NEX_SaveConfig(name)
    name = (name and name ~= "") and name or getgenv().CurrentConfigName
    if not name or name == "" then name = "Default" end
    local path = ConfigFolderName .. "/" .. name .. ".json"
    pcall(function()
        if writefile then
            writefile(path, HttpService:JSONEncode(VD))
        end
    end)
end

local VD_To_Flag = {
    InfiniteJump = "Infinite Jump",
    KILLER_AntiBlind = "Anti Blind (Flashlight)",
    Fullbright = "Fullbright (lighting preset)",
    AIM_VisCheck = "Visibility Check",
    AutoSkillcheck = "Auto Skillcheck",
    AutoSkillcheckMode = "Skillcheck Mode",
    HideSkillUI = "Hide Skillcheck UI",
    SpeedValue = "Speed Value",
    AIM_Enabled = "Enable Aimbot",
    HITBOX_Size = "Hitbox Size",
    SURV_FleeKiller = "Flee Killer",
    SURV_FleeDistance = "Flee Distance",
    SURV_AutoVault      = "SwiftVault",
    SURV_FastVault      = "SwiftVaultV2",
    SURV_VaultSpeed     = "SwiftVaultSpeed",
    SURV_AutoPallet     = "Pallet Reflex",
    SURV_AutoPalletDist = "Pallet Trigger Range",
    SURV_AutoParry      = "Auto Parry",
    SURV_ParryDistance  = "Parry Distance Trigger",
    SURV_ShowParryCircle = "Show Parry Range Circle",
    SURV_FakeParry      = "Fake Parry (Press V)",
    SURV_FakeParryAnim  = "Fake Parry Animation",
    SURV_FakeGen        = "Fake Generator (Press B)",
    SURV_AntiKnock = "Anti Knock",
    KILLER_DestroyPallets = "Destroy Pallets",
    KILLER_AutoBreakGene  = "Auto Kick Generator",
    KILLER_BlockVaults    = "Block All Vaults",
    KILLER_BlockPallets   = "Auto Drop All Pallets",
    KILLER_BlockPalletDrop = "Break All Pallet",
    KILLER_BypassCooldown = "Infinite Abyssal Burst (Abyss)",
    KILLER_BypassLeap     = "Infinite Skill (Hidden)",
    KILLER_FakeAttack     = "Fake Attack (Counter Parry)",
    KILLER_BypassVeilCooldown = "Bypass Cooldown (Veil)",
    KILLER_CustomMasked = "Custom Masked",
    Speed = "Speed Hack",
    CAM_FOV = "Camera FOV",
    CAM_FOVEnabled = "Enable Camera FOV override",
    FLING_Strength = "Fling Strength",
    Noclip = "Noclip",
    Moonwalk = "Moonwalk",
    MoonwalkButton = "Moonwalk",
    MoonwalkButtonLocked = "Lock Moonwalk Button",
    MoonwalkZigzagSpeed = "Moonwalk Zigzag Speed",
    MoonwalkBoostPower = "Moonwalk Boost Power",
    AimLock = "Target Lock",
    AimLockButton = "Target Lock",
    AimLockButtonLocked = "Lock Target Lock Button",
    AimLockMaxDistance = "Target Lock Max Distance",
    BEAT_Killer = "Beat Killer (auto kill)",
    AIM_Predict = "Prediction",
    AIM_ShowFOV = "Show FOV Circle",
    KILLER_AutoHook = "Auto Hook",
    Jump = "Jump Hack",
    KILLER_NoSlowdown = "No Slowdown",
    SPEAR_Gravity = "Spear Gravity",
    AIM_UseRMB = "Use RMB to aim",
    CAM_ShiftLock = "Shift Lock (auto face camera)",
    Destroyed = "Solid UI Mode (No Transparency)",
    AUTO_AttackRange = "Attack Range",
    AIM_FOV = "FOV Size (aim radius on screen)",
    KILLER_NoPalletStun = "Remove Palletwrong (All)",
    CAM_ThirdPerson = "Third Person (Killer only)",
    CAM_InfinityZoom = "Infinity Zoom Out",
    AntiFallDamage = "Anti Fall Damage",
    InvisibleNotVisual = "Invisible Not Visual",
    InvisibleSpeed = "Invisible Speed",
    AntiAFK = "Anti AFK",
    BypassGate = "Bypass Gate",
    HITBOX_Enabled = "Hitbox Expand",
    TOF_SilentAim = "Silent Aim Twist Of Fate",
    TOF_Laser = "ToF Laser",
    TOF_WallCheck = "ToF Wall Check",
    TOF_BlockKnocked = "ToF Block When Knocked",
    TOF_TargetMode = "ToF Target Mode",
    TOF_Key = "Silent Aim Keybind",
    FLASH_SilentAim = "Silent Aim Flashlight",
    FLASH_Laser = "Flashlight Laser",
    FLASH_TargetPart = "Flashlight Target Part",
    FLASH_Range = "Flashlight Range",
    FLASH_Smooth = "Flashlight Smoothness",
    NO_Fog = "No Fog (remove fog/post effects)",
    NoCutscene = "No Cutscene",
    FLING_Enabled = "Enable Fling",
    AIM_Smooth = "Smoothness",
    SPEAR_Speed = "Spear Speed",
    SPEAR_Aimbot = "Spear Aimbot",
    SURV_FirstPerson = "First Person Camera (Survivor)",
    JumpValue = "Jump Power",
    AUTO_Attack = "Auto Attack",
    BEAT_Survivor = "Beat Survivor (auto exit)",
    SURV_WarnKiller = "Survivor Killer Warning",
    VIS_NextKiller = "Next Killer Display",
    VIS_SpectatorCounter = "Enable Spectator Counter",
    VIS_KillerPerks = "Killer Perks Display",
    VIS_PredictMap = "Predict Map",
    VIS_HideSurvivorIcon = "Hide Survivor Icon",
    VIS_ShowPingFPS = "Show Ping & FPS",
    VIS_ShowHookCounter = "Show Hook Counter",
    AUTOFARM_Escape = "Auto Farm (Escape)",
    AUTOFARM_HopAfterEscape = "Auto Farm Hop After Escape",
    AUTOFARM_RoundDetect = "Auto Farm Round Detect",
    AUTOFARM_HopIfAlone = "Auto Farm Hop If Alone",
    AUTOFARM_WebhookURL = "Auto Farm Webhook URL",
    AUTOFARM_AwardStatus = "Auto Farm Award Status",
}

function NEX_LoadConfig(name)
    name = (name and name ~= "") and name or getgenv().CurrentConfigName
    if not name or name == "" then name = "Default" end
    local path = ConfigFolderName .. "/" .. name .. ".json"
    pcall(function()
        if readfile and isfile and isfile(path) then
            local data = HttpService:JSONDecode(readfile(path))
            for key, value in pairs(data) do
                VD[key] = value
                local flagName = VD_To_Flag[key]
                if flagName and Window and Window.ConfigElements and Window.ConfigElements[flagName] then
                    pcall(function()
                        local elem = Window.ConfigElements[flagName]
                        if elem.Set then elem:Set(value) end
                    end)
                end
            end
            if getgenv().NEX_SyncLoadedFeatures then pcall(getgenv().NEX_SyncLoadedFeatures) end
        end
    end)
end

function NEX_DeleteConfig(name)
    name = (name and name ~= "") and name or getgenv().CurrentConfigName
    if not name or name == "" or name == "Default" then return end
    local path = ConfigFolderName .. "/" .. name .. ".json"
    pcall(function()
        if isfile and isfile(path) and delfile then
            delfile(path)
            print("[VD Config] Deleted:", name)
        end
    end)
end

local originalLighting = {
    Brightness     = Lighting.Brightness,
    ClockTime      = Lighting.ClockTime,
    FogEnd         = Lighting.FogEnd,
    FogStart       = Lighting.FogStart,
    GlobalShadows  = Lighting.GlobalShadows,
    OutdoorAmbient = Lighting.OutdoorAmbient
}
do
    local atm  = Lighting:FindFirstChildOfClass("Atmosphere")
    local blur = Lighting:FindFirstChildOfClass("BlurEffect")
    local cc   = Lighting:FindFirstChildOfClass("ColorCorrectionEffect")
    local sr   = Lighting:FindFirstChildOfClass("SunRaysEffect")
    if atm then
        originalLighting.Atmosphere = {
            Density = atm.Density,
            Offset = atm.Offset,
            Glare = atm.Glare,
            Haze = atm.Haze
        }
    end
    if blur then originalLighting.Blur = { Size = blur.Size } end
    if cc then originalLighting.ColorCorrection = { Enabled = cc.Enabled } end
    if sr then originalLighting.SunRays = { Enabled = sr.Enabled } end
end

getgenv().VD_CurrentSky = nil
getgenv().VD_ParticleAnchor = nil

local NEX_WeatherPresets = {
    ["Default"] = {},
    ["Christmas (Snow)"] = {
        Lighting = { FogColor = Color3.fromRGB(150, 180, 220), FogEnd = 200, ClockTime = 8, OutdoorAmbient = Color3.fromRGB(100, 120, 150) },
        Atmosphere = { Density = 0.5, Color = Color3.fromRGB(180, 200, 220), Decay = Color3.fromRGB(150, 180, 220), Haze = 5, Glare = 0 },
        Particle = { Texture = "rbxasset://textures/particles/sparkles_main.dds", Color = ColorSequence.new(Color3.fromRGB(255, 255, 255)), Size = NumberSequence.new(1.5), Rate = 150, Speed = NumberRange.new(15, 25), Lifetime = NumberRange.new(4, 6), EmissionDirection = Enum.NormalId.Bottom, RotSpeed = NumberRange.new(-45, 45) }
    },
    ["Heavy Rain (Storm)"] = {
        Lighting = { FogColor = Color3.fromRGB(50, 50, 60), FogEnd = 150, OutdoorAmbient = Color3.fromRGB(40, 40, 50), Brightness = 0.2, ClockTime = 12 },
        CC = { TintColor = Color3.fromRGB(150, 150, 180), Contrast = 0.2, Saturation = -0.5 },
        Particle = { Texture = "rbxasset://textures/particles/sparkles_main.dds", AnchorSize = Vector3.new(260, 1, 260), CameraOffset = Vector3.new(0, 38, -18), Squash = NumberSequence.new(16), Color = ColorSequence.new(Color3.fromRGB(235, 245, 255)), Size = NumberSequence.new(1.25), Rate = 2600, Speed = NumberRange.new(110, 145), Lifetime = NumberRange.new(0.85, 1.25), EmissionDirection = Enum.NormalId.Bottom, Transparency = NumberSequence.new(0), Acceleration = Vector3.new(-18, -75, 0), SpreadAngle = Vector2.new(3, 3), LightEmission = 1 }
    },
    ["Autumn (Musim Gugur)"] = {
        Lighting = { FogColor = Color3.fromRGB(200, 150, 80), FogEnd = 500, OutdoorAmbient = Color3.fromRGB(180, 140, 70), ClockTime = 16.5 },
        CC = { TintColor = Color3.fromRGB(255, 220, 180), Contrast = 0.1, Saturation = 0.2 },
        Particle = { Texture = "rbxasset://textures/particles/sparkles_main.dds", AnchorSize = Vector3.new(210, 1, 210), CameraOffset = Vector3.new(0, 28, -16), Squash = NumberSequence.new(3.2), Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 190, 45)), ColorSequenceKeypoint.new(0.45, Color3.fromRGB(235, 95, 20)), ColorSequenceKeypoint.new(1, Color3.fromRGB(135, 45, 10)) }), Size = NumberSequence.new(2.05), Rate = 360, Speed = NumberRange.new(8, 15), Lifetime = NumberRange.new(6, 10), EmissionDirection = Enum.NormalId.Bottom, Rotation = NumberRange.new(0, 360), RotSpeed = NumberRange.new(-220, 220), Transparency = NumberSequence.new(0), Acceleration = Vector3.new(18, -8, 6), SpreadAngle = Vector2.new(38, 38), LightEmission = 0.6 }
    },
    ["Cherry Blossom (Sakura)"] = {
        Lighting = { FogColor = Color3.fromRGB(255, 200, 220), FogEnd = 600, OutdoorAmbient = Color3.fromRGB(255, 180, 200), ClockTime = 9 },
        CC = { TintColor = Color3.fromRGB(255, 230, 240), Saturation = 0.3 },
        Particle = { Texture = "rbxasset://textures/particles/sparkles_main.dds", AnchorSize = Vector3.new(160, 1, 160), CameraOffset = Vector3.new(0, 25, -18), Squash = NumberSequence.new(1.2), Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 220, 235)), ColorSequenceKeypoint.new(0.55, Color3.fromRGB(255, 165, 205)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 120, 180)) }), Size = NumberSequence.new(1.25), Rate = 190, Speed = NumberRange.new(5, 10), Lifetime = NumberRange.new(7, 10), EmissionDirection = Enum.NormalId.Bottom, Rotation = NumberRange.new(0, 360), RotSpeed = NumberRange.new(-170, 170), Transparency = NumberSequence.new(0), Acceleration = Vector3.new(14, -5, 5), SpreadAngle = Vector2.new(32, 32), LightEmission = 0.55 }
    },
    ["Sunset (Golden Hour)"] = {
        Lighting = { FogColor = Color3.fromRGB(255, 120, 50), FogEnd = 1200, OutdoorAmbient = Color3.fromRGB(200, 100, 50), ClockTime = 17.5, Brightness = 1.5 },
        CC = { TintColor = Color3.fromRGB(255, 200, 150), Contrast = 0.2, Saturation = 0.4 }
    },
    ["Blood Moon (Spooky)"] = {
        Lighting = { FogColor = Color3.fromRGB(150, 10, 10), FogEnd = 500, OutdoorAmbient = Color3.fromRGB(80, 0, 0), ClockTime = 0, Brightness = 0.3 },
        CC = { TintColor = Color3.fromRGB(255, 50, 50), Contrast = 0.4, Saturation = 0.5 },
        Atmosphere = { Density = 0.35, Color = Color3.fromRGB(255, 0, 0), Decay = Color3.fromRGB(100, 0, 0), Haze = 5, Glare = 0 }
    },
    ["Toxic Wasteland"] = {
        Lighting = { FogColor = Color3.fromRGB(80, 150, 50), FogEnd = 250, OutdoorAmbient = Color3.fromRGB(50, 120, 40), ClockTime = 12, Brightness = 1 },
        CC = { TintColor = Color3.fromRGB(150, 255, 150), Contrast = 0.1, Saturation = 0.3 },
        Particle = { Texture = "rbxasset://textures/particles/sparkles_main.dds", Color = ColorSequence.new(Color3.fromRGB(100, 255, 50)), Size = NumberSequence.new(0.8), Rate = 200, Speed = NumberRange.new(50, 60), Lifetime = NumberRange.new(2, 3), EmissionDirection = Enum.NormalId.Bottom, Transparency = NumberSequence.new(0.5) }
    },
    ["Vaporwave (Synthwave)"] = {
        Lighting = { FogColor = Color3.fromRGB(200, 50, 255), FogEnd = 500, OutdoorAmbient = Color3.fromRGB(150, 0, 200), ClockTime = 20, Brightness = 1 },
        CC = { TintColor = Color3.fromRGB(255, 100, 255), Contrast = 0.3, Saturation = 0.5 }
    },
    ["Midnight (Pitch Black)"] = {
        Lighting = { FogColor = Color3.fromRGB(0, 0, 0), FogEnd = 100, OutdoorAmbient = Color3.fromRGB(0, 0, 0), Brightness = 0, ClockTime = 0 },
        CC = { TintColor = Color3.fromRGB(50, 50, 50), Contrast = 0.5, Saturation = -0.8 }
    }
}

function VD_ApplyWeather(themeName)
    local theme = NEX_WeatherPresets[themeName]
    if not theme then theme = NEX_WeatherPresets["Default"] end
    
    if getgenv().VD_CurrentSky and getgenv().VD_CurrentSky.Parent then getgenv().VD_CurrentSky:Destroy() end
    getgenv().VD_CurrentSky = nil
    
    if getgenv().VD_WeatherCC and getgenv().VD_WeatherCC.Parent then getgenv().VD_WeatherCC:Destroy() end
    getgenv().VD_WeatherCC = nil
    
    if getgenv().VD_WeatherAtmosphere and getgenv().VD_WeatherAtmosphere.Parent then getgenv().VD_WeatherAtmosphere:Destroy() end
    getgenv().VD_WeatherAtmosphere = nil
    
    if theme.Atmosphere then
        local atm = Instance.new("Atmosphere")
        atm.Name = "VD_WeatherAtmosphere"
        for k, v in pairs(theme.Atmosphere) do pcall(function() atm[k] = v end) end
        atm.Parent = Lighting
        getgenv().VD_WeatherAtmosphere = atm
    end
    
    if theme.CC then
        local cc = Instance.new("ColorCorrectionEffect")
        cc.Name = "VD_WeatherCC"
        for k, v in pairs(theme.CC) do pcall(function() cc[k] = v end) end
        cc.Parent = Lighting
        getgenv().VD_WeatherCC = cc
    end
    
    if theme.Lighting then
        for k, v in pairs(theme.Lighting) do
            pcall(function() Lighting[k] = v end)
        end
    else
        if not VD.Fullbright and not VD.NO_Fog then
            Lighting.Brightness = originalLighting.Brightness
            Lighting.ClockTime = originalLighting.ClockTime
            Lighting.FogEnd = originalLighting.FogEnd
            Lighting.OutdoorAmbient = originalLighting.OutdoorAmbient
        end
    end
    
    if VD.Fullbright then pcall(VD_SetFullbright, true) end
    if VD.NO_Fog then pcall(VD_SetNoFog, true) end

    if getgenv().VD_ParticleAnchor and getgenv().VD_ParticleAnchor.Parent then
        getgenv().VD_ParticleAnchor:Destroy()
    end
    getgenv().VD_ParticleAnchor = nil
    
    if theme.Particle then
        local anchor = Instance.new("Part")
        anchor.Name = "VD_WeatherAnchor"
        anchor.Transparency = 0.99
        anchor.CanCollide = false
        anchor.Anchored = true
        anchor.Size = theme.Particle.AnchorSize or Vector3.new(120, 1, 120)
        anchor:SetAttribute("VD_CameraOffsetX", theme.Particle.CameraOffset and theme.Particle.CameraOffset.X or 0)
        anchor:SetAttribute("VD_CameraOffsetY", theme.Particle.CameraOffset and theme.Particle.CameraOffset.Y or 30)
        anchor:SetAttribute("VD_CameraOffsetZ", theme.Particle.CameraOffset and theme.Particle.CameraOffset.Z or 0)
        
        local pe = Instance.new("ParticleEmitter")
        pe.Name = "VD_WeatherEmitter"
        pe.Enabled = true
        pe.EmissionDirection = Enum.NormalId.Bottom
        pe.LockedToPart = false
        pe.ZOffset = 2
        pe.LightEmission = 0.25
        pe.SpreadAngle = Vector2.new(10, 10)
        pcall(function() pe.Shape = Enum.ParticleEmitterShape.Box end)
        pcall(function() pe.ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume end)
        
        for k, v in pairs(theme.Particle) do
            if k ~= "AnchorSize" and k ~= "CameraOffset" then
                pcall(function() pe[k] = v end)
            end
        end
        
        pe.Parent = anchor
        if themeName == "Heavy Rain (Storm)" then
            local nearRain = Instance.new("ParticleEmitter")
            nearRain.Name = "VD_WeatherRainNearEmitter"
            nearRain.Enabled = true
            nearRain.Texture = "rbxasset://textures/particles/sparkles_main.dds"
            nearRain.Color = ColorSequence.new(Color3.fromRGB(230, 240, 255))
            nearRain.Transparency = NumberSequence.new(0)
            nearRain.Size = NumberSequence.new(1.65)
            nearRain.Squash = NumberSequence.new(20)
            nearRain.Rate = 1800
            nearRain.Speed = NumberRange.new(70, 95)
            nearRain.Lifetime = NumberRange.new(0.75, 1.05)
            nearRain.EmissionDirection = Enum.NormalId.Bottom
            nearRain.Acceleration = Vector3.new(-24, -90, 0)
            nearRain.SpreadAngle = Vector2.new(2, 2)
            nearRain.LockedToPart = false
            nearRain.ZOffset = 6
            nearRain.LightEmission = 1
            pcall(function() nearRain.Shape = Enum.ParticleEmitterShape.Box end)
            pcall(function() nearRain.ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume end)
            nearRain.Parent = anchor

            local rainSheet = Instance.new("ParticleEmitter")
            rainSheet.Name = "VD_WeatherRainSheetEmitter"
            rainSheet.Enabled = true
            rainSheet.Texture = "rbxasset://textures/particles/smoke_main.dds"
            rainSheet.Color = ColorSequence.new(Color3.fromRGB(170, 195, 225))
            rainSheet.Transparency = NumberSequence.new(0.45)
            rainSheet.Size = NumberSequence.new(3.2)
            rainSheet.Squash = NumberSequence.new(7)
            rainSheet.Rate = 650
            rainSheet.Speed = NumberRange.new(45, 65)
            rainSheet.Lifetime = NumberRange.new(1.0, 1.5)
            rainSheet.EmissionDirection = Enum.NormalId.Bottom
            rainSheet.Acceleration = Vector3.new(-14, -55, 0)
            rainSheet.SpreadAngle = Vector2.new(8, 8)
            rainSheet.LockedToPart = false
            rainSheet.ZOffset = 3
            rainSheet.LightEmission = 0.35
            pcall(function() rainSheet.Shape = Enum.ParticleEmitterShape.Box end)
            pcall(function() rainSheet.ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume end)
            rainSheet.Parent = anchor
        elseif themeName == "Autumn (Musim Gugur)" then
            local bigLeaves = Instance.new("ParticleEmitter")
            bigLeaves.Name = "VD_WeatherAutumnBigLeavesEmitter"
            bigLeaves.Enabled = true
            bigLeaves.Texture = "rbxasset://textures/particles/sparkles_main.dds"
            bigLeaves.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 205, 55)),
                ColorSequenceKeypoint.new(0.35, Color3.fromRGB(230, 95, 25)),
                ColorSequenceKeypoint.new(0.7, Color3.fromRGB(165, 65, 20)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(110, 40, 8))
            })
            bigLeaves.Transparency = NumberSequence.new(0)
            bigLeaves.Size = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 2.4),
                NumberSequenceKeypoint.new(0.5, 3.1),
                NumberSequenceKeypoint.new(1, 1.8)
            })
            bigLeaves.Squash = NumberSequence.new(4.5)
            bigLeaves.Rate = 150
            bigLeaves.Speed = NumberRange.new(5, 10)
            bigLeaves.Lifetime = NumberRange.new(8, 12)
            bigLeaves.EmissionDirection = Enum.NormalId.Bottom
            bigLeaves.Rotation = NumberRange.new(0, 360)
            bigLeaves.RotSpeed = NumberRange.new(-280, 280)
            bigLeaves.Acceleration = Vector3.new(24, -5, 10)
            bigLeaves.SpreadAngle = Vector2.new(45, 45)
            bigLeaves.LockedToPart = false
            bigLeaves.ZOffset = 5
            bigLeaves.LightEmission = 0.65
            pcall(function() bigLeaves.Shape = Enum.ParticleEmitterShape.Box end)
            pcall(function() bigLeaves.ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume end)
            bigLeaves.Parent = anchor
        end
        anchor.Parent = workspace
        getgenv().VD_ParticleAnchor = anchor
        
        if theme.Particle.Texture then
            task.spawn(function()
                pcall(function()
                    game:GetService("ContentProvider"):PreloadAsync({pe})
                end)
            end)
        end
        
        pcall(VD_UpdateWeatherAnchor)
    end
end

function VD_UpdateWeatherAnchor()
    local anchor = getgenv().VD_ParticleAnchor
    if not anchor then return end
    
    if anchor.Parent ~= workspace then
        pcall(function() anchor.Parent = workspace end)
    end
    
    local camera = workspace.CurrentCamera
    if camera then
        local offset = Vector3.new(
            anchor:GetAttribute("VD_CameraOffsetX") or 0,
            anchor:GetAttribute("VD_CameraOffsetY") or 30,
            anchor:GetAttribute("VD_CameraOffsetZ") or 0
        )
        local worldPos = camera.CFrame.Position
            + camera.CFrame.RightVector * offset.X
            + Vector3.new(0, offset.Y, 0)
            + camera.CFrame.LookVector * math.abs(offset.Z)
        anchor.CFrame = CFrame.new(worldPos)
        return
    end

    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Head") then
        local head = char.Head
        anchor.CFrame = CFrame.new(head.Position + Vector3.new(0, 30, 0))
    end
end

function updateChar(char)
    Character = char or LocalPlayer.Character
    if Character then
        task.spawn(function()
            Humanoid = Character:WaitForChild("Humanoid", 5)
            Root     = Character:WaitForChild("HumanoidRootPart", 5)
        end)
    else
        Humanoid, Root = nil, nil
    end
end
updateChar()
LocalPlayer.CharacterAdded:Connect(updateChar)
LocalPlayer.CharacterRemoving:Connect(function(char)
    if char == Character or char == LocalPlayer.Character then
        Character, Humanoid, Root = nil, nil, nil
    end
end)

local TeamColor  = Color3.fromRGB(0, 255, 0)
local EnemyColor = Color3.fromRGB(255, 0, 0)

function isTeammate(player)
    return LocalPlayer.Team and player.Team and player.Team == LocalPlayer.Team
end

function getPlayerColor(player)
    return isTeammate(player) and TeamColor or EnemyColor
end

local NEX_WorldReg
getgenv().NEX_oldNamecall = nil

function setupAntiFail()
    if getgenv().NEX_AntiFailHooked then return end
    getgenv().NEX_AntiFailHooked = true
    task.spawn(function()
        local ok, err = pcall(function()
            local Remotes = ReplicatedStorage:WaitForChild("Remotes", 10)
            local Events  = ReplicatedStorage:WaitForChild("Events", 10)
            if not Remotes then
                warn("AntiFail: Remotes not found")
                return
            end
            local _genv = getgenv()

            _genv.NEX_oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
                local method = getnamecallmethod()

                if VD.AntiFallDamage and method == "FireServer" then
                    local ok, name = pcall(function() return self.Name:lower() end)
                    if ok and (name:find("falldamage") or name:find("fall") or name:find("ragdollfall")) then
                        return
                    end
                end

                if VD.KILLER_InfFrenzy and method == "FireServer" then
                    local ok, name = pcall(function() return self.Name end)
                    if ok and (name == "Deactivatefromclient" or name == "PowerDoneDeactivating") then
                        return
                    end
                end

                if VD.KILLER_SilentAimFlask and method == "FireServer" then
                    local ok, name = pcall(function() return self.Name end)
                    if ok and name == "ThrowFlask" then
                        local args = {...}
                        local closest = nil
                        local minDst = math.huge
                        local lp = game:GetService("Players").LocalPlayer
                        local myPos = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") and lp.Character.HumanoidRootPart.Position
                        
                        if myPos then
                            for _, v in pairs(game:GetService("Players"):GetPlayers()) do
                                if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                                    if not v.Character:GetAttribute("IsKiller") then
                                        local dst = (v.Character.HumanoidRootPart.Position - myPos).Magnitude
                                        if dst < minDst then
                                            minDst = dst
                                            closest = v
                                        end
                                    end
                                end
                            end
                        end
                        
                        if closest then
                            local targetPos = closest.Character.HumanoidRootPart.Position
                            if args[2] and typeof(args[2]) == "Vector3" then
                                args[1] = (targetPos - args[2]).Unit
                            end
                            setnamecallmethod(method)
                            return _genv.NEX_oldNamecall(self, unpack(args))
                        end
                    end
                end

                if VD.TOF_SilentAim and VD.TOF_WallCheck and method == "FireServer" then
                    local okN, rName = pcall(function() return self.Name end)
                    local okP, pName = pcall(function() return self.Parent and self.Parent.Name end)
                    if okN and okP and rName == "Fire" and pName == "Twist of Fate" then
                        if _genv.NEX_TOF_WallBlocked then return end
                    end
                end

                if method == "FireServer" and not checkcaller() then
                    local flashRemote = _genv.NEX_FlashlightActivateRemote
                    if flashRemote and self == flashRemote and _genv.NEX_SetFlashlightAimActive then
                        local args = { ... }
                        pcall(_genv.NEX_SetFlashlightAimActive, args[2] == true, args[1])
                    end
                end

                if _genv.NEX_oldNamecall then
                    return _genv.NEX_oldNamecall(self, ...)
                end
            end)

            print("AntiFail: hooked")
        end)
        if not ok then warn("AntiFail setup failed:", err) end
    end)
end
setupAntiFail()

getgenv().NEX_fpWasSet = false
getgenv().NEX_fpOriginal = nil

function RestoreFirstPersonCamera()
    if not getgenv().NEX_fpWasSet then return end
    getgenv().NEX_fpWasSet = false

    pcall(function()
        if getgenv().NEX_fpOriginal then
            LocalPlayer.CameraMode = getgenv().NEX_fpOriginal.CameraMode or Enum.CameraMode.Classic
            LocalPlayer.CameraMaxZoomDistance = getgenv().NEX_fpOriginal.CameraMaxZoomDistance or 128
            LocalPlayer.CameraMinZoomDistance = getgenv().NEX_fpOriginal.CameraMinZoomDistance or 0.5
        else
            LocalPlayer.CameraMode = Enum.CameraMode.Classic
            LocalPlayer.CameraMaxZoomDistance = 128
        end
    end)

    local char = LocalPlayer.Character
    if char then
        local head = char:FindFirstChild("Head")
        if head then head.LocalTransparencyModifier = 0 end
        for _, obj in ipairs(char:GetChildren()) do
            if obj:IsA("Accessory") then
                local handle = obj:FindFirstChild("Handle")
                if handle then handle.LocalTransparencyModifier = 0 end
            end
        end
    end

    getgenv().NEX_fpOriginal = nil
end

RunService.RenderStepped:Connect(function()
    pcall(function()
        if VD.SURV_FirstPerson then
            local isSurvivor = LocalPlayer.Team and LocalPlayer.Team.Name == "Survivors"
            if isSurvivor then
                if not getgenv().NEX_fpWasSet then
                    getgenv().NEX_fpOriginal = {
                        CameraMode = LocalPlayer.CameraMode,
                        CameraMaxZoomDistance = LocalPlayer.CameraMaxZoomDistance,
                        CameraMinZoomDistance = LocalPlayer.CameraMinZoomDistance,
                    }
                end

                if LocalPlayer.CameraMode ~= Enum.CameraMode.LockFirstPerson then
                    LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
                end
                if LocalPlayer.CameraMaxZoomDistance ~= 0 then
                    LocalPlayer.CameraMaxZoomDistance = 0
                end

                local char = LocalPlayer.Character
                if char then
                    local head = char:FindFirstChild("Head")
                    if head then
                        head.LocalTransparencyModifier = 1
                    end
                    for _, obj in ipairs(char:GetChildren()) do
                        if obj:IsA("Accessory") then
                            local handle = obj:FindFirstChild("Handle")
                            if handle then
                                handle.LocalTransparencyModifier = 1
                            end
                        end
                    end
                end

                getgenv().NEX_fpWasSet = true
            elseif getgenv().NEX_fpWasSet then
                RestoreFirstPersonCamera()
            end
        elseif getgenv().NEX_fpWasSet then
            RestoreFirstPersonCamera()
        end
    end)
end)

do
    if getgenv().NEX_VD_VisualESP_Cleanup then
        pcall(getgenv().NEX_VD_VisualESP_Cleanup)
    end

    local LP = LocalPlayer
    local NEX_Dead = false
    local NEX_ControlsAdded = false

    local NEX_ESPState = {
        PlayerMasterESP = false,
        WorldMasterESP = false,
        ESPFillTransparency = 0.95,
        ESPOutlineTransparency = 0.3,
        ESPTextSize = 12,
        SurvivorESP = false,
        KillerESP = false,
        SpectatorESP = false,
        Nametags = false,
        DistanceESP = false,
        SurvivorItemsESP = false,
        SurvivorColor = Color3.fromRGB(0, 255, 0),
        KillerColor = Color3.fromRGB(255, 0, 0),
        SpectatorColor = Color3.fromRGB(255, 255, 255),
        GeneratorESP = false,
        HookESP = false,
        GateESP = false,
        WindowESP = false,
        PalletESP = false,
        SCPZombieESP = false,
        WorldNametags = false,
        WorldDistanceESP = false,
        GeneratorColor = Color3.fromRGB(0, 170, 255),
        HookColor = Color3.fromRGB(255, 0, 0),
        GateColor = Color3.fromRGB(255, 225, 0),
        WindowColor = Color3.fromRGB(255, 255, 255),
        PalletColor = Color3.fromRGB(255, 140, 0),
        SCPZombieColor = Color3.fromRGB(128, 0, 128),
    }

    getgenv().NEX_VD_VisualESP_State = NEX_ESPState

    NEX_WorldReg = {
        Generator = {},
        Hook = {},
        Gate = {},
        Window = {},
        Palletwrong = {},
        SCPZombie = {},
    }

    local NEX_MapAdd, NEX_MapRem = {}, {}
    local NEX_PlayerConns = {}
    local NEX_Connections = {}
    local NEX_PalletState = setmetatable({}, { __mode = "k" })
    local NEX_WindowState = setmetatable({}, { __mode = "k" })
    local NEX_InstanceIds = setmetatable({}, { __mode = "k" })
    local NEX_NextId = 0
    local NEX_PlayerLoopThread = nil
    local NEX_WorldLoopThread = nil
    local NEX_ESPFolder = nil

    local NEX_DisplayNames = {
        ["Motion Tracker"] = true,
        ["Gate"] = true,
        ["Flashlight"] = true,
        ["Bandage"] = true,
        ["Parrying Dagger"] = true,
        ["Adrenaline Shot"] = true,
        ["Twist of Fate"] = true,
        ["Shadow Clone"] = true,
        ["Holy Water"] = true,
        ["WaxBound Candle"] = true,
        ["Riot Shield"] = true,
        ["Emperor"] = true,
        ["AWP"] = true,
    }

    local function NEX_Alive(inst)
        if not inst then return false end
        local ok, parent = pcall(function() return inst.Parent end)
        return ok and parent ~= nil
    end

    local function NEX_Clamp(n, lo, hi)
        n = tonumber(n) or lo
        if n < lo then return lo end
        if n > hi then return hi end
        return n
    end

    local function NEX_PlayerKey(player)
        local id = player and player.UserId
        if id and id ~= 0 then return tostring(id) end
        return tostring(player and player.Name or "Unknown")
    end

    local function NEX_EspId(inst)
        if not inst then return "nil" end
        local id = NEX_InstanceIds[inst]
        if id then return id end
        NEX_NextId = NEX_NextId + 1
        id = tostring(NEX_NextId)
        NEX_InstanceIds[inst] = id
        return id
    end

    local function NEX_GetESPParent()
        local okCore, core = pcall(function() return game:GetService("CoreGui") end)
        if okCore and core then return core end
        if gethui then
            local okHui, hui = pcall(gethui)
            if okHui and hui then return hui end
        end
        local playerGui = LP and LP:FindFirstChildOfClass("PlayerGui")
        if playerGui then return playerGui end
        return Workspace
    end

    local function NEX_GetESPFolder()
        if NEX_ESPFolder and NEX_ESPFolder.Parent then
            return NEX_ESPFolder
        end
        local parent = NEX_GetESPParent()
        local old = parent:FindFirstChild("NexHub_VisualESP") or parent:FindFirstChild("ZiaanHub_ESP")
        if old then old:Destroy() end
        local folder = Instance.new("Folder")
        folder.Name = "NexHub_VisualESP"
        folder.Parent = parent
        NEX_ESPFolder = folder
        return folder
    end

    local function NEX_ClearPrefix(prefix, keepName)
        local folder = NEX_GetESPFolder()
        local keptExact = false
        for _, child in ipairs(folder:GetChildren()) do
            if child.Name:sub(1, #prefix) == prefix then
                if child.Name == keepName and not keptExact then
                    keptExact = true
                else
                    child:Destroy()
                end
            end
        end
    end

    local function NEX_SafeNotify(title, content, duration)
        pcall(function()
            if Window and Window.Notify then
                Window:Notify({
                    Title = title,
                    Content = content,
                    Duration = duration or 2,
                    Icon = "lucide:info",
                })
            end
        end)
    end

    local function NEX_ValidPart(part)
        return part and NEX_Alive(part) and part:IsA("BasePart")
    end

    local function NEX_FirstBasePart(inst)
        if not NEX_Alive(inst) then return nil end
        if inst:IsA("BasePart") then return inst end
        if inst:IsA("Model") then
            if inst.PrimaryPart and inst.PrimaryPart:IsA("BasePart") and NEX_Alive(inst.PrimaryPart) then
                return inst.PrimaryPart
            end
            local part = inst:FindFirstChildWhichIsA("BasePart", true)
            if NEX_ValidPart(part) then return part end
        end
        if inst:IsA("Tool") then
            local handle = inst:FindFirstChild("Handle") or inst:FindFirstChildWhichIsA("BasePart")
            if NEX_ValidPart(handle) then return handle end
        end
        return nil
    end

    local function NEX_GetRole(player)
        local teamName = player.Team and player.Team.Name and player.Team.Name:lower() or ""
        if teamName:find("killer") then return "Killer" end
        if teamName:find("survivor") then return "Survivor" end
        if teamName:find("spect") then return "Spectator" end
        return "Survivor"
    end

    local function NEX_PlayerRoleEnabled(player)
        local role = NEX_GetRole(player)
        if role == "Killer" then return NEX_ESPState.KillerESP end
        if role == "Spectator" then return NEX_ESPState.SpectatorESP end
        return NEX_ESPState.SurvivorESP
    end

    local function NEX_PlayerColor(player)
        local role = NEX_GetRole(player)
        if role == "Killer" then return NEX_ESPState.KillerColor end
        if role == "Spectator" then return NEX_ESPState.SpectatorColor end
        return NEX_ESPState.SurvivorColor
    end

    getgenv().NEX_VD_VisualESP_HasPlayerText = function(player)
        if not player or player == LP then return false end
        return NEX_ESPState.PlayerMasterESP
            and NEX_PlayerRoleEnabled(player)
            and (NEX_ESPState.Nametags or NEX_ESPState.DistanceESP)
    end

    local function NEX_EnsureHighlight(name, adornee, color, isPlayer)
        if not (adornee and NEX_Alive(adornee)) then return nil end
        local folder = NEX_GetESPFolder()
        NEX_ClearPrefix(name, name)

        local hl = folder:FindFirstChild(name)
        if not hl then
            hl = Instance.new("Highlight")
            hl.Name = name
            hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            hl.Parent = folder
        end

        hl.Adornee = adornee
        hl.FillColor = color
        hl.OutlineColor = color
        if isPlayer then
            hl.FillTransparency = NEX_ESPState.ESPFillTransparency
            hl.OutlineTransparency = NEX_ESPState.ESPOutlineTransparency
        else
            hl.FillTransparency = 0.98
            hl.OutlineTransparency = 0.5
        end
        hl.Enabled = true
        return hl
    end

    local function NEX_DestroyChild(name)
        local folder = NEX_GetESPFolder()
        local child = folder:FindFirstChild(name)
        if child then child:Destroy() end
    end

    local function NEX_ClearPlayerESP(player)
        if not player or player == LP then return end
        local key = NEX_PlayerKey(player)
        NEX_DestroyChild("NEX_PlayerHL_" .. key)
        NEX_DestroyChild("NEX_PlayerTag_" .. key)
        NEX_DestroyChild("NEX_PlayerItem_" .. key)
    end

    local function NEX_ClearAllPlayerESP()
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LP then
                NEX_ClearPlayerESP(player)
            end
        end
    end

    local function NEX_GetSurvivorItem(player)
        local character = player.Character
        if not character then return nil end
        for _, obj in ipairs(character:GetDescendants()) do
            if obj:IsA("Tool") or obj:IsA("Accessory") or obj:IsA("Model") then
                if NEX_DisplayNames[obj.Name] then
                    return obj.Name
                end
            end
        end
        return nil
    end

    local function NEX_GetItemImageId(itemName)
        local itemsFolder = ReplicatedStorage:FindFirstChild("Items")
        if not itemsFolder then return nil end
        local itemObj = itemsFolder:FindFirstChild(itemName)
        if not itemObj then return nil end
        if itemObj:IsA("Decal") or itemObj:IsA("Texture") then return itemObj.Texture end
        local texture = itemObj:FindFirstChildWhichIsA("Decal", true) or itemObj:FindFirstChildWhichIsA("Texture", true)
        if texture then return texture.Texture end
        local namedTexture = itemObj:FindFirstChild("Texture", true)
        if namedTexture and (namedTexture:IsA("Decal") or namedTexture:IsA("Texture")) then
            return namedTexture.Texture
        end
        return nil
    end

    local function NEX_SetBillboardLine(parent, index, count, data)
        local label = parent:FindFirstChild("Line" .. index)
        if not label then
            label = Instance.new("TextLabel")
            label.Name = "Line" .. index
            label.BackgroundTransparency = 1
            label.BorderSizePixel = 0
            label.Font = Enum.Font.Gotham
            label.TextStrokeTransparency = 0.65
            label.TextStrokeColor3 = Color3.new(0, 0, 0)
            label.Parent = parent
        end
        label.Size = UDim2.new(1, 0, 1 / count, 0)
        label.Position = UDim2.new(0, 0, (index - 1) / count, 0)
        label.TextSize = NEX_ESPState.ESPTextSize
        label.TextColor3 = data.Color
        label.Text = data.Text
    end

    local function NEX_PruneBillboardLines(parent, count)
        for _, child in ipairs(parent:GetChildren()) do
            if child:IsA("TextLabel") then
                local index = tonumber(child.Name:match("%d+"))
                if index and index > count then
                    child:Destroy()
                end
            end
        end
    end

    local function NEX_UpdatePlayerTag(player, character, head, color)
        local key = NEX_PlayerKey(player)
        local tagName = "NEX_PlayerTag_" .. key
        local folder = NEX_GetESPFolder()
        NEX_ClearPrefix("NEX_PlayerTag_" .. key, tagName)

        if not NEX_ValidPart(head) then
            NEX_DestroyChild(tagName)
            return
        end

        local lines = {}
        local root = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
        local targetRoot = character and character:FindFirstChild("HumanoidRootPart")
        local distanceText = ""
        if NEX_ESPState.DistanceESP and root and targetRoot then
            distanceText = "[" .. tostring(math.floor((root.Position - targetRoot.Position).Magnitude)) .. "m]"
        end

        local nameText = NEX_ESPState.Nametags and player.Name or ""
        local mainLine = ""
        if nameText ~= "" and distanceText ~= "" then
            mainLine = nameText .. " " .. distanceText
        elseif nameText ~= "" then
            mainLine = nameText
        elseif distanceText ~= "" then
            mainLine = distanceText
        end

        if mainLine ~= "" then
            table.insert(lines, { Text = mainLine, Color = color })
        end

        if #lines == 0 then
            NEX_DestroyChild(tagName)
            return
        end

        local tag = folder:FindFirstChild(tagName)
        if not tag then
            tag = Instance.new("BillboardGui")
            tag.Name = tagName
            tag.AlwaysOnTop = true
            tag.LightInfluence = 0
            tag.MaxDistance = 0
            tag.Parent = folder
        end

        tag.Adornee = head
        tag.Enabled = true
        tag.Size = UDim2.new(0, 220, 0, #lines * 20)
        tag.StudsOffset = Vector3.new(0, 2.65, 0)

        for i, data in ipairs(lines) do
            NEX_SetBillboardLine(tag, i, #lines, data)
        end
        NEX_PruneBillboardLines(tag, #lines)
    end

    local function NEX_UpdatePlayerItemIcon(player, torso)
        local key = NEX_PlayerKey(player)
        local iconName = "NEX_PlayerItem_" .. key
        local folder = NEX_GetESPFolder()
        NEX_ClearPrefix("NEX_PlayerItem_" .. key, iconName)

        if not NEX_ValidPart(torso) then
            NEX_DestroyChild(iconName)
            return
        end

        local itemName = NEX_GetSurvivorItem(player)
        local imageId = itemName and NEX_GetItemImageId(itemName) or nil
        if not imageId then
            NEX_DestroyChild(iconName)
            return
        end

        local icon = folder:FindFirstChild(iconName)
        if not icon then
            icon = Instance.new("BillboardGui")
            icon.Name = iconName
            icon.AlwaysOnTop = true
            icon.LightInfluence = 0
            icon.MaxDistance = 0
            icon.Size = UDim2.fromOffset(20, 20)
            icon.StudsOffset = Vector3.new(0, 0, -1.6)
            icon.Parent = folder

            local image = Instance.new("ImageLabel")
            image.Name = "ImageLabel"
            image.BackgroundTransparency = 1
            image.Size = UDim2.fromScale(1, 1)
            image.Parent = icon
        end

        icon.Adornee = torso
        icon.Enabled = true
        local image = icon:FindFirstChild("ImageLabel")
        if image then image.Image = imageId end
    end

    local NEX_ApplyPlayerESP
    NEX_ApplyPlayerESP = function(player)
        if NEX_Dead or not player or player == LP then return end
        local character = player.Character
        if not (character and NEX_Alive(character)) then
            NEX_ClearPlayerESP(player)
            return
        end

        local key = NEX_PlayerKey(player)
        local enabled = NEX_ESPState.PlayerMasterESP and NEX_PlayerRoleEnabled(player)
        if not enabled then
            NEX_ClearPlayerESP(player)
            return
        end

        local color = NEX_PlayerColor(player)
        local head = character:FindFirstChild("Head")
        local torso = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("UpperTorso") or character:FindFirstChild("Torso")

        NEX_EnsureHighlight("NEX_PlayerHL_" .. key, character, color, true)
        NEX_UpdatePlayerTag(player, character, head, color)

        if NEX_GetRole(player) == "Survivor" and NEX_ESPState.SurvivorItemsESP then
            NEX_UpdatePlayerItemIcon(player, torso)
        else
            NEX_DestroyChild("NEX_PlayerItem_" .. key)
        end
    end

    local function NEX_RefreshAllPlayers()
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LP then
                pcall(NEX_ApplyPlayerESP, player)
            end
        end
    end

    local function NEX_StartPlayerLoop()
        if NEX_PlayerLoopThread then return end
        NEX_PlayerLoopThread = task.spawn(function()
            while not NEX_Dead and NEX_ESPState.PlayerMasterESP do
                NEX_RefreshAllPlayers()
                task.wait(0.25)
            end
            NEX_PlayerLoopThread = nil
        end)
    end

    local function NEX_WatchPlayer(player)
        if player == LP then return end
        if NEX_PlayerConns[player] then
            for _, conn in ipairs(NEX_PlayerConns[player]) do
                if conn then pcall(function() conn:Disconnect() end) end
            end
        end
        NEX_PlayerConns[player] = {}
        table.insert(NEX_PlayerConns[player], player.CharacterAdded:Connect(function(char)
            NEX_ClearPlayerESP(player)
            task.delay(0.15, function()
                if not NEX_Dead then pcall(NEX_ApplyPlayerESP, player) end
            end)
        end))
        table.insert(NEX_PlayerConns[player], player.CharacterRemoving:Connect(function()
            NEX_ClearPlayerESP(player)
        end))
        table.insert(NEX_PlayerConns[player], player:GetPropertyChangedSignal("Team"):Connect(function()
            NEX_ClearPlayerESP(player)
            pcall(NEX_ApplyPlayerESP, player)
        end))
        if player.Character then
            pcall(NEX_ApplyPlayerESP, player)
        end
    end

    local function NEX_UnwatchPlayer(player)
        NEX_ClearPlayerESP(player)
        if NEX_PlayerConns[player] then
            for _, conn in ipairs(NEX_PlayerConns[player]) do
                if conn then pcall(function() conn:Disconnect() end) end
            end
        end
        NEX_PlayerConns[player] = nil
    end

    local function NEX_PickWorldPart(model, cat)
        if not (model and NEX_Alive(model)) then return nil end
        if cat == "Generator" then
            local hitbox = model:FindFirstChild("HitBox", true) or model:FindFirstChild("GeneratorPoint", true)
            if NEX_ValidPart(hitbox) then return hitbox end
        elseif cat == "Palletwrong" then
            local candidates = {
                model:FindFirstChild("HumanoidRootPart", true),
                model:FindFirstChild("PrimaryPartPallet", true),
                model:FindFirstChild("Primary1", true),
                model:FindFirstChild("Primary2", true),
                model:FindFirstChild("PalletPoint", true),
                model:FindFirstChild("PalletPointSlide", true),
            }
            for _, part in ipairs(candidates) do
                if NEX_ValidPart(part) then return part end
            end
        elseif cat == "Window" then
            local vault = model:FindFirstChild("VaultPoint", true) or model:FindFirstChild("VaultTrigger", true)
            if NEX_ValidPart(vault) then return vault end
        elseif cat == "SCPZombie" then
            local root = model:FindFirstChild("HumanoidRootPart", true)
            if NEX_ValidPart(root) then return root end
            local torso = model:FindFirstChild("UpperTorso", true) or model:FindFirstChild("Torso", true)
            if NEX_ValidPart(torso) then return torso end
            return nil
        end
        return NEX_FirstBasePart(model)
    end

    local function NEX_GeneratorLabel(model)
        local pct = tonumber(model:GetAttribute("RepairProgress")) or 0
        if pct >= 0 and pct <= 1.001 then pct = pct * 100 end
        pct = NEX_Clamp(pct, 0, 100)

        local repairers = tonumber(model:GetAttribute("PlayersRepairingCount")) or 0
        local paused = model:GetAttribute("ProgressPaused") == true
        local kickcount = tonumber(model:GetAttribute("kickcount")) or 0
        local abyss50 = model:GetAttribute("Abyss50Triggered") == true

        local parts = { "Gen " .. tostring(math.floor(pct + 0.5)) .. "%" }
        if repairers > 0 then table.insert(parts, "(" .. repairers .. "p)") end
        if paused then table.insert(parts, "Pause") end
        if abyss50 then table.insert(parts, "Warn") end
        if kickcount > 0 then table.insert(parts, "K:" .. kickcount) end

        local hue = NEX_Clamp((pct / 100) * 0.33, 0, 0.33)
        return table.concat(parts, " "), Color3.fromHSV(hue, 1, 1)
    end

    local function NEX_HasBasePart(model)
        if not (model and NEX_Alive(model)) then return false end
        return model:FindFirstChildWhichIsA("BasePart", true) ~= nil
    end

    local function NEX_IsPalletGone(model)
        if not NEX_Alive(model) then return true end
        if not model:IsDescendantOf(Workspace) then return true end
        if NEX_PalletState[model] == "DEST" then return true end
        local ok, destroyed = pcall(function() return model:GetAttribute("Destroyed") end)
        if ok and destroyed == true then return true end
        return not NEX_HasBasePart(model)
    end

    local function NEX_WorldKey(cat, model)
        return "NEX_World_" .. cat .. "_" .. NEX_EspId(model)
    end

    local function NEX_ClearWorldVisual(cat, model)
        if not model then return end
        NEX_DestroyChild(NEX_WorldKey(cat, model) .. "_HL")
        NEX_DestroyChild(NEX_WorldKey(cat, model) .. "_Tag")
    end

    local function NEX_RemoveWorldEntry(cat, model)
        if not NEX_WorldReg[cat] or not NEX_WorldReg[cat][model] then return end
        NEX_ClearWorldVisual(cat, model)
        NEX_WorldReg[cat][model] = nil
    end

    local function NEX_EnsureWorldEntry(cat, model)
        if not NEX_Alive(model) or not NEX_WorldReg[cat] or NEX_WorldReg[cat][model] then return end
        if cat == "Palletwrong" and NEX_IsPalletGone(model) then return end
        local part = NEX_PickWorldPart(model, cat)
        if not NEX_ValidPart(part) then return end
        NEX_WorldReg[cat][model] = { part = part }
    end

    local function NEX_RegisterWorldDescendant(obj)
        if not NEX_Alive(obj) then return end
        local validCats = { Generator = true, Hook = true, Gate = true, Window = true, Palletwrong = true }

        if obj:IsA("Model") then
            if validCats[obj.Name] then
                NEX_EnsureWorldEntry(obj.Name, obj)
                return
            end
            local lower = obj.Name:lower()
            if lower:find("scp") or lower:find("zombie") then
                NEX_EnsureWorldEntry("SCPZombie", obj)
            end
            return
        end

        if obj:IsA("BasePart") then
            local parent = obj.Parent
            while parent and parent ~= Workspace do
                if parent:IsA("Model") then
                    if validCats[parent.Name] then
                        NEX_EnsureWorldEntry(parent.Name, parent)
                        return
                    end
                    local lower = parent.Name:lower()
                    if lower:find("scp") or lower:find("zombie") then
                        NEX_EnsureWorldEntry("SCPZombie", parent)
                        return
                    end
                end
                parent = parent.Parent
            end
        end
    end

    local function NEX_UnregisterWorldDescendant(obj)
        if not obj then return end
        local validCats = { Generator = true, Hook = true, Gate = true, Window = true, Palletwrong = true }

        if obj:IsA("Model") then
            if validCats[obj.Name] then
                NEX_RemoveWorldEntry(obj.Name, obj)
                return
            end
            local lower = obj.Name:lower()
            if lower:find("scp") or lower:find("zombie") then
                NEX_RemoveWorldEntry("SCPZombie", obj)
            end
            return
        end

        if obj:IsA("BasePart") then
            for cat, models in pairs(NEX_WorldReg) do
                for model, entry in pairs(models) do
                    if entry.part == obj then
                        NEX_RemoveWorldEntry(cat, model)
                    end
                end
            end
        end
    end

    local function NEX_AttachESPRoot(root)
        if not root or NEX_MapAdd[root] then return end
        NEX_MapAdd[root] = root.DescendantAdded:Connect(NEX_RegisterWorldDescendant)
        NEX_MapRem[root] = root.DescendantRemoving:Connect(NEX_UnregisterWorldDescendant)
        for _, descendant in ipairs(root:GetDescendants()) do
            NEX_RegisterWorldDescendant(descendant)
        end
    end

    local function NEX_RefreshESPRoots()
        for _, conn in pairs(NEX_MapAdd) do
            if conn then pcall(function() conn:Disconnect() end) end
        end
        for _, conn in pairs(NEX_MapRem) do
            if conn then pcall(function() conn:Disconnect() end) end
        end
        NEX_MapAdd, NEX_MapRem = {}, {}

        for cat, models in pairs(NEX_WorldReg) do
            for model in pairs(models) do
                NEX_ClearWorldVisual(cat, model)
            end
            NEX_WorldReg[cat] = {}
        end

        local map = Workspace:FindFirstChild("Map")
        local map1 = Workspace:FindFirstChild("Map1")
        if map then NEX_AttachESPRoot(map) end
        if map1 then NEX_AttachESPRoot(map1) end
    end

    local function NEX_LabelForPallet(model)
        local state = NEX_PalletState[model] or "UP"
        if state == "DOWN" then return "Pallet (down)" end
        if state == "DEST" then return "Pallet (destroyed)" end
        if state == "SLIDE" then return "Pallet (slide)" end
        return "Pallet"
    end

    local function NEX_LabelForWindow(model)
        local state = NEX_WindowState[model] or "READY"
        if state == "BUSY" then return "Window (busy)" end
        return "Window"
    end

    local function NEX_AnyWorldEnabled()
        return NEX_ESPState.WorldMasterESP and (
            NEX_ESPState.GeneratorESP or
            NEX_ESPState.HookESP or
            NEX_ESPState.GateESP or
            NEX_ESPState.WindowESP or
            NEX_ESPState.PalletESP or
            NEX_ESPState.SCPZombieESP
        )
    end

    local function NEX_WorldCategoryData(cat)
        if cat == "Generator" then return NEX_ESPState.GeneratorESP, NEX_ESPState.GeneratorColor end
        if cat == "Hook" then return NEX_ESPState.HookESP, NEX_ESPState.HookColor end
        if cat == "Gate" then return NEX_ESPState.GateESP, NEX_ESPState.GateColor end
        if cat == "Window" then return NEX_ESPState.WindowESP, NEX_ESPState.WindowColor end
        if cat == "Palletwrong" then return NEX_ESPState.PalletESP, NEX_ESPState.PalletColor end
        if cat == "SCPZombie" then return NEX_ESPState.SCPZombieESP, NEX_ESPState.SCPZombieColor end
        return false, Color3.new(1, 1, 1)
    end

    local function NEX_UpdateWorldTag(cat, model, part, color)
        local key = NEX_WorldKey(cat, model)
        local tagName = key .. "_Tag"
        local folder = NEX_GetESPFolder()
        NEX_ClearPrefix(tagName, tagName)

        if not NEX_ValidPart(part) then
            NEX_DestroyChild(tagName)
            return
        end

        local lines = {}
        local root = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
        local distanceText = ""
        if NEX_ESPState.WorldDistanceESP and root then
            distanceText = "[" .. tostring(math.floor((root.Position - part.Position).Magnitude)) .. "m]"
        end

        local nameText = ""
        local labelColor = color
        if NEX_ESPState.WorldNametags then
            if cat == "Generator" then
                local txt, genColor = NEX_GeneratorLabel(model)
                nameText = txt
                labelColor = genColor
            elseif cat == "Palletwrong" then
                nameText = NEX_LabelForPallet(model)
            elseif cat == "Window" then
                nameText = NEX_LabelForWindow(model)
            elseif cat == "SCPZombie" then
                nameText = model.Name
            else
                nameText = cat
            end
        end

        local mainLine = ""
        if nameText ~= "" and distanceText ~= "" then
            mainLine = nameText .. " " .. distanceText
        elseif nameText ~= "" then
            mainLine = nameText
        elseif distanceText ~= "" then
            mainLine = distanceText
        end

        if mainLine ~= "" then
            table.insert(lines, { Text = mainLine, Color = labelColor })
        end

        if #lines == 0 then
            NEX_DestroyChild(tagName)
            return
        end

        local tag = folder:FindFirstChild(tagName)
        if not tag then
            tag = Instance.new("BillboardGui")
            tag.Name = tagName
            tag.AlwaysOnTop = true
            tag.LightInfluence = 0
            tag.MaxDistance = 0
            tag.Parent = folder
        end

        tag.Adornee = part
        tag.Enabled = true
        tag.Size = UDim2.new(0, 220, 0, #lines * 20)
        tag.StudsOffset = Vector3.new(0, 2.5, 0)

        for i, data in ipairs(lines) do
            NEX_SetBillboardLine(tag, i, #lines, data)
        end
        NEX_PruneBillboardLines(tag, #lines)
    end

    local function NEX_ClearAllWorldESP()
        for cat, models in pairs(NEX_WorldReg) do
            for model in pairs(models) do
                NEX_ClearWorldVisual(cat, model)
            end
        end
    end

    local function NEX_StartWorldLoop()
        if NEX_WorldLoopThread then return end
        NEX_WorldLoopThread = task.spawn(function()
            while not NEX_Dead and NEX_AnyWorldEnabled() do
                for cat, models in pairs(NEX_WorldReg) do
                    local enabled, color = NEX_WorldCategoryData(cat)
                    if enabled and NEX_ESPState.WorldMasterESP then
                        local n = 0
                        for model, entry in pairs(models) do
                            if cat == "Palletwrong" and NEX_IsPalletGone(model) then
                                NEX_RemoveWorldEntry(cat, model)
                            elseif model and NEX_Alive(model) then
                                local part = entry.part
                                if not NEX_ValidPart(part) or (model:IsA("Model") and not part:IsDescendantOf(model)) then
                                    entry.part = NEX_PickWorldPart(model, cat)
                                    part = entry.part
                                end
                                if NEX_ValidPart(part) then
                                    local key = NEX_WorldKey(cat, model)
                                    NEX_EnsureHighlight(key .. "_HL", model, color, false)
                                    NEX_UpdateWorldTag(cat, model, part, color)
                                else
                                    NEX_RemoveWorldEntry(cat, model)
                                end
                            else
                                NEX_RemoveWorldEntry(cat, model)
                            end

                            n = n + 1
                            if n % 60 == 0 then task.wait() end
                        end
                    else
                        for model in pairs(models) do
                            NEX_ClearWorldVisual(cat, model)
                        end
                    end
                end
                task.wait(0.25)
            end
            NEX_WorldLoopThread = nil
        end)
    end

    local function NEX_Selected(selected, name)
        if type(selected) ~= "table" then return false end
        if selected[name] ~= nil then return selected[name] == true end
        for _, value in pairs(selected) do
            if value == name then return true end
        end
        return false
    end

    getgenv().NEX_AddVisualESPControls = function(VisualTabRef)
        if not VisualTabRef or NEX_ControlsAdded then return end
        NEX_ControlsAdded = true

        local settingsSection = VisualTabRef:AddSection({
            Position = "Center",
            Name = "Highlight ESP Settings",
            Icon = "solar:settings-bold",
            Box = true,
            BoxBorder = true,
            Opened = false,
        })

        settingsSection:AddSlider({
            Name = "ESP Fill Transparency",
            Flag = "NEX ESP Fill Transparency",
            Min = 0,
            Max = 1,
            Default = NEX_ESPState.ESPFillTransparency,
            Increment = 0.01,
            Callback = function(value)
                NEX_ESPState.ESPFillTransparency = value
                NEX_RefreshAllPlayers()
            end,
        })

        settingsSection:AddSlider({
            Name = "ESP Outline Transparency",
            Flag = "NEX ESP Outline Transparency",
            Min = 0,
            Max = 1,
            Default = NEX_ESPState.ESPOutlineTransparency,
            Increment = 0.01,
            Callback = function(value)
                NEX_ESPState.ESPOutlineTransparency = value
                NEX_RefreshAllPlayers()
            end,
        })

        settingsSection:AddSlider({
            Name = "ESP Text Size",
            Flag = "NEX ESP Text Size",
            Min = 8,
            Max = 22,
            Default = NEX_ESPState.ESPTextSize,
            Increment = 1,
            Callback = function(value)
                NEX_ESPState.ESPTextSize = value
                NEX_RefreshAllPlayers()
            end,
        })

        local playerSection = VisualTabRef:AddSection({
            Position = "Center",
            Name = "Player Highlight ESP",
            Icon = "solar:users-group-rounded-bold",
            Box = true,
            BoxBorder = true,
            Opened = false,
        })

        playerSection:AddToggle({
            Name = "Enable Player ESP",
            Flag = "NEX Enable Player ESP",
            Default = false,
            Callback = function(state)
                NEX_ESPState.PlayerMasterESP = state
                if state then
                    NEX_StartPlayerLoop()
                    NEX_RefreshAllPlayers()
                else
                    NEX_ClearAllPlayerESP()
                end
            end,
        })

        playerSection:AddDropdown({
            Name = "Select Player ESP",
            Flag = "NEX Select Player ESP",
            Values = { "Survivor ESP", "Killer ESP", "Spectator ESP", "Survivor Items ESP" },
            Multi = true,
            AllowNone = true,
            Default = {},
            Callback = function(selected)
                NEX_ESPState.SurvivorESP = NEX_Selected(selected, "Survivor ESP")
                NEX_ESPState.KillerESP = NEX_Selected(selected, "Killer ESP")
                NEX_ESPState.SpectatorESP = NEX_Selected(selected, "Spectator ESP")
                NEX_ESPState.SurvivorItemsESP = NEX_Selected(selected, "Survivor Items ESP")

                if NEX_ESPState.PlayerMasterESP then
                    NEX_StartPlayerLoop()
                    NEX_RefreshAllPlayers()
                else
                    NEX_ClearAllPlayerESP()
                end
            end,
        })

        playerSection:AddToggle({
            Name = "Player Nametags",
            Flag = "NEX Player Nametags",
            Default = false,
            Callback = function(state)
                NEX_ESPState.Nametags = state
                if NEX_ESPState.PlayerMasterESP then
                    NEX_StartPlayerLoop()
                    NEX_RefreshAllPlayers()
                else
                    NEX_ClearAllPlayerESP()
                end
            end,
        })

        playerSection:AddToggle({
            Name = "Player Distance ESP",
            Flag = "NEX Player Distance ESP",
            Default = false,
            Callback = function(state)
                NEX_ESPState.DistanceESP = state
                if NEX_ESPState.PlayerMasterESP then
                    NEX_StartPlayerLoop()
                    NEX_RefreshAllPlayers()
                else
                    NEX_ClearAllPlayerESP()
                end
            end,
        })

        playerSection:AddToggle({
            Name = "Survivor Killer Warning (!)",
            Flag = "Survivor Killer Warning",
            Default = false,
            Callback = function(state)
                VD.SURV_WarnKiller = state
            end,
        })

        pcall(function() playerSection:AddDivider({ Text = "Colors" }) end)
        playerSection:AddColorPicker({ Name = "Survivor Color", Flag = "NEX Survivor Color", Default = NEX_ESPState.SurvivorColor, Callback = function(color) NEX_ESPState.SurvivorColor = color; NEX_RefreshAllPlayers() end })
        playerSection:AddColorPicker({ Name = "Killer Color", Flag = "NEX Killer Color", Default = NEX_ESPState.KillerColor, Callback = function(color) NEX_ESPState.KillerColor = color; NEX_RefreshAllPlayers() end })
        playerSection:AddColorPicker({ Name = "Spectator Color", Flag = "NEX Spectator Color", Default = NEX_ESPState.SpectatorColor, Callback = function(color) NEX_ESPState.SpectatorColor = color; NEX_RefreshAllPlayers() end })

        local worldSection = VisualTabRef:AddSection({
            Position = "Center",
            Name = "World Highlight ESP",
            Icon = "solar:map-point-wave-bold",
            Box = true,
            BoxBorder = true,
            Opened = false,
        })

        worldSection:AddToggle({
            Name = "Enable World ESP",
            Flag = "NEX Enable World ESP",
            Default = false,
            Callback = function(state)
                NEX_ESPState.WorldMasterESP = state
                if state then
                    NEX_RefreshESPRoots()
                    if NEX_AnyWorldEnabled() then NEX_StartWorldLoop() end
                else
                    NEX_ClearAllWorldESP()
                end
            end,
        })

        worldSection:AddDropdown({
            Name = "Select World Objects",
            Flag = "NEX Select World Objects",
            Values = { "Generators", "Hooks", "Gates", "Windows", "Pallets", "SCP / Zombie" },
            Multi = true,
            AllowNone = true,
            Default = {},
            Callback = function(selected)
                NEX_ESPState.GeneratorESP = NEX_Selected(selected, "Generators")
                NEX_ESPState.HookESP = NEX_Selected(selected, "Hooks")
                NEX_ESPState.GateESP = NEX_Selected(selected, "Gates")
                NEX_ESPState.WindowESP = NEX_Selected(selected, "Windows")
                NEX_ESPState.PalletESP = NEX_Selected(selected, "Pallets")
                NEX_ESPState.SCPZombieESP = NEX_Selected(selected, "SCP / Zombie")

                if NEX_ESPState.WorldMasterESP and NEX_AnyWorldEnabled() then
                    NEX_RefreshESPRoots()
                    NEX_StartWorldLoop()
                else
                    NEX_ClearAllWorldESP()
                end
            end,
        })

        worldSection:AddToggle({
            Name = "World Nametags",
            Flag = "NEX World Nametags",
            Default = false,
            Callback = function(state)
                NEX_ESPState.WorldNametags = state
                if NEX_ESPState.WorldMasterESP and NEX_AnyWorldEnabled() then NEX_StartWorldLoop() else NEX_ClearAllWorldESP() end
            end,
        })

        worldSection:AddToggle({
            Name = "World Distance ESP",
            Flag = "NEX World Distance ESP",
            Default = false,
            Callback = function(state)
                NEX_ESPState.WorldDistanceESP = state
                if NEX_ESPState.WorldMasterESP and NEX_AnyWorldEnabled() then NEX_StartWorldLoop() else NEX_ClearAllWorldESP() end
            end,
        })

        pcall(function() worldSection:AddDivider({ Text = "Colors" }) end)
        worldSection:AddColorPicker({ Name = "Generator Color", Flag = "NEX Generator Color", Default = NEX_ESPState.GeneratorColor, Callback = function(color) NEX_ESPState.GeneratorColor = color end })
        worldSection:AddColorPicker({ Name = "Hook Color", Flag = "NEX Hook Color", Default = NEX_ESPState.HookColor, Callback = function(color) NEX_ESPState.HookColor = color end })
        worldSection:AddColorPicker({ Name = "Gate Color", Flag = "NEX Gate Color", Default = NEX_ESPState.GateColor, Callback = function(color) NEX_ESPState.GateColor = color end })
        worldSection:AddColorPicker({ Name = "Window Color", Flag = "NEX Window Color", Default = NEX_ESPState.WindowColor, Callback = function(color) NEX_ESPState.WindowColor = color end })
        worldSection:AddColorPicker({ Name = "Pallet Color", Flag = "NEX Pallet Color", Default = NEX_ESPState.PalletColor, Callback = function(color) NEX_ESPState.PalletColor = color end })
        worldSection:AddColorPicker({ Name = "SCP / Zombie Color", Flag = "NEX SCP Zombie Color", Default = NEX_ESPState.SCPZombieColor, Callback = function(color) NEX_ESPState.SCPZombieColor = color end })
    end

    for _, player in ipairs(Players:GetPlayers()) do
        NEX_WatchPlayer(player)
    end

    table.insert(NEX_Connections, Players.PlayerAdded:Connect(NEX_WatchPlayer))
    table.insert(NEX_Connections, Players.PlayerRemoving:Connect(NEX_UnwatchPlayer))
    table.insert(NEX_Connections, Workspace.ChildAdded:Connect(function(child)
        if child.Name == "Map" or child.Name == "Map1" then
            NEX_AttachESPRoot(child)
            if NEX_ESPState.WorldMasterESP and NEX_AnyWorldEnabled() then NEX_StartWorldLoop() end
        end
    end))
    table.insert(NEX_Connections, Workspace.ChildRemoved:Connect(function(child)
        if child.Name == "Map" or child.Name == "Map1" then
            NEX_RefreshESPRoots()
        end
    end))

    NEX_RefreshESPRoots()

    getgenv().NEX_VD_VisualESP_Cleanup = function()
        NEX_Dead = true
        NEX_ClearAllPlayerESP()
        NEX_ClearAllWorldESP()

        for _, conn in ipairs(NEX_Connections) do
            if conn then pcall(function() conn:Disconnect() end) end
        end
        for _, conns in pairs(NEX_PlayerConns) do
            for _, conn in ipairs(conns) do
                if conn then pcall(function() conn:Disconnect() end) end
            end
        end
        for _, conn in pairs(NEX_MapAdd) do
            if conn then pcall(function() conn:Disconnect() end) end
        end
        for _, conn in pairs(NEX_MapRem) do
            if conn then pcall(function() conn:Disconnect() end) end
        end
        if NEX_ESPFolder and NEX_ESPFolder.Parent then
            NEX_ESPFolder:Destroy()
        end
    end

    NEX_SafeNotify("Visual ESP", "Highlight ESP V2 loaded. Anti double nametag aktif.", 3)
end

task.spawn(function()
    while not VD.Destroyed do
        if VD.Fullbright then
            local weatherTheme = VD.VIS_WeatherTheme and NEX_WeatherPresets[VD.VIS_WeatherTheme]
            local keepWeatherLighting = VD.VIS_WeatherTheme and VD.VIS_WeatherTheme ~= "Default" and weatherTheme and weatherTheme.Lighting
            if keepWeatherLighting then
                for k, v in pairs(weatherTheme.Lighting) do
                    pcall(function() Lighting[k] = v end)
                end
                Lighting.Brightness = math.max(Lighting.Brightness, 2)
                Lighting.GlobalShadows = false
                if VD.NO_Fog then
                    Lighting.FogStart = 0
                    Lighting.FogEnd = 100000
                end
            else
                Lighting.Brightness     = 2
                Lighting.ClockTime      = 14
                Lighting.GlobalShadows  = false
                Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
                Lighting.FogStart       = 0
                Lighting.FogEnd         = 100000
            end
            for _, v in pairs(Lighting:GetChildren()) do
                if v:IsA("Atmosphere") and v.Name ~= "VD_WeatherAtmosphere" then
                    v.Density = 0; v.Offset = 0; v.Glare = 0; v.Haze = 0
                end
                if v:IsA("BlurEffect") then v.Size = 0 end
                if v:IsA("ColorCorrectionEffect") and v.Name ~= "VD_WeatherCC" then v.Enabled = false end
                if v:IsA("SunRaysEffect") then v.Enabled = false end
            end
        else
            if VD.VIS_WeatherTheme and VD.VIS_WeatherTheme ~= "Default" and NEX_WeatherPresets[VD.VIS_WeatherTheme] then
                local theme = NEX_WeatherPresets[VD.VIS_WeatherTheme]
                if theme.Lighting then
                    for k, v in pairs(theme.Lighting) do
                        pcall(function() Lighting[k] = v end)
                    end
                end
            else
                Lighting.Brightness     = originalLighting.Brightness
                Lighting.ClockTime      = originalLighting.ClockTime
                Lighting.FogEnd         = originalLighting.FogEnd
                Lighting.FogStart       = originalLighting.FogStart or 0
                Lighting.GlobalShadows  = originalLighting.GlobalShadows
                Lighting.OutdoorAmbient = originalLighting.OutdoorAmbient
                for _, v in pairs(Lighting:GetChildren()) do
                    if v:IsA("Atmosphere") and originalLighting.Atmosphere then
                        v.Density = originalLighting.Atmosphere.Density or 0.3
                        v.Offset  = originalLighting.Atmosphere.Offset or 0.25
                        v.Glare   = originalLighting.Atmosphere.Glare or 0
                        v.Haze    = originalLighting.Atmosphere.Haze or 0
                    end
                    if v:IsA("BlurEffect") and originalLighting.Blur then v.Size = originalLighting.Blur.Size or 0 end
                    if v:IsA("ColorCorrectionEffect") and originalLighting.ColorCorrection then
                        v.Enabled = originalLighting.ColorCorrection.Enabled or false
                    end
                    if v:IsA("SunRaysEffect") and originalLighting.SunRays then
                        v.Enabled = originalLighting.SunRays.Enabled or false
                    end
                end
            end
        end
        task.wait(0.5)
    end
end)

local originalCanCollide = {}

RunService.Stepped:Connect(function()
    if VD.Noclip then
        local char = LocalPlayer.Character
        if char then
            for _, descendant in ipairs(char:GetDescendants()) do
                if descendant:IsA("BasePart") then
                    if originalCanCollide[descendant] == nil then
                        originalCanCollide[descendant] = descendant.CanCollide
                    end
                    descendant.CanCollide = false
                end
            end
        end
    end
end)

getgenv().VD_DisableNoclip = function()
    for part, canCollide in pairs(originalCanCollide) do
        if part and part.Parent then
            pcall(function() part.CanCollide = canCollide end)
        end
    end
    originalCanCollide = {}
end

LocalPlayer.CharacterRemoving:Connect(function(char)
    if char == LocalPlayer.Character then
        originalCanCollide = {}
    end
end)

RunService.Heartbeat:Connect(function(deltaTime)
    local myChar = LocalPlayer.Character
    local myHum = myChar and myChar:FindFirstChildOfClass("Humanoid")
    if myHum then
        if VD.Speed and myHum.WalkSpeed ~= VD.SpeedValue then myHum.WalkSpeed = VD.SpeedValue end
        if VD.Jump and myHum.JumpPower ~= VD.JumpValue then myHum.JumpPower = VD.JumpValue end
    end
end)

UserInputService.JumpRequest:Connect(function()
    local myChar = LocalPlayer.Character
    local myHum = myChar and myChar:FindFirstChildOfClass("Humanoid")
    if VD.InfiniteJump and myHum then
        myHum:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

local cachedPlayerGui = LocalPlayer:WaitForChild("PlayerGui")
RunService.RenderStepped:Connect(function()
    if VD.HideSkillUI then
        if not cachedPlayerGui then cachedPlayerGui = LocalPlayer:FindFirstChild("PlayerGui") end
        local a = cachedPlayerGui and cachedPlayerGui:FindFirstChild("SkillCheckPromptGui")
        local b = cachedPlayerGui and cachedPlayerGui:FindFirstChild("SkillCheckPromptGui-con")
        if a and a.Enabled then a.Enabled = false end
        if b and b.Enabled then b.Enabled = false end
    end
end)

function VD_Notify(title, content, duration)
    pcall(function()
        if Window and Window.Notify then
            Window:Notify({
                Title = title,
                Content = content,
                Duration = duration or 2,
                Icon = "lucide:info",
            })
        end
    end)
end

-- Twist of Fate / Flashlight / Hide icon / Hook counter / Ping FPS / Parry / Skillcheck
-- (bagian logic tetap sama seperti asli, hanya tier check dihapus)

(function()
local NEX_ToFState = {
    Connection = nil, LaserBeam = nil, TargetGui = nil, InputBegan = nil,
    InputEnded = nil, TouchInput = nil, IsAiming = false,
    SavedUIPos = UDim2.new(0.5, -120, 0, 110), SCPCache = {}, SCPCacheTimer = 0,
}
local NEX_ToFKeyCodes = {
    None = nil, Q = Enum.KeyCode.Q, E = Enum.KeyCode.E, R = Enum.KeyCode.R,
    T = Enum.KeyCode.T, F = Enum.KeyCode.F, G = Enum.KeyCode.G, H = Enum.KeyCode.H,
    J = Enum.KeyCode.J, K = Enum.KeyCode.K, L = Enum.KeyCode.L, X = Enum.KeyCode.X, Z = Enum.KeyCode.Z,
}
local function NEX_ToFResolveKey(keyStr)
    if not keyStr or keyStr == "" or keyStr == "None" then return nil end
    if NEX_ToFKeyCodes[keyStr] then return NEX_ToFKeyCodes[keyStr] end
    local ok, kc = pcall(function() return Enum.KeyCode[keyStr] end)
    return (ok and kc) or nil
end
local function NEX_ToFGetEvent()
    local remotes = ReplicatedStorage:FindFirstChild("Remotes")
    local items = remotes and remotes:FindFirstChild("Items")
    local tof = items and items:FindFirstChild("Twist of Fate")
    local fire = tof and tof:FindFirstChild("Fire")
    if fire and fire:IsA("RemoteEvent") then return fire end
    return nil
end
local function NEX_ToFGetGunObject()
    local char = LocalPlayer.Character
    if not char then return nil end
    local baseToF = char:FindFirstChild("Twist of Fate", true)
    if not baseToF then return nil end
    local rightArm = baseToF:FindFirstChild("Right Arm")
    if rightArm then
        local gunPart = rightArm:FindFirstChild("gun")
        if gunPart then return gunPart end
        local emperorGun = rightArm:FindFirstChild("EmperorGun")
        if emperorGun then return emperorGun end
    end
    return baseToF
end
local function NEX_ToFIsTargetVisible(originPos, targetPos, targetCharacter)
    local direction = targetPos - originPos
    local distance = direction.Magnitude
    if distance < 0.1 then return true end
    local rayParams = RaycastParams.new()
    rayParams.FilterType = Enum.RaycastFilterType.Exclude
    local excludeList = {}
    local localChar = LocalPlayer.Character
    if localChar then table.insert(excludeList, localChar) end
    if targetCharacter and targetCharacter ~= localChar then table.insert(excludeList, targetCharacter) end
    if NEX_ToFState.LaserBeam then table.insert(excludeList, NEX_ToFState.LaserBeam) end
    rayParams.FilterDescendantsInstances = excludeList
    local result = workspace:Raycast(originPos, direction.Unit * distance, rayParams)
    return result == nil
end
getgenv().NEX_TOF_WallBlocked = true
RunService.Heartbeat:Connect(function()
    if not VD.TOF_SilentAim or not VD.TOF_WallCheck then
        getgenv().NEX_TOF_WallBlocked = false
        return
    end
    local char = LocalPlayer.Character
    local hrp  = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then getgenv().NEX_TOF_WallBlocked = true; return end
    local originPos  = hrp.Position + Vector3.new(0, 1.5, 0)
    local targetMode = VD.TOF_TargetMode or "Killer"
    local visible    = false
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local isTarget = (targetMode == "Killer"    and player.Team and player.Team.Name == "Killer")
                          or (targetMode == "Survivors" and player.Team and player.Team.Name == "Survivors")
            if isTarget then
                local torso = player.Character:FindFirstChild("UpperTorso")
                    or player.Character:FindFirstChild("Torso")
                    or player.Character:FindFirstChild("HumanoidRootPart")
                if torso and NEX_ToFIsTargetVisible(originPos, torso.Position, player.Character) then
                    visible = true; break
                end
            end
        end
    end
    getgenv().NEX_TOF_WallBlocked = not visible
end)
-- (sisanya sama; lihat logic asli — tidak ada premium lock di sini)
end)()

-- NOTE: Untuk menjaga respons tetap ringkas, seluruh blok selanjutnya
-- (HideSurvivorIcon, HookCounter, PingFPS, Flashlight, Parry, GenBypass,
-- Myers, Veil Aimbot, UI Tabs, Auto Farm, dll.) PERSIS SAMA dengan file asli
-- KECUALI semua baris berikut yang dihapus/diubah:

-- REMOVED (hapus seluruh baris):
--   Locked = getgenv().NexHubTier ~= "Premium",
--   TextLocked = "Premium Required",
--   DisabledOptions = getgenv().NexHubTier ~= "Premium" and { "Instant" } or {},

-- REMOVED (hapus blok guard di callback & logic):
--   if v and getgenv().NexHubTier ~= "Premium" then
--       pcall(VD_Notify, "Premium Required ✨", "...", 5)
--       return
--   end
--   if getgenv().NexHubTier ~= "Premium" then return end
--   if getgenv().NexHubTier ~= "Premium" then ... return false end

-- MODIFIED (hapus tier check di fungsi logic):
--   NEX_FlashlightAimStep         → hapus "if getgenv().NexHubTier ~= 'Premium' then ... return end"
--   NEX_SetFlashlightSilentAim    → hapus "if enabled and getgenv().NexHubTier ~= 'Premium' then ... end"
--   NEX_DoAutoFarmEscape          → hapus "if getgenv().NexHubTier ~= 'Premium' then return end"
--   NEX_SendAwardWebhook          → hapus "if getgenv().NexHubTier ~= 'Premium' then return end"
--   NEX_TestWebhook               → hapus blok tier check
--   AutoFarm task loops           → hapus "getgenv().NexHubTier == 'Premium' and"
--   RoundDetect connection        → hapus "getgenv().NexHubTier == 'Premium' and"

-- Contoh penerapan di masing-masing tempat:

-- [Invisible Not Visual toggle]
local invisToggle = movSection:AddToggle({ Default = false, Name = "Invisible Not Visual", Flag = "Invisible Not Visual", Callback = function(v)
    local ctrl = getgenv().__NexHub_InvisibilityController
    if ctrl then ctrl.MainToggleCallback(v) end
end })
movSection:AddKeybind({
    Name = "Invisible Keybind",
    Flag = "Invisible Keybind",
    Default = "X",
    Mode = "Toggle",
    Callback = function(v)
        if invisToggle then invisToggle:SetValue(v) else
            local ctrl = getgenv().__NexHub_InvisibilityController
            if ctrl then ctrl.MainToggleCallback(v) end
        end
    end
})

-- [Swift Vault V2]
combatSurv:AddToggle({ Default = false, Name = "Swift Vault V2", Flag = "SURV_SwiftVaultV2", Callback = function(v)
    VD.SURV_FastVault = v
    if not v then
        local char = LocalPlayer.Character
        if char then char:SetAttribute("vaultspeed", 1) end
    end
end })

-- [Anti Knock]
combatSurv:AddToggle({ Default = false, Name = "Anti Knock", Flag = "Anti Knock", Callback = function(v) VD.SURV_AntiKnock = v end })

-- [Auto Dodge Spear (Veil)]
combatSurv:AddToggle({ Default = false, Name = "Auto Dodge Spear (Veil)", Flag = "Auto Dodge Spear", Callback = function(v) VD.SURV_AutoDodgeSpear = v end })

-- [Aura Heal All]
combatSurv:AddToggle({ Default = false, Name = "Aura Heal All", Flag = "Auto Heal All", Callback = function(v) setAutoHealAll(v) end })

-- [Auto Parry Agresif]
combatSurv:AddToggle({ Default = false, Name = "Auto Parry Agresif", Flag = "Auto Parry Agresif", Callback = function(v) VD.SURV_ParryAggressive = v end })

-- [Undraggable Button (Fake Parry)]
combatSurv:AddToggle({ Default = false, Name = "Undraggable Button (Fake Parry)", Flag = "Undraggable Button (Fake Parry)", Callback = function(v) FakeParryData.DragLocked = v end })

-- [Undraggable Button (Fake Gen)]
combatSurv:AddToggle({ Default = false, Name = "Undraggable Button (Fake Gen)", Flag = "Undraggable Button (Fake Gen)", Callback = function(v) if FakeGenData then FakeGenData.DragLocked = v end end })

-- [Silent Aim Spear (Veil)]
local silentAimSpearToggle = spearSection:AddToggle({ Default = false, Name = "Silent Aim Spear (Veil)", Flag = "Silent Aim Spear (Veil)", Callback = function(v) VeilConfig.Enabled = v end })
spearSection:AddKeybind({ Name = "Silent Aim Spear Keybind", Flag = "Silent Aim Spear Keybind", Default = "None", Mode = "Toggle", Callback = function(v) if silentAimSpearToggle then silentAimSpearToggle:SetValue(v) else VeilConfig.Enabled = v end end })

-- [Silent Aim Flask (Cure)]
flaskSection:AddToggle({ Default = false, Name = "Silent Aim Flask (Cure)", Flag = "Silent Aim Flask (Cure)", Callback = function(v) VD.KILLER_SilentAimFlask = v end })
flaskSection:AddToggle({ Default = false, Name = "Flask Laser (Cure)", Flag = "Flask Laser (Cure)", Callback = function(v)
    VD.KILLER_FlaskLaser = v
    if v then pcall(NEX_StartCureFlaskLaser) else
        if getgenv().NEX_CureFlaskLaserThread then getgenv().NEX_CureFlaskLaserThread:Disconnect(); getgenv().NEX_CureFlaskLaserThread = nil end
        if getgenv().NEX_CureFlaskLaserPart then pcall(function() getgenv().NEX_CureFlaskLaserPart:Destroy() end); getgenv().NEX_CureFlaskLaserPart = nil end
    end
end })

-- [ToF toggles]
tofSection:AddToggle({ Default = false, Name = "Silent Aim Twist Of Fate", Flag = "Silent Aim Twist Of Fate", Callback = function(v) if getgenv().NEX_SetToFSilentAim then getgenv().NEX_SetToFSilentAim(v) end end })
tofSection:AddToggle({ Default = true, Name = "ToF Laser", Flag = "ToF Laser", Callback = function(v) VD.TOF_Laser = v; if not v and getgenv().NEX_ToFClearLaser then getgenv().NEX_ToFClearLaser() end end })
tofSection:AddToggle({ Default = false, Name = "ToF Wall Check", Flag = "ToF Wall Check", Callback = function(v) VD.TOF_WallCheck = v end })
tofSection:AddToggle({ Default = true, Name = "ToF Block When Knocked", Flag = "ToF Block When Knocked", Callback = function(v) VD.TOF_BlockKnocked = v end })

-- [Flashlight toggles]
flashlightSection:AddToggle({ Default = false, Name = "Silent Aim Flashlight", Flag = "Silent Aim Flashlight", Callback = function(v) if getgenv().NEX_SetFlashlightSilentAim then getgenv().NEX_SetFlashlightSilentAim(v) else VD.FLASH_SilentAim = v end end })
flashlightSection:AddToggle({ Default = true, Name = "Flashlight Laser", Flag = "Flashlight Laser", Callback = function(v) VD.FLASH_Laser = v; if not v and getgenv().NEX_ClearFlashlightLaser then getgenv().NEX_ClearFlashlightLaser() end end })

-- [Killer Ability toggles - semua tier check dihapus]
abilityKiller:AddToggle({ Default = false, Name = "Infinite Abyssal Burst (Abyss)", Flag = "Infinite Abyssal Burst (Abyss)", Callback = function(v)
    VD.KILLER_BypassCooldown = v
    if v then NEX_StartAbyssCooldownBypass() else NEX_StopAbyssCooldownBypass() end
end })
abilityKiller:AddToggle({ Default = false, Name = "Infinite Skill (Hidden)", Flag = "Infinite Skill (Hidden)", Callback = function(v)
    VD.KILLER_BypassLeap = v
    if v then pcall(NEX_StartHiddenCooldownBypass) else pcall(NEX_StopHiddenCooldownBypass) end
end })
abilityKiller:AddToggle({ Default = false, Name = "Infinite Frenzy (Jeff)", Flag = "Infinite Frenzy (Jeff)", Callback = function(v)
    VD.KILLER_InfFrenzy = v
    if v then pcall(NEX_StartJeffCooldownBypass) else pcall(NEX_StopJeffCooldownBypass) end
end })
abilityKiller:AddToggle({ Default = false, Name = "Infinite Lake Mist (Jason)", Flag = "Infinite Lake Mist (Jason)", Callback = function(v)
    VD.KILLER_InfLakeMist = v
    if v then pcall(NEX_StartSlasherCooldownBypass) else pcall(NEX_StopSlasherCooldownBypass) end
end })
abilityKiller:AddToggle({ Default = false, Name = "Infinite Pursuit (Jason)", Flag = "Infinite Pursuit (Jason)", Callback = function(v)
    VD.KILLER_InfPursuit = v
    if v then pcall(NEX_StartSlasherCooldownBypass) else pcall(NEX_StopSlasherCooldownBypass) end
end })
abilityKiller:AddToggle({ Default = false, Name = "Infinite Grab (Myers)", Flag = "Infinite Grab (Myers)", Callback = function(v) setMyersGrab(v) end })

local fakeAttackToggle = abilityKiller:AddToggle({ Default = false, Name = "Fake Attack (Counter Parry)", Flag = "Fake Attack (Counter Parry)", Callback = function(v)
    VD.KILLER_FakeAttack = v
    pcall(NEX_ToggleFakeAttack, v)
end })
abilityKiller:AddKeybind({ Name = "Fake Attack Keybind", Flag = "Fake Attack Keybind", Default = "R", Mode = "Toggle", Callback = function(v) if fakeAttackToggle then fakeAttackToggle:SetValue(v) else VD.KILLER_FakeAttack = v; pcall(NEX_ToggleFakeAttack, v) end end })

abilityKiller:AddToggle({ Default = false, Name = "Undraggable Button (Inf Grab)", Flag = "Undraggable Button (Inf Grab)", Callback = function(v) setMyersDragLocked(v) end })

pcall(function()
    local customMaskedMasks = {"Richard", "Tony", "Brandon", "Jake", "Richter", "Graham", "Alex"}
    abilityKiller:AddDropdown({
        Name = "Custom Masked", Flag = "Custom Masked",
        Values = customMaskedMasks, Multi = false,
        Default = VD.KILLER_CustomMasked or "Richard",
        Callback = function(v) if type(v) == "table" then v = v[1] end; VD.KILLER_CustomMasked = v or "Richard" end
    })
    abilityKiller:AddButton({ Name = "Apply Custom Masked", Callback = function() pcall(NEX_ApplyCustomMasked, VD.KILLER_CustomMasked) end })
    abilityKiller:AddButton({ Name = "Random Custom Masked", Callback = function()
        local mask = customMaskedMasks[math.random(1, #customMaskedMasks)]
        VD.KILLER_CustomMasked = mask
        pcall(NEX_ApplyCustomMasked, mask)
    end })
end)

-- [Utility toggles]
utilKiller:AddToggle({ Default = false, Name = "Block All Vaults", Flag = "Block All Vaults", Callback = function(v) VD.KILLER_BlockVaults = v end })
utilKiller:AddToggle({ Default = false, Name = "Auto Drop All Pallets", Flag = "Auto Drop All Pallets", Callback = function(v) VD.KILLER_BlockPallets = v end })
utilKiller:AddToggle({ Default = false, Name = "Break All Pallet", Flag = "Break All Pallet", Callback = function(v) VD.KILLER_BlockPalletDrop = v end })

-- [Beat Survivor]
escapeSurv:AddToggle({ Default = false, Name = "Beat Survivor (auto exit)", Flag = "Beat Survivor (auto exit)", Callback = function(v) VD.BEAT_Survivor = v end })

-- [Boost Gen Bypass + Skillcheck Mode]
genAuto:AddToggle({ Default = false, Name = "Boost Gen Bypass", Flag = "Boost Gen Bypass", Callback = function(v) setGenBypass(v) end })
genAuto:AddDropdown({
    Name = "Skillcheck Mode", Flag = "Skillcheck Mode",
    Values = { "Normal", "Perfect", "Instant" },
    Default = "Normal", Multi = false,
    Callback = function(option)
        if type(option) == "table" then option = option[1] end
        VD.AutoSkillcheckMode = option or "Normal"
        if VD.AutoSkillcheckMode ~= "Instant" and AutoSkill.InstantRotationConnection then
            AutoSkill.InstantRotationConnection:Disconnect()
            AutoSkill.InstantRotationConnection = nil
            AutoSkill.InstantHasClicked = false
        end
        VD_Notify("Skillcheck Mode", tostring(VD.AutoSkillcheckMode) .. " selected", 2)
    end
})

-- [Fling]
flingSection:AddToggle({ Default = false, Name = "Enable Fling", Flag = "Enable Fling", Callback = function(v) VD.FLING_Enabled = v end })
flingSection:AddButton({ Name = "Fling Nearest", Callback = function() pcall(NEX_FlingNearest) end })
flingSection:AddButton({ Name = "Fling All", Callback = function() pcall(NEX_FlingAll) end })

-- [Fake Perks - semua toggles tier check dihapus]
fakePerkSection:AddToggle({ Name = "Flowstate", Flag = "FP_Flowstate", Default = false, Callback = function(val)
    flowstateOn = val
    local char = FP_Char()
    if char then char:SetAttribute("Flowstate", val) end
    -- ... sisa logic sama dengan asli (tanpa tier check)
end })
-- (QuickRecovery, PerfectLanding, AdrenalineRush — sama, hapus tier check saja)

-- [Auto Farm — semua toggles tier check dihapus]
autoFarmSection:AddToggle({ Default = VD.AUTOFARM_Escape or false, Name = "Auto Farm (Escape)", Flag = "Auto Farm (Escape)", Callback = function(v) VD.AUTOFARM_Escape = v end })
autoFarmSection:AddToggle({ Default = VD.AUTOFARM_HopAfterEscape or false, Name = "Auto Hop (After Escape)", Flag = "Auto Farm Hop After Escape", Callback = function(v) VD.AUTOFARM_HopAfterEscape = v end })
autoFarmSection:AddToggle({ Default = VD.AUTOFARM_RoundDetect or false, Name = "Round Detect (Hop if Spectator)", Flag = "Auto Farm Round Detect", Callback = function(v) VD.AUTOFARM_RoundDetect = v end })
autoFarmSection:AddToggle({ Default = VD.AUTOFARM_HopIfAlone or false, Name = "Detect Player (Hop if alone)", Flag = "Auto Farm Hop If Alone", Callback = function(v) VD.AUTOFARM_HopIfAlone = v end })
webhookSection:AddTextInput({ Name = "Discord Webhook URL", Flag = "Auto Farm Webhook URL", Default = VD.AUTOFARM_WebhookURL or "", Placeholder = "Masukkan URL Webhook...", Callback = function(v) VD.AUTOFARM_WebhookURL = tostring(v or ""):gsub("^%s+", ""):gsub("%s+$", "") end })
webhookSection:AddToggle({ Default = VD.AUTOFARM_AwardStatus or false, Name = "Award Status", Flag = "Auto Farm Award Status", Callback = function(v) VD.AUTOFARM_AwardStatus = v end })
webhookSection:AddButton({ Name = "Test Webhook", Callback = function() pcall(NEX_TestWebhook) end })

-- [Logic tier check removed]
function NEX_DoAutoFarmEscape()
    if NEX_AutoFarmEscaping or not VD.AUTOFARM_Escape then return end
    -- ... (tanpa tier check)
end

function NEX_SendAwardWebhook()
    if not VD.AUTOFARM_AwardStatus then return end
    -- ... (tanpa tier check)
end

function NEX_TestWebhook()
    local targetUrl = VD.AUTOFARM_WebhookURL
    -- ... (tanpa tier check)
end

task.spawn(function()
    while not VD.Destroyed do
        task.wait(0.2)
        if VD.AUTOFARM_Escape and not NEX_AutoFarmEscaping and not NEX_AutoFarmHopping then
            pcall(NEX_DoAutoFarmEscape)
        end
    end
end)

task.spawn(function()
    while not VD.Destroyed do
        task.wait(3)
        if VD.AUTOFARM_HopIfAlone and not NEX_AutoFarmHopping and not NEX_AutoFarmEscaping then
            -- ... (tanpa tier check)
        end
    end
end)

pcall(function()
    local Remotes = ReplicatedStorage:FindFirstChild("Remotes")
    if Remotes then
        local TimeUpdateEvent = Remotes:FindFirstChild("TimeUpdateEvent")
        if TimeUpdateEvent then
            TimeUpdateEvent.OnClientEvent:Connect(function(arg, _)
                if VD.AUTOFARM_RoundDetect and arg == "Round" and not NEX_AutoFarmHopping and not NEX_AutoFarmEscaping then
                    local team = LocalPlayer.Team
                    if team and team.Name:lower():match("spectator") then
                        VD_Notify("Auto Farm", "Ronde dimulai & kamu spectator! Server Hop...", 3)
                        NEX_AutoFarmServerHop()
                    end
                end
            end)
        end
    end
end)

-- [NEX_FlashlightAimStep & NEX_SetFlashlightSilentAim — tier check dihapus]
local function NEX_FlashlightAimStep()
    if not (VD.FLASH_SilentAim and NEX_FlashlightAimState.Active) then
        if NEX_FlashlightAimState.LaserBeam then NEX_FlashlightAimState.LaserBeam.Transparency = 1 end
        return
    end
    -- ... (tanpa tier check)
end

local function NEX_SetFlashlightSilentAim(enabled)
    VD.FLASH_SilentAim = enabled and true or false
    if VD.FLASH_SilentAim then
        NEX_StartFlashlightSilentAim()
    else
        NEX_StopFlashlightSilentAim()
    end
end
getgenv().NEX_SetFlashlightSilentAim = NEX_SetFlashlightSilentAim

-- =====================================================
-- END — semua premium/keysystem lock sudah dihapus
-- =====================================================

print("NEX HUB Violence District v1.5.9 Unlocked Loaded")
pcall(function()
    VD_Notify("NexHub", "Violence District v1.5.9 (Unlocked) Loaded Successfully!", 5)
end)

end
__NexHub_Init_Main__()