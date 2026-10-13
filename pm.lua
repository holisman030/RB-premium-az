--========================================================--
-- ALFzxzzz HUB v0.4.4
-- Theme: Monochrome (Black / 15,15,15 / White)
-- Sections: Groupbox style (header + accent dot + divider)
-- Patch: Working Config System + Music Player
--========================================================--

getgenv().VD = getgenv().VD or {}
local W = getgenv()

--====================================================--
-- GLOBAL THEME (MONOCHROME)
--====================================================--
_G.GLUTO_THEME      = Color3.fromRGB(255, 255, 255)
_G.GLUTO_THEME_DIM  = Color3.fromRGB(170, 170, 170)
_G.GLUTO_ACCENT     = _G.GLUTO_THEME
_G.GLUTO_ACCENT_BG  = Color3.fromRGB(15, 15, 15)
_G.GLUTO_NEUTRAL    = Color3.fromRGB(140, 140, 140)
_G.GLUTO_STROKE_OFF = Color3.fromRGB(60, 60, 60)
_G.GLUTO_BG_OFF     = Color3.fromRGB(10, 10, 10)

--====================================================--
-- SAFE GUI PARENT
--====================================================--
local function SafeGuiParent()
    if gethui then
        local ok, hui = pcall(gethui)
        if ok and hui then return hui end
    end
    local cg = game:GetService("CoreGui")
    local ok, can = pcall(function()
        local f = Instance.new("Folder"); f.Parent = cg; f:Destroy()
    end)
    if ok and can then return cg end
    return game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
end

--====================================================--
-- VARIABLE DEFAULTS
--====================================================--
VD.AutoCrouch                = VD.AutoCrouch or false
VD.KILLER_AutoAttack         = VD.KILLER_AutoAttack or false
VD.KILLER_AutoAttackRange    = VD.KILLER_AutoAttackRange or 12
VD.KILLER_AutoAttackCooldown = VD.KILLER_AutoAttackCooldown or 0.15
VD.SURV_AutoFlee             = VD.SURV_AutoFlee or false
VD.SURV_AutoFleeDist         = VD.SURV_AutoFleeDist or 40
VD.SURV_AutoFleeCooldown     = VD.SURV_AutoFleeCooldown or 1.5

VD.Surv_AutoParry       = VD.Surv_AutoParry or false
VD.Surv_ParrySafety     = VD.Surv_ParrySafety or false
VD.Surv_ParryAggressive = VD.Surv_ParryAggressive or false
VD.Surv_ParryCircle     = VD.Surv_ParryCircle ~= false
VD.Surv_ParryRadius     = VD.Surv_ParryRadius or 15
VD.Surv_ParryFace       = VD.Surv_ParryFace or 0.7
VD.Surv_IgnoredSkills   = VD.Surv_IgnoredSkills or {}

VD.VeilEnabled          = VD.VeilEnabled          or false
VD.VeilShowFOV          = VD.VeilShowFOV          ~= false
VD.VeilShowTracker      = VD.VeilShowTracker      or false
VD.VeilAutoPredict      = VD.VeilAutoPredict      ~= false
VD.VeilFOV              = VD.VeilFOV              or 150
VD.VeilMaxDist          = VD.VeilMaxDist          or 500
VD.VeilSpearSpeed       = VD.VeilSpearSpeed       or 165
VD.VeilGravity          = VD.VeilGravity          or 103
VD.VeilAuraSpearSpeed   = VD.VeilAuraSpearSpeed   or 165
VD.VeilAuraSpearGravity = VD.VeilAuraSpearGravity or 96
VD.VeilLeadMultiplier   = VD.VeilLeadMultiplier   or 1.4

VD.TOF_SilentAim    = VD.TOF_SilentAim    or false
VD.TOF_TargetMode   = VD.TOF_TargetMode   or "Killer"
VD.TOF_Key          = VD.TOF_Key          or "Q"
VD.TOF_Laser        = VD.TOF_Laser        ~= false
VD.TOF_WallCheck    = VD.TOF_WallCheck    ~= false
VD.TOF_BlockKnocked = VD.TOF_BlockKnocked ~= false

VD.Invis_Enabled       = VD.Invis_Enabled or false
VD.Invis_ShowFloatBtn  = VD.Invis_ShowFloatBtn or false
VD.Invis_Hotkey        = VD.Invis_Hotkey or "G"

VD.KILLER_BypassLeap     = VD.KILLER_BypassLeap or false
VD.KILLER_InfGrab        = VD.KILLER_InfGrab or false
VD.KILLER_InfLakeMist    = VD.KILLER_InfLakeMist or false
VD.KILLER_InfPursuit     = VD.KILLER_InfPursuit or false
VD.KILLER_BypassCooldown = VD.KILLER_BypassCooldown or false
VD.KILLER_InfFrenzy      = VD.KILLER_InfFrenzy or false
VD.KILLER_AntiBlind      = VD.KILLER_AntiBlind or false
VD.KILLER_DestroyPallets = VD.KILLER_DestroyPallets or false
VD.KILLER_InfLunge       = VD.KILLER_InfLunge or false
VD.KILLER_AutoHook       = VD.KILLER_AutoHook or false
VD.KILLER_CounterParry   = VD.KILLER_CounterParry or false

VD.KA_AutoStalk      = VD.KA_AutoStalk or false
VD.KA_AutoStalkRange = VD.KA_AutoStalkRange or 150
VD.KA_AutoKillAll    = VD.KA_AutoKillAll or false
VD.KA_DropAllPallet  = VD.KA_DropAllPallet or false
VD.KA_BlockAllVault  = VD.KA_BlockAllVault or false

VD.NoFallDamage     = VD.NoFallDamage or false
VD.NextMapPredict   = VD.NextMapPredict or false
VD.ManualGen        = VD.ManualGen or false
VD.AutoGen          = VD.AutoGen or false
VD.KillerEscapeDist = VD.KillerEscapeDist or 30

VD.KillerPerksDisplay = VD.KillerPerksDisplay or false
VD.SpeedBoostEnabled  = VD.SpeedBoostEnabled or false
VD.SpeedBoostValue    = VD.SpeedBoostValue or 30
VD.CursorEnabled      = VD.CursorEnabled or false

W.InstantHealSelf = W.InstantHealSelf or false
W.AutoHealAll     = W.AutoHealAll or false

--====================================================--
-- MAIN FUNCTION
--====================================================--
local function __Gluto_Init_Main__()

    local Players           = game:GetService("Players")
    local RunService        = game:GetService("RunService")
    local UserInputService  = game:GetService("UserInputService")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Workspace         = game:GetService("Workspace")
    local CoreGui           = game:GetService("CoreGui")
    local CollectionService = game:GetService("CollectionService")
    local TweenService      = game:GetService("TweenService")
    local GuiService        = game:GetService("GuiService")
    local HttpService       = game:GetService("HttpService")
    local Lighting          = game:GetService("Lighting")
    local SoundService      = game:GetService("SoundService")

    local LocalPlayer = Players.LocalPlayer
    local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
    local VirtualInputManager = nil
    pcall(function() VirtualInputManager = game:GetService("VirtualInputManager") end)

    --====================================================--
    -- CONFIG STORAGE (HARUS DIINIT SEBELUM UI)
    --====================================================--
    if type(getgenv().ConfigData) ~= "table" then getgenv().ConfigData = {} end
    if type(getgenv().Elements)   ~= "table" then getgenv().Elements   = {} end
    local ConfigData = getgenv().ConfigData
    local Elements   = getgenv().Elements

    local AutoSaveEnabled = true
    local ActiveConfigName = nil
    local ActiveConfigPath = nil
    local ActiveConfigMode = nil

    local function MakeFlag(sec, title)
        local tabName = tostring(sec and sec._tabName or "tab")
        local secName = tostring(sec and sec._sectionName or "sec")
        local t       = tostring(title or "opt")
        local function san(s)
            s = s:gsub("[^%w]", "_")
            s = s:gsub("_+", "_")
            s = s:gsub("^_", ""):gsub("_$", "")
            return s
        end
        return san(tabName) .. "_" .. san(secName) .. "_" .. san(t)
    end

    local UILib = {}
    local _window
    local function corner(o,r) local c=Instance.new("UICorner"); c.CornerRadius=UDim.new(0,r or 8); c.Parent=o end
    local function stroke(o,c,t) local s=Instance.new("UIStroke"); s.Color=c or Color3.new(1,1,1); s.Thickness=t or 1; s.Transparency=.25; s.Parent=o; return s end
    local function label(p,text,size,color,bold) local x=Instance.new("TextLabel"); x.BackgroundTransparency=1; x.Text=tostring(text or ""); x.TextColor3=color or Color3.new(1,1,1); x.TextSize=size or 11; x.Font=bold and Enum.Font.GothamBold or Enum.Font.Gotham; x.TextXAlignment=Enum.TextXAlignment.Left; x.Parent=p; return x end
    local function tw(o,props,t) pcall(function() TweenService:Create(o,TweenInfo.new(t or .15,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),props):Play() end) end
    local function row(parent,h) local f=Instance.new("Frame"); f.BackgroundColor3=Color3.fromRGB(18,18,18); f.BorderSizePixel=0; f.Size=UDim2.new(1,0,0,h or 44); f.Parent=parent; corner(f,7); return f end

    --====================================================--
    -- COLOR PICKER
    --====================================================--
    local ActiveColorPopups = {}

    local function GetColorPickerScreenGui()
        local existing = _G.__GlutoColorPickerScreenGui
        if existing and existing.Parent then return existing end
        local parent = SafeGuiParent()
        if not parent then return nil end
        local sg = Instance.new("ScreenGui")
        sg.Name = "GlutoColorPickerLayer"
        sg.ResetOnSpawn = false
        sg.IgnoreGuiInset = true
        sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        sg.DisplayOrder = 1000001
        sg.Parent = parent
        _G.__GlutoColorPickerScreenGui = sg
        return sg
    end

    local function addColor(sec, o)
        local r = row(sec.Body, 45)
        local t = label(r, o.Title, 11, Color3.fromRGB(245,245,245), true)
        t.Position = UDim2.new(0,11,0,0)
        t.Size = UDim2.new(1,-80,1,0)

        local btn = Instance.new("TextButton")
        btn.Text = ""
        btn.BackgroundColor3 = o.Default or Color3.new(1,1,1)
        btn.AutoButtonColor = false
        btn.Position = UDim2.new(1,-55,.5,-13)
        btn.Size = UDim2.fromOffset(44,26)
        btn.Parent = r
        corner(btn,6); stroke(btn, Color3.fromRGB(90,90,90))

        local value = o.Default or Color3.new(1,1,1)
        local h, s, v = Color3.toHSV(value)
        local popup = nil
        local flag = o.Flag or MakeFlag(sec, o.Title)

        local function fireCallback()
            ConfigData[flag] = { R = value.R, G = value.G, B = value.B, _c3 = true }
            if o.Callback then pcall(o.Callback, value) end
        end

        local function closePopup()
            if popup and popup.Parent then popup:Destroy() end
            popup = nil
            ActiveColorPopups[btn] = nil
        end

        local function openPopup()
            if popup and popup.Parent then closePopup(); return end
            for _, closer in pairs(ActiveColorPopups) do pcall(closer) end

            local sg = GetColorPickerScreenGui()
            if not sg then
                warn("[ColorPicker] No valid ScreenGui parent")
                return
            end

            popup = Instance.new("Frame")
            popup.Name = "GlutoColorPicker"
            popup.Size = UDim2.fromOffset(240, 306)
            popup.BackgroundColor3 = Color3.fromRGB(15,15,15)
            popup.BorderSizePixel = 0
            popup.ZIndex = 10
            popup.Parent = sg
            corner(popup, 10)
            local popupStroke = Instance.new("UIStroke")
            popupStroke.Color = Color3.fromRGB(70,70,70)
            popupStroke.Thickness = 1.2
            popupStroke.Parent = popup

            local vp = sg.AbsoluteSize
            if vp.X == 0 then
                local cam = workspace.CurrentCamera
                vp = cam and cam.ViewportSize or Vector2.new(1280,720)
            end
            local bPos = btn.AbsolutePosition
            local bSize = btn.AbsoluteSize
            local POP_W, POP_H = 240, 306
            local px = bPos.X + bSize.X + 8
            local py = bPos.Y
            if px + POP_W > vp.X - 8 then px = bPos.X - POP_W - 8 end
            if px < 8 then px = 8 end
            if py + POP_H > vp.Y - 8 then py = vp.Y - POP_H - 8 end
            if py < 8 then py = 8 end
            popup.Position = UDim2.fromOffset(px, py)

            local hdr = label(popup, o.Title or "Color", 12, Color3.new(1,1,1), true)
            hdr.Position = UDim2.new(0,12,0,9)
            hdr.Size = UDim2.new(1,-42,0,18)

            local closeBtn = Instance.new("TextButton")
            closeBtn.Text = "×"
            closeBtn.Font = Enum.Font.GothamBold
            closeBtn.TextSize = 16
            closeBtn.TextColor3 = Color3.fromRGB(210,210,210)
            closeBtn.BackgroundColor3 = Color3.fromRGB(28,28,28)
            closeBtn.AutoButtonColor = false
            closeBtn.Position = UDim2.new(1,-28,0,6)
            closeBtn.Size = UDim2.fromOffset(22,22)
            closeBtn.Parent = popup
            corner(closeBtn, 6)
            closeBtn.MouseButton1Click:Connect(closePopup)

            local preview = Instance.new("Frame")
            preview.Position = UDim2.fromOffset(12, 38)
            preview.Size = UDim2.fromOffset(70, 58)
            preview.BackgroundColor3 = value
            preview.BorderSizePixel = 0
            preview.Parent = popup
            corner(preview, 6); stroke(preview, Color3.fromRGB(70,70,70))

            local rgbLbl = label(popup, "RGB: 255, 255, 255", 10, Color3.fromRGB(210,210,210))
            rgbLbl.Position = UDim2.fromOffset(90, 44)
            rgbLbl.Size = UDim2.fromOffset(140, 16)

            local hexLbl = label(popup, "Hex: #FFFFFF", 10, Color3.fromRGB(210,210,210))
            hexLbl.Position = UDim2.fromOffset(90, 62)
            hexLbl.Size = UDim2.fromOffset(140, 16)

            local function makeSlider(yPos, title)
                local lbl = label(popup, title, 10, Color3.fromRGB(200,200,200), true)
                lbl.Position = UDim2.fromOffset(12, yPos)
                lbl.Size = UDim2.fromOffset(200, 14)

                local bar = Instance.new("Frame")
                bar.Position = UDim2.fromOffset(12, yPos + 18)
                bar.Size = UDim2.fromOffset(216, 14)
                bar.BackgroundColor3 = Color3.new(1,1,1)
                bar.BorderSizePixel = 0
                bar.Parent = popup
                corner(bar, 7); stroke(bar, Color3.fromRGB(70,70,70))

                local grad = Instance.new("UIGradient")
                grad.Parent = bar

                local handle = Instance.new("Frame")
                handle.Size = UDim2.fromOffset(4, 20)
                handle.AnchorPoint = Vector2.new(0.5, 0.5)
                handle.BackgroundColor3 = Color3.new(1,1,1)
                handle.BorderSizePixel = 0
                handle.Position = UDim2.new(0, 0, 0.5, 0)
                handle.ZIndex = 5
                handle.Parent = bar
                corner(handle, 2)
                local hs = Instance.new("UIStroke")
                hs.Color = Color3.new(0,0,0); hs.Thickness = 1
                hs.Parent = handle

                local hit = Instance.new("TextButton")
                hit.Text = ""
                hit.BackgroundTransparency = 1
                hit.Size = UDim2.new(1, 0, 1, 20)
                hit.Position = UDim2.new(0, 0, 0, -10)
                hit.Parent = bar

                return { Bar = bar, Handle = handle, Grad = grad, Hit = hit }
            end

            local hueSlider = makeSlider(106, "Hue")
            local satSlider = makeSlider(152, "Saturation")
            local valSlider = makeSlider(198, "Brightness")

            local hexInput = Instance.new("TextBox")
            hexInput.Position = UDim2.fromOffset(12, 240)
            hexInput.Size = UDim2.fromOffset(216, 26)
            hexInput.BackgroundColor3 = Color3.fromRGB(28,28,28)
            hexInput.BorderSizePixel = 0
            hexInput.Text = ""
            hexInput.PlaceholderText = "#FFFFFF (tekan Enter)"
            hexInput.PlaceholderColor3 = Color3.fromRGB(110,110,110)
            hexInput.TextColor3 = Color3.fromRGB(255,255,255)
            hexInput.Font = Enum.Font.Gotham
            hexInput.TextSize = 11
            hexInput.ClearTextOnFocus = false
            hexInput.Parent = popup
            corner(hexInput, 5); stroke(hexInput, Color3.fromRGB(60,60,60))

            local applyBtn = Instance.new("TextButton")
            applyBtn.Position = UDim2.fromOffset(12, 272)
            applyBtn.Size = UDim2.fromOffset(216, 24)
            applyBtn.BackgroundColor3 = Color3.fromRGB(255,255,255)
            applyBtn.Text = "APPLY"
            applyBtn.TextColor3 = Color3.new(0,0,0)
            applyBtn.Font = Enum.Font.GothamBold
            applyBtn.TextSize = 10
            applyBtn.AutoButtonColor = false
            applyBtn.Parent = popup
            corner(applyBtn, 5)

            local function refresh()
                local c = Color3.fromHSV(h, s, v)
                preview.BackgroundColor3 = c
                local r255 = math.floor(c.R * 255 + 0.5)
                local g255 = math.floor(c.G * 255 + 0.5)
                local b255 = math.floor(c.B * 255 + 0.5)
                rgbLbl.Text = ("RGB: %d, %d, %d"):format(r255, g255, b255)
                hexLbl.Text = ("Hex: #%02X%02X%02X"):format(r255, g255, b255)

                hueSlider.Handle.Position = UDim2.new(h, 0, 0.5, 0)
                satSlider.Handle.Position = UDim2.new(s, 0, 0.5, 0)
                valSlider.Handle.Position = UDim2.new(v, 0, 0.5, 0)

                hueSlider.Grad.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0/6, Color3.fromHSV(0/6,1,1)),
                    ColorSequenceKeypoint.new(1/6, Color3.fromHSV(1/6,1,1)),
                    ColorSequenceKeypoint.new(2/6, Color3.fromHSV(2/6,1,1)),
                    ColorSequenceKeypoint.new(3/6, Color3.fromHSV(3/6,1,1)),
                    ColorSequenceKeypoint.new(4/6, Color3.fromHSV(4/6,1,1)),
                    ColorSequenceKeypoint.new(5/6, Color3.fromHSV(5/6,1,1)),
                    ColorSequenceKeypoint.new(6/6, Color3.fromHSV(1,1,1)),
                })
                satSlider.Grad.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromHSV(h, 0, 1)),
                    ColorSequenceKeypoint.new(1, Color3.fromHSV(h, 1, 1)),
                })
                valSlider.Grad.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.new(0,0,0)),
                    ColorSequenceKeypoint.new(1, Color3.fromHSV(h, s, 1)),
                })

                value = c
                btn.BackgroundColor3 = c
                fireCallback()
            end

            local function bindSlider(slider, onChange)
                local dragging2 = false
                local function apply(input)
                    local absX = slider.Bar.AbsolutePosition.X
                    local absW = slider.Bar.AbsoluteSize.X
                    if absW <= 0 then return end
                    local rel = math.clamp((input.Position.X - absX) / absW, 0, 1)
                    onChange(rel)
                    refresh()
                end
                slider.Hit.InputBegan:Connect(function(inp)
                    if inp.UserInputType == Enum.UserInputType.MouseButton1
                        or inp.UserInputType == Enum.UserInputType.Touch then
                        dragging2 = true
                        apply(inp)
                    end
                end)
                UserInputService.InputChanged:Connect(function(inp)
                    if not dragging2 then return end
                    if inp.UserInputType == Enum.UserInputType.MouseMovement
                        or inp.UserInputType == Enum.UserInputType.Touch then
                        apply(inp)
                    end
                end)
                UserInputService.InputEnded:Connect(function(inp)
                    if inp.UserInputType == Enum.UserInputType.MouseButton1
                        or inp.UserInputType == Enum.UserInputType.Touch then
                        dragging2 = false
                    end
                end)
            end

            bindSlider(hueSlider, function(x) h = x end)
            bindSlider(satSlider, function(x) s = x end)
            bindSlider(valSlider, function(x) v = x end)

            hexInput.FocusLost:Connect(function()
                local txt = (hexInput.Text or ""):gsub("#", ""):gsub("%s", "")
                if #txt == 6 then
                    local rr = tonumber(txt:sub(1,2), 16)
                    local gg = tonumber(txt:sub(3,4), 16)
                    local bb = tonumber(txt:sub(5,6), 16)
                    if rr and gg and bb then
                        local c = Color3.fromRGB(rr, gg, bb)
                        h, s, v = Color3.toHSV(c)
                        refresh()
                    end
                end
                hexInput.Text = ""
            end)

            applyBtn.MouseButton1Click:Connect(function()
                refresh()
                closePopup()
            end)

            ActiveColorPopups[btn] = closePopup
            refresh()
        end

        btn.MouseButton1Click:Connect(openPopup)

        local obj = {
            Set = function(_, v2, silent)
                if type(v2) == "table" and v2._c3 then
                    v2 = Color3.new(v2.R or 1, v2.G or 1, v2.B or 1)
                end
                if typeof(v2) == "Color3" then
                    value = v2
                    h, s, v = Color3.toHSV(v2)
                    btn.BackgroundColor3 = v2
                    ConfigData[flag] = { R = v2.R, G = v2.G, B = v2.B, _c3 = true }
                    if not silent then fireCallback() end
                end
            end,
            Get = function() return value end,
            Flag = flag
        }
        Elements[flag] = obj
        return obj
    end

    local function addToggle(sec,o)
        local r=row(sec.Body,o.Content and 53 or 43)
        local t=label(r,o.Title,11,Color3.fromRGB(245,245,245),true)
        t.Position=UDim2.new(0,11,0, o.Content and 6 or 0); t.Size=UDim2.new(1,-75,0,18)
        if o.Content then
            local d=label(r,o.Content,9,Color3.fromRGB(145,145,145))
            d.Position=UDim2.new(0,11,0,25); d.Size=UDim2.new(1,-75,0,18)
            d.TextTruncate=Enum.TextTruncate.AtEnd
        end
        local b=Instance.new("TextButton"); b.Text=""; b.AutoButtonColor=false
        b.BackgroundColor3=Color3.fromRGB(48,48,48); b.Size=UDim2.fromOffset(40,22)
        b.Position=UDim2.new(1,-52,.5,-11); b.Parent=r; corner(b,11)
        local k=Instance.new("Frame"); k.BackgroundColor3=Color3.fromRGB(170,170,170)
        k.Size=UDim2.fromOffset(16,16); k.Position=UDim2.new(0,3,.5,-8)
        k.Parent=b; corner(k,8)
        local state=o.Default==true
        local flag = o.Flag or MakeFlag(sec, o.Title)
        local obj={}
        local function set(v,silent)
            state=not not v
            tw(b,{BackgroundColor3=state and Color3.fromRGB(255,255,255) or Color3.fromRGB(48,48,48)})
            tw(k,{Position=state and UDim2.new(1,-19,.5,-8) or UDim2.new(0,3,.5,-8),
                  BackgroundColor3=state and Color3.fromRGB(5,5,5) or Color3.fromRGB(170,170,170)})
            ConfigData[flag] = state
            if not silent and o.Callback then pcall(o.Callback,state) end
        end
        b.MouseButton1Click:Connect(function() set(not state,false) end)
        set(state,true)
        function obj:Set(v,silent) set(v,silent) end
        function obj:Get() return state end
        obj.Flag = flag
        Elements[flag] = obj
        return obj
    end

    local function addButton(sec,o)
        local hasSub = o.SubCallback ~= nil
        local r=Instance.new("Frame"); r.BackgroundTransparency=1
        r.Size=UDim2.new(1,0,0, hasSub and 84 or 42)
        r.Parent=sec.Body
        local b=Instance.new("TextButton")
        b.Text=o.Title or "Button"; b.AutoButtonColor=false
        b.BackgroundColor3=Color3.fromRGB(28,28,28); b.TextColor3=Color3.fromRGB(245,245,245)
        b.TextSize=11; b.Font=Enum.Font.GothamMedium
        b.Size=UDim2.new(1,0,0,38); b.Position=UDim2.new(0,0,0,0)
        b.Parent=r; corner(b,7); stroke(b,Color3.fromRGB(55,55,55))
        b.MouseButton1Click:Connect(function() if o.Callback then pcall(o.Callback) end end)
        if hasSub then
            local b2=Instance.new("TextButton")
            b2.Text=o.SubTitle or "Sub"; b2.AutoButtonColor=false
            b2.BackgroundColor3=Color3.fromRGB(22,22,22); b2.TextColor3=Color3.fromRGB(220,220,220)
            b2.TextSize=11; b2.Font=Enum.Font.GothamMedium
            b2.Size=UDim2.new(1,0,0,38); b2.Position=UDim2.new(0,0,0,42)
            b2.Parent=r; corner(b2,7); stroke(b2,Color3.fromRGB(50,50,50))
            b2.MouseButton1Click:Connect(function() if o.SubCallback then pcall(o.SubCallback) end end)
        end
        return b
    end

    --====================================================--
    -- SLIDER (WITH ROUND KNOB)
    --====================================================--
    local function addSlider(sec,o)
        local r=row(sec.Body,62)
        local t=label(r,o.Title,11,Color3.fromRGB(245,245,245),true)
        t.Position=UDim2.new(0,11,0,5); t.Size=UDim2.new(1,-80,0,18)
        local vl=label(r,"",10,Color3.fromRGB(160,160,160))
        vl.TextXAlignment=Enum.TextXAlignment.Right
        vl.Position=UDim2.new(1,-70,0,5); vl.Size=UDim2.fromOffset(60,18)
        local bar=Instance.new("Frame")
        bar.BackgroundColor3=Color3.fromRGB(48,48,48); bar.BorderSizePixel=0
        bar.Position=UDim2.new(0,11,0,39); bar.Size=UDim2.new(1,-22,0,5)
        bar.Parent=r; corner(bar,3)
        local fill=Instance.new("Frame")
        fill.BackgroundColor3=Color3.fromRGB(255,255,255); fill.BorderSizePixel=0
        fill.Size=UDim2.new(0,0,1,0); fill.Parent=bar; corner(fill,3)
        local knob=Instance.new("Frame"); knob.Name="Knob"
        knob.AnchorPoint=Vector2.new(0.5,0.5); knob.Position=UDim2.new(0,0,0.5,0)
        knob.Size=UDim2.fromOffset(18,18); knob.BackgroundColor3=Color3.fromRGB(255,255,255)
        knob.BorderSizePixel=0; knob.ZIndex=2; knob.Parent=bar; corner(knob,9)
        local knobStroke=Instance.new("UIStroke")
        knobStroke.Color=Color3.fromRGB(0,0,0); knobStroke.Thickness=1.2
        knobStroke.Transparency=0.35; knobStroke.Parent=knob
        local hit=Instance.new("TextButton"); hit.Text=""; hit.BackgroundTransparency=1
        hit.Size=UDim2.new(1,20,1,30); hit.Position=UDim2.new(0,-10,0,-14)
        hit.ZIndex=3; hit.Parent=bar
        local mn,mx=tonumber(o.Min or 0),tonumber(o.Max or 100)
        local val=tonumber(o.Default or mn) or mn
        local drag=false
        local flag = o.Flag or MakeFlag(sec, o.Title)
        local function set(v,silent)
            v=math.clamp(tonumber(v) or mn,mn,mx)
            local inc=tonumber(o.Increment)
            if inc and inc>0 then v=math.floor((v-mn)/inc+.5)*inc+mn end
            val=v
            local a=(mx==mn) and 0 or (v-mn)/(mx-mn)
            fill.Size=UDim2.new(a,0,1,0)
            knob.Position=UDim2.new(a,0,0.5,0)
            vl.Text=tostring(math.floor(v*100)/100)..tostring(o.Suffix or "")
            ConfigData[flag] = v
            if not silent and o.Callback then pcall(o.Callback,v) end
        end
        hit.MouseButton1Down:Connect(function()
            drag=true
            TweenService:Create(knob,TweenInfo.new(0.1),{Size=UDim2.fromOffset(22,22)}):Play()
        end)
        UserInputService.InputEnded:Connect(function(i)
            if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
                drag=false
                TweenService:Create(knob,TweenInfo.new(0.15,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Size=UDim2.fromOffset(18,18)}):Play()
            end
        end)
        UserInputService.InputChanged:Connect(function(i)
            if drag and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
                set(mn+(mx-mn)*math.clamp((i.Position.X-bar.AbsolutePosition.X)/math.max(bar.AbsoluteSize.X,1),0,1),false)
            end
        end)
        set(val,true)
        local obj = {Set=function(_,v,s) set(v,s) end,Get=function() return val end, Flag=flag}
        Elements[flag] = obj
        return obj
    end

    --====================================================--
    -- DROPDOWN SCREEN GUI LAYER
    --====================================================--
    local ActiveDropdownPopups = {}

    local function GetDropdownScreenGui()
        local existing = _G.__GlutoDropdownScreenGui
        if existing and existing.Parent then return existing end
        local parent = SafeGuiParent()
        if not parent then return nil end
        local sg = Instance.new("ScreenGui")
        sg.Name = "GlutoDropdownLayer"
        sg.ResetOnSpawn = false
        sg.IgnoreGuiInset = true
        sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        sg.DisplayOrder = 1000000
        sg.Parent = parent
        _G.__GlutoDropdownScreenGui = sg
        return sg
    end

    local function addDropdown(sec, o)
        local r = row(sec.Body, 48)
        local t = label(r, o.Title or "Dropdown", 11, Color3.fromRGB(245,245,245), true)
        t.Position = UDim2.new(0, 12, 0, 0)
        t.Size = UDim2.new(1, -200, 1, 0)
        t.TextYAlignment = Enum.TextYAlignment.Center

        local btn = Instance.new("TextButton")
        btn.AutoButtonColor = false
        btn.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
        btn.Text = ""
        btn.AnchorPoint = Vector2.new(1, 0.5)
        btn.Position = UDim2.new(1, -10, 0.5, 0)
        btn.Size = UDim2.new(0, 175, 0, 32)
        btn.ClipsDescendants = true
        btn.Parent = r
        corner(btn, 7)
        local btnStroke = stroke(btn, Color3.fromRGB(50,50,50), 1, 0.3)

        local valueLbl = Instance.new("TextLabel")
        valueLbl.BackgroundTransparency = 1
        valueLbl.Text = "Select..."
        valueLbl.TextColor3 = Color3.fromRGB(235,235,235)
        valueLbl.TextSize = 11
        valueLbl.Font = Enum.Font.GothamMedium
        valueLbl.TextXAlignment = Enum.TextXAlignment.Left
        valueLbl.TextYAlignment = Enum.TextYAlignment.Center
        valueLbl.TextTruncate = Enum.TextTruncate.AtEnd
        valueLbl.Position = UDim2.new(0, 14, 0, 0)
        valueLbl.Size = UDim2.new(1, -40, 1, 0)
        valueLbl.Parent = btn

        local chevron = Instance.new("TextLabel")
        chevron.BackgroundTransparency = 1
        chevron.Text = "v"
        chevron.TextColor3 = Color3.fromRGB(160,160,160)
        chevron.TextSize = 12
        chevron.Font = Enum.Font.GothamBold
        chevron.AnchorPoint = Vector2.new(0.5, 0.5)
        chevron.Position = UDim2.new(1, -14, 0.5, 0)
        chevron.Size = UDim2.fromOffset(12, 12)
        chevron.Parent = btn

        local val = o.Default or ((o.Options or {})[1])
        local multiValues = {}
        if o.Multi and type(val) == "table" then
            for k, v in pairs(val) do
                if type(k) == "string" then multiValues[k] = v
                elseif type(v) == "string" then multiValues[v] = true end
            end
        end

        local flag = o.Flag or MakeFlag(sec, o.Title)

        local popup = nil
        local optionMeta = {}
        local searchBoxRef = nil

        local function closePopup()
            if popup and popup.Parent then
                local p = popup
                popup = nil
                TweenService:Create(p, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                    BackgroundTransparency = 1,
                }):Play()
                task.delay(0.16, function() pcall(function() p:Destroy() end) end)
            end
            ActiveDropdownPopups[btn] = nil
            TweenService:Create(chevron, TweenInfo.new(0.2), { Rotation = 0 }):Play()
            TweenService:Create(btn, TweenInfo.new(0.15), { BackgroundColor3 = Color3.fromRGB(22,22,22) }):Play()
            TweenService:Create(btnStroke, TweenInfo.new(0.15), { Color = Color3.fromRGB(50,50,50) }):Play()
        end

        local function getDisplayText()
            if o.Multi then
                local count, first = 0, nil
                for k, v in pairs(multiValues) do
                    if v then count = count + 1; if not first then first = k end end
                end
                if count == 0 then return "None" end
                if count == 1 then return tostring(first) end
                return count .. " selected"
            end
            return tostring(val or "Select...")
        end

        local function refreshButton() valueLbl.Text = getDisplayText() end

        local function fireCallback()
            if o.Multi then
                ConfigData[flag] = multiValues
                if o.Callback then pcall(o.Callback, multiValues) end
            else
                ConfigData[flag] = val
                if o.Callback then pcall(o.Callback, val) end
            end
        end

        local function isSelected(v2)
            if o.Multi then return multiValues[v2] == true end
            return tostring(val) == tostring(v2)
        end

        local function refreshOptionStates()
            for opt, meta in pairs(optionMeta) do
                if opt.Parent then
                    if isSelected(meta.Value) then
                        opt.BackgroundColor3 = Color3.fromRGB(45,45,45)
                        opt.TextColor3 = Color3.fromRGB(255,255,255)
                        if meta.Accent then meta.Accent.BackgroundTransparency = 0 end
                        if meta.Check then meta.Check.TextTransparency = 0 end
                        if meta.Dot then meta.Dot.BackgroundTransparency = 0 end
                    else
                        opt.BackgroundColor3 = Color3.fromRGB(20,20,20)
                        opt.TextColor3 = Color3.fromRGB(200,200,200)
                        if meta.Accent then meta.Accent.BackgroundTransparency = 1 end
                        if meta.Check then meta.Check.TextTransparency = 1 end
                        if meta.Dot then meta.Dot.BackgroundTransparency = 1 end
                    end
                end
            end
        end

        local function buildPopup()
            for _, closer in pairs(ActiveDropdownPopups) do pcall(closer) end

            local sg = GetDropdownScreenGui()
            if not sg then return end

            popup = Instance.new("Frame")
            popup.Name = "GlutoDropdownPopup"
            popup.BackgroundColor3 = Color3.fromRGB(15,15,15)
            popup.BackgroundTransparency = 1
            popup.BorderSizePixel = 0
            popup.ZIndex = 10
            popup.ClipsDescendants = true
            popup.Parent = sg
            corner(popup, 8)

            local popupStroke = Instance.new("UIStroke")
            popupStroke.Color = Color3.fromRGB(50,50,50)
            popupStroke.Thickness = 1
            popupStroke.Transparency = 1
            popupStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            popupStroke.Parent = popup

            local options = o.Options or {}
            local optionCount = #options
            local useSearch = optionCount > 7

            local ITEM_H  = 28
            local PAD     = 6
            local MAX_VIS = 7
            local visible = math.min(optionCount, MAX_VIS)
            local listH   = math.max(visible * ITEM_H + math.max(visible - 1, 0) * 2, ITEM_H)
            local searchH = useSearch and 32 or 0
            local popH    = listH + PAD * 2 + searchH
            local popW    = math.max(btn.AbsoluteSize.X, 175)

            local vp = sg.AbsoluteSize
            if vp.X == 0 then
                local cam = workspace.CurrentCamera
                vp = cam and cam.ViewportSize or Vector2.new(1280, 720)
            end
            local bPos  = btn.AbsolutePosition
            local bSize = btn.AbsoluteSize

            local px = bPos.X + bSize.X - popW
            local py = bPos.Y + bSize.Y + 4
            if px < 8 then px = 8 end
            if px + popW > vp.X - 8 then px = vp.X - popW - 8 end
            if py + popH > vp.Y - 8 then
                py = bPos.Y - popH - 4
                if py < 8 then py = 8 end
            end
            popup.Position = UDim2.fromOffset(px, py)
            popup.Size     = UDim2.fromOffset(popW, popH)

            searchBoxRef = nil
            if useSearch then
                local searchWrap = Instance.new("Frame")
                searchWrap.BackgroundColor3 = Color3.fromRGB(22,22,22)
                searchWrap.BorderSizePixel = 0
                searchWrap.Position = UDim2.fromOffset(PAD, PAD)
                searchWrap.Size = UDim2.new(1, -PAD * 2, 0, 26)
                searchWrap.ZIndex = 11
                searchWrap.Parent = popup
                corner(searchWrap, 5)

                local searchBox = Instance.new("TextBox")
                searchBox.BackgroundTransparency = 1
                searchBox.Text = ""
                searchBox.PlaceholderText = "Search..."
                searchBox.PlaceholderColor3 = Color3.fromRGB(120,120,120)
                searchBox.TextColor3 = Color3.fromRGB(230,230,230)
                searchBox.TextSize = 11
                searchBox.Font = Enum.Font.Gotham
                searchBox.TextXAlignment = Enum.TextXAlignment.Left
                searchBox.ClearTextOnFocus = false
                searchBox.Position = UDim2.new(0, 10, 0, 0)
                searchBox.Size = UDim2.new(1, -18, 1, 0)
                searchBox.ZIndex = 12
                searchBox.Parent = searchWrap
                searchBoxRef = searchBox
            end

            local listFrame = Instance.new("ScrollingFrame")
            listFrame.BackgroundTransparency = 1
            listFrame.BorderSizePixel = 0
            listFrame.Position = UDim2.fromOffset(PAD, PAD + searchH)
            listFrame.Size = UDim2.new(1, -PAD * 2, 1, -(PAD * 2) - searchH)
            listFrame.CanvasSize = UDim2.new()
            listFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
            listFrame.ScrollBarThickness = 2
            listFrame.ScrollBarImageColor3 = Color3.fromRGB(100,100,100)
            listFrame.ZIndex = 11
            listFrame.Parent = popup

            local listLayout = Instance.new("UIListLayout")
            listLayout.Padding = UDim.new(0, 2)
            listLayout.SortOrder = Enum.SortOrder.LayoutOrder
            listLayout.Parent = listFrame

            optionMeta = {}

            for i, v in ipairs(options) do
                local opt = Instance.new("TextButton")
                opt.Name = "Opt_" .. tostring(i)
                opt.Text = "   " .. tostring(v)
                opt.BackgroundColor3 = Color3.fromRGB(20,20,20)
                opt.TextColor3 = Color3.fromRGB(200,200,200)
                opt.TextSize = 11
                opt.Font = Enum.Font.GothamMedium
                opt.TextXAlignment = Enum.TextXAlignment.Left
                opt.TextTruncate = Enum.TextTruncate.AtEnd
                opt.AutoButtonColor = false
                opt.Size = UDim2.new(1, 0, 0, ITEM_H)
                opt.LayoutOrder = i
                opt.ZIndex = 12
                opt.Parent = listFrame
                corner(opt, 5)

                local accent = Instance.new("Frame")
                accent.AnchorPoint = Vector2.new(0, 0.5)
                accent.Position = UDim2.new(0, 4, 0.5, 0)
                accent.Size = UDim2.fromOffset(2, 14)
                accent.BackgroundColor3 = Color3.fromRGB(255,255,255)
                accent.BackgroundTransparency = 1
                accent.BorderSizePixel = 0
                accent.ZIndex = 13
                accent.Parent = opt
                corner(accent, 1)

                local check, dot = nil, nil
                if o.Multi then
                    check = Instance.new("TextLabel")
                    check.BackgroundTransparency = 1
                    check.Text = "✓"
                    check.TextColor3 = Color3.fromRGB(255,255,255)
                    check.TextSize = 13
                    check.Font = Enum.Font.GothamBold
                    check.AnchorPoint = Vector2.new(1, 0.5)
                    check.Position = UDim2.new(1, -10, 0.5, 0)
                    check.Size = UDim2.fromOffset(16, 16)
                    check.TextTransparency = 1
                    check.ZIndex = 13
                    check.Parent = opt
                else
                    dot = Instance.new("Frame")
                    dot.AnchorPoint = Vector2.new(1, 0.5)
                    dot.Position = UDim2.new(1, -12, 0.5, 0)
                    dot.Size = UDim2.fromOffset(5, 5)
                    dot.BackgroundColor3 = Color3.fromRGB(255,255,255)
                    dot.BackgroundTransparency = 1
                    dot.BorderSizePixel = 0
                    dot.ZIndex = 13
                    dot.Parent = opt
                    corner(dot, 3)
                end

                optionMeta[opt] = { Accent = accent, Check = check, Dot = dot, Value = v }

                opt.MouseEnter:Connect(function()
                    if not isSelected(v) then
                        TweenService:Create(opt, TweenInfo.new(0.12), { BackgroundColor3 = Color3.fromRGB(30,30,30) }):Play()
                    end
                end)
                opt.MouseLeave:Connect(function()
                    if not isSelected(v) then
                        TweenService:Create(opt, TweenInfo.new(0.12), { BackgroundColor3 = Color3.fromRGB(20,20,20) }):Play()
                    end
                end)
                opt.MouseButton1Click:Connect(function()
                    if o.Multi then
                        if multiValues[v] then multiValues[v] = nil
                        else multiValues[v] = true end
                        refreshButton()
                        refreshOptionStates()
                        fireCallback()
                    else
                        val = v
                        refreshButton()
                        refreshOptionStates()
                        fireCallback()
                        closePopup()
                    end
                end)
            end

            if searchBoxRef then
                searchBoxRef:GetPropertyChangedSignal("Text"):Connect(function()
                    local term = string.lower(searchBoxRef.Text or "")
                    for opt, meta in pairs(optionMeta) do
                        if opt.Parent then
                            local match = term == "" or string.find(string.lower(tostring(meta.Value)), term, 1, true) ~= nil
                            opt.Visible = match
                        end
                    end
                end)
            end

            refreshOptionStates()

            TweenService:Create(popup, TweenInfo.new(0.18, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                BackgroundTransparency = 0,
            }):Play()
            TweenService:Create(popupStroke, TweenInfo.new(0.18), { Transparency = 0.4 }):Play()
            TweenService:Create(chevron, TweenInfo.new(0.22), { Rotation = 180 }):Play()
            TweenService:Create(btn, TweenInfo.new(0.15), { BackgroundColor3 = Color3.fromRGB(34,34,34) }):Play()
            TweenService:Create(btnStroke, TweenInfo.new(0.15), { Color = Color3.fromRGB(120,120,120) }):Play()

            ActiveDropdownPopups[btn] = closePopup
        end

        btn.MouseButton1Click:Connect(function()
            if popup and popup.Parent then closePopup()
            else buildPopup() end
        end)

        UserInputService.InputBegan:Connect(function(input, gp)
            if gp then return end
            if not (popup and popup.Parent) then return end
            if input.UserInputType ~= Enum.UserInputType.MouseButton1
               and input.UserInputType ~= Enum.UserInputType.Touch then return end
            local mp   = input.Position
            local bPos = btn.AbsolutePosition
            local bSz  = btn.AbsoluteSize
            local pPos = popup.AbsolutePosition
            local pSz  = popup.AbsoluteSize
            local inBtn = mp.X >= bPos.X and mp.X <= bPos.X + bSz.X and mp.Y >= bPos.Y and mp.Y <= bPos.Y + bSz.Y
            local inPop = mp.X >= pPos.X and mp.X <= pPos.X + pSz.X and mp.Y >= pPos.Y and mp.Y <= pPos.Y + pSz.Y
            if not inBtn and not inPop then closePopup() end
        end)

        refreshButton()
        ConfigData[flag] = o.Multi and multiValues or val

        local obj = {}
        function obj:Set(v, silent)
            if o.Multi then
                multiValues = {}
                if type(v) == "table" then
                    for k, mv in pairs(v) do
                        if type(k) == "string" then multiValues[k] = mv
                        elseif type(mv) == "string" then multiValues[mv] = true end
                    end
                end
            else
                val = v
            end
            refreshButton()
            ConfigData[flag] = o.Multi and multiValues or val
            if not silent then fireCallback() end
        end
        function obj:Get()
            if o.Multi then return multiValues end
            return val
        end
        function obj:SetValues(list, selected, silent)
            o.Options = list or {}
            if selected ~= nil then
                if o.Multi then
                    multiValues = {}
                    if type(selected) == "table" then
                        for k, v in pairs(selected) do
                            if type(k) == "string" then multiValues[k] = v
                            elseif type(v) == "string" then multiValues[v] = true end
                        end
                    end
                else
                    val = selected
                end
            end
            refreshButton()
            if not silent then fireCallback() end
        end
        obj.Flag = flag
        Elements[flag] = obj
        return obj
    end

    local function addInput(sec,o)
        local r=row(sec.Body,56)
        local t=label(r,o.Title,10,Color3.fromRGB(235,235,235),true)
        t.Position=UDim2.new(0,11,0,5); t.Size=UDim2.new(1,-22,0,16)
        local b=Instance.new("TextBox"); b.ClearTextOnFocus=false
        b.Text=tostring(o.Default or ""); b.PlaceholderText=o.Placeholder or ""
        b.TextColor3=Color3.fromRGB(240,240,240); b.PlaceholderColor3=Color3.fromRGB(100,100,100)
        b.TextSize=10; b.Font=Enum.Font.Gotham; b.BackgroundColor3=Color3.fromRGB(30,30,30)
        b.Position=UDim2.new(0,9,0,25); b.Size=UDim2.new(1,-18,0,25)
        b.Parent=r; corner(b,5); stroke(b,Color3.fromRGB(55,55,55))
        local flag = o.Flag or MakeFlag(sec, o.Title)
        b.FocusLost:Connect(function()
            ConfigData[flag] = b.Text
            if o.Callback then pcall(o.Callback,b.Text) end
        end)
        local obj = {
            Set = function(_,v,s)
                b.Text = tostring(v or "")
                ConfigData[flag] = b.Text
                if not s and o.Callback then pcall(o.Callback, b.Text) end
            end,
            Get = function() return b.Text end,
            Flag = flag
        }
        Elements[flag] = obj
        return obj
    end

    local function addKeybind(sec,o)
        local r=row(sec.Body,45)
        local t=label(r,o.Title,11,Color3.fromRGB(245,245,245),true)
        t.Position=UDim2.new(0,11,0,0); t.Size=UDim2.new(1,-105,1,0)
        local b=Instance.new("TextButton")
        b.Text=o.Default and o.Default.Name or "None"; b.AutoButtonColor=false
        b.BackgroundColor3=Color3.fromRGB(30,30,30); b.TextColor3=Color3.fromRGB(225,225,225)
        b.TextSize=10; b.Font=Enum.Font.GothamMedium
        b.Position=UDim2.new(1,-94,0,6); b.Size=UDim2.fromOffset(84,33)
        b.Parent=r; corner(b,7); stroke(b,Color3.fromRGB(55,55,55))
        local key=o.Default
        local flag = o.Flag or MakeFlag(sec, o.Title)
        b.MouseButton1Click:Connect(function()
            b.Text="Press key..."
            local c
            c=UserInputService.InputBegan:Connect(function(i,gp)
                if gp then return end
                if i.UserInputType==Enum.UserInputType.Keyboard then
                    key=i.KeyCode
                    b.Text=key.Name
                    ConfigData[flag] = key.Name
                    c:Disconnect()
                    if o.Callback then pcall(o.Callback,key) end
                end
            end)
        end)
        local obj = {
            Set = function(_,v,s)
                if type(v) == "string" then
                    if v == "None" or v == "" then key = nil
                    else key = Enum.KeyCode[v] end
                else
                    key = v
                end
                b.Text = key and key.Name or "None"
                ConfigData[flag] = key and key.Name or "None"
                if not s and o.Callback then pcall(o.Callback, key) end
            end,
            Get = function() return key end,
            Flag = flag
        }
        Elements[flag] = obj
        return obj
    end

    local function addParagraph(sec,o)
        local r=row(sec.Body,62)
        local t=label(r,o.Title or "Info",11,Color3.fromRGB(245,245,245),true)
        t.Position=UDim2.new(0,11,0,7); t.Size=UDim2.new(1,-22,0,18)
        local c=label(r,o.Content or "",9,Color3.fromRGB(150,150,150))
        c.Position=UDim2.new(0,11,0,28); c.Size=UDim2.new(1,-22,0,28); c.TextWrapped=true
        return r
    end

    --====================================================--
    -- SECTION (GROUPBOX STYLE) — DEFAULT COLLAPSED
    --====================================================--
    local function section(tab, name)
        local card = Instance.new("Frame")
        card.Name = "Section_" .. tostring(name)
        card.BackgroundColor3 = Color3.fromRGB(11, 11, 11)
        card.BorderSizePixel = 0
        card.Size = UDim2.new(1, -2, 0, 0)
        card.AutomaticSize = Enum.AutomaticSize.Y
        card.ClipsDescendants = false
        card.Parent = tab.Page
        corner(card, 10)

        local cardStroke = Instance.new("UIStroke")
        cardStroke.Name = "SectionStroke"
        cardStroke.Color = Color3.fromRGB(45, 45, 45)
        cardStroke.Thickness = 1
        cardStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        cardStroke.Parent = card

        local header = Instance.new("Frame")
        header.Name = "Header"
        header.BackgroundTransparency = 1
        header.Position = UDim2.new(0, 0, 0, 0)
        header.Size = UDim2.new(1, 0, 0, 36)
        header.Parent = card

        local dotGlow = Instance.new("Frame")
        dotGlow.Name = "AccentDotGlow"
        dotGlow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        dotGlow.BackgroundTransparency = 0.85
        dotGlow.BorderSizePixel = 0
        dotGlow.Size = UDim2.fromOffset(14, 14)
        dotGlow.Position = UDim2.new(0, 8, 0.5, -7)
        dotGlow.ZIndex = 0
        dotGlow.Parent = header
        corner(dotGlow, 7)

        local dot = Instance.new("Frame")
        dot.Name = "AccentDot"
        dot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        dot.BorderSizePixel = 0
        dot.Size = UDim2.fromOffset(6, 6)
        dot.Position = UDim2.new(0, 12, 0.5, -3)
        dot.Parent = header
        corner(dot, 3)

        local title = Instance.new("TextLabel")
        title.Name = "Title"
        title.BackgroundTransparency = 1
        title.Text = string.upper(tostring(name or "Section"))
        title.TextColor3 = Color3.fromRGB(245, 245, 245)
        title.TextSize = 11
        title.Font = Enum.Font.GothamBold
        title.TextXAlignment = Enum.TextXAlignment.Left
        title.Position = UDim2.new(0, 28, 0, 0)
        title.Size = UDim2.new(1, -60, 1, 0)
        title.Parent = header

        local collapseBtn = Instance.new("TextButton")
        collapseBtn.Name = "CollapseBtn"
        collapseBtn.Text = "+"
        collapseBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
        collapseBtn.TextSize = 15
        collapseBtn.Font = Enum.Font.GothamBold
        collapseBtn.BackgroundTransparency = 1
        collapseBtn.AutoButtonColor = false
        collapseBtn.AnchorPoint = Vector2.new(1, 0.5)
        collapseBtn.Position = UDim2.new(1, -10, 0.5, 0)
        collapseBtn.Size = UDim2.fromOffset(22, 22)
        collapseBtn.Parent = header

        local divider = Instance.new("Frame")
        divider.Name = "Divider"
        divider.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
        divider.BorderSizePixel = 0
        divider.Position = UDim2.new(0, 0, 0, 36)
        divider.Size = UDim2.new(1, 0, 0, 1)
        divider.Parent = card

        local body = Instance.new("Frame")
        body.Name = "Body"
        body.BackgroundTransparency = 1
        body.Position = UDim2.new(0, 10, 0, 46)
        body.Size = UDim2.new(1, -20, 0, 0)
        body.AutomaticSize = Enum.AutomaticSize.Y
        body.Parent = card

        local layout = Instance.new("UIListLayout")
        layout.Padding = UDim.new(0, 6)
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Parent = body

        local pad = Instance.new("UIPadding")
        pad.PaddingBottom = UDim.new(0, 10)
        pad.Parent = body

        local collapsed = true
        local function toggleCollapse()
            collapsed = not collapsed
            body.Visible = not collapsed
            divider.Visible = not collapsed
            dotGlow.Visible = not collapsed
            collapseBtn.Text = collapsed and "+" or "−"
            pcall(function()
                TweenService:Create(collapseBtn, TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Rotation = collapsed and 0 or 180
                }):Play()
            end)
        end
        collapseBtn.MouseButton1Click:Connect(toggleCollapse)

        body.Visible = false
        divider.Visible = false
        dotGlow.Visible = false
        collapseBtn.Text = "+"
        collapseBtn.Rotation = 0

        local s = { Body = body, Root = card, Header = header, Collapsed = collapsed }
        s.AddToggle = addToggle
        s.AddButton = addButton
        s.AddSlider = addSlider
        s.AddDropdown = addDropdown
        s.AddInput = addInput
        s.AddKeybind = addKeybind
        s.AddColorPicker = addColor
        s.AddParagraph = addParagraph
        s._tabName = tab and tab._name
        s._tabPage = tab and tab.Page
        s._sectionName = name
        s._expand = function() if collapsed then toggleCollapse() end end
        return s
    end

    function UILib:Window(cfg)
        local safeParent = SafeGuiParent()
        local gui=Instance.new("ScreenGui"); gui.Name="PromersCustomUI"; gui.ResetOnSpawn=false; gui.IgnoreGuiInset=true; gui.DisplayOrder=999999; gui.Parent=safeParent
        local main=Instance.new("Frame"); main.Name="Main"; main.AnchorPoint=Vector2.new(.5,.5); main.Position=UDim2.fromScale(.5,.5); main.Size=UDim2.fromOffset(620,440); main.BackgroundColor3=Color3.fromRGB(5,5,5); main.BorderSizePixel=0; main.Active=true; main.Parent=gui; corner(main,12); stroke(main,Color3.fromRGB(65,65,65))
        local top=Instance.new("Frame"); top.BackgroundColor3=Color3.fromRGB(12,12,12); top.BorderSizePixel=0; top.Size=UDim2.new(1,0,0,56); top.Parent=main; corner(top,12)
        local logo=Instance.new("ImageLabel"); logo.BackgroundTransparency=1; logo.Image="rbxassetid://118748055443363"; logo.Size=UDim2.fromOffset(38,38); logo.Position=UDim2.new(0,12,0,9); logo.Parent=top
        local title=label(top,cfg.Title or "Promers Hub",15,Color3.fromRGB(255,255,255),true); title.Position=UDim2.new(0,58,0,9); title.Size=UDim2.new(1,-145,0,20)
        local sub=label(top,cfg.Footer or "Violence District",9,Color3.fromRGB(145,145,145)); sub.Position=UDim2.new(0,58,0,30); sub.Size=UDim2.new(1,-145,0,16)
        local premiumBadge = Instance.new("Frame")
        premiumBadge.Name = "PremiumBadge"
        premiumBadge.AnchorPoint = Vector2.new(1, 0.5)
        premiumBadge.Position = UDim2.new(1, -88, 0.5, 0)
        premiumBadge.Size = UDim2.fromOffset(78, 22)
        premiumBadge.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        premiumBadge.BorderSizePixel = 0
        premiumBadge.Parent = top
        corner(premiumBadge, 11)

        local badgeStroke = Instance.new("UIStroke")
        badgeStroke.Color = Color3.fromRGB(255, 255, 255)
        badgeStroke.Thickness = 1
        badgeStroke.Transparency = 0.25
        badgeStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        badgeStroke.Parent = premiumBadge

        local badgeLabel = Instance.new("TextLabel")
        badgeLabel.BackgroundTransparency = 1
        badgeLabel.Size = UDim2.fromScale(1, 1)
        badgeLabel.Text = "✦ PREMIUM"
        badgeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        badgeLabel.TextSize = 10
        badgeLabel.Font = Enum.Font.GothamBold
        badgeLabel.TextXAlignment = Enum.TextXAlignment.Center
        badgeLabel.Parent = premiumBadge

        task.spawn(function()
            while premiumBadge.Parent do
                TweenService:Create(badgeStroke, TweenInfo.new(1.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    Transparency = 0.7
                }):Play()
                task.wait(1.4)
                if not premiumBadge.Parent then break end
                TweenService:Create(badgeStroke, TweenInfo.new(1.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    Transparency = 0.15
                }):Play()
                task.wait(1.4)
            end
        end)

        local close=Instance.new("TextButton"); close.Text="×"; close.TextSize=18; close.Font=Enum.Font.GothamBold; close.TextColor3=Color3.fromRGB(235,235,235); close.BackgroundColor3=Color3.fromRGB(28,28,28); close.AutoButtonColor=false; close.Position=UDim2.new(1,-44,0,12); close.Size=UDim2.fromOffset(30,32); close.Parent=top; corner(close,7)
        local mini=Instance.new("TextButton"); mini.Text="—"; mini.TextSize=16; mini.Font=Enum.Font.GothamBold; mini.TextColor3=Color3.fromRGB(235,235,235); mini.BackgroundColor3=Color3.fromRGB(28,28,28); mini.AutoButtonColor=false; mini.Position=UDim2.new(1,-80,0,12); mini.Size=UDim2.fromOffset(30,32); mini.Parent=top; corner(mini,7)
        local side=Instance.new("Frame"); side.BackgroundColor3=Color3.fromRGB(8,8,8); side.BorderSizePixel=0; side.Position=UDim2.new(0,0,0,56); side.Size=UDim2.new(0,130,1,-56); side.Parent=main
        local tl=Instance.new("UIListLayout"); tl.Padding=UDim.new(0,6); tl.Parent=side
        local pad=Instance.new("UIPadding"); pad.PaddingTop=UDim.new(0,12); pad.PaddingLeft=UDim.new(0,9); pad.PaddingRight=UDim.new(0,9); pad.Parent=side
        local content=Instance.new("Frame"); content.BackgroundTransparency=1; content.Position=UDim2.new(0,130,0,56); content.Size=UDim2.new(1,-130,1,-56); content.Parent=main
        local tabs={}; local win={Gui=gui,Main=main}
        local float=Instance.new("ImageButton"); float.Name="FloatingOpenButton"; float.Image="rbxassetid://118748055443363"; float.BackgroundColor3=Color3.fromRGB(10,10,10); float.Size=UDim2.fromOffset(58,58); float.Position=UDim2.new(1,-78,0,105); float.AutoButtonColor=false; float.Visible=false; float.Parent=gui; corner(float,13); stroke(float,Color3.fromRGB(255,255,255),1.3)
        local drag=false; local ds,dp
        top.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then drag=true; ds=i.Position; dp=main.Position end end)
        UserInputService.InputChanged:Connect(function(i) if drag and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then local d=i.Position-ds; main.Position=UDim2.new(dp.X.Scale,dp.X.Offset+d.X,dp.Y.Scale,dp.Y.Offset+d.Y) end end)
        UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then drag=false end end)
        local fdrag=false; local fds,fdp
        float.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then fdrag=true; fds=i.Position; fdp=float.Position end end)
        UserInputService.InputChanged:Connect(function(i) if fdrag and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then local d=i.Position-fds; float.Position=UDim2.new(fdp.X.Scale,fdp.X.Offset+d.X,fdp.Y.Scale,fdp.Y.Offset+d.Y) end end)
        UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then fdrag=false end end)
        local function hide() main.Visible=false; float.Visible=true end
        local function show() main.Visible=true; float.Visible=false end
        mini.MouseButton1Click:Connect(hide); close.MouseButton1Click:Connect(hide); float.MouseButton1Click:Connect(show)
        task.spawn(function()
            local cam = Workspace.CurrentCamera
            local function adapt()
                if not cam then return end
                local vp = cam.ViewportSize
                if vp.X < 720 then
                    local w = math.clamp(vp.X - 40, 400, 620)
                    local h = math.clamp(vp.Y - 80, 320, 440)
                    main.Size = UDim2.fromOffset(w, h)
                else
                    main.Size = UDim2.fromOffset(620, 440)
                end
            end
            adapt()
            if cam then cam:GetPropertyChangedSignal("ViewportSize"):Connect(adapt) end
        end)
        local current
        local function select(n) current=n; for k,v in pairs(tabs) do v.Button.BackgroundColor3=(k==n and Color3.fromRGB(40,40,40) or Color3.fromRGB(13,13,13)); v.Page.Visible=(k==n) end end
        function win:AddTab(o)
            local name=o.Name
            local b=Instance.new("TextButton"); b.Text=name; b.BackgroundColor3=Color3.fromRGB(13,13,13); b.TextColor3=Color3.fromRGB(155,155,155); b.TextSize=11; b.Font=Enum.Font.GothamMedium; b.AutoButtonColor=false; b.Size=UDim2.new(1,0,0,36); b.Parent=side; corner(b,7)
            local p=Instance.new("ScrollingFrame"); p.BackgroundTransparency=1; p.BorderSizePixel=0; p.Position=UDim2.new(0,12,0,12); p.Size=UDim2.new(1,-24,1,-24); p.ScrollBarThickness=3; p.CanvasSize=UDim2.new(); p.AutomaticCanvasSize=Enum.AutomaticSize.Y; p.Visible=false; p.Parent=content
            local l=Instance.new("UIListLayout"); l.Padding=UDim.new(0,10); l.Parent=p
            local page={Page=p, _name=name}
            function page:AddSection(n) return section(page,n) end
            tabs[name]={Button=b,Page=p}
            b.MouseButton1Click:Connect(function() select(name) end)
            return page
        end
        function win:InfoTab(o)
            local p=self:AddTab({Name=o.Name or "Information"})
            local ban=Instance.new("ImageLabel"); ban.Image=o.Banner or "rbxassetid://124361049319609"; ban.ScaleType=Enum.ScaleType.Crop; ban.BackgroundColor3=Color3.fromRGB(12,12,12); ban.Size=UDim2.new(1,0,0,140); ban.Parent=p.Page; corner(ban,9); stroke(ban,Color3.fromRGB(55,55,55))
            local ov=Instance.new("Frame"); ov.BackgroundColor3=Color3.new(0,0,0); ov.BackgroundTransparency=.38; ov.Size=UDim2.fromScale(1,1); ov.Parent=ban; corner(ov,9)
            local a=label(ov,o.SectionTitle or "Information",18,Color3.new(1,1,1),true); a.Position=UDim2.new(0,15,0,52); a.Size=UDim2.new(1,-30,0,28)
            local v=label(ov,o.Version or "",10,Color3.fromRGB(205,205,205)); v.Position=UDim2.new(0,15,0,82); v.Size=UDim2.new(1,-30,0,18)
            for _,c in ipairs(o.Cards or {}) do local s=section(p,c.Title or "Info"); addParagraph(s,{Title=c.Title,Content=c.Description}) end
            return p
        end
        function win:Notify(o)
            local h=gui:FindFirstChild("Notifications") or Instance.new("Frame")
            h.Name="Notifications"; h.BackgroundTransparency=1; h.AnchorPoint=Vector2.new(1,1); h.Position=UDim2.new(1,-15,1,-15); h.Size=UDim2.fromOffset(310,360); h.Parent=gui
            if not h:FindFirstChildOfClass("UIListLayout") then
                local l=Instance.new("UIListLayout"); l.VerticalAlignment=Enum.VerticalAlignment.Bottom; l.HorizontalAlignment=Enum.HorizontalAlignment.Right; l.Padding=UDim.new(0,6); l.Parent=h
            end
            local r=row(h,62)
            local a=label(r,o.Title or "Promers",12,Color3.new(1,1,1),true); a.Position=UDim2.new(0,10,0,7); a.Size=UDim2.new(1,-20,0,18)
            local b=label(r,o.Content or "",10,Color3.fromRGB(165,165,165)); b.Position=UDim2.new(0,10,0,28); b.Size=UDim2.new(1,-20,0,25); b.TextWrapped=true
            task.delay(o.Delay or o.Time or 2,function() if r.Parent then r:Destroy() end end)
        end

        --====================
        -- TOPBAR SEARCH
        --====================
        do
            local searchBox = Instance.new("Frame")
            searchBox.Name = "SearchBox"
            searchBox.AnchorPoint = Vector2.new(1, 0.5)
            searchBox.Position = UDim2.new(1, -174, 0.5, 0)
            searchBox.Size = UDim2.fromOffset(130, 28)
            searchBox.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
            searchBox.BorderSizePixel = 0
            searchBox.Parent = top
            corner(searchBox, 6)

            local searchStroke = Instance.new("UIStroke")
            searchStroke.Color = Color3.fromRGB(50, 50, 50)
            searchStroke.Thickness = 1
            searchStroke.Transparency = 0.3
            searchStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            searchStroke.Parent = searchBox

            local searchIcon = Instance.new("TextLabel")
            searchIcon.BackgroundTransparency = 1
            searchIcon.Text = "•"
            searchIcon.TextColor3 = Color3.fromRGB(140, 140, 140)
            searchIcon.TextSize = 16
            searchIcon.Font = Enum.Font.GothamBold
            searchIcon.Position = UDim2.new(0, 5, 0, 0)
            searchIcon.Size = UDim2.fromOffset(16, 28)
            searchIcon.Parent = searchBox

            local searchInput = Instance.new("TextBox")
            searchInput.BackgroundTransparency = 1
            searchInput.Text = ""
            searchInput.PlaceholderText = "Search..."
            searchInput.PlaceholderColor3 = Color3.fromRGB(110, 110, 110)
            searchInput.TextColor3 = Color3.fromRGB(235, 235, 235)
            searchInput.TextSize = 10
            searchInput.Font = Enum.Font.Gotham
            searchInput.TextXAlignment = Enum.TextXAlignment.Left
            searchInput.ClearTextOnFocus = false
            searchInput.Position = UDim2.new(0, 22, 0, 0)
            searchInput.Size = UDim2.new(1, -28, 1, 0)
            searchInput.Parent = searchBox

            local resultGui = nil
            local ActiveCloser = nil

            local function closeResult()
                if resultGui and resultGui.Parent then
                    local g = resultGui
                    resultGui = nil
                    pcall(function() g:Destroy() end)
                end
                ActiveCloser = nil
            end

            local function scanAllItems()
                local items = {}
                for tabName, tabData in pairs(tabs) do
                    local page = tabData.Page
                    if page then
                        for _, sectionFrame in ipairs(page:GetChildren()) do
                            if sectionFrame:IsA("Frame") and sectionFrame.Name:sub(1, 8) == "Section_" then
                                local header = sectionFrame:FindFirstChild("Header")
                                local secTitleLbl = header and header:FindFirstChild("Title")
                                local sectionName = secTitleLbl and secTitleLbl.Text or "Section"
                                local body = sectionFrame:FindFirstChild("Body")
                                if body then
                                    for _, itemFrame in ipairs(body:GetChildren()) do
                                        if itemFrame:IsA("Frame") then
                                            local titleLbl = nil
                                            for _, c in ipairs(itemFrame:GetChildren()) do
                                                if c:IsA("TextLabel")
                                                   and c.Font == Enum.Font.GothamBold
                                                   and (c.TextSize == 10 or c.TextSize == 11)
                                                   and c.Text ~= "" then
                                                    titleLbl = c; break
                                                end
                                            end
                                            if titleLbl then
                                                table.insert(items, {
                                                    Name = titleLbl.Text,
                                                    Frame = itemFrame,
                                                    SectionFrame = sectionFrame,
                                                    SectionName = sectionName,
                                                    TabName = tabName,
                                                })
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                return items
            end

            local function navigateTo(entry)
                closeResult()
                searchInput.Text = ""

                if entry.TabName and tabs[entry.TabName] and select then
                    pcall(select, entry.TabName)
                end

                task.defer(function()
                    local header = entry.SectionFrame:FindFirstChild("Header")
                    local body = entry.SectionFrame:FindFirstChild("Body")
                    if body and not body.Visible and header then
                        local collapseBtn = header:FindFirstChild("CollapseBtn")
                        if collapseBtn and firesignal then
                            pcall(firesignal, collapseBtn.MouseButton1Click)
                        end
                    end

                    task.wait(0.08)

                    local page = tabs[entry.TabName] and tabs[entry.TabName].Page
                    if page and entry.Frame then
                        local frameY = entry.Frame.AbsolutePosition.Y - page.AbsolutePosition.Y + page.CanvasPosition.Y
                        local target = math.max(0, frameY - 60)
                        TweenService:Create(page, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                            CanvasPosition = Vector2.new(page.CanvasPosition.X, target)
                        }):Play()
                    end

                    if entry.Frame then
                        local origColor = entry.Frame.BackgroundColor3
                        entry.Frame.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
                        TweenService:Create(entry.Frame, TweenInfo.new(0.9, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                            BackgroundColor3 = origColor,
                        }):Play()
                    end
                end)
            end

            local function buildResult(results)
                closeResult()
                if #results == 0 then return end

                local parent = SafeGuiParent()
                if not parent then return end

                local sg = Instance.new("ScreenGui")
                sg.Name = "GlutoSearchPopup"
                sg.ResetOnSpawn = false
                sg.IgnoreGuiInset = true
                sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                sg.DisplayOrder = 1000002
                sg.Parent = parent
                resultGui = sg

                local frame = Instance.new("Frame")
                frame.Name = "Panel"
                frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
                frame.BackgroundTransparency = 1
                frame.BorderSizePixel = 0
                frame.Parent = sg
                corner(frame, 8)

                local fStroke = Instance.new("UIStroke")
                fStroke.Color = Color3.fromRGB(55, 55, 55)
                fStroke.Thickness = 1
                fStroke.Transparency = 0.3
                fStroke.Parent = frame

                local ITEM_H = 40
                local MAX_SHOW = 8
                local showCount = math.min(#results, MAX_SHOW)
                local popH = showCount * ITEM_H + 12
                local popW = 300

                local absPos = searchBox.AbsolutePosition
                local absSize = searchBox.AbsoluteSize
                local vp = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1280, 720)

                local px = absPos.X + absSize.X - popW
                local py = absPos.Y + absSize.Y + 6
                if px < 8 then px = 8 end
                if px + popW > vp.X - 8 then px = vp.X - popW - 8 end
                if py + popH > vp.Y - 8 then py = absPos.Y - popH - 6 end
                frame.Position = UDim2.fromOffset(px, py)
                frame.Size = UDim2.fromOffset(popW, popH)

                local listFrame = Instance.new("ScrollingFrame")
                listFrame.BackgroundTransparency = 1
                listFrame.BorderSizePixel = 0
                listFrame.Position = UDim2.fromOffset(6, 6)
                listFrame.Size = UDim2.new(1, -12, 1, -12)
                listFrame.CanvasSize = UDim2.new()
                listFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
                listFrame.ScrollBarThickness = 2
                listFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
                listFrame.Parent = frame

                local listLayout = Instance.new("UIListLayout")
                listLayout.Padding = UDim.new(0, 2)
                listLayout.SortOrder = Enum.SortOrder.LayoutOrder
                listLayout.Parent = listFrame

                for i, entry in ipairs(results) do
                    local opt = Instance.new("TextButton")
                    opt.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                    opt.Text = ""
                    opt.AutoButtonColor = false
                    opt.Size = UDim2.new(1, 0, 0, ITEM_H - 2)
                    opt.LayoutOrder = i
                    opt.Parent = listFrame
                    corner(opt, 5)

                    local nameLbl = Instance.new("TextLabel")
                    nameLbl.BackgroundTransparency = 1
                    nameLbl.Text = entry.Name
                    nameLbl.TextColor3 = Color3.fromRGB(235, 235, 235)
                    nameLbl.TextSize = 11
                    nameLbl.Font = Enum.Font.GothamBold
                    nameLbl.TextXAlignment = Enum.TextXAlignment.Left
                    nameLbl.TextTruncate = Enum.TextTruncate.AtEnd
                    nameLbl.Position = UDim2.new(0, 12, 0, 5)
                    nameLbl.Size = UDim2.new(1, -24, 0, 14)
                    nameLbl.Parent = opt

                    local pathLbl = Instance.new("TextLabel")
                    pathLbl.BackgroundTransparency = 1
                    pathLbl.Text = entry.TabName .. " › " .. tostring(entry.SectionName)
                    pathLbl.TextColor3 = Color3.fromRGB(140, 140, 140)
                    pathLbl.TextSize = 9
                    pathLbl.Font = Enum.Font.Gotham
                    pathLbl.TextXAlignment = Enum.TextXAlignment.Left
                    pathLbl.TextTruncate = Enum.TextTruncate.AtEnd
                    pathLbl.Position = UDim2.new(0, 12, 0, 21)
                    pathLbl.Size = UDim2.new(1, -24, 0, 12)
                    pathLbl.Parent = opt

                    opt.MouseEnter:Connect(function()
                        TweenService:Create(opt, TweenInfo.new(0.12), { BackgroundColor3 = Color3.fromRGB(32, 32, 32) }):Play()
                    end)
                    opt.MouseLeave:Connect(function()
                        TweenService:Create(opt, TweenInfo.new(0.12), { BackgroundColor3 = Color3.fromRGB(20, 20, 20) }):Play()
                    end)
                    opt.MouseButton1Click:Connect(function() navigateTo(entry) end)
                end

                TweenService:Create(frame, TweenInfo.new(0.18), { BackgroundTransparency = 0 }):Play()
                ActiveCloser = closeResult
            end

            local function doSearch()
                local q = string.lower(searchInput.Text or "")
                if q == "" then closeResult(); return end
                local items = scanAllItems()
                local results = {}
                for _, it in ipairs(items) do
                    if string.find(string.lower(it.Name), q, 1, true) then
                        table.insert(results, it)
                    end
                end
                if #results > 0 then buildResult(results) else closeResult() end
            end

            searchInput:GetPropertyChangedSignal("Text"):Connect(doSearch)

            searchInput.Focused:Connect(function()
                TweenService:Create(searchStroke, TweenInfo.new(0.15), { Color = Color3.fromRGB(180, 180, 180), Transparency = 0 }):Play()
            end)
            searchInput.FocusLost:Connect(function()
                TweenService:Create(searchStroke, TweenInfo.new(0.15), { Color = Color3.fromRGB(50, 50, 50), Transparency = 0.3 }):Play()
            end)

            UserInputService.InputBegan:Connect(function(input, gp)
                if gp then return end
                if not ActiveCloser then return end
                if input.UserInputType ~= Enum.UserInputType.MouseButton1
                   and input.UserInputType ~= Enum.UserInputType.Touch then return end
                local mp = input.Position
                local boxPos = searchBox.AbsolutePosition
                local boxSz = searchBox.AbsoluteSize
                local inBox = mp.X >= boxPos.X and mp.X <= boxPos.X + boxSz.X and mp.Y >= boxPos.Y and mp.Y <= boxPos.Y + boxSz.Y
                if not inBox then
                    if resultGui then
                        local panel = resultGui:FindFirstChild("Panel")
                        if panel then
                            local pPos = panel.AbsolutePosition
                            local pSz = panel.AbsoluteSize
                            local inPanel = mp.X >= pPos.X and mp.X <= pPos.X + pSz.X and mp.Y >= pPos.Y and mp.Y <= pPos.Y + pSz.Y
                            if inPanel then return end
                        end
                    end
                    closeResult()
                end
            end)
        end

        _window=win
        return win
    end
    function UILib:MakeNotify(o) if _window then _window:Notify(o) end end

    do
        local function FixText(inst)
            if not inst then return end
            if inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox") then
                local txt = inst.Text
                if txt and (string.find(txt, "Gluto Windows", 1, true) or string.find(txt, "Gluto Window", 1, true)) then
                    pcall(function()
                        inst.Text = txt:gsub("Gluto Windows", "Close Windows"):gsub("Gluto Window", "Close Windows")
                    end)
                end
            end
        end
        local function ScanAndHook(container)
            if not container then return end
            for _, d in ipairs(container:GetDescendants()) do FixText(d) end
            container.DescendantAdded:Connect(FixText)
        end
        ScanAndHook(CoreGui)
        if gethui then
            local hok, hui = pcall(gethui)
            if hok and hui then ScanAndHook(hui) end
        end
        ScanAndHook(LocalPlayer:FindFirstChild("PlayerGui"))
    end

    local NotifyColor = _G.GLUTO_THEME
    W.NotifyEnabled = W.NotifyEnabled ~= false

    local function ShowNotify(title, message, duration)
        if not W.NotifyEnabled then return end
        if not UILib or not UILib.MakeNotify then return end
        pcall(function()
            UILib:MakeNotify({
                Title = title or "Promers", Description = "Info",
                Content = message or "", Color = NotifyColor,
                Time = 0.4, Delay = duration or 2, Icon = "92106934813318"
            })
        end)
    end
    local function VD_Notify(title, content, duration) ShowNotify(title, content, duration) end
    local function ForceNotify(title, message, duration)
        if not UILib or not UILib.MakeNotify then return end
        pcall(function()
            UILib:MakeNotify({
                Title = title or "Promers", Description = "Info",
                Content = message or "", Color = NotifyColor,
                Time = 0.4, Delay = duration or 2, Icon = "92106934813318"
            })
        end)
    end

    local function TeamIs(plr, role)
        if not plr or not plr.Team or not plr.Team.Name then return false end
        local tn = string.lower(plr.Team.Name)
        if role == "Killer" then return string.find(tn, "killer", 1, true) ~= nil end
        if role == "Survivor" then return string.find(tn, "survivor", 1, true) ~= nil end
        return false
    end
    W.TeamIs = TeamIs

    local function GetRole()
        if TeamIs(LocalPlayer, "Killer") then return "Killer" end
        if TeamIs(LocalPlayer, "Survivor") then return "Survivor" end
        return nil
    end
    W.GetRole = GetRole

    W.GB_GetAllGenerators = function()
        local gens = {}
        local mf = Workspace:FindFirstChild("Map")
        if mf then
            for _, obj in ipairs(mf:GetDescendants()) do
                if obj:IsA("Model") and obj.Name == "Generator" then
                    local real = obj:GetAttribute("RepairProgress") ~= nil
                              or obj:GetAttribute("kickcount") ~= nil
                              or obj:GetAttribute("ProgressRepair") ~= nil
                    if real then table.insert(gens, obj) end
                end
            end
        end
        return gens
    end
    W.GB_GetPoints = function(m)
        local pts = {}
        if m then
            for _, o in ipairs(m:GetChildren()) do
                if o:IsA("BasePart") and string.find(o.Name, "GeneratorPoint") then
                    table.insert(pts, o)
                end
            end
        end
        return pts
    end

    function IsDowned(char)
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then return true end
        local state = char:GetAttribute("State")
        return state == "Downed" or state == "Dead"
    end

    function TriggerCrouch()
        local startT = tick()
        task.spawn(function()
            local char = LocalPlayer.Character
            if not char then return end
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            pcall(function() char:SetAttribute("Crouching", true) end)
            pcall(function() ReplicatedStorage.Remotes.Mechanics.ChangeAttribute:FireServer("Crouchingserver", true) end)
            pcall(function() ReplicatedStorage.Remotes.Chase.Runevent:FireServer(char, false) end)
            if humanoid then pcall(function() humanoid:ChangeState(Enum.HumanoidStateType.Landed) end) end
            pcall(function()
                local survMob = LocalPlayer:FindFirstChildOfClass("PlayerGui"):FindFirstChild("Survivor-mob")
                if survMob then
                    local controls = survMob:FindFirstChild("Controls")
                    if controls then
                        local crouchBtn = controls:FindFirstChild("crouch")
                        if crouchBtn then firesignal(crouchBtn.MouseButton1Click) end
                    end
                end
            end)
            while tick() - startT < 1.2 do
                pcall(function() ReplicatedStorage.Remotes.Mechanics.ChangeAttribute:FireServer("Crouchingserver", true) end)
                task.wait(0.1)
            end
            pcall(function() char:SetAttribute("Crouching", false) end)
            pcall(function() ReplicatedStorage.Remotes.Mechanics.ChangeAttribute:FireServer("Crouchingserver", false) end)
            if humanoid then pcall(function() humanoid:ChangeState(Enum.HumanoidStateType.Landed) end) end
            pcall(function()
                local survMob = LocalPlayer:FindFirstChildOfClass("PlayerGui"):FindFirstChild("Survivor-mob")
                if survMob then
                    local controls = survMob:FindFirstChild("Controls")
                    if controls then
                        local crouchBtn = controls:FindFirstChild("crouch")
                        if crouchBtn then firesignal(crouchBtn.MouseButton1Click) end
                    end
                end
            end)
        end)
    end

    local CrouchAttached = {}
    function IsKiller(p) return p.Team and p.Team.Name == "Killer" end

    function AttachCrouchSensor(kChar)
        if not kChar or CrouchAttached[kChar] then return end
        CrouchAttached[kChar] = true
        local humanoid = kChar:FindFirstChild("Humanoid")
        if not humanoid then humanoid = kChar:WaitForChild("Humanoid", 5); if not humanoid then return end end
        local animator = humanoid:FindFirstChildOfClass("Animator")
        if not animator then animator = humanoid:WaitForChild("Animator", 5); if not animator then return end end
        humanoid.ChildAdded:Connect(function(child)
            if child:IsA("Animator") then CrouchAttached[kChar] = nil; AttachCrouchSensor(kChar) end
        end)
        kChar.AncestryChanged:Connect(function(_, parent)
            if not parent then CrouchAttached[kChar] = nil end
        end)
        animator.AnimationPlayed:Connect(function(track)
            local animId = track.Animation and track.Animation.AnimationId or ""
            local id = animId:match("%d+")
            if id == "80411309607666" and VD.AutoCrouch then
                local myChar = LocalPlayer.Character
                if IsDowned(myChar) then return end
                local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
                local kHRP = kChar:FindFirstChild("HumanoidRootPart")
                if myHRP and kHRP then
                    local dist = (myHRP.Position - kHRP.Position).Magnitude
                    if dist <= 40 then TriggerCrouch() end
                end
            end
        end)
    end

    function TryAttachCrouch(p)
        if p ~= LocalPlayer and IsKiller(p) and p.Character then AttachCrouchSensor(p.Character) end
    end
    function SetupCrouchPlayer(p)
        if p == LocalPlayer then return end
        p.CharacterAdded:Connect(function() TryAttachCrouch(p) end)
        p:GetPropertyChangedSignal("Team"):Connect(function() TryAttachCrouch(p) end)
        if p.Character then TryAttachCrouch(p) end
    end
    for _, p in pairs(Players:GetPlayers()) do SetupCrouchPlayer(p) end
    Players.PlayerAdded:Connect(SetupCrouchPlayer)
    task.spawn(function()
        while true do
            task.wait(5)
            for _, p in pairs(Players:GetPlayers()) do TryAttachCrouch(p) end
        end
    end)

    local lastAutoAttack = 0
    function W.KA_AutoAttack()
        if not VD.KILLER_AutoAttack then return end
        if GetRole() ~= "Killer" then return end
        local now = tick()
        if now - lastAutoAttack < (VD.KILLER_AutoAttackCooldown or 0.15) then return end
        local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not root then return end
        local closest, shortest = nil, VD.KILLER_AutoAttackRange or 12
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and TeamIs(plr, "Survivor") and plr.Character then
                local hum = plr.Character:FindFirstChildOfClass("Humanoid")
                local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                if hum and hrp and hum.Health > 35 then
                    local d = (hrp.Position - root.Position).Magnitude
                    if d <= shortest then shortest = d; closest = plr end
                end
            end
        end
        if closest then
            lastAutoAttack = now
            pcall(function()
                local attacks = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("Attacks")
                local basic = attacks and attacks:FindFirstChild("BasicAttack")
                if basic then basic:FireServer(false) end
            end)
        end
    end

    local lastAutoFlee = 0
    function W.SURV_AutoFlee()
        if not VD.SURV_AutoFlee then return end
        if GetRole() ~= "Survivor" then return end
        local now = tick()
        if now - lastAutoFlee < (VD.SURV_AutoFleeCooldown or 1.5) then return end
        local myChar = LocalPlayer.Character
        local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
        local hum = myChar and myChar:FindFirstChildOfClass("Humanoid")
        if not myRoot or not hum or hum.Health <= 0 then return end
        local killerRoot = nil
        local nearest = math.huge
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and TeamIs(plr, "Killer") and plr.Character then
                local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local d = (hrp.Position - myRoot.Position).Magnitude
                    if d < nearest then nearest = d; killerRoot = hrp end
                end
            end
        end
        if not killerRoot then return end
        if nearest > (VD.SURV_AutoFleeDist or 40) then return end
        lastAutoFlee = now
        local bestPt, bestDist = nil, 0
        local mf = Workspace:FindFirstChild("Map")
        if mf then
            for _, obj in ipairs(mf:GetDescendants()) do
                if obj:IsA("BasePart") and string.find(obj.Name, "^GeneratorPoint%d+$") then
                    local d = (obj.Position - killerRoot.Position).Magnitude
                    if d > bestDist then bestDist = d; bestPt = obj end
                end
            end
        end
        if bestPt then
            pcall(function() myRoot.CFrame = bestPt.CFrame + Vector3.new(0, 5, 0) end)
            VD_Notify("Auto Flee", "Teleported away from killer!", 2)
        end
    end

    task.spawn(function()
        while true do
            task.wait(0.1)
            pcall(W.KA_AutoAttack)
            pcall(W.SURV_AutoFlee)
        end
    end)

    local KillerAttackAnims = {
        ["78432063483146"]="attack",["121216847022485"]="attack",["74968262036854"]="attack",
        ["132817836308238"]="attack",["82666958311998"]="attack",["111920872708571"]="attack",
        ["106871536134254"]="attack",["109402730355822"]="attack",["130593238885843"]="attack",
        ["138720291317243"]="attack",["139369275981139"]="attack",["133963973694098"]="attack",
        ["78935059863801"]="attack",
        ["118907603246885"]="lungehold",["135002183282873"]="lungehold",["113255068724446"]="lungehold",
        ["129784271201071"]="lungehold",["105374834496520"]="lungehold",["117070354890871"]="lungehold",
        ["115244153053858"]="lungehold",["110355011987939"]="lungehold",["117042998468241"]="lungehold",
        ["122812055447896"]="lungehold"
    }

    local WisnuParry = {
        Cooldown       = false,
        CooldownThread = nil,
        Circle         = nil,
        Attached       = {},
        LastParry      = 0,
        Debounce       = 0.2,
        CircleSpawnTime = nil,
        CircleHideTime  = nil,
        ValidIds       = {
            ["122812055447896"] = "Veil lunge",
            ["133963973694098"] = "Mayers Basic",
            ["117042998468241"] = "Mayers lunge",
            ["135002183282873"] = "cure lunge",
            ["121216847022485"] = "cure Basic",
            ["132817836308238"] = "Jeff Basic",
            ["129784271201071"] = "Jeff lunge",
            ["82666958311998"]  = "Jeff Frenzy",
            ["78432063483146"]  = "Abyssal Basic",
            ["118907603246885"] = "Abyssal lunge",
            ["139369275981139"] = "Jason Basic",
            ["110355011987939"] = "Jason lunge",
            ["111920872708571"] = "Masked Basic",
            ["105374834496520"] = "Masked lunge",
            ["138720291317243"] = "Masked Tony",
            ["106871536134254"] = "Masked Alex",
            ["130593238885843"] = "Masked Cobra",
            ["115244153053858"] = "Masked Cobra lunge",
            ["74968262036854"]  = "Hidden Basic",
            ["113255068724446"] = "Hidden lunge",
            ["98163597193511"]  = "Hidden S1",
            ["80411309607666"]  = "Abyssal S1"
        }
    }

    local function Wisnu_IsDowned(char)
        if not char then return false end
        return char:GetAttribute("Knocked") == true
            or char:GetAttribute("IsHooked") == true
    end

    local function Wisnu_IsSafeToParry(char, kChar)
        if not VD.Surv_ParrySafety then return true end
        if not char then return false end

        if kChar then
            local myHRP = char:FindFirstChild("HumanoidRootPart")
            local kHRP  = kChar:FindFirstChild("HumanoidRootPart")
            if myHRP and kHRP then
                local toMe = myHRP.Position - kHRP.Position
                local flatToMe = Vector3.new(toMe.X, 0, toMe.Z)
                if flatToMe.Magnitude > 0.01 then
                    local kLook = kHRP.CFrame.LookVector
                    local flatLook = Vector3.new(kLook.X, 0, kLook.Z)
                    if flatLook.Magnitude > 0.01 then
                        if flatLook.Unit:Dot(flatToMe.Unit) < 0.5 then
                            return false
                        end
                    end
                end
            end
        end

        local interactObj = char:FindFirstChild("CheckInterractable")
        if interactObj then
            if interactObj:GetAttribute("isVaulting")  == true then return false end
            if interactObj:GetAttribute("isRepairing") == true then return false end
            if interactObj:GetAttribute("isUnhooking") == true then return false end
            if interactObj:GetAttribute("isHealing")   == true then return false end
            if interactObj:GetAttribute("isSliding")   == true then return false end
        end
        return true
    end

    local function Wisnu_TapMobileParryButton()
        local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
        if not playerGui then return end
        local survivorMob = playerGui:FindFirstChild("Survivor-mob")
        local parryBtn = survivorMob
            and survivorMob:FindFirstChild("Controls")
            and survivorMob.Controls:FindFirstChild("Gui-mob")
        if parryBtn and parryBtn.Visible then
            if firesignal then
                pcall(function()
                    firesignal(parryBtn.MouseButton1Down)
                    task.wait(0.01)
                    firesignal(parryBtn.MouseButton1Up)
                end)
            end
        else
            pcall(function()
                if mouse2click then mouse2click(); return end
                if mouse2press and mouse2release then
                    mouse2press(); task.wait(0.01); mouse2release(); return
                end
                if MouseButton2Click then MouseButton2Click(); return end
                VirtualInputManager:SendMouseButtonEvent(0, 0, 1, true, game, 0)
                task.wait(0.01)
                VirtualInputManager:SendMouseButtonEvent(0, 0, 1, false, game, 0)
            end)
        end
    end

    local function Wisnu_ExecuteParry()
        if WisnuParry.Cooldown then return end
        local now = tick()
        if now - WisnuParry.LastParry < WisnuParry.Debounce then return end
        WisnuParry.LastParry = now
        pcall(function()
            local remotes  = ReplicatedStorage:FindFirstChild("Remotes")
            local items    = remotes and remotes:FindFirstChild("Items")
            local dagger   = items and items:FindFirstChild("Parrying Dagger")
            local parryRem = dagger and dagger:FindFirstChild("parry")
            if parryRem then
                for _ = 1, 10 do parryRem:FireServer() end
            end
            task.spawn(Wisnu_TapMobileParryButton)
        end)
    end

    task.spawn(function()
        local remotes = ReplicatedStorage:WaitForChild("Remotes", 5)
        local items   = remotes and remotes:WaitForChild("Items", 5)
        local dagger  = items and items:WaitForChild("Parrying Dagger", 5)
        local parryResultRemote = dagger and dagger:WaitForChild("parryResult", 5)
        if parryResultRemote then
            parryResultRemote.OnClientEvent:Connect(function(arg1, arg2)
                local cdDur = tonumber(arg2) or ((arg1 == true) and 90 or 60)
                WisnuParry.Cooldown = true
                if WisnuParry.CooldownThread then task.cancel(WisnuParry.CooldownThread) end
                WisnuParry.CooldownThread = task.delay(cdDur, function()
                    WisnuParry.Cooldown = false
                end)
            end)
        end
    end)

    local function Wisnu_AttachParrySensor(kChar)
        if not kChar or WisnuParry.Attached[kChar] then return end
        WisnuParry.Attached[kChar] = true
        local humanoid = kChar:FindFirstChild("Humanoid")
        if not humanoid then
            humanoid = kChar:WaitForChild("Humanoid", 5)
            if not humanoid then return end
        end
        local animator = humanoid:FindFirstChildOfClass("Animator")
        if not animator then
            animator = humanoid:WaitForChild("Animator", 5)
            if not animator then return end
        end

        humanoid.ChildAdded:Connect(function(child)
            if child:IsA("Animator") then
                WisnuParry.Attached[kChar] = nil
                Wisnu_AttachParrySensor(kChar)
            end
        end)
        kChar.AncestryChanged:Connect(function(_, parent)
            if not parent then WisnuParry.Attached[kChar] = nil end
        end)

        animator.AnimationPlayed:Connect(function(track)
            local animId = track.Animation and track.Animation.AnimationId or ""
            local id = animId:match("%d+")
            local attackName = WisnuParry.ValidIds[id]
            if not attackName then return end

            if not VD.Surv_AutoParry then return end
            if WisnuParry.Cooldown then return end
            if VD.Surv_IgnoredSkills and VD.Surv_IgnoredSkills[attackName] then return end

            local myChar = LocalPlayer.Character
            if Wisnu_IsDowned(myChar) or not Wisnu_IsSafeToParry(myChar, kChar) then return end
            local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
            local kHRP  = kChar:FindFirstChild("HumanoidRootPart")
            if not myHRP or not kHRP then return end

            local startDistance = (myHRP.Position - kHRP.Position).Magnitude

            if VD.Surv_ParryAggressive then
                local aggressiveRadius = 12
                local detectionRadius  = VD.Surv_ParryRadius + 5
                if startDistance > detectionRadius then return end
                if startDistance <= aggressiveRadius then
                    Wisnu_ExecuteParry()
                else
                    local tracker
                    local startTime = os.clock()
                    tracker = RunService.Heartbeat:Connect(function()
                        if os.clock() - startTime >= 1.5
                            or WisnuParry.Cooldown
                            or not myHRP or not kHRP
                            or Wisnu_IsDowned(myChar) then
                            if tracker then tracker:Disconnect() end
                            return
                        end
                        if (myHRP.Position - kHRP.Position).Magnitude <= aggressiveRadius then
                            Wisnu_ExecuteParry()
                            if tracker then tracker:Disconnect() end
                        end
                    end)
                end
            else
                if startDistance > VD.Surv_ParryRadius then return end
                Wisnu_ExecuteParry()
            end
        end)
    end

    local function Wisnu_TryAttach(p)
        if p ~= LocalPlayer and p.Team and p.Team.Name == "Killer" and p.Character then
            Wisnu_AttachParrySensor(p.Character)
        end
    end

    local function Wisnu_SetupPlayer(p)
        if p == LocalPlayer then return end
        p.CharacterAdded:Connect(function() Wisnu_TryAttach(p) end)
        p:GetPropertyChangedSignal("Team"):Connect(function() Wisnu_TryAttach(p) end)
        if p.Character then Wisnu_TryAttach(p) end
    end

    for _, p in pairs(Players:GetPlayers()) do Wisnu_SetupPlayer(p) end
    Players.PlayerAdded:Connect(Wisnu_SetupPlayer)
    task.spawn(function()
        while true do
            task.wait(5)
            for _, p in pairs(Players:GetPlayers()) do Wisnu_TryAttach(p) end
        end
    end)

    RunService.RenderStepped:Connect(function()
        local char = LocalPlayer.Character
        local hrp  = char and char:FindFirstChild("HumanoidRootPart")
        local now  = os.clock()

        local shouldShow = VD.Surv_ParryCircle and VD.Surv_AutoParry and hrp ~= nil

        if shouldShow then
            if not WisnuParry.Circle or WisnuParry.Circle.Parent ~= hrp then
                if WisnuParry.Circle then
                    pcall(function() WisnuParry.Circle:Destroy() end)
                end
                WisnuParry.Circle = Instance.new("CylinderHandleAdornment")
                WisnuParry.Circle.Name         = "WisnuParryCircle"
                WisnuParry.Circle.Height       = 0.05
                WisnuParry.Circle.Transparency = 1
                WisnuParry.Circle.Adornee      = hrp
                WisnuParry.Circle.Parent       = hrp
                WisnuParry.Circle.ZIndex       = 0
                WisnuParry.Circle.AlwaysOnTop  = false
                WisnuParry.CircleSpawnTime = now
                WisnuParry.CircleHideTime  = nil
            end

            WisnuParry.CircleHideTime = nil

            local cR = VD.Surv_ParryRadius or 15

            local spawnElapsed = now - (WisnuParry.CircleSpawnTime or now)
            local spawnDur     = 0.45
            local t            = math.clamp(spawnElapsed / spawnDur, 0, 1)
            local c1           = 1.70158
            local c3           = c1 + 1
            local easeOutBack  = 1 + c3 * (t - 1)^3 + c1 * (t - 1)^2

            local radiusAnim = cR * easeOutBack
            if radiusAnim < 0.15 then radiusAnim = 0.15 end

            local pulse      = 0.30 + math.sin(now * 3.2) * 0.12
            local fadeIn     = math.clamp(t * 2, 0, 1)
            local baseTrans  = WisnuParry.Cooldown and 0.55 or pulse
            local finalTrans = 1 - (1 - baseTrans) * fadeIn

            WisnuParry.Circle.Radius       = radiusAnim
            WisnuParry.Circle.InnerRadius  = math.max(0.1, radiusAnim - 0.15)
            WisnuParry.Circle.CFrame       = CFrame.new(0, -3, 0)
                                           * CFrame.Angles(math.rad(90), 0, 0)
            WisnuParry.Circle.Transparency = finalTrans

            if WisnuParry.Cooldown then
                WisnuParry.Circle.Color3 = _G.GLUTO_THEME_DIM
            else
                WisnuParry.Circle.Color3 = _G.GLUTO_THEME
            end

        elseif WisnuParry.Circle then
            if not WisnuParry.CircleHideTime then
                WisnuParry.CircleHideTime  = now
                WisnuParry.CircleSpawnTime = nil
            end
            local hideElapsed = now - WisnuParry.CircleHideTime
            local hideDur     = 0.28

            if hideElapsed >= hideDur then
                pcall(function() WisnuParry.Circle:Destroy() end)
                WisnuParry.Circle         = nil
                WisnuParry.CircleHideTime = nil
            else
                local ht      = hideElapsed / hideDur
                local easeIn  = ht * ht * ht
                local cR      = VD.Surv_ParryRadius or 15
                local shrinkR = math.max(0.1, cR * (1 - easeIn))

                WisnuParry.Circle.Radius       = shrinkR
                WisnuParry.Circle.InnerRadius  = math.max(0.05, shrinkR - 0.15)
                WisnuParry.Circle.Transparency = 0.3 + easeIn * 0.7
            end
        end
    end)

    W.WisnuParry         = WisnuParry
    W.WisnuParry_Execute = Wisnu_ExecuteParry

    do
        local VeilState = { target = nil, lookVector = nil, velHistory = {} }
        local VeilVisuals = {}

        pcall(function()
            if typeof(Drawing) ~= "table" or not Drawing.new then return end

            VeilVisuals.FOVCircleOutline = Drawing.new("Circle")
            VeilVisuals.FOVCircleOutline.Color = Color3.fromRGB(0, 0, 0)
            VeilVisuals.FOVCircleOutline.Thickness = 3
            VeilVisuals.FOVCircleOutline.Filled = false
            VeilVisuals.FOVCircleOutline.Transparency = 0.4
            VeilVisuals.FOVCircleOutline.Visible = false

            VeilVisuals.FOVCircleFill = Drawing.new("Circle")
            VeilVisuals.FOVCircleFill.Color = _G.GLUTO_THEME
            VeilVisuals.FOVCircleFill.Thickness = 1
            VeilVisuals.FOVCircleFill.Filled = false
            VeilVisuals.FOVCircleFill.Transparency = 0.5
            VeilVisuals.FOVCircleFill.Visible = false

            VeilVisuals.TrackerCircleOutline = Drawing.new("Circle")
            VeilVisuals.TrackerCircleOutline.Color = Color3.fromRGB(0, 0, 0)
            VeilVisuals.TrackerCircleOutline.Thickness = 3
            VeilVisuals.TrackerCircleOutline.Filled = false
            VeilVisuals.TrackerCircleOutline.Transparency = 0.4
            VeilVisuals.TrackerCircleOutline.Visible = false

            VeilVisuals.TrackerCircleFill = Drawing.new("Circle")
            VeilVisuals.TrackerCircleFill.Color = _G.GLUTO_THEME
            VeilVisuals.TrackerCircleFill.Thickness = 1
            VeilVisuals.TrackerCircleFill.Filled = false
            VeilVisuals.TrackerCircleFill.Transparency = 0.5
            VeilVisuals.TrackerCircleFill.Visible = false

            VeilVisuals.TrackerLine = Drawing.new("Line")
            VeilVisuals.TrackerLine.Color = _G.GLUTO_THEME
            VeilVisuals.TrackerLine.Thickness = 2
            VeilVisuals.TrackerLine.Transparency = 0.5
            VeilVisuals.TrackerLine.Visible = false
        end)

        local function Veil_IsSurvivorVeil(p)
            if not p or not p.Team or not p.Team.Name then return false end
            return string.find(string.lower(p.Team.Name), "survivor", 1, true) ~= nil
        end

        local function Veil_solvePitch(p, d, dy)
            d = math.max(d, 0.1)
            local s2 = p.v0 * p.v0
            local root = s2 * s2 - p.g * (p.g * d * d + 2 * dy * s2)
            if root < 0 then root = 0 end
            local tanTheta = (s2 - math.sqrt(root)) / (p.g * d)
            local theta = math.atan(tanTheta)
            local t = d / (p.v0 * math.cos(theta))
            return theta, t
        end

        local function Veil_getCharacterVelocity(char)
            local root = char and (char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso"))
            if not root or not root:IsA("BasePart") then return Vector3.zero end
            local now = os.clock()
            local last = VeilState.velHistory[char]
            local measured = Vector3.zero
            if last and now - last.t > 0.02 then
                measured = (root.Position - last.pos) / (now - last.t)
                if measured.Magnitude > 150 then measured = last.smooth or Vector3.zero end
            end
            local smooth = last and last.smooth or measured
            smooth = smooth:Lerp(measured, 0.65)
            VeilState.velHistory[char] = { pos = root.Position, t = now, smooth = smooth }
            if smooth.Magnitude < 1 then return Vector3.zero end
            return Vector3.new(smooth.X, 0, smooth.Z)
        end

        Players.PlayerRemoving:Connect(function(p)
            if p.Character then VeilState.velHistory[p.Character] = nil end
        end)

        local function Veil_HideTracker()
            if VeilVisuals.TrackerLine then VeilVisuals.TrackerLine.Visible = false end
            if VeilVisuals.TrackerCircleOutline then VeilVisuals.TrackerCircleOutline.Visible = false end
            if VeilVisuals.TrackerCircleFill then VeilVisuals.TrackerCircleFill.Visible = false end
        end

        local function Veil_HideAllVisuals()
            if VeilVisuals.FOVCircleFill then VeilVisuals.FOVCircleFill.Visible = false end
            if VeilVisuals.FOVCircleOutline then VeilVisuals.FOVCircleOutline.Visible = false end
            Veil_HideTracker()
        end

        local function Veil_UpdateAimbot()
            if GetRole() ~= "Killer" then
                VeilState.target = nil
                VeilState.lookVector = nil
                Veil_HideAllVisuals()
                return
            end

            local cam = Workspace.CurrentCamera
            if not cam then return end
            local center = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)

            if VD.VeilShowFOV and VD.VeilEnabled then
                if VeilVisuals.FOVCircleOutline then
                    VeilVisuals.FOVCircleOutline.Position = center
                    VeilVisuals.FOVCircleOutline.Radius = VD.VeilFOV or 150
                    VeilVisuals.FOVCircleOutline.Visible = true
                end
                if VeilVisuals.FOVCircleFill then
                    VeilVisuals.FOVCircleFill.Position = center
                    VeilVisuals.FOVCircleFill.Radius = VD.VeilFOV or 150
                    VeilVisuals.FOVCircleFill.Visible = true
                end
            else
                if VeilVisuals.FOVCircleOutline then VeilVisuals.FOVCircleOutline.Visible = false end
                if VeilVisuals.FOVCircleFill then VeilVisuals.FOVCircleFill.Visible = false end
            end

            if not VD.VeilEnabled then
                VeilState.target = nil
                VeilState.lookVector = nil
                Veil_HideAllVisuals()
                return
            end

            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if not hrp then
                VeilState.target = nil
                VeilState.lookVector = nil
                Veil_HideTracker()
                return
            end

            local nearest, nearestPart = nil, nil
            local bestDist = VD.VeilFOV or 150
            local bestStudDist = VD.VeilMaxDist or 500

            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and Veil_IsSurvivorVeil(p) and p.Character then
                    local pc = p.Character
                    local isDown = pc:GetAttribute("Knocked") == true
                                or pc:GetAttribute("HookProgressDepleting") == true
                    if not isDown then
                        local hum = pc:FindFirstChildOfClass("Humanoid")
                        local targetPart = pc:FindFirstChild("UpperTorso")
                                        or pc:FindFirstChild("Torso")
                                        or pc:FindFirstChild("HumanoidRootPart")
                        if hum and hum.Health > 0 and targetPart then
                            local sp, on = cam:WorldToViewportPoint(targetPart.Position)
                            if on and sp.Z > 0 then
                                local sd = (Vector2.new(sp.X, sp.Y) - center).Magnitude
                                if sd < bestDist then
                                    local studDist = (targetPart.Position - hrp.Position).Magnitude
                                    if studDist <= bestStudDist then
                                        bestDist = sd
                                        nearest = p
                                        nearestPart = targetPart
                                    end
                                end
                            end
                        end
                    end
                end
            end

            if not nearest or not nearestPart then
                VeilState.target = nil
                VeilState.lookVector = nil
                Veil_HideTracker()
                return
            end

            local tp = nearestPart.Position
            local hand = char:FindFirstChild("Right Arm") or char:FindFirstChild("RightHand")
            local origin = (hand and hand:IsA("BasePart")) and hand.Position or hrp.Position
            local dir = tp - origin
            local dist = dir.Magnitude

            if dist <= 0.1 or dist > (VD.VeilMaxDist or 500) then
                VeilState.target = nil
                VeilState.lookVector = nil
                Veil_HideTracker()
                return
            end

            local isAuraActive = char:GetAttribute("special") == true
            local prof
            if isAuraActive then
                prof = {
                    v0 = VD.VeilAuraSpearSpeed or 165,
                    g = VD.VeilAuraSpearGravity or 96.5,
                    windup = 0.10, latency = 0.04,
                    maxlead = 25, scale = VD.VeilLeadMultiplier or 1.4
                }
            else
                prof = {
                    v0 = VD.VeilSpearSpeed or 165,
                    g = VD.VeilGravity or 103,
                    windup = 0.10, latency = 0.04,
                    maxlead = 45, scale = VD.VeilLeadMultiplier or 1.4
                }
            end

            local aimPoint = tp
            if VD.VeilAutoPredict then
                local vel = Veil_getCharacterVelocity(nearest.Character)
                if vel.Magnitude > 0.5 then
                    local h0 = Vector3.new(dir.X, 0, dir.Z)
                    local _, tFlight = Veil_solvePitch(prof, h0.Magnitude, dir.Y)
                    local ping = 0.08
                    pcall(function() ping = math.clamp(LocalPlayer:GetNetworkPing(), 0, 0.35) end)
                    local delay = tFlight + prof.windup + ping + prof.latency
                    for _ = 1, 2 do
                        local lead = vel * delay * prof.scale
                        local maxLead = math.clamp(dist * 0.6, 3, prof.maxlead)
                        if lead.Magnitude > maxLead then lead = lead.Unit * maxLead end
                        aimPoint = tp + lead
                        local ad = aimPoint - origin
                        local ah = Vector3.new(ad.X, 0, ad.Z)
                        local _, t2 = Veil_solvePitch(prof, math.max(ah.Magnitude, 0.1), ad.Y)
                        delay = t2 + prof.windup + ping + prof.latency
                    end
                end
            end

            local adir = aimPoint - origin
            local ah = Vector3.new(adir.X, 0, adir.Z)
            local ahDist = ah.Magnitude
            local pitch = Veil_solvePitch(prof, ahDist, adir.Y)

            if ahDist > 0.001 then
                VeilState.lookVector = ah.Unit * math.cos(pitch)
                                     + Vector3.new(0, math.sin(pitch), 0)
            else
                VeilState.lookVector = adir.Unit
            end
            VeilState.target = nearest

            if VD.VeilShowTracker then
                local sp, vis = cam:WorldToViewportPoint(tp)
                local showTracker = false

                if vis and sp.Z > 0 then
                    local screenDist = (Vector2.new(sp.X, sp.Y) - center).Magnitude
                    if screenDist <= (VD.VeilFOV or 150) then
                        showTracker = true
                        local bottomCenter = Vector2.new(center.X, cam.ViewportSize.Y)
                        if VeilVisuals.TrackerLine then
                            VeilVisuals.TrackerLine.From = bottomCenter
                            VeilVisuals.TrackerLine.To = Vector2.new(sp.X, sp.Y)
                            VeilVisuals.TrackerLine.Visible = true
                        end
                        local radius = math.clamp(1000 / dist, 10, 40)
                        if VeilVisuals.TrackerCircleOutline then
                            VeilVisuals.TrackerCircleOutline.Position = Vector2.new(sp.X, sp.Y)
                            VeilVisuals.TrackerCircleOutline.Radius = radius
                            VeilVisuals.TrackerCircleOutline.Visible = true
                        end
                        if VeilVisuals.TrackerCircleFill then
                            VeilVisuals.TrackerCircleFill.Position = Vector2.new(sp.X, sp.Y)
                            VeilVisuals.TrackerCircleFill.Radius = radius
                            VeilVisuals.TrackerCircleFill.Visible = true
                        end
                    end
                end

                if not showTracker then
                    Veil_HideTracker()
                end
            else
                Veil_HideTracker()
            end
        end

        local VeilHookState = { remoteHooked = false }
        local function Veil_setupInterceptor()
            if VeilHookState.remoteHooked then return end
            if typeof(hookmetamethod) ~= "function" then return end
            task.spawn(function()
                pcall(function()
                    local oldNamecall
                    oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
                        local method = getnamecallmethod()
                        if not checkcaller() and method == "FireServer" then
                            if self.Name == "Spearthrow" and VD.VeilEnabled
                                and typeof(VeilState.lookVector) == "Vector3"
                                and GetRole() == "Killer" then
                                local args = {...}
                                if typeof(args[1]) == "Vector3" then
                                    args[1] = VeilState.lookVector
                                end
                                return oldNamecall(self, unpack(args))
                            end
                        end
                        return oldNamecall(self, ...)
                    end)
                    VeilHookState.remoteHooked = true
                end)
            end)
        end
        Veil_setupInterceptor()

        RunService.RenderStepped:Connect(function() pcall(Veil_UpdateAimbot) end)

        W.Veil_HideAllVisuals = Veil_HideAllVisuals
    end

    function W.doSelfHealTrue()
        local c = LocalPlayer.Character
        if not c then return end
        local hr = ReplicatedStorage.Remotes.Healing.HealEvent
        local hp = c:FindFirstChild("HumanoidRootPart")
        if not hp then return end
        pcall(function() hr:FireServer(hp, true) end)
    end
    function W.doSelfHealFalse()
        local c = LocalPlayer.Character
        if not c then return end
        local hr = ReplicatedStorage.Remotes.Healing.HealEvent
        local hp = c:FindFirstChild("HumanoidRootPart")
        if not hp then return end
        pcall(function() hr:FireServer(hp, false) end)
    end
    function W.doOthersHealTrue(tp)
        if not tp or not tp.Character then return end
        local hrp = tp.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local hr = ReplicatedStorage.Remotes.Healing.HealEvent
        pcall(function() hr:FireServer(hrp, true) end)
    end
    function W.doOthersHealFalse(tp)
        if not tp or not tp.Character then return end
        local hrp = tp.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local hr = ReplicatedStorage.Remotes.Healing.HealEvent
        pcall(function() hr:FireServer(hrp, false) end)
    end

    W.SelfHeal_BlockedAnimId = "95836365038528"
    W.SelfHeal_AnimMonitor = W.SelfHeal_AnimMonitor or { Conn = nil, CharHook = nil }
    function W.SelfHeal_StartAnimBlock()
        if W.SelfHeal_AnimMonitor.Conn then return end
        W.SelfHeal_AnimMonitor.Conn = RunService.Heartbeat:Connect(function()
            if not W.InstantHealSelf then return end
            local char = LocalPlayer.Character
            if not char then return end
            local hum = char:FindFirstChildOfClass("Humanoid")
            if not hum then return end
            local anim = hum:FindFirstChildOfClass("Animator")
            if not anim then return end
            local ok2, tracks = pcall(function() return anim:GetPlayingAnimationTracks() end)
            if not ok2 then return end
            for _, track in ipairs(tracks) do
                local aid = track.Animation and track.Animation.AnimationId or ""
                local numId = aid:match("%d+")
                if numId == W.SelfHeal_BlockedAnimId then
                    pcall(function() track:Stop(0) end)
                end
            end
        end)
        local function hookChar(char)
            if not char then return end
            local hum = char:FindFirstChildOfClass("Humanoid")
            if not hum then return end
            local anim = hum:FindFirstChildOfClass("Animator") or hum:WaitForChild("Animator", 3)
            if not anim then return end
            anim.AnimationPlayed:Connect(function(track)
                if not W.InstantHealSelf then return end
                local aid = track.Animation and track.Animation.AnimationId or ""
                local numId = aid:match("%d+")
                if numId == W.SelfHeal_BlockedAnimId then
                    pcall(function() track:Stop(0) end)
                end
            end)
        end
        hookChar(LocalPlayer.Character)
        W.SelfHeal_AnimMonitor.CharHook = LocalPlayer.CharacterAdded:Connect(function(c)
            task.wait(0.3); hookChar(c)
        end)
    end
    function W.SelfHeal_StopAnimBlock()
        if W.SelfHeal_AnimMonitor.Conn then
            pcall(function() W.SelfHeal_AnimMonitor.Conn:Disconnect() end)
            W.SelfHeal_AnimMonitor.Conn = nil
        end
        if W.SelfHeal_AnimMonitor.CharHook then
            pcall(function() W.SelfHeal_AnimMonitor.CharHook:Disconnect() end)
            W.SelfHeal_AnimMonitor.CharHook = nil
        end
    end
    function W.setInstantHealSelf(v)
        W.InstantHealSelf = v
        if v then
            if W.SelfHeal_StartAnimBlock then W.SelfHeal_StartAnimBlock() end
        else
            if W.SelfHeal_StopAnimBlock then W.SelfHeal_StopAnimBlock() end
        end
        if v then
            local ha = false
            if W.InstantHealConnection then W.InstantHealConnection:Disconnect() end
            W.InstantHealConnection = RunService.Heartbeat:Connect(function()
                if not W.InstantHealSelf then return end
                local c = LocalPlayer.Character
                local h = c and c:FindFirstChildOfClass("Humanoid")
                if not h then return end
                if h.Health >= h.MaxHealth * 0.9 then
                    if ha then ha = false; W.doSelfHealFalse() end
                    return
                end
                if ha then
                    local ci = c:FindFirstChild("CheckInterractable")
                    if ci and not ci:GetAttribute("isHealing") then ha = false end
                end
                if not ha then ha = true; W.doSelfHealTrue() end
            end)
        else
            if W.InstantHealConnection then W.InstantHealConnection:Disconnect(); W.InstantHealConnection = nil end
            pcall(W.doSelfHealFalse)
        end
    end
    function W.setAutoHealAll(v)
        W.AutoHealAll = v
        if v then
            local ah = {}
            if W.AutoHealAllConnection then W.AutoHealAllConnection:Disconnect() end
            W.AutoHealAllConnection = RunService.Heartbeat:Connect(function()
                if not W.AutoHealAll then return end
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Character then
                        local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                        local hu = p.Character:FindFirstChildOfClass("Humanoid")
                        if hu and hu.Health > 0 and hu.Health < hu.MaxHealth * 0.9 and hrp then
                            if ah[p] then
                                local c = LocalPlayer.Character
                                local ci = c and c:FindFirstChild("CheckInterractable")
                                if ci and not ci:GetAttribute("isHealing") then ah[p] = nil end
                            end
                            if not ah[p] then ah[p] = true; W.doOthersHealTrue(p) end
                        else
                            if ah[p] then ah[p] = nil; W.doOthersHealFalse(p) end
                        end
                    else
                        if ah[p] then ah[p] = nil; pcall(function() W.doOthersHealFalse(p) end) end
                    end
                end
            end)
        else
            if W.AutoHealAllConnection then W.AutoHealAllConnection:Disconnect(); W.AutoHealAllConnection = nil end
        end
    end
    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(0.5)
        if W.InstantHealSelf then W.setInstantHealSelf(true) end
        if W.AutoHealAll then W.setAutoHealAll(true) end
    end)

    W.FP = W.FP or {
        ActiveBuffs = {}, Conns = {}, LastBuffEnd = 0, CooldownTime = 5, HB = nil,
        FlowstateOn = false, QuickRecOn = false, PerfLandOn = false, AdrenalineOn = false,
    }
    local FP = W.FP
    local function FP_Char() return LocalPlayer.Character end
    local function FP_Hum() local c = FP_Char(); return c and c:FindFirstChildOfClass("Humanoid") end
    local function FP_GetTotal()
        local t = 0
        for _,b in pairs(FP.ActiveBuffs) do if tick() < b.endTime then t = t + b.amt end end
        return t
    end
    local function FP_Apply()
        local c = FP_Char()
        local tb = FP_GetTotal()
        local h = FP_Hum()
        if c then if tb > 0 then c:SetAttribute("speedboost", 1+(tb/14)) else c:SetAttribute("speedboost", 1) end end
        if h and tb > 0 then h.WalkSpeed = 16 + tb end
    end
    local PerkGUI = {
        Gui = nil, Container = nil, Layout = nil, Cards = {},
        PerkInfo = {
            Flowstate        = { Icon = "✦", Label = "FLOWSTATE" },
            QuickRecovery    = { Icon = "✚", Label = "QUICK RECOV" },
            PerfectLanding   = { Icon = "▼", Label = "PERFECT LAND" },
            AdrenalineRush   = { Icon = "♥", Label = "ADRENALINE" },
        }
    }
    local function PerkGUI_Create()
        if PerkGUI.Gui then return end
        local parent = SafeGuiParent()
        if not parent then return end
        local gui = Instance.new("ScreenGui")
        gui.Name = "GlutoPerkGUI"
        gui.ResetOnSpawn = false
        gui.IgnoreGuiInset = true
        gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        gui.DisplayOrder = 50
        gui.Parent = parent
        PerkGUI.Gui = gui
        local container = Instance.new("Frame")
        container.Name = "Container"
        container.AnchorPoint = Vector2.new(1, 0)
        container.Position = UDim2.new(1, -12, 0, 100)
        container.Size = UDim2.new(0, 180, 0, 0)
        container.AutomaticSize = Enum.AutomaticSize.Y
        container.BackgroundTransparency = 1
        container.Parent = gui
        PerkGUI.Container = container
        local layout = Instance.new("UIListLayout")
        layout.FillDirection = Enum.FillDirection.Vertical
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Padding = UDim.new(0, 6)
        layout.HorizontalAlignment = Enum.HorizontalAlignment.Right
        layout.Parent = container
        PerkGUI.Layout = layout
    end
    local function PerkGUI_AddCard(name)
        if PerkGUI.Cards[name] then return end
        if not PerkGUI.Gui then PerkGUI_Create() end
        if not PerkGUI.Gui then return end
        local info = PerkGUI.PerkInfo[name] or { Icon = "★", Label = string.upper(name) }
        local card = Instance.new("Frame")
        card.Name = "Card_" .. name
        card.Size = UDim2.new(0, 180, 0, 38)
        card.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        card.BackgroundTransparency = 1
        card.BorderSizePixel = 0
        card.ZIndex = 1
        card.LayoutOrder = #PerkGUI.Cards + 1
        card.Parent = PerkGUI.Container
        Instance.new("UICorner", card).CornerRadius = UDim.new(0, 10)
        local grad = Instance.new("UIGradient")
        grad.Rotation = 135
        grad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 20)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 10)),
        })
        grad.Parent = card
        local stroke = Instance.new("UIStroke", card)
        stroke.Name = "Stroke"
        stroke.Color = _G.GLUTO_THEME
        stroke.Thickness = 1.2
        stroke.Transparency = 0.2
        stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        local iconHolder = Instance.new("Frame")
        iconHolder.Name = "IconHolder"
        iconHolder.Size = UDim2.fromOffset(26, 26)
        iconHolder.Position = UDim2.new(0, 6, 0.5, -13)
        iconHolder.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        iconHolder.BorderSizePixel = 0
        iconHolder.ZIndex = 3
        iconHolder.Parent = card
        Instance.new("UICorner", iconHolder).CornerRadius = UDim.new(1, 0)
        local iconGrad = Instance.new("UIGradient", iconHolder)
        iconGrad.Rotation = 135
        iconGrad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 45, 45)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 25)),
        })
        local iconStroke = Instance.new("UIStroke", iconHolder)
        iconStroke.Color = _G.GLUTO_THEME
        iconStroke.Thickness = 1
        iconStroke.Transparency = 0.25
        local iconTxt = Instance.new("TextLabel")
        iconTxt.Name = "Icon"
        iconTxt.Size = UDim2.fromScale(1, 1)
        iconTxt.BackgroundTransparency = 1
        iconTxt.Font = Enum.Font.GothamBlack
        iconTxt.Text = info.Icon
        iconTxt.TextColor3 = _G.GLUTO_THEME
        iconTxt.TextScaled = true
        iconTxt.ZIndex = 4
        iconTxt.Parent = iconHolder
        local nameLbl = Instance.new("TextLabel")
        nameLbl.Name = "Name"
        nameLbl.Size = UDim2.new(1, -46, 0, 12)
        nameLbl.Position = UDim2.new(0, 38, 0, 5)
        nameLbl.BackgroundTransparency = 1
        nameLbl.Font = Enum.Font.GothamBold
        nameLbl.Text = info.Label
        nameLbl.TextColor3 = _G.GLUTO_THEME
        nameLbl.TextSize = 10
        nameLbl.TextXAlignment = Enum.TextXAlignment.Left
        nameLbl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        nameLbl.TextStrokeTransparency = 0.5
        nameLbl.ZIndex = 3
        nameLbl.Parent = card
        local timeLbl = Instance.new("TextLabel")
        timeLbl.Name = "Time"
        timeLbl.AnchorPoint = Vector2.new(1, 0)
        timeLbl.Size = UDim2.fromOffset(34, 12)
        timeLbl.Position = UDim2.new(1, -6, 0, 5)
        timeLbl.BackgroundTransparency = 1
        timeLbl.Font = Enum.Font.GothamBold
        timeLbl.Text = "3.0s"
        timeLbl.TextColor3 = Color3.fromRGB(170, 170, 170)
        timeLbl.TextSize = 9
        timeLbl.TextXAlignment = Enum.TextXAlignment.Right
        timeLbl.ZIndex = 3
        timeLbl.Parent = card
        local barBg = Instance.new("Frame")
        barBg.Name = "BarBg"
        barBg.AnchorPoint = Vector2.new(0.5, 1)
        barBg.Size = UDim2.new(1, -12, 0, 3)
        barBg.Position = UDim2.new(0.5, 0, 1, -5)
        barBg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        barBg.BorderSizePixel = 0
        barBg.ZIndex = 4
        barBg.Parent = card
        Instance.new("UICorner", barBg).CornerRadius = UDim.new(1, 0)
        local barFill = Instance.new("Frame")
        barFill.Name = "BarFill"
        barFill.Size = UDim2.new(1, 0, 1, 0)
        barFill.BackgroundColor3 = _G.GLUTO_THEME
        barFill.BorderSizePixel = 0
        barFill.ZIndex = 5
        barFill.Parent = barBg
        Instance.new("UICorner", barFill).CornerRadius = UDim.new(1, 0)
        PerkGUI.Cards[name] = {
            Card = card, BarFill = barFill, Stroke = stroke,
            TimeLbl = timeLbl, IconTxt = iconTxt,
        }
        card.Position = UDim2.new(0.4, 0, 0, 0)
        TweenService:Create(card, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Position = UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 0.05,
        }):Play()
    end
    local function PerkGUI_RemoveCard(name)
        local data = PerkGUI.Cards[name]
        if not data then return end
        PerkGUI.Cards[name] = nil
        local card = data.Card
        if not card or not card.Parent then return end
        TweenService:Create(card, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(0.4, 0, 0, 0),
            BackgroundTransparency = 1,
        }):Play()
        task.delay(0.28, function()
            if card and card.Parent then card:Destroy() end
        end)
    end
    task.spawn(function()
        while true do
            task.wait(0.05)
            for name in pairs(FP.ActiveBuffs) do
                if not PerkGUI.Cards[name] then PerkGUI_AddCard(name) end
            end
            for name, data in pairs(PerkGUI.Cards) do
                if not FP.ActiveBuffs[name] then
                    PerkGUI_RemoveCard(name)
                else
                    local b = FP.ActiveBuffs[name]
                    if b and data.BarFill then
                        local remain = math.max(0, b.endTime - tick())
                        local dur = b.duration or 3
                        local ratio = math.clamp(remain / dur, 0, 1)
                        data.BarFill.Size = UDim2.new(ratio, 0, 1, 0)
                        data.BarFill.BackgroundColor3 = _G.GLUTO_THEME_DIM:Lerp(_G.GLUTO_THEME, ratio)
                        if data.TimeLbl then data.TimeLbl.Text = string.format("%.1fs", remain) end
                    end
                end
            end
        end
    end)
    local function FP_EnsureHB()
        if FP.HB then return end
        FP.HB = RunService.Heartbeat:Connect(function()
            local exp = {}
            for n,b in pairs(FP.ActiveBuffs) do if tick() >= b.endTime then table.insert(exp,n) end end
            for _,n in ipairs(exp) do FP.ActiveBuffs[n]=nil end
            if #exp > 0 and FP_GetTotal()<=0 then FP.LastBuffEnd = tick() end
            FP_Apply()
            if FP_GetTotal()<=0 and next(FP.ActiveBuffs)==nil then
                if FP.HB then FP.HB:Disconnect(); FP.HB=nil end
                local c = FP_Char()
                if c then c:SetAttribute("speedboost",1) end
            end
        end)
    end
    local function FP_TryBuff(name, amt, dur)
        if FP.ActiveBuffs[name] then return end
        if tick()-FP.LastBuffEnd < FP.CooldownTime and next(FP.ActiveBuffs)==nil then return end
        FP.ActiveBuffs[name] = {amt=amt, endTime=tick()+dur, duration=dur, startTime=tick()}
        FP_Apply(); FP_EnsureHB()
        VD_Notify("Fake Perks", "["..name.."] Aktif! +"..amt.." Speed ("..dur.."s)", 3)
    end
    local function FP_Clean(name)
        if FP.Conns[name] then for _,c in ipairs(FP.Conns[name]) do pcall(function() c:Disconnect() end) end FP.Conns[name] = nil end
    end
    local function FP_Reg(name, conn) if not FP.Conns[name] then FP.Conns[name] = {} end table.insert(FP.Conns[name], conn) end
    function W.FP_SetupFlowstate(val)
        FP.FlowstateOn = val
        local c = FP_Char()
        if c then c:SetAttribute("Flowstate", val) end
        if val then
            local r = ReplicatedStorage:FindFirstChild("Remotes")
            local w = r and r:FindFirstChild("Window")
            local p = r and r:FindFirstChild("Pallet")
            local function onV()
                if not FP.FlowstateOn then return end
                task.delay(0.5, function() if FP.FlowstateOn then FP_TryBuff("Flowstate",5,3) end end)
            end
            if w then local vb = w:FindFirstChild("Vaultbindable"); if vb and vb:IsA("BindableEvent") then FP_Reg("Flowstate", vb.Event:Connect(onV)) end end
            if p then local sb = p:FindFirstChild("Slidebindable"); if sb and sb:IsA("BindableEvent") then FP_Reg("Flowstate", sb.Event:Connect(onV)) end end
            local function hookChar(cc)
                if not cc then return end
                local cn = cc:GetAttributeChangedSignal("__VaultFireCount"):Connect(function() if FP.FlowstateOn then onV() end end)
                FP_Reg("Flowstate", cn)
            end
            hookChar(LocalPlayer.Character)
            FP_Reg("Flowstate", LocalPlayer.CharacterAdded:Connect(function(cc) if FP.FlowstateOn then cc:SetAttribute("Flowstate",true); hookChar(cc) end end))
        else
            FP_Clean("Flowstate")
            FP.ActiveBuffs["Flowstate"] = nil
            local c2 = FP_Char()
            if c2 then c2:SetAttribute("Flowstate", false) end
        end
    end
    function W.FP_SetupQuickRecovery(val)
        FP.QuickRecOn = val
        if val then
            local function onH() if not FP.QuickRecOn then return end FP_TryBuff("QuickRecovery", 6, 3) end
            local r = ReplicatedStorage:FindFirstChild("Remotes")
            local hf = r and r:FindFirstChild("Healing")
            if hf then local hd = hf:FindFirstChild("Healdone"); if hd and hd:IsA("BindableEvent") then FP_Reg("QuickRecovery", hd.Event:Connect(onH)) end end
            local function hookH(cc)
                if not cc then return end
                local h = cc:FindFirstChildOfClass("Humanoid")
                if h then
                    local lh = h.Health
                    local cn = h.HealthChanged:Connect(function(nh)
                        if not FP.QuickRecOn then return end
                        if nh > lh and (nh>=h.MaxHealth or (nh-lh)>=15) then onH() end
                        lh = nh
                    end)
                    FP_Reg("QuickRecovery", cn)
                end
            end
            hookH(LocalPlayer.Character)
            FP_Reg("QuickRecovery", LocalPlayer.CharacterAdded:Connect(hookH))
        else
            FP_Clean("QuickRecovery")
            FP.ActiveBuffs["QuickRecovery"] = nil
        end
    end
    function W.FP_SetupPerfectLanding(val)
        FP.PerfLandOn = val
        if val then
            local function hookF(cc)
                if not cc then return end
                local h = cc:FindFirstChildOfClass("Humanoid")
                if not h then return end
                local wf, fs = false, 0
                local cn = h.StateChanged:Connect(function(_,n)
                    if not FP.PerfLandOn then return end
                    if n == Enum.HumanoidStateType.Freefall then wf=true; fs=tick() end
                    if wf and (n == Enum.HumanoidStateType.Landed or n == Enum.HumanoidStateType.Running) then
                        local ft = tick() - fs
                        wf = false
                        if ft >= 0.25 then FP_TryBuff("PerfectLanding", 8, 3) end
                    end
                end)
                FP_Reg("PerfectLanding", cn)
            end
            hookF(LocalPlayer.Character)
            FP_Reg("PerfectLanding", LocalPlayer.CharacterAdded:Connect(hookF))
        else
            FP_Clean("PerfectLanding")
            FP.ActiveBuffs["PerfectLanding"] = nil
        end
    end
    function W.FP_SetupAdrenalineRush(val)
        FP.AdrenalineOn = val
        if val then
            local function hookD(cc)
                if not cc then return end
                local h = cc:FindFirstChildOfClass("Humanoid")
                if not h then return end
                local lh = h.Health
                local cn = h.HealthChanged:Connect(function(nh)
                    if not FP.AdrenalineOn then return end
                    if nh < lh and nh <= 50 and nh > 0 then FP_TryBuff("AdrenalineRush", 4, 5) end
                    lh = nh
                end)
                FP_Reg("AdrenalineRush", cn)
            end
            hookD(LocalPlayer.Character)
            FP_Reg("AdrenalineRush", LocalPlayer.CharacterAdded:Connect(hookD))
        else
            FP_Clean("AdrenalineRush")
            FP.ActiveBuffs["AdrenalineRush"] = nil
        end
    end

    W.StunSounds = W.StunSounds or {
        ["Default"]="18843924331",["Clash Royale"]="114072050006157",["Blash"]="89068385567682",
        ["Coin"]="75510526696824",["Kururin Kuru"]="119896940405402",["Spongebob"]="6835794541",
        ["Fahhhh"]="123562480982353",["Cave"]="3173566193",["Aughhh"]="9095205664",
        ["Samsung"]="6879335951",["iPhone"]="4203251375",["Siren"]="130677853589923",
    }
    W.StunIndicator = W.StunIndicator or {
        Enabled = false, Cache = {}, HeartbeatConn = nil, Range = 500,
        Icon = "rbxassetid://81633822407558",
        SoundEnabled = true, SoundId = "18843924331",
        SoundVolume = 1.5, SoundRange = 500, SelectedSound = "Default",
    }
    local SInd = W.StunIndicator
    SInd.SelectedSound = SInd.SelectedSound or "Default"
    local function SInd_GetActiveSoundId()
        local id = W.StunSounds[SInd.SelectedSound]
        if id then return id end
        return SInd.SoundId
    end
    local function SInd_IsStunned(char)
        if not char then return false end
        if char:GetAttribute("IsStunned") == true then return true end
        if char:GetAttribute("isStunned") == true then return true end
        if char:GetAttribute("Stunned") == true then return true end
        if char:GetAttribute("stunned") == true then return true end
        if char:GetAttribute("IsStun") == true then return true end
        if char:GetAttribute("Stun") == true then return true end
        local ci = char:FindFirstChild("CheckInterractable")
        if ci then
            if ci:GetAttribute("isStunned") == true then return true end
            if ci:GetAttribute("Stunned") == true then return true end
        end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            local sv = hum:FindFirstChild("StunValue")
            if sv and sv.Value > 0 then return true end
        end
        return false
    end
    local function SInd_Remove(char)
        local data = SInd.Cache[char]
        if data then
            pcall(function()
                if data.StopAnim then data.StopAnim() end
                if data.Gui then data.Gui:Destroy() end
            end)
            SInd.Cache[char] = nil
        end
    end
    local function SInd_PlaySound(char)
        if not SInd.SoundEnabled then return end
        pcall(function()
            local head = char and char:FindFirstChild("Head")
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local attachTo = head or hrp
            if not attachTo then return end
            local snd = Instance.new("Sound")
            snd.Name = "GlutoStunSound"
            snd.SoundId = "rbxassetid://" .. tostring(SInd_GetActiveSoundId())
            snd.Volume = SInd.SoundVolume or 1.5
            snd.PlaybackSpeed = 1
            snd.RollOffMaxDistance = SInd.SoundRange or 500
            snd.RollOffMinDistance = 10
            snd.RollOffMode = Enum.RollOffMode.InverseTapered
            snd.Parent = attachTo
            snd:Play()
            snd.Ended:Connect(function() pcall(function() snd:Destroy() end) end)
            task.delay(5, function() pcall(function() if snd and snd.Parent then snd:Destroy() end end) end)
        end)
    end
    local function SInd_Create(char)
        if SInd.Cache[char] then return SInd.Cache[char] end
        local head = char:FindFirstChild("Head")
        if not head then return nil end
        local bbg = Instance.new("BillboardGui")
        bbg.Name = "GlutoStunIndicator"
        bbg.Size = UDim2.fromOffset(140, 42)
        bbg.StudsOffset = Vector3.new(0, 3.0, 0)
        bbg.AlwaysOnTop = true
        bbg.LightInfluence = 0
        bbg.MaxDistance = 500
        bbg.Adornee = head
        bbg.Parent = char
        local pulse1 = Instance.new("Frame")
        pulse1.Name = "Pulse1"
        pulse1.AnchorPoint = Vector2.new(0.5, 0.5)
        pulse1.Position = UDim2.new(0.5, 0, 0.5, 0)
        pulse1.Size = UDim2.fromOffset(34, 34)
        pulse1.BackgroundTransparency = 1
        pulse1.BorderSizePixel = 0
        pulse1.ZIndex = 0
        pulse1.Parent = bbg
        Instance.new("UICorner", pulse1).CornerRadius = UDim.new(1, 0)
        local p1s = Instance.new("UIStroke", pulse1)
        p1s.Color = _G.GLUTO_THEME
        p1s.Thickness = 1.8
        p1s.Transparency = 0.3
        p1s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        local pulse2 = Instance.new("Frame")
        pulse2.Name = "Pulse2"
        pulse2.AnchorPoint = Vector2.new(0.5, 0.5)
        pulse2.Position = UDim2.new(0.5, 0, 0.5, 0)
        pulse2.Size = UDim2.fromOffset(34, 34)
        pulse2.BackgroundTransparency = 1
        pulse2.BorderSizePixel = 0
        pulse2.ZIndex = 0
        pulse2.Parent = bbg
        Instance.new("UICorner", pulse2).CornerRadius = UDim.new(1, 0)
        local p2s = Instance.new("UIStroke", pulse2)
        p2s.Color = _G.GLUTO_THEME
        p2s.Thickness = 1.8
        p2s.Transparency = 0.4
        p2s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        local main = Instance.new("Frame")
        main.Name = "Main"
        main.Size = UDim2.new(0, 140, 0, 34)
        main.Position = UDim2.new(0, 0, 0, 4)
        main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        main.BackgroundTransparency = 0.05
        main.BorderSizePixel = 0
        main.ZIndex = 1
        main.Parent = bbg
        Instance.new("UICorner", main).CornerRadius = UDim.new(0, 9)
        local bodyGrad = Instance.new("UIGradient")
        bodyGrad.Rotation = 135
        bodyGrad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 25, 25)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 10)),
        })
        bodyGrad.Parent = main
        local mainStroke = Instance.new("UIStroke", main)
        mainStroke.Name = "MainStroke"
        mainStroke.Color = _G.GLUTO_THEME
        mainStroke.Thickness = 1.3
        mainStroke.Transparency = 0.15
        mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        local iconHolder = Instance.new("Frame")
        iconHolder.Name = "IconHolder"
        iconHolder.Size = UDim2.fromOffset(24, 24)
        iconHolder.Position = UDim2.new(0, 5, 0.5, -12)
        iconHolder.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        iconHolder.BorderSizePixel = 0
        iconHolder.ZIndex = 3
        iconHolder.Parent = main
        Instance.new("UICorner", iconHolder).CornerRadius = UDim.new(1, 0)
        local iconGrad = Instance.new("UIGradient", iconHolder)
        iconGrad.Rotation = 135
        iconGrad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 45, 45)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 25)),
        })
        local iconStroke = Instance.new("UIStroke", iconHolder)
        iconStroke.Color = _G.GLUTO_THEME
        iconStroke.Thickness = 1
        iconStroke.Transparency = 0.25
        local starIcon = Instance.new("TextLabel")
        starIcon.Name = "StarIcon"
        starIcon.Size = UDim2.fromScale(1, 1)
        starIcon.BackgroundTransparency = 1
        starIcon.Font = Enum.Font.GothamBlack
        starIcon.Text = "★"
        starIcon.TextColor3 = _G.GLUTO_THEME
        starIcon.TextScaled = true
        starIcon.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        starIcon.TextStrokeTransparency = 0.5
        starIcon.ZIndex = 4
        starIcon.Parent = iconHolder
        local title = Instance.new("TextLabel")
        title.Name = "Title"
        title.Size = UDim2.new(1, -42, 0, 12)
        title.Position = UDim2.new(0, 34, 0, 4)
        title.BackgroundTransparency = 1
        title.Font = Enum.Font.GothamBlack
        title.Text = "STUNNED"
        title.TextColor3 = _G.GLUTO_THEME
        title.TextSize = 11
        title.TextXAlignment = Enum.TextXAlignment.Left
        title.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        title.TextStrokeTransparency = 0.5
        title.ZIndex = 3
        title.Parent = main
        local sub = Instance.new("TextLabel")
        sub.Name = "Sub"
        sub.Size = UDim2.new(1, -42, 0, 8)
        sub.Position = UDim2.new(0, 34, 0, 18)
        sub.BackgroundTransparency = 1
        sub.Font = Enum.Font.GothamBold
        sub.Text = "SILENT"
        sub.TextColor3 = Color3.fromRGB(170, 170, 170)
        sub.TextSize = 7
        sub.TextXAlignment = Enum.TextXAlignment.Left
        sub.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        sub.TextStrokeTransparency = 0.6
        sub.ZIndex = 3
        sub.Parent = main
        local accent = Instance.new("Frame")
        accent.Name = "Accent"
        accent.AnchorPoint = Vector2.new(1, 0.5)
        accent.Size = UDim2.fromOffset(2.5, 14)
        accent.Position = UDim2.new(1, -5, 0.5, 0)
        accent.BackgroundColor3 = _G.GLUTO_THEME
        accent.BorderSizePixel = 0
        accent.ZIndex = 3
        accent.Parent = main
        Instance.new("UICorner", accent).CornerRadius = UDim.new(1, 0)
        main.Size = UDim2.new(0, 0, 0, 0)
        main.BackgroundTransparency = 1
        task.spawn(function()
            task.wait(0.02)
            TweenService:Create(main, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 140, 0, 34),
                BackgroundTransparency = 0.05,
            }):Play()
        end)
        local animActive = true
        local function StopAnim() animActive = false end
        task.spawn(function()
            local t = 0
            while animActive and bbg.Parent and main.Parent do
                t = t + 0.05
                local pulse = (math.sin(t * 3) + 1) * 0.5
                mainStroke.Transparency = 0.35 - pulse * 0.2
                mainStroke.Thickness = 1.2 + pulse * 0.3
                starIcon.Rotation = math.sin(t * 2) * 10
                local p1 = (t * 0.55) % 1
                pulse1.Size = UDim2.fromOffset(34 + p1 * 40, 34 + p1 * 40)
                p1s.Transparency = 0.15 + p1 * 0.75
                local p2 = ((t * 0.55) + 0.5) % 1
                pulse2.Size = UDim2.fromOffset(34 + p2 * 40, 34 + p2 * 40)
                p2s.Transparency = 0.15 + p2 * 0.75
                task.wait(0.03)
            end
        end)
        local function ExitAndDestroy()
            animActive = false
            TweenService:Create(main, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Size = UDim2.new(0, 0, 0, 0),
                BackgroundTransparency = 1,
            }):Play()
            task.delay(0.28, function() pcall(function() bbg:Destroy() end) end)
        end
        SInd.Cache[char] = { Gui = bbg, Main = main, StopAnim = StopAnim, Exit = ExitAndDestroy }
        return SInd.Cache[char]
    end
    function W.SInd_SetEnabled(v)
        SInd.Enabled = v and true or false
        if SInd.Enabled then
            if SInd.HeartbeatConn then return end
            SInd.HeartbeatConn = RunService.Heartbeat:Connect(function()
                if not SInd.Enabled then return end
                local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if not myRoot then return end
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and TeamIs(p, "Killer") and p.Character then
                        local char = p.Character
                        local hrp = char:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            local dist = (hrp.Position - myRoot.Position).Magnitude
                            local stunned = SInd_IsStunned(char)
                            local data = SInd.Cache[char]
                            local wasStunned = data ~= nil
                            if stunned and dist <= SInd.Range then
                                if not wasStunned then SInd_PlaySound(char); SInd_Create(char) end
                            else
                                if wasStunned then
                                    if data.Exit then data.Exit() else SInd_Remove(char) end
                                    SInd.Cache[char] = nil
                                end
                            end
                        end
                    end
                end
            end)
        else
            if SInd.HeartbeatConn then SInd.HeartbeatConn:Disconnect(); SInd.HeartbeatConn = nil end
            for _, data in pairs(SInd.Cache) do
                pcall(function()
                    if data.StopAnim then data.StopAnim() end
                    if data.Gui then data.Gui:Destroy() end
                end)
            end
            SInd.Cache = {}
        end
    end

    W.TrollTeleport = W.TrollTeleport or {
        Enabled = false, IsProcessing = false, TriggerCount = 0,
        AnimatorHook = nil, CharHook = nil,
        BlockedAnimList = { ["123812278891591"] = 1, ["74099023522626"] = 2 },
    }
    local TT = W.TrollTeleport
    local function TT_HookCharacter(char)
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum then return end
        local anim = hum:FindFirstChildOfClass("Animator") or hum:WaitForChild("Animator", 3)
        if not anim then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        anim.AnimationPlayed:Connect(function(track)
            if not TT.Enabled then return end
            if TT.IsProcessing then return end
            local aid = track.Animation and track.Animation.AnimationId or ""
            local numId = aid:match("%d+")
            local delay = numId and TT.BlockedAnimList[numId]
            if not delay then return end
            TT.IsProcessing = true
            TT.TriggerCount = TT.TriggerCount + 1
            local startCF = root.CFrame
            VD_Notify("Troll Teleport", "Trigger #" .. TT.TriggerCount .. " | Delay " .. delay .. "s", 2)
            task.spawn(function()
                if track.IsPlaying then pcall(function() track.Stopped:Wait() end) end
                task.wait(delay)
                local c = LocalPlayer.Character
                local rp = c and c:FindFirstChild("HumanoidRootPart")
                if rp and rp.Parent then pcall(function() rp.CFrame = startCF end) end
                TT.IsProcessing = false
            end)
        end)
    end
    function W.TrollTeleport_Start()
        if TT.AnimatorHook then return end
        TT.IsProcessing = false
        TT_HookCharacter(LocalPlayer.Character)
        TT.CharHook = LocalPlayer.CharacterAdded:Connect(function(c) task.wait(0.4); TT_HookCharacter(c) end)
    end
    function W.TrollTeleport_Stop()
        if TT.CharHook then pcall(function() TT.CharHook:Disconnect() end); TT.CharHook = nil end
        TT.AnimatorHook = nil
        TT.IsProcessing = false
    end
    function W.TrollTeleport_SetEnabled(v)
        TT.Enabled = v and true or false
        if TT.Enabled then W.TrollTeleport_Start() else W.TrollTeleport_Stop() end
    end

    W.Escape = W.Escape or { Enabled = false, FinishLineName = "fininshline", TeleportCount = 0 }
    local Esc = W.Escape
    function W.Escape_Teleport()
        local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not root then ForceNotify("Escape", "Character not found", 2); return false end
        local found = nil
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if string.lower(obj.Name) == string.lower(Esc.FinishLineName) and obj:IsA("BasePart") then
                found = obj; break
            end
        end
        if not found then ForceNotify("Escape", "Finish line not found", 2); return false end
        pcall(function() root.CFrame = found.CFrame + Vector3.new(0, 5, 0) end)
        Esc.TeleportCount = Esc.TeleportCount + 1
        VD_Notify("Instant Escape", "Teleported! (#" .. Esc.TeleportCount .. ")", 2)
        return true
    end

    W.Masked = W.Masked or { CurrentPower = "Cobra", Powers = {"Cobra", "Richter", "Brandon", "Rabbit", "Alex", "Tony"} }
    local Masked = W.Masked
    function W.Masked_Activate()
        local ev = ReplicatedStorage:FindFirstChild("Remotes", true)
            and ReplicatedStorage.Remotes:FindFirstChild("Killers", true)
            and ReplicatedStorage.Remotes.Killers:FindFirstChild("Masked", true)
            and ReplicatedStorage.Remotes.Killers.Masked:FindFirstChild("Activatepower")
        if ev then
            pcall(function() ev:FireServer(Masked.CurrentPower) end)
            VD_Notify("Select Masked", "Activated: " .. Masked.CurrentPower, 2)
        else ForceNotify("Select Masked", "Activatepower remote not found", 2) end
    end
    function W.Masked_Deactivate()
        local ev = ReplicatedStorage:FindFirstChild("Remotes", true)
            and ReplicatedStorage.Remotes:FindFirstChild("Killers", true)
            and ReplicatedStorage.Remotes.Killers:FindFirstChild("Masked", true)
            and ReplicatedStorage.Remotes.Killers.Masked:FindFirstChild("Deactivatepower")
        if ev then
            pcall(function() ev:FireServer() end)
            VD_Notify("Select Masked", "Deactivated", 2)
        else ForceNotify("Select Masked", "Deactivatepower remote not found", 2) end
    end

    W.FullESP = W.FullESP or {
        Survivor = false, Killer = false,
        Generator = false, Pallet = false, Window = false, SCP = false,
        Distance = 500,
    }
    W.FullESPStatus = W.FullESPStatus or {
        Enabled = false,
        ShowName = true, ShowDistance = true, ShowHealth = false,
        ShowAvatar = true, ShowAction = true, Radius = 500,
    }
    W.FullESPColors = W.FullESPColors or {
        Survivor  = Color3.fromRGB(0, 190, 255), Killer    = Color3.fromRGB(255, 0, 0),
        Generator = Color3.fromRGB(255, 255, 0), Window    = _G.GLUTO_THEME,
        Pallet    = Color3.fromRGB(255, 165, 0), SCP       = Color3.fromRGB(0, 255, 0),
    }
    local FESP  = W.FullESP
    local FESPS = W.FullESPStatus
    local FESPC = W.FullESPColors

    do
        local ESPObjects = {}
        local StatusESP  = {}
        local CachedSCP     = {}
        local CachedGen     = {}
        local CachedPallet  = {}
        local CachedWindow  = {}
        local WindowObjects = {}

        local function CacheObject(obj)
            if not obj then return end
            local ln = string.lower(obj.Name)
            if string.find(ln, "scp", 1, true) then CachedSCP[obj] = true end
            if obj.Name == "Generator" then
                CachedGen[obj] = true
            elseif obj.Name == "Pallet" or obj.Name == "Palletwrong" then
                CachedPallet[obj] = true
            end
        end

        for _, obj in ipairs(Workspace:GetDescendants()) do CacheObject(obj) end
        Workspace.DescendantAdded:Connect(CacheObject)
        Workspace.DescendantRemoving:Connect(function(obj)
            CachedSCP[obj] = nil; CachedGen[obj] = nil
            CachedPallet[obj] = nil; CachedWindow[obj] = nil
            if ESPObjects[obj] then pcall(function() ESPObjects[obj]:Destroy() end); ESPObjects[obj] = nil end
            if StatusESP[obj] then pcall(function() StatusESP[obj]:Destroy() end); StatusESP[obj] = nil end
        end)

        local function RemoveESP(obj)
            if not obj then return end
            if ESPObjects[obj] then
                pcall(function() ESPObjects[obj]:Destroy() end)
                ESPObjects[obj] = nil
            end
        end

        local function CreateESP(obj, color)
            if not obj or not obj.Parent then return end
            if ESPObjects[obj] then
                ESPObjects[obj].FillColor = color
                ESPObjects[obj].OutlineColor = color
                return
            end
            local h = Instance.new("Highlight")
            h.FillColor = color
            h.OutlineColor = color
            h.FillTransparency = 0.9
            h.OutlineTransparency = 0.3
            h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            h.Parent = obj
            ESPObjects[obj] = h
            obj.AncestryChanged:Connect(function(_, parent)
                if not parent then RemoveESP(obj) end
            end)
        end

        local function RemoveStatusESP(char)
            if StatusESP[char] then
                pcall(function() StatusESP[char]:Destroy() end)
                StatusESP[char] = nil
            end
        end

        local function StatusESP_GetAction(char, hum)
            if not char or not hum then return "IDLE", Color3.fromRGB(140, 140, 140) end
            if hum.Health <= 0 then return "DEAD", Color3.fromRGB(200, 60, 60) end
            if char:GetAttribute("IsHooked") or char:GetAttribute("isHooked") or char:GetAttribute("Hooked") then
                return "HOOKED", Color3.fromRGB(255, 60, 60)
            end
            if char:GetAttribute("IsCarried") or char:GetAttribute("isCarried") or char:GetAttribute("Carried") then
                return "CARRIED", Color3.fromRGB(255, 100, 100)
            end
            local state = char:GetAttribute("State")
            if state == "Downed" or char:GetAttribute("Knocked") == true
               or char:GetAttribute("IsDown") == true or char:GetAttribute("Downed") == true then
                return "DOWNED", Color3.fromRGB(255, 130, 60)
            end
            local ci = char:FindFirstChild("CheckInterractable")
            if ci then
                if ci:GetAttribute("isRepairing") then return "REPAIR", Color3.fromRGB(255, 220, 60) end
                if ci:GetAttribute("isHealing") then return "HEAL", Color3.fromRGB(80, 220, 120) end
                if ci:GetAttribute("isVaulting") then return "VAULT", Color3.fromRGB(120, 200, 255) end
                if ci:GetAttribute("isSliding") then return "SLIDE", Color3.fromRGB(150, 180, 255) end
                if ci:GetAttribute("isDroppingPallet") then return "PALLET", Color3.fromRGB(255, 165, 60) end
                if ci:GetAttribute("isUnhooking") then return "UNHOOK", Color3.fromRGB(180, 120, 255) end
                if ci:GetAttribute("isExiting") then return "EXIT", Color3.fromRGB(80, 255, 180) end
            end
            local root = char:FindFirstChild("HumanoidRootPart")
            if root then
                local vel = root.AssemblyLinearVelocity
                local speed = Vector3.new(vel.X, 0, vel.Z).Magnitude
                if speed > 20 then return "SPRINT", Color3.fromRGB(120, 255, 200) end
                if speed > 2 then return "MOVE", Color3.fromRGB(180, 180, 180) end
            end
            return "IDLE", Color3.fromRGB(140, 140, 140)
        end

        local function CreateStatusESP(plr, char, root)
            if not FESPS.Enabled then RemoveStatusESP(char); return end
            if not root then return end
            local head = char:FindFirstChild("Head")
            local hum = char:FindFirstChildOfClass("Humanoid")
            if not head or not hum then return end

            local isDown = hum.Health <= 0 or hum.Health < 2
                or char:GetAttribute("Downed") == true
                or char:GetAttribute("IsDown") == true
                or char:GetAttribute("Knocked") == true

            local dist = (head.Position - root.Position).Magnitude
            if dist > FESPS.Radius then RemoveStatusESP(char); return end

            local accentColor = _G.GLUTO_THEME
            if TeamIs(plr, "Killer") then accentColor = FESPC.Killer
            elseif TeamIs(plr, "Survivor") then accentColor = FESPC.Survivor end
            if isDown then accentColor = Color3.fromRGB(255, 60, 60) end

            local hpPct = math.clamp(hum.Health / math.max(hum.MaxHealth, 1), 0, 1)
            local hpColor
            if hpPct > 0.6 then hpColor = Color3.fromRGB(80, 220, 120)
            elseif hpPct > 0.3 then hpColor = Color3.fromRGB(255, 200, 60)
            else hpColor = Color3.fromRGB(255, 80, 80) end

            local actionText, actionColor = StatusESP_GetAction(char, hum)

            local bb = StatusESP[char]
            if not bb or not bb.Parent then
                bb = Instance.new("BillboardGui")
                bb.Name = "GlutoStatusESP"
                bb.AlwaysOnTop = true
                bb.LightInfluence = 0
                bb.Adornee = head
                bb.StudsOffset = Vector3.new(0, 3.0, 0)
                bb.Size = UDim2.fromOffset(280, 60)
                bb.Parent = char

                local scaleObj = Instance.new("UIScale")
                scaleObj.Name = "DistScale"
                scaleObj.Scale = 1
                scaleObj.Parent = bb

                local card = Instance.new("Frame")
                card.Name = "Card"
                card.Size = UDim2.fromOffset(260, 52)
                card.Position = UDim2.new(0.5, 0, 0, 0)
                card.AnchorPoint = Vector2.new(0.5, 0)
                card.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
                card.BackgroundTransparency = 0.15
                card.BorderSizePixel = 0
                card.Parent = bb
                Instance.new("UICorner", card).CornerRadius = UDim.new(0, 10)

                local cardStroke = Instance.new("UIStroke", card)
                cardStroke.Name = "CardStroke"
                cardStroke.Color = accentColor
                cardStroke.Thickness = 1
                cardStroke.Transparency = 0.4
                cardStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                local accent = Instance.new("Frame")
                accent.Name = "Accent"
                accent.AnchorPoint = Vector2.new(0, 0.5)
                accent.Size = UDim2.new(0, 3, 0, 34)
                accent.Position = UDim2.new(0, 0, 0.5, 0)
                accent.BackgroundColor3 = accentColor
                accent.BorderSizePixel = 0
                accent.Parent = card
                Instance.new("UICorner", accent).CornerRadius = UDim.new(1, 0)

                local avatarHolder = Instance.new("Frame")
                avatarHolder.Name = "AvatarHolder"
                avatarHolder.Size = UDim2.fromOffset(34, 34)
                avatarHolder.Position = UDim2.new(0, 11, 0.5, -17)
                avatarHolder.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                avatarHolder.BorderSizePixel = 0
                avatarHolder.ClipsDescendants = true
                avatarHolder.Parent = card
                Instance.new("UICorner", avatarHolder).CornerRadius = UDim.new(1, 0)

                local avatarStroke = Instance.new("UIStroke", avatarHolder)
                avatarStroke.Name = "AvatarStroke"
                avatarStroke.Color = accentColor
                avatarStroke.Thickness = 1.5
                avatarStroke.Transparency = 0.2
                avatarStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                local avatarImg = Instance.new("ImageLabel")
                avatarImg.Name = "AvatarImg"
                avatarImg.Size = UDim2.fromScale(1, 1)
                avatarImg.BackgroundTransparency = 1
                avatarImg.Image = "rbxthumb://type=AvatarHeadShot&id=" .. plr.UserId .. "&w=150&h=150"
                avatarImg.Parent = avatarHolder

                local nameLbl = Instance.new("TextLabel")
                nameLbl.Name = "NameLbl"
                nameLbl.BackgroundTransparency = 1
                nameLbl.Size = UDim2.new(1, -120, 0, 16)
                nameLbl.Position = UDim2.new(0, 54, 0, 7)
                nameLbl.Font = Enum.Font.GothamBold
                nameLbl.TextSize = 12
                nameLbl.TextColor3 = _G.GLUTO_THEME
                nameLbl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                nameLbl.TextStrokeTransparency = 0.6
                nameLbl.TextXAlignment = Enum.TextXAlignment.Left
                nameLbl.TextYAlignment = Enum.TextYAlignment.Center
                nameLbl.TextTruncate = Enum.TextTruncate.AtEnd
                nameLbl.Text = plr.Name
                nameLbl.Parent = card

                local actionPill = Instance.new("Frame")
                actionPill.Name = "ActionPill"
                actionPill.Size = UDim2.fromOffset(60, 16)
                actionPill.Position = UDim2.new(0, 54, 0, 27)
                actionPill.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
                actionPill.BackgroundTransparency = 0.1
                actionPill.BorderSizePixel = 0
                actionPill.Parent = card
                Instance.new("UICorner", actionPill).CornerRadius = UDim.new(1, 0)

                local actionStroke = Instance.new("UIStroke", actionPill)
                actionStroke.Name = "ActionStroke"
                actionStroke.Color = actionColor
                actionStroke.Thickness = 1
                actionStroke.Transparency = 0.5
                actionStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                local actionDot = Instance.new("Frame")
                actionDot.Name = "ActionDot"
                actionDot.Size = UDim2.fromOffset(5, 5)
                actionDot.Position = UDim2.new(0, 7, 0.5, -2.5)
                actionDot.BackgroundColor3 = actionColor
                actionDot.BorderSizePixel = 0
                actionDot.Parent = actionPill
                Instance.new("UICorner", actionDot).CornerRadius = UDim.new(1, 0)

                local actionLbl = Instance.new("TextLabel")
                actionLbl.Name = "ActionLbl"
                actionLbl.BackgroundTransparency = 1
                actionLbl.Size = UDim2.new(1, -18, 1, 0)
                actionLbl.Position = UDim2.new(0, 16, 0, 0)
                actionLbl.Font = Enum.Font.GothamBold
                actionLbl.TextSize = 9
                actionLbl.TextColor3 = actionColor
                actionLbl.Text = "IDLE"
                actionLbl.TextXAlignment = Enum.TextXAlignment.Left
                actionLbl.TextYAlignment = Enum.TextYAlignment.Center
                actionLbl.Parent = actionPill

                local distLbl = Instance.new("TextLabel")
                distLbl.Name = "DistLbl"
                distLbl.BackgroundTransparency = 1
                distLbl.AnchorPoint = Vector2.new(1, 0)
                distLbl.Size = UDim2.fromOffset(60, 14)
                distLbl.Position = UDim2.new(1, -12, 0, 7)
                distLbl.Font = Enum.Font.GothamBold
                distLbl.TextSize = 11
                distLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
                distLbl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                distLbl.TextStrokeTransparency = 0.5
                distLbl.TextXAlignment = Enum.TextXAlignment.Right
                distLbl.TextYAlignment = Enum.TextYAlignment.Center
                distLbl.Text = "0m"
                distLbl.Parent = card

                local downBadge = Instance.new("Frame")
                downBadge.Name = "DownBadge"
                downBadge.AnchorPoint = Vector2.new(1, 0)
                downBadge.Size = UDim2.fromOffset(42, 15)
                downBadge.Position = UDim2.new(1, -12, 0, 25)
                downBadge.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
                downBadge.BackgroundTransparency = 0.05
                downBadge.BorderSizePixel = 0
                downBadge.Visible = false
                downBadge.Parent = card
                Instance.new("UICorner", downBadge).CornerRadius = UDim.new(1, 0)

                local downLbl = Instance.new("TextLabel")
                downLbl.Name = "DownLbl"
                downLbl.Size = UDim2.fromScale(1, 1)
                downLbl.BackgroundTransparency = 1
                downLbl.Font = Enum.Font.GothamBold
                downLbl.TextSize = 9
                downLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
                downLbl.Text = "DOWN"
                downLbl.Parent = downBadge

                local hpBg = Instance.new("Frame")
                hpBg.Name = "HPBarBg"
                hpBg.AnchorPoint = Vector2.new(0.5, 1)
                hpBg.Size = UDim2.new(1, -20, 0, 3)
                hpBg.Position = UDim2.new(0.5, 0, 1, -5)
                hpBg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                hpBg.BorderSizePixel = 0
                hpBg.Parent = card
                Instance.new("UICorner", hpBg).CornerRadius = UDim.new(1, 0)

                local hpFill = Instance.new("Frame")
                hpFill.Name = "HPFill"
                hpFill.Size = UDim2.new(1, 0, 1, 0)
                hpFill.BackgroundColor3 = hpColor
                hpFill.BorderSizePixel = 0
                hpFill.Parent = hpBg
                Instance.new("UICorner", hpFill).CornerRadius = UDim.new(1, 0)

                StatusESP[char] = bb
            end

            local card = bb:FindFirstChild("Card")
            if not card then return end
            local cardStroke = card:FindFirstChild("CardStroke")
            local accent = card:FindFirstChild("Accent")
            local avatarHolder = card:FindFirstChild("AvatarHolder")
            local avatarStroke = avatarHolder and avatarHolder:FindFirstChild("AvatarStroke")
            local avatarImg = avatarHolder and avatarHolder:FindFirstChild("AvatarImg")
            local nameLbl = card:FindFirstChild("NameLbl")
            local actionPill = card:FindFirstChild("ActionPill")
            local actionStroke = actionPill and actionPill:FindFirstChild("ActionStroke")
            local actionDot = actionPill and actionPill:FindFirstChild("ActionDot")
            local actionLbl = actionPill and actionPill:FindFirstChild("ActionLbl")
            local distLbl = card:FindFirstChild("DistLbl")
            local downBadge = card:FindFirstChild("DownBadge")
            local hpBg = card:FindFirstChild("HPBarBg")
            local hpFill = hpBg and hpBg:FindFirstChild("HPFill")
            local distScale = bb:FindFirstChild("DistScale")

            if accent then accent.BackgroundColor3 = accentColor end
            if cardStroke then
                cardStroke.Color = accentColor
                cardStroke.Transparency = isDown and 0.1 or 0.5
            end
            if avatarStroke then
                avatarStroke.Color = accentColor
                avatarStroke.Transparency = isDown and 0.1 or 0.3
            end
            if avatarHolder then
                avatarHolder.Visible = FESPS.ShowAvatar == true
            end
            if avatarImg and avatarImg.Image == "" then
                avatarImg.Image = "rbxthumb://type=AvatarHeadShot&id=" .. plr.UserId .. "&w=150&h=150"
            end
            if nameLbl then
                nameLbl.Text = plr.Name
                nameLbl.Visible = FESPS.ShowName
                nameLbl.TextColor3 = isDown and Color3.fromRGB(255, 130, 130) or _G.GLUTO_THEME
            end
            if actionPill then
                actionPill.Visible = FESPS.ShowAction == true
                actionPill.Size = UDim2.fromOffset(math.max(50, #actionText * 6 + 24), 16)
            end
            if actionStroke then actionStroke.Color = actionColor end
            if actionDot then actionDot.BackgroundColor3 = actionColor end
            if actionLbl then
                actionLbl.Text = actionText
                actionLbl.TextColor3 = actionColor
            end
            if distLbl then
                distLbl.Text = string.format("%.0fm", dist)
                distLbl.Visible = FESPS.ShowDistance
            end
            if downBadge then downBadge.Visible = isDown end
            if hpBg and hpFill then
                hpFill.Size = UDim2.new(hpPct, 0, 1, 0)
                hpFill.BackgroundColor3 = hpColor
                hpBg.Visible = FESPS.ShowHealth
            end

            if distScale then
                local minScale = 0.40
                local maxScale = 0.55
                local nearDist = 20
                local farDist  = 180

                local t = math.clamp((dist - nearDist) / math.max(farDist - nearDist, 1), 0, 1)
                local eased = 1 - (1 - t) * (1 - t)
                local targetScale = maxScale - (maxScale - minScale) * eased

                local currentScale = distScale.Scale
                distScale.Scale = currentScale + (targetScale - currentScale) * 0.25
            end

            if nameLbl then
                nameLbl.TextTransparency = math.clamp((dist - 250) / 500, 0, 0.25)
            end
        end

        local function GetGameValue(obj, name)
            if not obj then return nil end
            local attr = obj:GetAttribute(name)
            if attr ~= nil then return attr end
            local child = obj:FindFirstChild(name)
            if child then
                local ok, v = pcall(function() return child.Value end)
                if ok then return v end
            end
            return nil
        end

        local function UpdateGenerator(gen)
            if not gen or not gen.Parent then return end
            if not FESP.Generator then
                local o = gen:FindFirstChild("GenESP"); if o then o:Destroy() end
                local h = gen:FindFirstChild("GenHighlight"); if h then h:Destroy() end
                return
            end

            local percent = GetGameValue(gen, "RepairProgress")
                or GetGameValue(gen, "Progress")
                or GetGameValue(gen, "ProgressRepair") or 0

            local bb = gen:FindFirstChild("GenESP")
            local isDone = percent >= 100
            local statusText = isDone and "DONE" or string.format("%.0f%%", percent)
            local currentColor = isDone and Color3.fromRGB(0, 200, 100) or FESPC.Generator

            if not bb then
                bb = Instance.new("BillboardGui")
                bb.Name = "GenESP"
                bb.Size = UDim2.fromOffset(80, 20)
                bb.AlwaysOnTop = true
                bb.StudsOffset = Vector3.new(0, 2.5, 0)

                local scaleObj = Instance.new("UIScale")
                scaleObj.Name = "DistScale"
                scaleObj.Scale = 1
                scaleObj.Parent = bb

                local container = Instance.new("Frame")
                container.Name = "Container"
                container.Size = UDim2.fromOffset(80, 20)
                container.Position = UDim2.new(0.5, 0, 0.5, 0)
                container.AnchorPoint = Vector2.new(0.5, 0.5)
                container.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
                container.BackgroundTransparency = 0.05
                container.BorderSizePixel = 0
                container.Parent = bb
                Instance.new("UICorner", container).CornerRadius = UDim.new(0, 4)

                local stroke = Instance.new("UIStroke", container)
                stroke.Color = Color3.fromRGB(60, 60, 60)
                stroke.Thickness = 1
                stroke.Transparency = 0

                local lblGEN = Instance.new("TextLabel")
                lblGEN.Name = "LabelGEN"
                lblGEN.Size = UDim2.new(0.45, 0, 1, 0)
                lblGEN.BackgroundTransparency = 1
                lblGEN.Text = "GEN"
                lblGEN.TextColor3 = Color3.fromRGB(255, 255, 255)
                lblGEN.Font = Enum.Font.GothamBold
                lblGEN.TextSize = 11
                lblGEN.TextXAlignment = Enum.TextXAlignment.Right
                lblGEN.Parent = container

                local lblPCT = Instance.new("TextLabel")
                lblPCT.Name = "LabelPCT"
                lblPCT.Size = UDim2.new(0.55, 0, 1, 0)
                lblPCT.Position = UDim2.new(0.45, 0, 0, 0)
                lblPCT.BackgroundTransparency = 1
                lblPCT.Text = statusText
                lblPCT.TextColor3 = currentColor
                lblPCT.Font = Enum.Font.GothamBold
                lblPCT.TextSize = 11
                lblPCT.TextXAlignment = Enum.TextXAlignment.Left
                lblPCT.Parent = container

                bb.Adornee = gen
                bb.Parent = gen
            else
                local container = bb:FindFirstChild("Container")
                if container then
                    local lblPCT = container:FindFirstChild("LabelPCT")
                    if lblPCT then
                        lblPCT.Text = statusText
                        lblPCT.TextColor3 = currentColor
                    end
                end
            end

            local scaleObj = bb:FindFirstChild("DistScale")
            if scaleObj then
                local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if myRoot then
                    local genPos
                    pcall(function() genPos = gen:GetPivot().Position end)
                    if genPos then
                        local dist = (genPos - myRoot.Position).Magnitude
                        local scaleVal = math.clamp(80 / math.max(dist, 1), 0.4, 1.0)
                        scaleObj.Scale = scaleVal
                    end
                end
            end

            local h = gen:FindFirstChild("GenHighlight") or Instance.new("Highlight")
            h.Name = "GenHighlight"
            h.Adornee = gen
            h.FillColor = currentColor
            h.OutlineColor = currentColor
            h.FillTransparency = 1
            h.OutlineTransparency = 0
            h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            h.Parent = gen
        end

        local function UpdateMapESP(obj, root)
            if not obj or not root or not obj.Parent then return end
            local pos
            if obj:IsA("Model") then
                if obj.PrimaryPart then pos = obj.PrimaryPart.Position
                else
                    local ok, pivot = pcall(function() return obj:GetPivot().Position end)
                    pos = ok and pivot or nil
                    if not pos then
                        local bp = obj:FindFirstChildWhichIsA("BasePart", true)
                        if bp then pos = bp.Position end
                    end
                end
            elseif obj:IsA("BasePart") then
                pos = obj.Position
            end
            if not pos then return end
            local dist = (pos - root.Position).Magnitude

            if obj.Name == "Pallet" or obj.Name == "Palletwrong" then
                if FESP.Pallet and dist <= FESP.Distance then
                    CreateESP(obj, FESPC.Pallet)
                else
                    RemoveESP(obj)
                end
            end
        end

        local function UpdateSCPEsp(root)
            if not FESP.SCP then
                for obj in pairs(CachedSCP) do RemoveESP(obj) end
                return
            end
            for obj in pairs(CachedSCP) do
                if obj and obj.Parent then
                    local pos
                    if obj:IsA("Model") then
                        local ok, pivot = pcall(function() return obj:GetPivot().Position end)
                        pos = ok and pivot or nil
                    elseif obj:IsA("BasePart") then
                        pos = obj.Position
                    end
                    if pos then
                        local dist = (pos - root.Position).Magnitude
                        if dist <= FESP.Distance then
                            CreateESP(obj, FESPC.SCP)
                        else
                            RemoveESP(obj)
                        end
                    end
                end
            end
        end

        local function RemoveWindowESP(model)
            if not model then return end
            local wData = WindowObjects[model]
            if wData then
                if wData.highlight then pcall(function() wData.highlight:Destroy() end) end
                if wData.box then pcall(function() wData.box:Destroy() end) end
                if wData.bottomPart and wData.bottomPart.Parent then
                    pcall(function()
                        local orig = wData.bottomPart:GetAttribute("ESP_OrigTrans")
                        if orig ~= nil then
                            wData.bottomPart.Transparency = orig
                            wData.bottomPart:SetAttribute("ESP_OrigTrans", nil)
                        end
                    end)
                end
                WindowObjects[model] = nil
            end
            if CachedWindow[model] then CachedWindow[model] = nil end
        end

        local function HandleWindowObject(child)
            if not FESP.Window then return end
            if not child or child.Name ~= "VaultTrigger" then return end
            local winModel = child.Parent
            if not winModel or not winModel:IsA("Model") then return end
            if WindowObjects[winModel] then return end

            local bottomPart = winModel:FindFirstChild("Bottom")
            if not bottomPart or not bottomPart:IsA("BasePart") then
                local bestSize = 0
                for _, p in ipairs(winModel:GetChildren()) do
                    if p:IsA("BasePart")
                       and p.Name ~= "VaultTrigger"
                       and p.Name ~= "inviswall"
                       and p.Size.Magnitude > bestSize then
                        bestSize = p.Size.Magnitude
                        bottomPart = p
                    end
                end
            end
            if not bottomPart then return end

            if bottomPart:GetAttribute("ESP_OrigTrans") == nil then
                bottomPart:SetAttribute("ESP_OrigTrans", bottomPart.Transparency)
            end
            if bottomPart.Transparency > 0.5 then
                bottomPart.Transparency = 0.5
            end

            local box = Instance.new("BoxHandleAdornment")
            box.Name = "GlutoWindowBox"
            box.Adornee = bottomPart
            box.Size = bottomPart.Size
            box.Color3 = FESPC.Window
            box.Transparency = 0.3
            box.AlwaysOnTop = true
            box.ZIndex = 5
            box.Parent = bottomPart

            local hl = Instance.new("Highlight")
            hl.Name = "GlutoWindowHighlight"
            hl.Adornee = winModel
            hl.FillColor = FESPC.Window
            hl.FillTransparency = 0.9
            hl.OutlineColor = FESPC.Window
            hl.OutlineTransparency = 0.1
            hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            hl.Parent = winModel

            WindowObjects[winModel] = {
                highlight = hl,
                box = box,
                bottomPart = bottomPart,
            }
        end

        local function ScanAllWindows()
            if not FESP.Window then return end
            local map = Workspace:FindFirstChild("Map")
            if not map then return end
            for _, obj in ipairs(map:GetDescendants()) do
                if obj.Name == "VaultTrigger" then
                    HandleWindowObject(obj)
                end
            end
        end

        Workspace.DescendantAdded:Connect(function(obj)
            if obj.Name == "VaultTrigger" and FESP.Window then
                task.defer(function() HandleWindowObject(obj) end)
            end
        end)

        local espLastUpdate = 0
        RunService.RenderStepped:Connect(function()
            local now = tick()
            if now - espLastUpdate < 0.05 then return end
            espLastUpdate = now

            local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if not root then return end

            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character then
                    local char = p.Character
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if hum and hum.Health > 0 then
                        local hrp = char:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            local dist = (hrp.Position - root.Position).Magnitude
                            if dist <= FESP.Distance then
                                if FESP.Survivor and TeamIs(p, "Survivor") then
                                    CreateESP(char, FESPC.Survivor)
                                elseif FESP.Killer and TeamIs(p, "Killer") then
                                    CreateESP(char, FESPC.Killer)
                                else
                                    RemoveESP(char)
                                end
                            else
                                RemoveESP(char)
                            end
                        end
                        CreateStatusESP(p, char, root)
                    else
                        RemoveESP(char)
                        RemoveStatusESP(char)
                    end
                end
            end

            if FESP.Generator then
                for gen in pairs(CachedGen) do UpdateGenerator(gen) end
            end
            for obj in pairs(CachedPallet) do UpdateMapESP(obj, root) end
            UpdateSCPEsp(root)

            if FESP.Window then
                if not _G.GlutoWindowScanned then
                    _G.GlutoWindowScanned = true
                    pcall(ScanAllWindows)
                end
            else
                _G.GlutoWindowScanned = false
                for model in pairs(WindowObjects) do
                    RemoveWindowESP(model)
                end
            end
        end)
    end

    do
        local MV = getgenv().GlutoInvis
        if not MV then
            MV = {
                Enabled = false, Loading = false, Ready = false, API = nil,
                _lastToggle = 0, _retries = 0, _retryMax = 3,
                _retryDelay = 2, _queueState = nil,
            }
            getgenv().GlutoInvis = MV
        end
        local INVIS_URL = "https://leekguy.vercel.app/roblox/menghub/crack_obf_invisible_93978595733734.lua"
        local function Invis_ValidateAPI(api)
            if type(api) ~= "table" then return false end
            if type(api.enable) ~= "function" then return false end
            if type(api.disable) ~= "function" then return false end
            return true
        end
        local function Invis_Cleanup()
            pcall(function()
                local chair = Workspace:FindFirstChild("invischair")
                if chair then chair:Destroy() end
                local char = LocalPlayer.Character
                if char then
                    for _, part in ipairs(char:GetDescendants()) do
                        if part:IsA("BasePart") or part:IsA("Decal") then
                            if part.Name ~= "Hurtbox"
                               and part.Name ~= "HumanoidRootPart"
                               and part.Name ~= "HRP_Clone" then
                                part.Transparency = 0
                                if part:IsA("BasePart") then
                                    part.LocalTransparencyModifier = 0
                                end
                            end
                        end
                    end
                end
            end)
        end
        local function Invis_RefreshButton()
            if getgenv().Gluto_InvisBtn_UpdateVisual then
                pcall(getgenv().Gluto_InvisBtn_UpdateVisual)
            end
        end
        local function Invis_LoadAPI()
            if _G.MengHub and _G.MengHub.Invisible and Invis_ValidateAPI(_G.MengHub.Invisible) then
                MV.API = _G.MengHub.Invisible
                MV.Ready = true
                print("[GlutoInvis] MengHub API sudah tersedia di _G")
                return true
            end
            MV.Loading = true; MV.Ready = false
            for attempt = 1, MV._retryMax do
                MV._retries = attempt
                print(("[GlutoInvis] Loading API... (%d/%d)"):format(attempt, MV._retryMax))
                local ok, err = pcall(function()
                    loadstring(game:HttpGet(INVIS_URL))()
                end)
                task.wait(0.5)
                if ok and _G.MengHub and _G.MengHub.Invisible and Invis_ValidateAPI(_G.MengHub.Invisible) then
                    MV.API = _G.MengHub.Invisible
                    MV.Ready = true; MV.Loading = false
                    print(("[GlutoInvis] API loaded OK (attempt %d)"):format(attempt))
                    Invis_RefreshButton()
                    if MV._queueState ~= nil then
                        local queued = MV._queueState
                        MV._queueState = nil
                        task.defer(function() W.Invisible_SetState(queued, false) end)
                    end
                    return true
                else
                    warn(("[GlutoInvis] Attempt %d gagal: %s"):format(attempt, tostring(err)))
                    if attempt < MV._retryMax then task.wait(MV._retryDelay) end
                end
            end
            MV.Loading = false; MV.Ready = false
            print("[GlutoInvis] Semua retry gagal")
            Invis_RefreshButton()
            return false
        end
        task.spawn(function() Invis_LoadAPI() end)
        function W.Invisible_SetState(state, fromButton)
            state = state and true or false
            local now = tick()
            if now - MV._lastToggle < 0.25 then return end
            if not MV.API then
                if MV.Loading then
                    VD_Notify("Invisible", "Loading API...", 2)
                    MV._queueState = state
                else
                    VD_Notify("Invisible", "API gagal, retry...", 2)
                    MV._queueState = state
                    task.spawn(function()
                        if Invis_LoadAPI() then
                            local q = MV._queueState
                            MV._queueState = nil
                            if q ~= nil then
                                task.defer(function() W.Invisible_SetState(q, fromButton) end)
                            end
                        end
                    end)
                end
                return
            end
            if MV.Enabled == state then
                if not state then Invis_Cleanup() end
                Invis_RefreshButton()
                return
            end
            MV._lastToggle = now
            MV.Enabled = state
            VD.Invis_Enabled = state
            if state then
                local ok, err = pcall(function() MV.API.enable() end)
                if not ok then
                    warn("[GlutoInvis] enable error:", err)
                    MV.Enabled = false
                    VD.Invis_Enabled = false
                    Invis_Cleanup()
                    if not fromButton then VD_Notify("Invisible", "Gagal enable", 2) end
                else
                    if not fromButton then VD_Notify("Invisible", "Invisible AKTIF", 2) end
                end
            else
                pcall(function() MV.API.disable() end)
                Invis_Cleanup()
                if not fromButton then VD_Notify("Invisible", "Invisible Nonaktif", 2) end
            end
            Invis_RefreshButton()
        end
        function W.Invisible_SetEnabled(v)  W.Invisible_SetState(v and true or false, false) end
        function W.Invisible_Start()        W.Invisible_SetState(true, false)  end
        function W.Invisible_Stop()         W.Invisible_SetState(false, false) end
        function W.Invisible_Toggle()       W.Invisible_SetState(not MV.Enabled, false) end
        function W.Invisible_SetHotkey(kc)
            if kc and typeof(kc) == "EnumItem" then
                VD.Invis_Hotkey = kc.Name
            elseif type(kc) == "string" then
                VD.Invis_Hotkey = kc
            end
        end
        UserInputService.InputBegan:Connect(function(input, gp)
            if gp then return end
            if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
            local hkName = VD.Invis_Hotkey or "G"
            local hk = Enum.KeyCode[hkName]
            if hk and input.KeyCode == hk then
                W.Invisible_SetState(not MV.Enabled, false)
            end
        end)
        LocalPlayer.CharacterAdded:Connect(function()
            task.wait(1.2)
            if MV.Enabled and MV.API then
                pcall(function() MV.API.enable() end)
                Invis_RefreshButton()
            end
        end)
        pcall(function()
            game:BindToClose(function()
                if MV.Enabled and MV.API then
                    pcall(function() MV.API.disable() end)
                end
                Invis_Cleanup()
            end)
        end)
        Players.PlayerRemoving:Connect(function(plr)
            if plr == LocalPlayer then
                if MV.Enabled and MV.API then
                    pcall(function() MV.API.disable() end)
                end
                Invis_Cleanup()
            end
        end)
        W.Invisible_IsReady   = function() return MV.Ready and MV.API ~= nil end
        W.Invisible_IsLoading = function() return MV.Loading end
        W.Invisible_IsOn      = function() return MV.Enabled end
        W.Invisible_ReloadAPI = function() return Invis_LoadAPI() end
        W.Invisible_GetStatus = function()
            if MV.Loading then return "LOADING" end
            if not MV.Ready then return "FAILED" end
            if MV.Enabled then return "ON" end
            return "READY"
        end
    end

    getgenv().Bypass_HiddenLeapBypassThread = nil
    function W.BYPASS_StartHiddenCooldownBypass()
        if getgenv().Bypass_HiddenLeapBypassThread then return end
        getgenv().Bypass_HiddenLeapBypassThread = task.spawn(function()
            local leapFunction, m2Function
            local function scanGC()
                pcall(function()
                    for _, v in pairs(getgc(true)) do
                        if type(v) == "function" and islclosure(v) then
                            local info
                            pcall(function() info = debug.getinfo(v) end)
                            if info then
                                if info.name == "tryActivate" then leapFunction = v
                                elseif info.name == "playM2Animation" then m2Function = v end
                            end
                        end
                        if leapFunction and m2Function then break end
                    end
                end)
            end
            scanGC()
            local lastScan = os.clock()
            while task.wait(0.1) do
                if not VD.KILLER_BypassLeap then break end
                if not (leapFunction and m2Function) then
                    if os.clock() - lastScan >= 2 then lastScan = os.clock(); scanGC() end
                end
                if leapFunction then
                    pcall(function()
                        for i, val in pairs(debug.getupvalues(leapFunction)) do
                            if type(val) == "boolean" and val == true then
                                debug.setupvalue(leapFunction, i, false)
                            end
                        end
                    end)
                end
                if m2Function then
                    pcall(function()
                        for i, val in pairs(debug.getupvalues(m2Function)) do
                            if type(val) == "boolean" and val == true then
                                debug.setupvalue(m2Function, i, false)
                            end
                        end
                    end)
                end
            end
            getgenv().Bypass_HiddenLeapBypassThread = nil
        end)
    end
    function W.BYPASS_StopHiddenCooldownBypass() end
    function W.BYPASS_SetHiddenLeap(v)
        VD.KILLER_BypassLeap = v and true or false
        if VD.KILLER_BypassLeap then W.BYPASS_StartHiddenCooldownBypass()
        else W.BYPASS_StopHiddenCooldownBypass() end
    end

    W.MyersGrabData = W.MyersGrabData or { Enabled = false, HotkeyCode = Enum.KeyCode.H }
    local MyersGrabData = W.MyersGrabData
    function W.getMyersTarget()
        local char = LocalPlayer.Character
        if not char then return nil end
        local myHRP = char:FindFirstChild("HumanoidRootPart")
        if not myHRP then return nil end
        local candidates = {}
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local hrp = player.Character:FindFirstChild("HumanoidRootPart")
                local hum = player.Character:FindFirstChildOfClass("Humanoid")
                if hrp and hum and hum.Health > 0 then
                    table.insert(candidates, {
                        player = player, dist = (hrp.Position - myHRP.Position).Magnitude, health = hum.Health
                    })
                end
            end
        end
        table.sort(candidates, function(a, b) return a.dist < b.dist end)
        for _, c in ipairs(candidates) do return c.player end
        return nil
    end
    function W.doMyersGrab()
        if not MyersGrabData.Enabled then return end
        local target = W.getMyersTarget()
        if not target or not target.Character then return end
        pcall(function() ReplicatedStorage.Remotes.Killers.Stalker.grab:FireServer(target.Character) end)
    end
    function W.setMyersGrab(v)
        MyersGrabData.Enabled = v and true or false
        VD.KILLER_InfGrab = MyersGrabData.Enabled
        if getgenv().Gluto_MGrabBtn_UpdateVisual then pcall(getgenv().Gluto_MGrabBtn_UpdateVisual) end
    end
    UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.KeyCode == MyersGrabData.HotkeyCode and MyersGrabData.Enabled then
            W.doMyersGrab()
        end
    end)

    getgenv().MAWWW_SlasherCooldownBypassThread = nil
    function W.MAWWW_StartSlasherCooldownBypass()
        if getgenv().MAWWW_SlasherCooldownBypassThread then return end
        pcall(function()
            local b = true
            local mt = debug.getmetatable(b)
            if not mt then mt = {}; debug.setmetatable(b, mt) end
            if setreadonly then setreadonly(mt, false) end
            mt.__div = function() return 0 end
            mt.__mul = function() return 0 end
            mt.__add = function() return 0 end
            mt.__sub = function() return 0 end
            if setreadonly then setreadonly(mt, true) end
        end)
        getgenv().MAWWW_SlasherCooldownBypassThread = task.spawn(function()
            local toggleFunc = nil
            local pursuitHandler = nil
            local function scanGCForSlasher()
                pcall(function()
                    for _, v in pairs(getgc(true)) do
                        if type(v) == "function" and islclosure(v) then
                            local consts = debug.getconstants(v)
                            local hasOffset, hasLinear, hasAction, hasTweenInfo = false, false, false, false
                            local hasPursuit, hasWalkSpeed = false, false
                            for _, c in pairs(consts) do
                                if c == "Offset" then hasOffset = true end
                                if c == "Linear" then hasLinear = true end
                                if c == "action" then hasAction = true end
                                if c == "TweenInfo" then hasTweenInfo = true end
                                if c == "Pursuit" then hasPursuit = true end
                                if c == "WalkSpeed" then hasWalkSpeed = true end
                            end
                            if hasOffset and hasLinear and hasAction and hasTweenInfo and not hasPursuit then toggleFunc = v end
                            if hasPursuit and hasTweenInfo and hasAction and hasWalkSpeed then pursuitHandler = v end
                        end
                        if toggleFunc and pursuitHandler then break end
                    end
                end)
            end
            scanGCForSlasher()
            local lastScan = os.clock()
            while task.wait(0.1) do
                if not VD.KILLER_InfLakeMist and not VD.KILLER_InfPursuit then break end
                if not (toggleFunc and pursuitHandler) then
                    if os.clock() - lastScan >= 2 then scanGCForSlasher(); lastScan = os.clock() end
                end
                if toggleFunc and VD.KILLER_InfLakeMist then
                    pcall(function()
                        debug.setupvalue(toggleFunc, 6, false)
                        debug.setupvalue(toggleFunc, 10, false)
                    end)
                end
                if pursuitHandler and VD.KILLER_InfPursuit then
                    pcall(function()
                        debug.setupvalue(pursuitHandler, 5, false)
                        debug.setupvalue(pursuitHandler, 6, false)
                    end)
                end
            end
            getgenv().MAWWW_SlasherCooldownBypassThread = nil
        end)
    end
    function W.MAWWW_StopSlasherCooldownBypass()
        pcall(function()
            local jason = ReplicatedStorage:FindFirstChild("Remotes")
                and ReplicatedStorage.Remotes:FindFirstChild("Killers")
                and ReplicatedStorage.Remotes.Killers:FindFirstChild("Jason")
            if jason then
                if not VD.KILLER_InfLakeMist then
                    local lm = jason:FindFirstChild("LakeMist")
                    if lm then lm:FireServer(false) end
                end
                if not VD.KILLER_InfPursuit then
                    local ps = jason:FindFirstChild("Pursuit")
                    if ps then ps:FireServer(false) end
                end
            end
        end)
    end
    function W.MAWWW_SetLakeMist(v)
        VD.KILLER_InfLakeMist = v and true or false
        if VD.KILLER_InfLakeMist or VD.KILLER_InfPursuit then W.MAWWW_StartSlasherCooldownBypass()
        else W.MAWWW_StopSlasherCooldownBypass() end
    end
    function W.MAWWW_SetPursuit(v)
        VD.KILLER_InfPursuit = v and true or false
        if VD.KILLER_InfLakeMist or VD.KILLER_InfPursuit then W.MAWWW_StartSlasherCooldownBypass()
        else W.MAWWW_StopSlasherCooldownBypass() end
    end

    getgenv().MAWWW_AbyssCooldownBypassConnection = nil
    getgenv().MAWWW_CorruptHandlerFunc = nil
    function W.MAWWW_StartAbyssCooldownBypass()
        if not getgenv().MAWWW_CorruptHandlerFunc then
            pcall(function()
                for _, v in pairs(getgc(true)) do
                    if type(v) == "function" and islclosure(v) then
                        local constants = debug.getconstants(v)
                        if table.find(constants, "corrupt") and table.find(constants, "Immobile") then
                            getgenv().MAWWW_CorruptHandlerFunc = v
                            break
                        end
                    end
                end
            end)
        end
        if not getgenv().MAWWW_CorruptHandlerFunc then return end
        if getgenv().MAWWW_AbyssCooldownBypassConnection then
            getgenv().MAWWW_AbyssCooldownBypassConnection:Disconnect()
        end
        getgenv().MAWWW_AbyssCooldownBypassConnection = RunService.Heartbeat:Connect(function()
            if not VD.KILLER_BypassCooldown then return end
            if getgenv().MAWWW_CorruptHandlerFunc then
                local upvalues = debug.getupvalues(getgenv().MAWWW_CorruptHandlerFunc)
                for idx, val in pairs(upvalues) do
                    if type(val) == "boolean" and val == false then
                        debug.setupvalue(getgenv().MAWWW_CorruptHandlerFunc, idx, true)
                    end
                end
            end
        end)
    end
    function W.MAWWW_StopAbyssCooldownBypass()
        if getgenv().MAWWW_AbyssCooldownBypassConnection then
            getgenv().MAWWW_AbyssCooldownBypassConnection:Disconnect()
            getgenv().MAWWW_AbyssCooldownBypassConnection = nil
        end
    end
    function W.MAWWW_SetAbyssBypass(v)
        VD.KILLER_BypassCooldown = v and true or false
        if VD.KILLER_BypassCooldown then W.MAWWW_StartAbyssCooldownBypass()
        else W.MAWWW_StopAbyssCooldownBypass() end
    end

    getgenv().MAWWW_JeffCooldownBypassThread = nil
    function W.MAWWW_StartJeffCooldownBypass()
        if getgenv().MAWWW_JeffCooldownBypassThread then return end
        getgenv().MAWWW_JeffCooldownBypassThread = task.spawn(function()
            while task.wait() do
                if not VD.KILLER_InfFrenzy then break end
                pcall(function()
                    local char = LocalPlayer.Character
                    if char and char:GetAttribute("Frenzy") ~= true then
                        char:SetAttribute("Frenzy", true)
                    end
                end)
            end
            getgenv().MAWWW_JeffCooldownBypassThread = nil
        end)
    end
    function W.MAWWW_StopJeffCooldownBypass()
        pcall(function()
            local char = LocalPlayer.Character
            if char and char:GetAttribute("Frenzy") == true then
                char:SetAttribute("Frenzy", false)
                local killer = ReplicatedStorage:FindFirstChild("Remotes")
                    and ReplicatedStorage.Remotes:FindFirstChild("Killers")
                    and ReplicatedStorage.Remotes.Killers:FindFirstChild("Killer")
                if killer then
                    local deact = killer:FindFirstChild("Deactivatefromclient")
                    if deact then deact:FireServer() end
                end
            end
        end)
    end
    function W.MAWWW_SetJeffFrenzy(v)
        VD.KILLER_InfFrenzy = v and true or false
        if VD.KILLER_InfFrenzy then W.MAWWW_StartJeffCooldownBypass()
        else W.MAWWW_StopJeffCooldownBypass() end
    end

    function W.SetupAntiBlind()
        pcall(function()
            local r  = ReplicatedStorage:FindFirstChild("Remotes")
            local i  = r and r:FindFirstChild("Items")
            local fl = i and i:FindFirstChild("Flashlight")
            local gb = fl and fl:FindFirstChild("GotBlinded")
            if not (gb and gb:IsA("RemoteEvent")) then return end

            local ok, mt = pcall(function() return getrawmetatable(game) end)
            if ok and mt and setreadonly then
                pcall(function()
                    setreadonly(mt, false)
                    local old = mt.__namecall
                    mt.__namecall = newcclosure(function(self, ...)
                        if not checkcaller() and getgenv().VD and getgenv().VD.KILLER_AntiBlind and self == gb then
                            local method = getnamecallmethod()
                            if method == "FireServer" and W.GetRole() == "Killer" then
                                return nil
                            end
                        end
                        return old(self, ...)
                    end)
                    setreadonly(mt, true)
                end)
            end
        end)
    end
    pcall(W.SetupAntiBlind)

    getgenv().MAWWW_IsBreakingPallet = false
    function W.MAWWW_DestroyAllPallets()
        if not VD.KILLER_DestroyPallets then return end
        if W.GetRole() ~= "Killer" then return end
        if getgenv().MAWWW_IsBreakingPallet then return end

        local char = LocalPlayer.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if not char or not root then return end

        local stunned = char:GetAttribute("IsStunned") or char:GetAttribute("isStunned")
        local immobile = char:GetAttribute("Immobile") or char:GetAttribute("immobile")
        local carrying = char:GetAttribute("IsCarrying") or char:GetAttribute("isCarrying")
        local ci = char:FindFirstChild("CheckInterractable")
        local action = ci and (ci:GetAttribute("action") or ci:GetAttribute("Action"))
        if stunned or immobile or carrying or action then return end

        local pts = CollectionService:GetTagged("PalletPointSlide")
        local nearest, minDist = nil, 6
        for _, p in ipairs(pts) do
            if p:IsA("BasePart") and not CollectionService:HasTag(p, "doing action") then
                local d = (p.Position - root.Position).Magnitude
                if d < minDist then minDist = d; nearest = p end
            end
        end
        if not nearest then return end

        getgenv().MAWWW_IsBreakingPallet = true
        task.spawn(function()
            pcall(function()
                local r = ReplicatedStorage:FindFirstChild("Remotes")
                local pFold = r and r:FindFirstChild("Pallet")
                local j = pFold and pFold:FindFirstChild("Jason")
                if j then
                    local dg = j:FindFirstChild("Destroy-Global")
                    local commit = j:FindFirstChild("PalletBreakCommit")
                    if dg and dg:IsA("RemoteEvent") then dg:FireServer(nearest) end
                    if commit and commit:IsA("RemoteEvent") then commit:FireServer(nearest) end
                end
            end)
            task.wait(0.2)
            local start = os.clock()
            while char and char.Parent and (char:GetAttribute("Immobile") or char:GetAttribute("immobile")) do
                if os.clock() - start > 3 then break end
                task.wait(0.1)
            end
            getgenv().MAWWW_IsBreakingPallet = false
        end)
    end

    local VD_OriginalLungeBoost = nil
    function VD_UpdateInfiniteLunge()
        local char = LocalPlayer.Character
        if not char then return end

        if VD.KILLER_InfLunge then
            if char:GetAttribute("lungeboost") ~= 999999 then
                VD_OriginalLungeBoost = char:GetAttribute("lungeboost") or 1
                char:SetAttribute("lungeboost", 999999)
            end
        else
            if VD_OriginalLungeBoost then
                char:SetAttribute("lungeboost", VD_OriginalLungeBoost)
                VD_OriginalLungeBoost = nil
            end
        end
    end
    W.VD_UpdateInfiniteLunge = VD_UpdateInfiniteLunge

    LocalPlayer.CharacterRemoving:Connect(function()
        VD_OriginalLungeBoost = nil
    end)

    do
        local AttackAim = {
            Enabled = false, Holding = false, Strength = 1,
            Predict = true, PredictStrength = 0.12, FOV = 250,
            VisibilityCheck = true, AimPart = "HumanoidRootPart",
        }

        local AttackAimConnection = nil
        local CurrentAttackButton = nil
        local AttackPaths = {
            "Slasher-mob.Controls.attack",
            "Masked-mob.Controls.attack",
            "Killer-mob.Controls.attack",
        }

        local RayParams = RaycastParams.new()
        RayParams.FilterType = Enum.RaycastFilterType.Exclude

        local function AL_IsVisible(part)
            local cam = Workspace.CurrentCamera
            if not cam then return true end
            RayParams.FilterDescendantsInstances = { LocalPlayer.Character }
            local origin = cam.CFrame.Position
            local dir = part.Position - origin
            local result = Workspace:Raycast(origin, dir, RayParams)
            if not result then return true end
            return result.Instance:IsDescendantOf(part.Parent)
        end

        local function AL_GetAttackButton()
            for _, path in ipairs(AttackPaths) do
                local current = LocalPlayer:FindFirstChild("PlayerGui")
                for seg in string.gmatch(path, "[^%.]+") do
                    current = current and current:FindFirstChild(seg)
                end
                if current and current:IsA("GuiObject") then return current end
            end
            return nil
        end

        local function AL_GetClosestAttackTarget()
            local cam = Workspace.CurrentCamera
            if not cam then return nil end
            local center = Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y/2)
            local closest, shortest = nil, AttackAim.FOV
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Team and string.find(string.lower(p.Team.Name), "survivor", 1, true) and p.Character then
                    local hrp = p.Character:FindFirstChild(AttackAim.AimPart)
                    local hum = p.Character:FindFirstChildOfClass("Humanoid")
                    if hrp and hum and hum.Health > 0 then
                        local pos, visible = cam:WorldToViewportPoint(hrp.Position)
                        if visible then
                            local dist = (Vector2.new(pos.X, pos.Y) - center).Magnitude
                            if dist < shortest then
                                if AttackAim.VisibilityCheck then
                                    if not AL_IsVisible(hrp) then continue end
                                end
                                shortest = dist
                                closest = hrp
                            end
                        end
                    end
                end
            end
            return closest
        end

        local function AL_StartAttackAim()
            if AttackAimConnection then return end
            AttackAimConnection = RunService.RenderStepped:Connect(function()
                if not AttackAim.Enabled then return end
                if not AttackAim.Holding then return end
                local target = AL_GetClosestAttackTarget()
                if not target then return end
                local cam = Workspace.CurrentCamera
                local pos = target.Position
                if AttackAim.Predict then
                    pos = pos + (target.AssemblyLinearVelocity * AttackAim.PredictStrength)
                end
                cam.CFrame = CFrame.new(cam.CFrame.Position, pos)
            end)
        end

        UserInputService.InputBegan:Connect(function(input, gp)
            if gp then return end
            if input.UserInputType == Enum.UserInputType.MouseButton2 and AttackAim.Enabled then
                AttackAim.Holding = true
            end
        end)
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton2 then
                AttackAim.Holding = false
            end
        end)

        task.spawn(function()
            while true do
                task.wait(1)
                local btn = AL_GetAttackButton()
                if btn and btn ~= CurrentAttackButton then
                    CurrentAttackButton = btn
                    btn.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.Touch and AttackAim.Enabled then
                            AttackAim.Holding = true
                        end
                    end)
                    btn.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.Touch then
                            AttackAim.Holding = false
                        end
                    end)
                end
            end
        end)

        W.AttackAim_Start = AL_StartAttackAim
        W.AttackAim_Cfg = AttackAim
    end

    do
        local GunAim = {
            Enabled = false, Holding = false, TargetMode = "Killer",
            Strength = 1, Predict = true, PredictStrength = 0.12,
            FOV = 250, VisibilityCheck = true,
            AimPart = "HumanoidRootPart", Target = nil,
        }

        local GunAimConnection = nil
        local CurrentGunButton = nil

        local function GA_IsVisible(part)
            local cam = Workspace.CurrentCamera
            if not cam then return true end
            local rp = RaycastParams.new()
            rp.FilterType = Enum.RaycastFilterType.Exclude
            rp.FilterDescendantsInstances = { LocalPlayer.Character }
            local origin = cam.CFrame.Position
            local dir = part.Position - origin
            local result = Workspace:Raycast(origin, dir, rp)
            if not result then return true end
            return result.Instance:IsDescendantOf(part.Parent)
        end

        local function GA_GetButton()
            local current = LocalPlayer:FindFirstChild("PlayerGui")
            for seg in string.gmatch("Survivor-mob.Controls.Gui-mob", "[^%.]+") do
                current = current and current:FindFirstChild(seg)
            end
            return current
        end

        local function GA_GetClosestTarget()
            local cam = Workspace.CurrentCamera
            if not cam then return nil end
            local center = Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y/2)
            local closest, shortest = nil, GunAim.FOV
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Team then
                    local valid = false
                    if GunAim.TargetMode == "Killer" and string.find(string.lower(p.Team.Name), "killer", 1, true) then valid = true
                    elseif GunAim.TargetMode == "Survivor" and string.find(string.lower(p.Team.Name), "survivor", 1, true) then valid = true end
                    if valid then
                        local hrp = p.Character:FindFirstChild(GunAim.AimPart)
                        local hum = p.Character:FindFirstChildOfClass("Humanoid")
                        if hrp and hum and hum.Health > 0 then
                            local pos, visible = cam:WorldToViewportPoint(hrp.Position)
                            if visible then
                                local dist = (Vector2.new(pos.X, pos.Y) - center).Magnitude
                                if dist < shortest then
                                    if GunAim.VisibilityCheck and not GA_IsVisible(hrp) then continue end
                                    shortest = dist; closest = hrp
                                end
                            end
                        end
                    end
                end
            end
            return closest
        end

        local function GA_Start()
            if GunAimConnection then return end
            GunAimConnection = RunService.RenderStepped:Connect(function()
                if not GunAim.Enabled or not GunAim.Holding then
                    GunAim.Target = nil; return
                end
                local target = GA_GetClosestTarget()
                if not target then return end
                GunAim.Target = target
                local pos = target.Position
                if GunAim.Predict then
                    pos = pos + (target.AssemblyLinearVelocity * GunAim.PredictStrength)
                end
                local cam = Workspace.CurrentCamera
                cam.CFrame = cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position, pos), GunAim.Strength)
            end)
        end

        UserInputService.InputBegan:Connect(function(input, gp)
            if gp then return end
            if input.UserInputType == Enum.UserInputType.MouseButton2 and GunAim.Enabled then
                GunAim.Holding = true
            end
        end)
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton2 then
                GunAim.Holding = false
            end
        end)

        task.spawn(function()
            while true do
                task.wait(1)
                local btn = GA_GetButton()
                if btn and btn ~= CurrentGunButton then
                    CurrentGunButton = btn
                    btn.InputBegan:Connect(function(input)
                        if (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton2) and GunAim.Enabled then
                            GunAim.Holding = true
                        end
                    end)
                    btn.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton2 then
                            GunAim.Holding = false
                        end
                    end)
                end
            end
        end)

        W.GunAim_Start = GA_Start
        W.GunAim_Cfg = GunAim
    end

    W.KillerAbilities = W.KillerAbilities or {
        AutoStalk = VD.KA_AutoStalk, AutoStalkRange = VD.KA_AutoStalkRange,
        AutoKillAll = VD.KA_AutoKillAll, DropAllPallet = VD.KA_DropAllPallet,
        BlockAllVault = VD.KA_BlockAllVault,
    }
    local KA = W.KillerAbilities
    function W.KA_GetClosestSurvivor(range, minHealth)
        local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not root then return nil end
        local closest, shortest = nil, (range or math.huge)
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and TeamIs(plr, "Survivor") then
                local hum = plr.Character:FindFirstChildOfClass("Humanoid")
                local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                if hum and hrp and hum.Health > (minHealth or 30) then
                    local d = (hrp.Position - root.Position).Magnitude
                    if d <= shortest then shortest = d; closest = plr end
                end
            end
        end
        return closest
    end
    local AutoStalkConnection = nil
    function W.KA_StartAutoStalk()
        if AutoStalkConnection then return end
        AutoStalkConnection = RunService.Heartbeat:Connect(function()
            if not KA.AutoStalk then return end
            if GetRole() ~= "Killer" then return end
            local target = W.KA_GetClosestSurvivor(KA.AutoStalkRange, 30)
            if not target or not target.Character then return end
            local stalkEvent = ReplicatedStorage:FindFirstChild("Remotes", true)
                and ReplicatedStorage.Remotes:FindFirstChild("Killers", true)
                and ReplicatedStorage.Remotes.Killers:FindFirstChild("Stalker", true)
                and ReplicatedStorage.Remotes.Killers.Stalker:FindFirstChild("StartStalking")
            if stalkEvent then pcall(function() stalkEvent:FireServer(target) end) end
        end)
    end
    function W.KA_StopAutoStalk()
        if AutoStalkConnection then
            pcall(function() AutoStalkConnection:Disconnect() end)
            AutoStalkConnection = nil
        end
    end
    function W.KA_SetAutoStalk(v)
        KA.AutoStalk = v and true or false
        VD.KA_AutoStalk = KA.AutoStalk
        if KA.AutoStalk then W.KA_StartAutoStalk() else W.KA_StopAutoStalk() end
    end
    local KillAllTarget = nil
    function W.KA_UpdateKillAll()
        if not KA.AutoKillAll then KillAllTarget = nil; return end
        if GetRole() ~= "Killer" then KillAllTarget = nil; return end
        local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not root then return end
        local tChar = KillAllTarget and KillAllTarget.Character
        if not KillAllTarget or not tChar or not tChar.Parent
            or not tChar:FindFirstChild("Humanoid") or tChar.Humanoid.Health <= 35 then
            KillAllTarget = W.KA_GetClosestSurvivor(math.huge, 30)
            tChar = KillAllTarget and KillAllTarget.Character
        end
        if KillAllTarget and tChar then
            local targetHRP = tChar:FindFirstChild("HumanoidRootPart")
            if targetHRP then
                local velocity  = targetHRP.AssemblyLinearVelocity
                local predict   = velocity * 0.15
                local targetPos = targetHRP.Position + predict
                local behind    = targetHRP.CFrame.LookVector * -3
                root.CFrame = CFrame.new(targetPos + behind, targetPos)
            end
            pcall(function()
                local attacks = ReplicatedStorage:FindFirstChild("Remotes")
                    and ReplicatedStorage.Remotes:FindFirstChild("Attacks")
                local basic = attacks and attacks:FindFirstChild("BasicAttack")
                if basic then basic:FireServer(false) end
            end)
        end
    end
    function W.KA_SetAutoKillAll(v)
        KA.AutoKillAll = v and true or false
        VD.KA_AutoKillAll = KA.AutoKillAll
        if not KA.AutoKillAll then KillAllTarget = nil end
    end
    local lastDropAllPallet = 0
    function W.KA_DropAllPallets()
        if not KA.DropAllPallet then return end
        if GetRole() ~= "Killer" then return end
        local now = tick()
        if now - lastDropAllPallet < 2 then return end
        lastDropAllPallet = now
        pcall(function()
            local remotes = ReplicatedStorage:FindFirstChild("Remotes")
            local palletFold = remotes and remotes:FindFirstChild("Pallet")
            local dropEvent = palletFold and palletFold:FindFirstChild("PalletDropEvent")
            if not dropEvent then return end
            local map = workspace:FindFirstChild("Map")
            if not map then return end
            for _, obj in ipairs(map:GetDescendants()) do
                if obj.Name == "Palletwrong" and (obj:IsA("Model") or obj:IsA("Folder")) then
                    local target = obj:FindFirstChild("PalletPointSlide") or obj:FindFirstChild("PalletPoint")
                    if target then pcall(function() dropEvent:FireServer(target) end) end
                end
            end
        end)
    end
    function W.KA_SetDropAllPallet(v)
        KA.DropAllPallet = v and true or false
        VD.KA_DropAllPallet = KA.DropAllPallet
    end
    local lastBlockVault = 0
    function W.KA_BlockAllVaults()
        if not KA.BlockAllVault then return end
        local VaultEvent = ReplicatedStorage:FindFirstChild("Remotes")
            and ReplicatedStorage.Remotes:FindFirstChild("Window")
            and ReplicatedStorage.Remotes.Window:FindFirstChild("VaultEvent")
        if not VaultEvent then return end
        local map = workspace:FindFirstChild("Map")
        if not map then return end
        for _, trigger in ipairs(map:GetDescendants()) do
            if trigger.Name == "VaultTrigger" then
                pcall(function() VaultEvent:FireServer(trigger, true) end)
            end
        end
    end
    function W.KA_SetBlockAllVault(v)
        KA.BlockAllVault = v and true or false
        VD.KA_BlockAllVault = KA.BlockAllVault
    end
    task.spawn(function()
        while true do
            task.wait(0.12)
            if KA.AutoKillAll then pcall(W.KA_UpdateKillAll) end
            if KA.DropAllPallet then pcall(W.KA_DropAllPallets) end
            if KA.BlockAllVault then pcall(W.KA_BlockAllVaults) end
            if VD.KILLER_DestroyPallets then pcall(W.MAWWW_DestroyAllPallets) end
            pcall(VD_UpdateInfiniteLunge)
        end
    end)
    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(1)
        if KA.AutoStalk then pcall(W.KA_StartAutoStalk) end
    end)

    do
        local CounterParryAnimList = {
            "122812055447896","133963973694098","117042998468241","135002183282873",
            "121216847022485","132817836308238","129784271201071","82666958311998",
            "78432063483146","118907603246885","139369275981139","110355011987939",
            "111920872708571","105374834496520","138720291317243","106871536134254",
            "130593238885843","115244153053858","74968262036854","113255068724446",
            "98163597193511","80411309607666",
        }

        W.CounterParry = W.CounterParry or { Running = false, Conn = nil }
        local CP = W.CounterParry

        function W.CounterParry_Start()
            if CP.Running then return end
            CP.Running = true
            CP.Conn = task.spawn(function()
                while task.wait(0.5) do
                    if not VD.KILLER_CounterParry then break end
                    if GetRole() ~= "Killer" then continue end
                    local char = LocalPlayer.Character
                    if not char then continue end
                    local myRoot = char:FindFirstChild("HumanoidRootPart")
                    if not myRoot then continue end

                    local near = false
                    for _, p in pairs(Players:GetPlayers()) do
                        if p ~= LocalPlayer and TeamIs(p, "Survivor") and p.Character then
                            local r = p.Character:FindFirstChild("HumanoidRootPart")
                            if r and (myRoot.Position - r.Position).Magnitude <= 15 then
                                near = true
                                break
                            end
                        end
                    end

                    if near then
                        local randomId = CounterParryAnimList[math.random(1, #CounterParryAnimList)]
                        local anim = Instance.new("Animation")
                        anim.AnimationId = "rbxassetid://" .. randomId
                        local hum = char:FindFirstChildOfClass("Humanoid")
                        local animator = hum and hum:FindFirstChildOfClass("Animator")
                        if animator then
                            local ok, track = pcall(function() return animator:LoadAnimation(anim) end)
                            if ok and track then
                                pcall(function()
                                    track:Play()
                                    track:AdjustWeight(0)
                                    task.wait(0.05)
                                    track:Stop()
                                end)
                            end
                        end
                        anim:Destroy()
                    end
                end
                CP.Running = false
            end)
        end

        function W.CounterParry_Stop()
            CP.Running = false
            if CP.Conn then pcall(function() task.cancel(CP.Conn) end); CP.Conn = nil end
        end

        function W.CounterParry_SetEnabled(v)
            VD.KILLER_CounterParry = v and true or false
            if v then W.CounterParry_Start() else W.CounterParry_Stop() end
        end
    end

    do
        local IsAutoHooking = false

        local function GetMapCacheHooks()
            local hooks = {}
            local map = Workspace:FindFirstChild("Map")
            if not map then return hooks end
            for _, obj in ipairs(map:GetDescendants()) do
                if obj:IsA("Model") and obj.Name == "Hook" then
                    local hp = obj:FindFirstChild("HookPoint")
                        or obj:FindFirstChild("HookHitbox")
                        or obj:FindFirstChildWhichIsA("BasePart", true)
                    if hp then table.insert(hooks, { model = obj, part = hp }) end
                end
            end
            return hooks
        end

        local function IsPlayerOnHook(character, hooks)
            local tr = character:FindFirstChild("HumanoidRootPart")
            if not tr then return false end
            for _, h in ipairs(hooks) do
                if (h.part.Position - tr.Position).Magnitude < 6 then return true end
            end
            return false
        end

        local function IsPlayerCarried(character)
            return character:GetAttribute("IsCarried") == true
        end

        local function FindDownedSurvivor(hooks)
            local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if not myRoot then return nil, nil end
            local closest, closestDist, closestChar = nil, math.huge, nil
            for _, pl in ipairs(Players:GetPlayers()) do
                if pl == LocalPlayer or not pl.Character then continue end
                if not TeamIs(pl, "Survivor") then continue end
                local tr = pl.Character:FindFirstChild("HumanoidRootPart")
                local h = pl.Character:FindFirstChildOfClass("Humanoid")
                if not tr or not h then continue end
                local pct = h.MaxHealth > 0 and (h.Health / h.MaxHealth) or 0
                if pct > 0.25 or pct <= 0 then continue end
                if IsPlayerOnHook(pl.Character, hooks) then continue end
                if IsPlayerCarried(pl.Character) then continue end
                local d = (tr.Position - myRoot.Position).Magnitude
                if d < closestDist then
                    closestDist = d
                    closest = tr
                    closestChar = pl.Character
                end
            end
            return closest, closestChar
        end

        local function FindNearestHook(targetPos, hooks)
            local closest, closestDist = nil, math.huge
            for _, h in ipairs(hooks) do
                local d = (h.part.Position - targetPos).Magnitude
                if d < closestDist then closestDist = d; closest = h end
            end
            return closest
        end

        local function DoAutoHook()
            if not VD.KILLER_AutoHook then return end
            if IsAutoHooking then return end
            if GetRole() ~= "Killer" then return end
            local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if not root then return end
            local hooks = GetMapCacheHooks()
            if #hooks == 0 then return end
            local targetRoot, targetChar = FindDownedSurvivor(hooks)
            if not targetRoot then return end
            local nearestHook = FindNearestHook(targetRoot.Position, hooks)
            if not nearestHook then return end

            IsAutoHooking = true
            task.spawn(function()
                local CarryEvent, HookEvent, HookCommit
                pcall(function()
                    local carryFolder = ReplicatedStorage:FindFirstChild("Remotes"):FindFirstChild("Carry")
                    CarryEvent = carryFolder:FindFirstChild("CarrySurvivorEvent")
                    HookEvent  = carryFolder:FindFirstChild("HookEvent")
                    HookCommit = carryFolder:FindFirstChild("HookCommit")
                end)
                pcall(function()
                    root.CFrame = CFrame.new(targetRoot.Position + Vector3.new(0, 3, 0), targetRoot.Position)
                end)
                task.wait(0.2)
                pcall(function() if CarryEvent then CarryEvent:FireServer(targetChar) end end)
                task.wait(0.5)
                local r2 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if not r2 then IsAutoHooking = false; return end
                pcall(function()
                    r2.CFrame = CFrame.new(nearestHook.part.Position + Vector3.new(0, 3, 0))
                end)
                task.wait(0.3)
                pcall(function()
                    local hookPoint = nearestHook.model:FindFirstChild("HookPoint")
                        or nearestHook.model:FindFirstChild("HookHitbox")
                        or nearestHook.part
                    if HookEvent then HookEvent:FireServer(hookPoint) end
                    if HookCommit then HookCommit:FireServer(hookPoint) end
                end)
                task.wait(1)
                IsAutoHooking = false
            end)
        end

        function W.KA_StartAutoHook()
            if W._AutoHookThread then return end
            W._AutoHookThread = task.spawn(function()
                while VD.KILLER_AutoHook do
                    if GetRole() == "Killer" then pcall(DoAutoHook) end
                    task.wait(1)
                end
                W._AutoHookThread = nil
            end)
        end
        function W.KA_StopAutoHook()
            if W._AutoHookThread then
                pcall(function() task.cancel(W._AutoHookThread) end)
                W._AutoHookThread = nil
            end
        end
        function W.KA_SetAutoHook(v)
            VD.KILLER_AutoHook = v and true or false
            if VD.KILLER_AutoHook then W.KA_StartAutoHook() else W.KA_StopAutoHook() end
        end
    end

    do
        local PerkDisplayState = { Gui = nil, Thread = nil, Enabled = false, Minimized = false }

        local function GetKillerPlayer()
            for _, p in ipairs(Players:GetPlayers()) do
                if TeamIs(p, "Killer") then return p end
            end
            return nil
        end

        local function FormatPerkName(name)
            name = tostring(name or "")
            local clean = name:gsub("_", " "):gsub("-", " ")
            clean = clean:gsub("(%l)(%u)", "%1 %2")
            clean = clean:gsub("(%a)(%d)", "%1 %2")
            clean = clean:gsub("(%d)(%a)", "%1 %2")
            clean = clean:gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", "")
            return clean ~= "" and clean or "Unknown Perk"
        end

        local function ParsePerkName(name)
            name = tostring(name or "")
            local perkName, level = name:match("^(.+)%s+(%d+)$")
            if not perkName then return nil end
            perkName = perkName:gsub("^%s+", ""):gsub("%s+$", "")
            if perkName == "" then return nil end
            local lower = perkName:lower()
            local excluded = {
                head=true,torso=true,humanoid=true,
                ["left arm"]=true,["right arm"]=true,
                ["left leg"]=true,["right leg"]=true,
                ["humanoidrootpart"]=true,
            }
            if excluded[lower] then return nil end
            return perkName, level
        end

        local function ReadPerksFromChar(char)
            if not char then return {} end
            local result, seen = {}, {}
            local function addPerk(rawName, displayName, level)
                if not rawName then return end
                rawName = tostring(rawName)
                if rawName == "" or rawName == "nil" then return end
                if rawName:lower():find("template") then return end
                if seen[rawName] then return end
                seen[rawName] = true
                table.insert(result, {
                    Raw = rawName,
                    Name = displayName and tostring(displayName) or FormatPerkName(rawName),
                    Level = level and tostring(level) or nil,
                })
            end

            local function scanAttrs(inst)
                if not inst.GetAttributes then return end
                local attrs = inst:GetAttributes()
                for k, v in pairs(attrs) do
                    local lk = tostring(k):lower()
                    if lk:find("perk") then
                        if type(v) == "string" then addPerk(v)
                        elseif v == true then addPerk(k)
                        elseif type(v) == "number" and lk:find("level") then
                            local bn = tostring(k):gsub("[Ll]evel",""):gsub("[Pp]erk","")
                            if bn ~= "" then addPerk(bn, nil, v) end
                        end
                    end
                end
            end

            scanAttrs(char)
            for _, child in ipairs(char:GetChildren()) do
                local pn, lv = ParsePerkName(child.Name)
                if pn then addPerk(child.Name, pn, lv) end
            end
            for _, inst in ipairs(char:GetDescendants()) do
                scanAttrs(inst)
                local lower = inst.Name:lower()
                if lower == "perks" or lower == "killerperks"
                    or lower:find("perkfolder") or lower:find("perklist") then
                    for _, child in ipairs(inst:GetChildren()) do
                        if child:IsA("StringValue") then addPerk(child.Value)
                        elseif child:IsA("IntValue") or child:IsA("NumberValue") then addPerk(child.Name, nil, child.Value)
                        elseif child:IsA("BoolValue") and child.Value then addPerk(child.Name) end
                    end
                elseif lower:find("perk") then
                    if inst:IsA("StringValue") then addPerk(inst.Value)
                    elseif inst:IsA("BoolValue") and inst.Value then addPerk(inst.Name) end
                end
            end
            table.sort(result, function(a, b) return tostring(a.Name) < tostring(b.Name) end)
            return result
        end

        local function BuildGui()
            if PerkDisplayState.Gui then pcall(function() PerkDisplayState.Gui:Destroy() end) end
            local pg = SafeGuiParent()
            if not pg then return end

            local gui = Instance.new("ScreenGui")
            gui.Name = "GlutoKillerPerksDisplay"
            gui.ResetOnSpawn = false
            gui.IgnoreGuiInset = true
            gui.DisplayOrder = 60
            gui.Parent = pg

            local frame = Instance.new("Frame")
            frame.Name = "MainFrame"
            frame.Size = UDim2.new(0, 200, 0, 28)
            frame.Position = UDim2.new(0.02, 0, 0.42, 0)
            frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
            frame.BackgroundTransparency = 0.1
            frame.BorderSizePixel = 0
            frame.Active = true
            frame.Parent = gui
            Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

            local stroke = Instance.new("UIStroke", frame)
            stroke.Color = _G.GLUTO_THEME
            stroke.Thickness = 1.2
            stroke.Transparency = 0.2
            stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

            local topBar = Instance.new("Frame", frame)
            topBar.Name = "TopBar"
            topBar.Size = UDim2.new(1, 0, 0, 3)
            topBar.BackgroundColor3 = _G.GLUTO_THEME
            topBar.BorderSizePixel = 0
            Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 8)

            local header = Instance.new("Frame", frame)
            header.Name = "Header"
            header.Size = UDim2.new(1, 0, 0, 22)
            header.Position = UDim2.new(0, 0, 0, 3)
            header.BackgroundTransparency = 1
            header.Active = true

            local title = Instance.new("TextLabel", header)
            title.Name = "Title"
            title.Size = UDim2.new(1, -26, 1, 0)
            title.Position = UDim2.new(0, 10, 0, 0)
            title.BackgroundTransparency = 1
            title.Font = Enum.Font.GothamBold
            title.Text = "KILLER PERKS"
            title.TextColor3 = _G.GLUTO_THEME
            title.TextSize = 11
            title.TextXAlignment = Enum.TextXAlignment.Left
            title.Parent = header

            local killerName = Instance.new("TextLabel", header)
            killerName.Name = "KillerName"
            killerName.AnchorPoint = Vector2.new(1, 0.5)
            killerName.Size = UDim2.new(0, 80, 1, 0)
            killerName.Position = UDim2.new(1, -26, 0.5, 0)
            killerName.BackgroundTransparency = 1
            killerName.Font = Enum.Font.GothamBold
            killerName.Text = "???"
            killerName.TextColor3 = Color3.fromRGB(255, 255, 255)
            killerName.TextSize = 9
            killerName.TextXAlignment = Enum.TextXAlignment.Right
            killerName.TextTruncate = Enum.TextTruncate.AtEnd
            killerName.Parent = header

            local minBtn = Instance.new("TextButton", header)
            minBtn.Name = "MinBtn"
            minBtn.AnchorPoint = Vector2.new(1, 0.5)
            minBtn.Size = UDim2.new(0, 20, 0, 20)
            minBtn.Position = UDim2.new(1, -3, 0.5, 0)
            minBtn.BackgroundTransparency = 1
            minBtn.Text = "−"
            minBtn.TextColor3 = _G.GLUTO_THEME
            minBtn.Font = Enum.Font.GothamBold
            minBtn.TextSize = 13
            minBtn.AutoButtonColor = false
            minBtn.Parent = header

            local divider = Instance.new("Frame", frame)
            divider.Name = "Divider"
            divider.Size = UDim2.new(1, -12, 0, 1)
            divider.Position = UDim2.new(0, 6, 0, 25)
            divider.BackgroundColor3 = _G.GLUTO_THEME
            divider.BackgroundTransparency = 0.7
            divider.BorderSizePixel = 0

            local body = Instance.new("Frame", frame)
            body.Name = "Body"
            body.Size = UDim2.new(1, -12, 0, 0)
            body.Position = UDim2.new(0, 6, 0, 28)
            body.AutomaticSize = Enum.AutomaticSize.Y
            body.BackgroundTransparency = 1

            local layout = Instance.new("UIListLayout", body)
            layout.FillDirection = Enum.FillDirection.Vertical
            layout.SortOrder = Enum.SortOrder.LayoutOrder
            layout.Padding = UDim.new(0, 3)

            local function setMinimized(state)
                PerkDisplayState.Minimized = state
                if state then
                    frame.Size = UDim2.new(0, 200, 0, 28)
                    divider.Visible = false
                    body.Visible = false
                    minBtn.Text = "+"
                else
                    frame.Size = UDim2.new(0, 200, 0, 28)
                    divider.Visible = true
                    body.Visible = true
                    minBtn.Text = "−"
                end
            end
            minBtn.MouseButton1Click:Connect(function() setMinimized(not PerkDisplayState.Minimized) end)
            setMinimized(false)

            local dragging, dragStart, startPos = false, nil, nil
            header.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true; dragStart = input.Position; startPos = frame.Position
                end
            end)
            UserInputService.InputChanged:Connect(function(input)
                if not dragging then return end
                if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                    local d = input.Position - dragStart
                    frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
                end
            end)
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                end
            end)

            PerkDisplayState.Gui = gui
        end

        local function UpdateDisplay()
            local gui = PerkDisplayState.Gui
            if not gui then return end
            local frame = gui:FindFirstChild("MainFrame")
            if not frame then return end
            local header = frame:FindFirstChild("Header")
            local body = frame:FindFirstChild("Body")
            local divider = frame:FindFirstChild("Divider")
            if not header or not body then return end

            local killer = GetKillerPlayer()
            local killerName = killer and (killer.DisplayName or killer.Name) or "???"
            local hName = header:FindFirstChild("KillerName")
            if hName then hName.Text = killerName end

            for _, child in ipairs(body:GetChildren()) do
                if child:IsA("TextLabel") then child:Destroy() end
            end

            local perks = {}
            if killer and killer.Character then
                perks = ReadPerksFromChar(killer.Character)
            end

            local count = math.min(#perks, 6)
            if count == 0 then
                local lbl = Instance.new("TextLabel")
                lbl.Size = UDim2.new(1, 0, 0, 14)
                lbl.BackgroundTransparency = 1
                lbl.Font = Enum.Font.GothamMedium
                lbl.Text = "Waiting for perk data..."
                lbl.TextColor3 = Color3.fromRGB(170, 170, 170)
                lbl.TextSize = 9
                lbl.TextXAlignment = Enum.TextXAlignment.Left
                lbl.Parent = body
            else
                for i = 1, count do
                    local p = perks[i]
                    local lbl = Instance.new("TextLabel")
                    lbl.Size = UDim2.new(1, 0, 0, 14)
                    lbl.BackgroundTransparency = 1
                    lbl.Font = Enum.Font.GothamMedium
                    local lvlText = p.Level and (" (Lv " .. tostring(p.Level) .. ")") or ""
                    lbl.Text = "• " .. p.Name .. lvlText
                    lbl.TextColor3 = _G.GLUTO_THEME
                    lbl.TextSize = 10
                    lbl.TextXAlignment = Enum.TextXAlignment.Left
                    lbl.Parent = body
                end
            end

            if PerkDisplayState.Minimized then
                if divider then divider.Visible = false end
                body.Visible = false
                frame.Size = UDim2.new(0, 200, 0, 28)
            else
                if divider then divider.Visible = true end
                body.Visible = true
                local bodyH = body.AbsoluteSize.Y
                frame.Size = UDim2.new(0, 200, 0, 28 + bodyH + 6)
            end
        end

        local function Stop()
            PerkDisplayState.Enabled = false
            if PerkDisplayState.Thread then
                pcall(function() task.cancel(PerkDisplayState.Thread) end)
                PerkDisplayState.Thread = nil
            end
            if PerkDisplayState.Gui then
                pcall(function() PerkDisplayState.Gui:Destroy() end)
                PerkDisplayState.Gui = nil
            end
        end

        local function Start()
            if PerkDisplayState.Enabled then return end
            PerkDisplayState.Enabled = true
            BuildGui()
            task.spawn(function()
                task.wait(0.05)
                UpdateDisplay()
            end)
            PerkDisplayState.Thread = task.spawn(function()
                while PerkDisplayState.Enabled do
                    pcall(UpdateDisplay)
                    task.wait(1)
                end
            end)
        end

        W.KillerPerksDisplay_Start = Start
        W.KillerPerksDisplay_Stop = Stop
        W.KillerPerksDisplay_SetEnabled = function(v)
            VD.KillerPerksDisplay = v and true or false
            if VD.KillerPerksDisplay then Start() else Stop() end
        end
    end

    do
        local SpeedBoostConnection = nil

        local function ShouldDisableSpeedBoost()
            local char = LocalPlayer.Character
            if not char then return true end
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                local animator = hum:FindFirstChildOfClass("Animator")
                if animator then
                    for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
                        local anim = track.Animation
                        if anim and anim.AnimationId then
                            if anim.AnimationId == "rbxassetid://127096285501517" then return true end
                            if anim.AnimationId == "rbxassetid://112166042383605" then return true end
                            if anim.AnimationId == "http://www.roblox.com/asset/?id=126965695851149" then return true end
                            if anim.AnimationId == "http://www.roblox.com/asset/?id=135084204086504" then return true end
                            if anim.AnimationId == "rbxassetid://123047897844134" then return true end
                            local id = anim.AnimationId:match("%d+")
                            if id and KillerAttackAnims["rbxassetid://" .. id] then return true end
                        end
                    end
                end
                if hum.Health <= 0 or hum.Health < 2
                    or char:GetAttribute("Downed") == true
                    or char:GetAttribute("IsDown") == true
                    or char:GetAttribute("Knocked") == true then
                    return true
                end
            end
            return false
        end

        function W.SpeedBoost_SetEnabled(v)
            VD.SpeedBoostEnabled = v and true or false
            if SpeedBoostConnection then SpeedBoostConnection:Disconnect(); SpeedBoostConnection = nil end
            if not VD.SpeedBoostEnabled then
                local char = LocalPlayer.Character
                local hum = char and char:FindFirstChildOfClass("Humanoid")
                if hum then pcall(function() hum.WalkSpeed = 16 end) end
                return
            end
            SpeedBoostConnection = RunService.Heartbeat:Connect(function()
                if not VD.SpeedBoostEnabled then return end
                if ShouldDisableSpeedBoost() then return end
                local char = LocalPlayer.Character
                local hum = char and char:FindFirstChildOfClass("Humanoid")
                if hum and hum.WalkSpeed ~= VD.SpeedBoostValue then
                    pcall(function() hum.WalkSpeed = VD.SpeedBoostValue end)
                end
            end)
        end

        W.SpeedBoost_SetValue = function(v)
            VD.SpeedBoostValue = tonumber(v) or 30
        end

        LocalPlayer.CharacterAdded:Connect(function()
            task.wait(0.8)
            if VD.SpeedBoostEnabled then W.SpeedBoost_SetEnabled(true) end
        end)
    end

    do
        local CursorThread = nil
        local savedOriginal = { MouseIconEnabled = nil, MouseBehavior = nil, AutoRotate = nil }

        function W.Cursor_SetEnabled(v)
            VD.CursorEnabled = v and true or false
            if v then
                savedOriginal.MouseIconEnabled = UserInputService.MouseIconEnabled
                savedOriginal.MouseBehavior = UserInputService.MouseBehavior
                local char = LocalPlayer.Character
                local hum = char and char:FindFirstChildOfClass("Humanoid")
                savedOriginal.AutoRotate = hum and hum.AutoRotate or true

                pcall(function()
                    UserInputService.MouseIconEnabled = true
                    UserInputService.MouseBehavior = Enum.MouseBehavior.Default
                end)
                if hum then pcall(function() hum.AutoRotate = false end) end

                if CursorThread then pcall(function() task.cancel(CursorThread) end) end
                CursorThread = task.spawn(function()
                    while VD.CursorEnabled do
                        pcall(function()
                            UserInputService.MouseIconEnabled = true
                            UserInputService.MouseBehavior = Enum.MouseBehavior.Default
                        end)
                        local c = LocalPlayer.Character
                        local h = c and c:FindFirstChildOfClass("Humanoid")
                        if h and h.AutoRotate then h.AutoRotate = false end
                        task.wait(0.1)
                    end
                end)
            else
                VD.CursorEnabled = false
                if CursorThread then
                    pcall(function() task.cancel(CursorThread) end)
                    CursorThread = nil
                end
                pcall(function()
                    UserInputService.MouseIconEnabled = savedOriginal.MouseIconEnabled or false
                    UserInputService.MouseBehavior = savedOriginal.MouseBehavior or Enum.MouseBehavior.LockCenter
                end)
                local c = LocalPlayer.Character
                local h = c and c:FindFirstChildOfClass("Humanoid")
                if h then pcall(function() h.AutoRotate = savedOriginal.AutoRotate or true end) end
            end
        end

        UserInputService.InputBegan:Connect(function(input, gp)
            if gp then return end
            if input.KeyCode == Enum.KeyCode.LeftAlt or input.KeyCode == Enum.KeyCode.RightAlt then
                W.Cursor_SetEnabled(not VD.CursorEnabled)
            end
        end)

        LocalPlayer.CharacterAdded:Connect(function()
            task.wait(1)
            if VD.CursorEnabled then W.Cursor_SetEnabled(true) end
        end)
    end

    do
        VD.FLASK_SilentAim    = VD.FLASK_SilentAim    or false
        VD.FLASK_ShowBeam     = VD.FLASK_ShowBeam     ~= false
        VD.FLASK_ShowLanding  = VD.FLASK_ShowLanding  ~= false
        VD.FLASK_Predict      = VD.FLASK_Predict      ~= false
        VD.FLASK_Speed        = VD.FLASK_Speed        or 90
        VD.FLASK_Gravity      = VD.FLASK_Gravity      or 196
        VD.FLASK_LeadMult     = VD.FLASK_LeadMult     or 1.0
        VD.FLASK_Range        = VD.FLASK_Range        or 200
        VD.FLASK_BeamColor    = VD.FLASK_BeamColor    or _G.GLUTO_THEME
        VD.FLASK_AccentColor  = VD.FLASK_AccentColor  or Color3.fromRGB(60, 60, 60)
        local FlaskState = { Target = nil, PredictedPos = nil, BeamPart = nil, AccentPart = nil, LandingRing = nil }
        local function Flask_GetTarget()
            local myChar = LocalPlayer.Character
            local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
            if not myRoot then return nil end
            local maxR = tonumber(VD.FLASK_Range) or 200
            local best, bd = nil, math.huge
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and TeamIs(p, "Survivor") and p.Character then
                    local hum = p.Character:FindFirstChildOfClass("Humanoid")
                    local root = p.Character:FindFirstChild("HumanoidRootPart")
                    if hum and hum.Health > 0 and root then
                        local d = (root.Position - myRoot.Position).Magnitude
                        if d <= maxR and d < bd then
                            bd = d; best = { Player = p, Root = root, Char = p.Character }
                        end
                    end
                end
            end
            return best
        end
        local function Flask_GetHandOrigin()
            local c = LocalPlayer.Character
            if not c then return nil end
            return c:FindFirstChild("LeftHand") or c:FindFirstChild("Left Arm")
                or c:FindFirstChild("RightHand") or c:FindFirstChild("Right Arm")
                or c:FindFirstChild("HumanoidRootPart")
        end
        local function Flask_PredictLanding(origin, targetRoot)
            local targetPos = targetRoot.Position
            local speed   = tonumber(VD.FLASK_Speed)   or 90
            local gravity = tonumber(VD.FLASK_Gravity) or 196
            local lead    = tonumber(VD.FLASK_LeadMult) or 1.0
            if not VD.FLASK_Predict then return targetPos end
            local tv = targetRoot.AssemblyLinearVelocity or Vector3.zero
            local horizVel = Vector3.new(tv.X, 0, tv.Z)
            local dist = (targetPos - origin).Magnitude
            local time = dist / speed
            local predicted = targetPos
            for _ = 1, 3 do
                predicted = targetPos + horizVel * time * lead
                local nd = (predicted - origin).Magnitude
                time = nd / speed
            end
            local drop = 0.5 * gravity * (time * time)
            return predicted + Vector3.new(0, drop, 0)
        end
        local function Flask_ClearVisuals()
            if FlaskState.BeamPart then pcall(function() FlaskState.BeamPart:Destroy() end); FlaskState.BeamPart = nil end
            if FlaskState.AccentPart then pcall(function() FlaskState.AccentPart:Destroy() end); FlaskState.AccentPart = nil end
            if FlaskState.LandingRing then pcall(function() FlaskState.LandingRing:Destroy() end); FlaskState.LandingRing = nil end
        end
        local function Flask_HideVisuals()
            if FlaskState.BeamPart then FlaskState.BeamPart.Transparency = 1 end
            if FlaskState.AccentPart then FlaskState.AccentPart.Transparency = 1 end
            if FlaskState.LandingRing then FlaskState.LandingRing.Transparency = 1 end
        end
        local function Flask_EnsureBeamParts()
            if not FlaskState.BeamPart or not FlaskState.BeamPart.Parent then
                local beam = Instance.new("Part")
                beam.Name = "GlutoFlaskBeam"
                beam.Anchored = true
                beam.CanCollide = false
                beam.CanTouch = false
                beam.CanQuery = false
                beam.CastShadow = false
                beam.Material = Enum.Material.Neon
                beam.Color = VD.FLASK_BeamColor or _G.GLUTO_THEME
                beam.Transparency = 0.2
                beam.Parent = Workspace
                FlaskState.BeamPart = beam
            end
            if not FlaskState.AccentPart or not FlaskState.AccentPart.Parent then
                local accent = Instance.new("Part")
                accent.Name = "GlutoFlaskBeamAccent"
                accent.Anchored = true
                accent.CanCollide = false
                accent.CanTouch = false
                accent.CanQuery = false
                accent.CastShadow = false
                accent.Material = Enum.Material.SmoothPlastic
                accent.Color = VD.FLASK_AccentColor or Color3.fromRGB(60, 60, 60)
                accent.Transparency = 0.35
                accent.Parent = Workspace
                FlaskState.AccentPart = accent
            end
            if FlaskState.BeamPart then FlaskState.BeamPart.Color = VD.FLASK_BeamColor or _G.GLUTO_THEME end
            if FlaskState.AccentPart then FlaskState.AccentPart.Color = VD.FLASK_AccentColor or Color3.fromRGB(60, 60, 60) end
        end
        local function Flask_UpdateBeam(origin, landing)
            Flask_EnsureBeamParts()
            local dir = landing - origin
            local dist = dir.Magnitude
            if dist < 0.1 then return end
            local mid = (origin + landing) / 2
            local cf = CFrame.lookAt(mid, landing)
            FlaskState.BeamPart.Size = Vector3.new(0.12, 0.12, dist)
            FlaskState.BeamPart.CFrame = cf
            FlaskState.BeamPart.Transparency = 0.2
            FlaskState.AccentPart.Size = Vector3.new(0.22, 0.22, dist)
            FlaskState.AccentPart.CFrame = cf
            FlaskState.AccentPart.Transparency = 0.35
        end
        local function Flask_UpdateLanding(pos)
            if not VD.FLASK_ShowLanding then
                if FlaskState.LandingRing then FlaskState.LandingRing.Transparency = 1 end
                return
            end
            if not FlaskState.LandingRing or not FlaskState.LandingRing.Parent then
                local ring = Instance.new("Part")
                ring.Name = "GlutoFlaskLanding"
                ring.Shape = Enum.PartType.Cylinder
                ring.Anchored = true
                ring.CanCollide = false
                ring.CanTouch = false
                ring.CanQuery = false
                ring.CastShadow = false
                ring.Material = Enum.Material.Neon
                ring.Color = VD.FLASK_BeamColor or _G.GLUTO_THEME
                ring.Size = Vector3.new(0.2, 5, 5)
                ring.Parent = Workspace
                FlaskState.LandingRing = ring
            end
            FlaskState.LandingRing.Color = VD.FLASK_BeamColor or _G.GLUTO_THEME
            FlaskState.LandingRing.CFrame = CFrame.new(pos) * CFrame.Angles(0, 0, math.rad(90))
            FlaskState.LandingRing.Transparency = 0.35
        end
        RunService.RenderStepped:Connect(function()
            if not VD.FLASK_SilentAim then
                Flask_HideVisuals()
                FlaskState.Target = nil
                FlaskState.PredictedPos = nil
                return
            end
            if GetRole() ~= "Killer" then Flask_HideVisuals(); return end
            local target = Flask_GetTarget()
            if not target or not target.Root then
                Flask_HideVisuals(); FlaskState.Target = nil; FlaskState.PredictedPos = nil; return
            end
            local hand = Flask_GetHandOrigin()
            if not hand then return end
            local landing = Flask_PredictLanding(hand.Position, target.Root)
            FlaskState.Target = target
            FlaskState.PredictedPos = landing
            if VD.FLASK_ShowBeam then pcall(Flask_UpdateBeam, hand.Position, landing)
            else
                if FlaskState.BeamPart then FlaskState.BeamPart.Transparency = 1 end
                if FlaskState.AccentPart then FlaskState.AccentPart.Transparency = 1 end
            end
            pcall(Flask_UpdateLanding, landing)
        end)
        task.spawn(function()
            pcall(function()
                local oldNC
                oldNC = hookmetamethod(game, "__namecall", function(self, ...)
                    if getnamecallmethod() == "FireServer"
                       and self.Name == "ThrowFlask"
                       and VD.FLASK_SilentAim
                       and GetRole() == "Killer"
                       and FlaskState.PredictedPos then
                        local args = {...}
                        if typeof(args[2]) == "Vector3" then
                            local origin = args[2]
                            local aimDir = (FlaskState.PredictedPos - origin)
                            if aimDir.Magnitude > 0.1 then
                                args[1] = aimDir.Unit
                                return oldNC(self, unpack(args))
                            end
                        elseif typeof(args[1]) == "Vector3" then
                            local hand = Flask_GetHandOrigin()
                            if hand then
                                local aimDir = (FlaskState.PredictedPos - hand.Position)
                                if aimDir.Magnitude > 0.1 then
                                    args[1] = aimDir.Unit
                                    return oldNC(self, unpack(args))
                                end
                            end
                        end
                    end
                    return oldNC(self, ...)
                end)
            end)
        end)
        W.Flask_SetEnabled = function(v) VD.FLASK_SilentAim = v and true or false; if not v then Flask_ClearVisuals() end end
        W.Flask_SetBeamColor   = function(c) VD.FLASK_BeamColor = c end
        W.Flask_SetAccentColor = function(c) VD.FLASK_AccentColor = c end
        W.Flask_SetSpeed       = function(v) VD.FLASK_Speed = tonumber(v) or 90 end
        W.Flask_SetGravity     = function(v) VD.FLASK_Gravity = tonumber(v) or 196 end
        W.Flask_SetLead        = function(v) VD.FLASK_LeadMult = tonumber(v) or 1.0 end
        W.Flask_SetRange       = function(v) VD.FLASK_Range = tonumber(v) or 200 end
    end

    do
        VD.SPEAR_Aimbot = VD.SPEAR_Aimbot or false
        VD.SPEAR_Gravity = VD.SPEAR_Gravity or 50
        VD.SPEAR_Speed = VD.SPEAR_Speed or 100
        local SpearBtnData = {
            UI = nil, Button = nil, Active = true, DragLocked = false,
            Dragging = false, DragStart = nil, DragStartPos = nil,
            ManualTarget = nil, TargetIndex = 0,
            TargetLabel = nil, LeftArrow = nil, RightArrow = nil,
        }
        local function SpearAimbotCalc(targetPos)
            if not VD.SPEAR_Aimbot or GetRole() ~= "Killer" then return nil end
            local char = LocalPlayer.Character
            if not char then return nil end
            local root = char:FindFirstChild("HumanoidRootPart")
            if not root then return nil end
            local startPos = root.Position + Vector3.new(0, 2, 0)
            local distance = (targetPos - startPos).Magnitude
            local gravity  = VD.SPEAR_Gravity or 50
            local speed    = VD.SPEAR_Speed or 100
            local time     = distance / speed
            local drop     = 0.5 * gravity * time * time
            return targetPos + Vector3.new(0, drop, 0)
        end
        local function Spear_GetTargetList()
            local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            local list = {}
            if not root then return list end
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and TeamIs(player, "Survivor") and player.Character then
                    local tr = player.Character:FindFirstChild("HumanoidRootPart")
                    local th = player.Character:FindFirstChildOfClass("Humanoid")
                    if tr and th and th.MaxHealth > 0 and (th.Health / th.MaxHealth) > 0.25 then
                        local dist = (tr.Position - root.Position).Magnitude
                        table.insert(list, { Player = player, Dist = dist })
                    end
                end
            end
            table.sort(list, function(a, b) return a.Dist < b.Dist end)
            local players = {}
            for _, v in ipairs(list) do table.insert(players, v.Player) end
            return players
        end
        local function Spear_UpdateTargetLabel()
            if not (SpearBtnData and SpearBtnData.TargetLabel) then return end
            if SpearBtnData.ManualTarget and SpearBtnData.ManualTarget.Parent then
                SpearBtnData.TargetLabel.Text = SpearBtnData.ManualTarget.Name
            else
                SpearBtnData.TargetLabel.Text = "AUTO"
            end
            SpearBtnData.TargetLabel.Visible = true
        end
        local function Spear_CycleTarget(direction)
            local list = Spear_GetTargetList()
            if #list == 0 then
                SpearBtnData.ManualTarget = nil; SpearBtnData.TargetIndex = 0
                VD_Notify("Spear Aimbot", "Tidak ada target survivor.", 2)
                return
            end
            local curIdx = nil
            if SpearBtnData.ManualTarget then
                for i, p in ipairs(list) do
                    if p == SpearBtnData.ManualTarget then curIdx = i; break end
                end
            end
            local nextIdx
            if curIdx then
                nextIdx = curIdx + direction
                if nextIdx > #list then nextIdx = 1 end
                if nextIdx < 1 then nextIdx = #list end
            else nextIdx = 1 end
            SpearBtnData.TargetIndex  = nextIdx
            SpearBtnData.ManualTarget = list[nextIdx]
            VD_Notify("Spear Aimbot", "Target: " .. SpearBtnData.ManualTarget.Name, 2)
            Spear_UpdateTargetLabel()
        end
        local function Spear_UpdateAim()
            if not VD.SPEAR_Aimbot then return end
            if SpearBtnData and not SpearBtnData.Active then return end
            if GetRole() ~= "Killer" then return end
            local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if not root then return end
            local target = nil
            if SpearBtnData.ManualTarget then
                local p = SpearBtnData.ManualTarget
                local valid = p.Parent and TeamIs(p, "Survivor") and p.Character
                if valid then
                    local tr = p.Character:FindFirstChild("HumanoidRootPart")
                    local th = p.Character:FindFirstChildOfClass("Humanoid")
                    valid = tr and th and th.MaxHealth > 0 and (th.Health / th.MaxHealth) > 0.25
                end
                if valid then target = p
                else SpearBtnData.ManualTarget = nil; Spear_UpdateTargetLabel() end
            end
            if not target then
                local closest, closestDist = nil, math.huge
                for _, player in ipairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and TeamIs(player, "Survivor") and player.Character then
                        local tr = player.Character:FindFirstChild("HumanoidRootPart")
                        local th = player.Character:FindFirstChildOfClass("Humanoid")
                        if tr and th and th.MaxHealth > 0 and (th.Health / th.MaxHealth) > 0.25 then
                            local dist = (tr.Position - root.Position).Magnitude
                            if dist < closestDist then closestDist = dist; closest = player end
                        end
                    end
                end
                target = closest
            end
            if target and target.Character then
                local tr = target.Character:FindFirstChild("HumanoidRootPart")
                if tr then
                    local aimPos = SpearAimbotCalc(tr.Position)
                    if aimPos then
                        local cam = Workspace.CurrentCamera
                        if cam then cam.CFrame = CFrame.new(cam.CFrame.Position, aimPos) end
                    end
                end
            end
        end
        local function Spear_SetupButton()
            if SpearBtnData.UI then pcall(function() SpearBtnData.UI:Destroy() end) end
            local pg = SafeGuiParent()
            if not pg then return end
            SpearBtnData.UI = Instance.new("ScreenGui")
            SpearBtnData.UI.Name = "GlutoSpearAimbotUI"
            SpearBtnData.UI.ResetOnSpawn = false
            SpearBtnData.UI.IgnoreGuiInset = true
            SpearBtnData.UI.Parent = pg
            SpearBtnData.Button = Instance.new("TextButton")
            SpearBtnData.Button.Name = "SpearAimbotButton"
            SpearBtnData.Button.Size = UDim2.new(0, 65, 0, 65)
            SpearBtnData.Button.Position = UDim2.new(0.15, 0, 0.75, 0)
            SpearBtnData.Button.AnchorPoint = Vector2.new(0.5, 0.5)
            SpearBtnData.Button.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
            SpearBtnData.Button.BackgroundTransparency = 0.15
            SpearBtnData.Button.AutoButtonColor = true
            SpearBtnData.Button.Text = "SPEAR\nAIM"
            SpearBtnData.Button.TextColor3 = _G.GLUTO_THEME
            SpearBtnData.Button.TextSize = 11
            SpearBtnData.Button.Font = Enum.Font.GothamBold
            SpearBtnData.Button.Visible = false
            SpearBtnData.Button.ZIndex = 10
            SpearBtnData.Button.Parent = SpearBtnData.UI
            Instance.new("UICorner", SpearBtnData.Button).CornerRadius = UDim.new(1, 0)
            local spearStk = Instance.new("UIStroke", SpearBtnData.Button)
            spearStk.Color = _G.GLUTO_THEME
            spearStk.Thickness = 2
            spearStk.Transparency = 0.2
            local lockBtn = Instance.new("TextButton")
            lockBtn.Name = "LockDrag"
            lockBtn.Size = UDim2.new(0, 22, 0, 22)
            lockBtn.Position = UDim2.new(1, -5, 0, -5)
            lockBtn.AnchorPoint = Vector2.new(1, 0)
            lockBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            lockBtn.BackgroundTransparency = 0.3
            lockBtn.Text = "L"
            lockBtn.TextSize = 10
            lockBtn.Font = Enum.Font.GothamBold
            lockBtn.TextColor3 = _G.GLUTO_THEME
            lockBtn.ZIndex = 11
            lockBtn.Parent = SpearBtnData.Button
            Instance.new("UICorner", lockBtn).CornerRadius = UDim.new(1, 0)
            lockBtn.MouseButton1Click:Connect(function()
                SpearBtnData.DragLocked = not SpearBtnData.DragLocked
                lockBtn.Text = SpearBtnData.DragLocked and "X" or "L"
                lockBtn.BackgroundColor3 = SpearBtnData.DragLocked and Color3.fromRGB(230, 80, 100) or Color3.fromRGB(40, 40, 40)
            end)
            local targetLabel = Instance.new("TextLabel")
            targetLabel.Name = "SpearTargetLabel"
            targetLabel.Size = UDim2.new(0, 90, 0, 18)
            targetLabel.Position = UDim2.new(0.5, 0, 0, -22)
            targetLabel.AnchorPoint = Vector2.new(0.5, 0)
            targetLabel.BackgroundTransparency = 1
            targetLabel.Text = "AUTO"
            targetLabel.TextColor3 = _G.GLUTO_THEME
            targetLabel.TextSize = 12
            targetLabel.Font = Enum.Font.GothamBold
            targetLabel.TextTruncate = Enum.TextTruncate.AtEnd
            targetLabel.ZIndex = 11
            targetLabel.Visible = false
            targetLabel.Parent = SpearBtnData.Button
            SpearBtnData.TargetLabel = targetLabel
            local leftArrow = Instance.new("TextButton")
            leftArrow.Name = "SpearTargetLeft"
            leftArrow.Size = UDim2.new(0, 28, 0, 28)
            leftArrow.Position = UDim2.new(0, -34, 0.5, 0)
            leftArrow.AnchorPoint = Vector2.new(0.5, 0.5)
            leftArrow.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
            leftArrow.BackgroundTransparency = 0.15
            leftArrow.Text = "<"
            leftArrow.TextColor3 = _G.GLUTO_THEME_DIM
            leftArrow.TextSize = 16
            leftArrow.Font = Enum.Font.GothamBold
            leftArrow.ZIndex = 10
            leftArrow.Parent = SpearBtnData.Button
            Instance.new("UICorner", leftArrow).CornerRadius = UDim.new(1, 0)
            local leftStk = Instance.new("UIStroke", leftArrow)
            leftStk.Color = _G.GLUTO_THEME
            leftStk.Thickness = 1.5
            leftStk.Transparency = 0.3
            SpearBtnData.LeftArrow = leftArrow
            leftArrow.MouseButton1Click:Connect(function() Spear_CycleTarget(-1) end)
            local rightArrow = Instance.new("TextButton")
            rightArrow.Name = "SpearTargetRight"
            rightArrow.Size = UDim2.new(0, 28, 0, 28)
            rightArrow.Position = UDim2.new(1, 34, 0.5, 0)
            rightArrow.AnchorPoint = Vector2.new(0.5, 0.5)
            rightArrow.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
            rightArrow.BackgroundTransparency = 0.15
            rightArrow.Text = ">"
            rightArrow.TextColor3 = _G.GLUTO_THEME
            rightArrow.TextSize = 16
            rightArrow.Font = Enum.Font.GothamBold
            rightArrow.ZIndex = 10
            rightArrow.Parent = SpearBtnData.Button
            Instance.new("UICorner", rightArrow).CornerRadius = UDim.new(1, 0)
            local rightStk = Instance.new("UIStroke", rightArrow)
            rightStk.Color = _G.GLUTO_THEME
            rightStk.Thickness = 1.5
            rightStk.Transparency = 0.3
            SpearBtnData.RightArrow = rightArrow
            rightArrow.MouseButton1Click:Connect(function() Spear_CycleTarget(1) end)
            SpearBtnData.Button.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    if SpearBtnData.DragLocked then return end
                    SpearBtnData.Dragging = true
                    SpearBtnData.DragStart = input.Position
                    SpearBtnData.DragStartPos = SpearBtnData.Button.Position
                end
            end)
            UserInputService.InputChanged:Connect(function(input)
                if SpearBtnData.Dragging and not SpearBtnData.DragLocked and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    local delta = input.Position - SpearBtnData.DragStart
                    SpearBtnData.Button.Position = UDim2.new(
                        SpearBtnData.DragStartPos.X.Scale, SpearBtnData.DragStartPos.X.Offset + delta.X,
                        SpearBtnData.DragStartPos.Y.Scale, SpearBtnData.DragStartPos.Y.Offset + delta.Y
                    )
                end
            end)
            SpearBtnData.Button.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    SpearBtnData.Dragging = false
                end
            end)
            SpearBtnData.Button.MouseButton1Click:Connect(function()
                SpearBtnData.Active = not SpearBtnData.Active
                if SpearBtnData.Active then
                    SpearBtnData.Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    SpearBtnData.Button.TextColor3 = Color3.fromRGB(0, 0, 0)
                    spearStk.Color = Color3.fromRGB(255, 255, 255)
                    VD_Notify("Spear Aimbot", "Spear Aimbot AKTIF!", 3)
                else
                    SpearBtnData.Button.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
                    SpearBtnData.Button.TextColor3 = _G.GLUTO_THEME
                    spearStk.Color = _G.GLUTO_THEME
                    VD_Notify("Spear Aimbot", "Spear Aimbot NONAKTIF", 3)
                end
            end)
        end
        RunService.RenderStepped:Connect(function() pcall(Spear_UpdateAim) end)
        RunService.Heartbeat:Connect(function()
            if SpearBtnData and SpearBtnData.Button then
                local shouldShow = VD.SPEAR_Aimbot and GetRole() == "Killer"
                SpearBtnData.Button.Visible = shouldShow
                if shouldShow then pcall(Spear_UpdateTargetLabel) end
            end
        end)
        LocalPlayer.CharacterAdded:Connect(function()
            task.wait(0.5)
            if VD.SPEAR_Aimbot then pcall(Spear_SetupButton) end
        end)
        W.SpearAimbot_SetEnabled = function(v)
            VD.SPEAR_Aimbot = v and true or false
            if v then SpearBtnData.Active = true; Spear_SetupButton()
            else
                if SpearBtnData.UI then pcall(function() SpearBtnData.UI:Destroy() end); SpearBtnData.UI = nil end
                SpearBtnData.Button = nil
            end
        end
        W.SpearAimbot_SetGravity = function(v) VD.SPEAR_Gravity = tonumber(v) or 50 end
        W.SpearAimbot_SetSpeed   = function(v) VD.SPEAR_Speed   = tonumber(v) or 100 end
        W.SpearAimbot_CycleTarget = Spear_CycleTarget
    end

    do
        VD.DashLockEnabled       = VD.DashLockEnabled      or false
        VD.DashLockDuration      = VD.DashLockDuration     or 1.5
        VD.DashLockSmoothness    = VD.DashLockSmoothness   or 0.3
        VD.FreezeDuringDashLock  = VD.FreezeDuringDashLock or false
        VD._DashLockActive       = false
        VD._DashLockTarget       = nil
        VD._DashLockConnection   = nil
        local DashAnimationId = "rbxassetid://98163597193511"
        local function DashLock_Update()
            if not VD.DashLockEnabled or not VD._DashLockActive then return end
            local myChar = LocalPlayer.Character
            local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
            if not myRoot then VD._DashLockTarget = nil; return end
            local target, targetDist = nil, math.huge
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and TeamIs(player, "Survivor") then
                    local char = player.Character
                    if char then
                        local root = char:FindFirstChild("HumanoidRootPart")
                        local hum = char:FindFirstChildOfClass("Humanoid")
                        if root and hum and hum.Health > 0 then
                            local dist = (myRoot.Position - root.Position).Magnitude
                            if dist < targetDist then targetDist = dist; target = root end
                        end
                    end
                end
            end
            if not target then VD._DashLockTarget = nil; return end
            VD._DashLockTarget = target
            local cam = Workspace.CurrentCamera
            if cam then
                local smooth = VD.DashLockSmoothness or 0.3
                cam.CFrame = cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position, target.Position), smooth)
            end
            if VD.FreezeDuringDashLock then
                local hum = myChar:FindFirstChildOfClass("Humanoid")
                if hum and hum.WalkSpeed ~= 0 then hum.WalkSpeed = 0 end
            end
        end
        local function DashLock_SetActive(active)
            active = active and true or false
            if active == VD._DashLockActive then return end
            VD._DashLockActive = active
            if active then
                if not VD._DashLockConnection then
                    VD._DashLockConnection = RunService.RenderStepped:Connect(function() pcall(DashLock_Update) end)
                end
            else
                if VD._DashLockConnection then
                    pcall(function() VD._DashLockConnection:Disconnect() end)
                    VD._DashLockConnection = nil
                end
                VD._DashLockTarget = nil
                if VD.FreezeDuringDashLock then
                    local char = LocalPlayer.Character
                    local hum = char and char:FindFirstChildOfClass("Humanoid")
                    if hum and hum.WalkSpeed == 0 then hum.WalkSpeed = 16 end
                end
            end
        end
        local function DashLock_HookCharacter(char)
            if not char then return end
            local hum = char:FindFirstChildOfClass("Humanoid")
            if not hum then return end
            local anim = hum:FindFirstChildOfClass("Animator") or hum:WaitForChild("Animator", 5)
            if not anim then return end
            anim.AnimationPlayed:Connect(function(track)
                if not VD.DashLockEnabled then return end
                local aid = track.Animation and track.Animation.AnimationId or ""
                if aid == DashAnimationId then
                    DashLock_SetActive(true)
                    task.delay(VD.DashLockDuration or 1.5, function() DashLock_SetActive(false) end)
                end
            end)
        end
        if LocalPlayer.Character then DashLock_HookCharacter(LocalPlayer.Character) end
        LocalPlayer.CharacterAdded:Connect(function(c)
            task.wait(0.5); DashLock_HookCharacter(c)
        end)
        W.DashLock_SetActive = DashLock_SetActive
        W.DashLock_SetEnabled = function(v)
            VD.DashLockEnabled = v and true or false
            if not v then DashLock_SetActive(false) end
        end
    end

    do
        VD.SURV_AutoVault  = VD.SURV_AutoVault  or false
        VD.SURV_FastVault  = VD.SURV_FastVault  or false
        VD.SURF_VaultSpeed = VD.SURF_VaultSpeed or 13
        local _vaultedWindows = {}
        local _lastVaultScan  = 0
        local function SwiftVault_BuildWindowGroups()
            local groups = {}
            local map = Workspace:FindFirstChild("Map")
            if not map then return groups end
            local seen = {}
            local function addPart(part)
                if not part or seen[part] then return end
                seen[part] = true
                local rootWindow = part.Parent
                if part.Name == "VaultPoint" and part.Parent and part.Parent.Name == "VaultTrigger" then
                    rootWindow = part.Parent.Parent
                elseif part.Name == "VaultTrigger" then
                    rootWindow = part.Parent
                end
                if rootWindow then
                    groups[rootWindow] = groups[rootWindow] or {}
                    local exists = false
                    for _, p in ipairs(groups[rootWindow]) do
                        if p == part then exists = true; break end
                    end
                    if not exists then table.insert(groups[rootWindow], part) end
                end
            end
            for _, obj in ipairs(map:GetDescendants()) do
                if obj:IsA("BasePart") and (obj.Name == "VaultTrigger" or obj.Name == "VaultPoint") then
                    addPart(obj)
                end
            end
            return groups
        end
        local function SwiftVault_GetVTPosition(vt)
            if not vt then return nil end
            if vt:IsA("BasePart") then return vt.Position end
            if vt:IsA("Model") then
                if vt.PrimaryPart then return vt.PrimaryPart.Position end
                local bp = vt:FindFirstChildWhichIsA("BasePart", true)
                if bp then return bp.Position end
            end
            return nil
        end
        RunService.Heartbeat:Connect(function()
            if VD.SURV_FastVault then
                pcall(function()
                    local char = LocalPlayer.Character
                    if char then char:SetAttribute("vaultspeed", (VD.SURF_VaultSpeed or 13) / 10) end
                end)
            end
        end)
        RunService.Heartbeat:Connect(function()
            if not VD.SURV_AutoVault then return end
            if GetRole() ~= "Survivor" then return end
            if tick() - _lastVaultScan < 0.15 then return end
            _lastVaultScan = tick()
            pcall(function()
                local char   = LocalPlayer.Character
                local myRoot = char and char:FindFirstChild("HumanoidRootPart")
                local hum    = char and char:FindFirstChildOfClass("Humanoid")
                if not myRoot or not hum or hum.Health <= 0 then return end
                local vel = myRoot.AssemblyLinearVelocity
                if vel.Magnitude < 1 then return end
                local remotes   = ReplicatedStorage:FindFirstChild("Remotes")
                local winFolder = remotes and remotes:FindFirstChild("Window")
                local vaultEv   = winFolder and winFolder:FindFirstChild("VaultCommit")
                if not vaultEv then return end
                local windowGroups = SwiftVault_BuildWindowGroups()
                for rootWindow, parts in pairs(windowGroups) do
                    local allVTs = {}
                    for _, child in ipairs(rootWindow:GetChildren()) do
                        if child.Name == "VaultTrigger" then table.insert(allVTs, child) end
                    end
                    if #allVTs == 0 then continue end
                    local nearestVT, nearestVTDist = nil, math.huge
                    for _, vt in ipairs(allVTs) do
                        local pos = SwiftVault_GetVTPosition(vt)
                        if pos then
                            local d = (myRoot.Position - pos).Magnitude
                            if d < nearestVTDist then nearestVTDist = d; nearestVT = vt end
                        end
                    end
                    if not nearestVT or nearestVTDist > 6.0 then continue end
                    local lastUsed = _vaultedWindows[rootWindow] or 0
                    if tick() - lastUsed < 3.0 then continue end
                    local finalTarget = nearestVT
                    local remotes2 = ReplicatedStorage:FindFirstChild("Remotes")
                    local winFold  = remotes2 and remotes2:FindFirstChild("Window")
                    if winFold and finalTarget then
                        local vaultEvent     = winFold:FindFirstChild("VaultEvent")
                        local vaultBindable  = winFold:FindFirstChild("Vaultbindable")
                        local fastvault      = winFold:FindFirstChild("fastvault")
                        local vaultComplete1 = winFold:FindFirstChild("VaultCompleteEventpart1")
                        local vaultComplete  = winFold:FindFirstChild("VaultCompleteEvent")
                        if vaultEvent    then pcall(function() vaultEvent:FireServer(finalTarget, true) end) end
                        if vaultBindable then pcall(function() vaultBindable:Fire(finalTarget, true) end) end
                        if fastvault     then pcall(function() fastvault:FireServer(LocalPlayer) end) end
                        if vaultComplete1 then pcall(function() vaultComplete1:FireServer() end) end
                        if vaultComplete  then pcall(function() vaultComplete:FireServer(finalTarget, false) end) end
                    end
                    _vaultedWindows[rootWindow] = tick()
                    break
                end
            end)
        end)
        LocalPlayer.CharacterAdded:Connect(function()
            task.wait(0.5); _vaultedWindows = {}
        end)
        W.SwiftVault_SetEnabled = function(v)
            VD.SURV_AutoVault = v and true or false; _vaultedWindows = {}
        end
        W.SwiftVaultV2_SetEnabled = function(v)
            VD.SURV_FastVault = v and true or false
            if not v then
                local char = LocalPlayer.Character
                if char then pcall(function() char:SetAttribute("vaultspeed", 1) end) end
            end
        end
        W.SwiftVault_SetSpeed = function(v) VD.SURF_VaultSpeed = tonumber(v) or 13 end
    end

    do
        local WorkspaceSvc = Workspace
        W.Graphics = W.Graphics or {
            Fullbright = false, NoShadow = false, LowGraphics = false,
            NoScreenEffects = false, CleanSky = false,
            ClockTimeEnabled = false, ClockTime = 14, Brightness = 2,
            UnlimitedZoom = false, MaxZoomDistance = 1000,
            FOVEnabled = false, FOV = 70, PotatoEnabled = false,
        }
        local G = W.Graphics
        local original = {
            Brightness = Lighting.Brightness, ClockTime = Lighting.ClockTime,
            Ambient = Lighting.Ambient, OutdoorAmbient = Lighting.OutdoorAmbient,
            GlobalShadows = Lighting.GlobalShadows,
            FOV = WorkspaceSvc.CurrentCamera and WorkspaceSvc.CurrentCamera.FieldOfView or 70,
        }
        local LastState = { Fullbright = nil, NoShadow = nil, Ambient = nil, Brightness = nil, ClockTime = nil }
        local LastOptimize = { LowGraphics = nil, CleanSky = nil }
        local DisabledEffects = {}
        local ScreenEffectTypes = { "ColorCorrectionEffect", "DepthOfFieldEffect", "BlurEffect", "SunRaysEffect", "BloomEffect" }
        local function Graphics_Apply(force)
            if force or LastState.Fullbright ~= G.Fullbright then
                LastState.Fullbright = G.Fullbright
                if G.Fullbright then
                    Lighting.Brightness     = 2; Lighting.ClockTime = 14
                    Lighting.Ambient        = Color3.fromRGB(255, 255, 255)
                    Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
                else
                    Lighting.Brightness     = original.Brightness
                    Lighting.ClockTime      = original.ClockTime
                    Lighting.Ambient        = original.Ambient
                    Lighting.OutdoorAmbient = original.OutdoorAmbient
                end
            end
            if force or LastState.NoShadow ~= G.NoShadow then
                LastState.NoShadow = G.NoShadow
                Lighting.GlobalShadows = not G.NoShadow
            end
            local ambientChanged = LastState.Ambient ~= G.ClockTimeEnabled or LastState.Brightness ~= G.Brightness or LastState.ClockTime ~= G.ClockTime
            if force or ambientChanged then
                LastState.Ambient = G.ClockTimeEnabled
                LastState.Brightness = G.Brightness
                LastState.ClockTime = G.ClockTime
                if G.ClockTimeEnabled then
                    Lighting.ClockTime  = G.ClockTime; Lighting.Brightness = G.Brightness
                elseif not G.Fullbright then
                    Lighting.Brightness = original.Brightness
                    Lighting.ClockTime  = original.ClockTime
                end
            end
        end
        local function Graphics_ApplyOptimization(force)
            if force or LastOptimize.LowGraphics ~= G.LowGraphics then
                LastOptimize.LowGraphics = G.LowGraphics
                pcall(function()
                    if G.LowGraphics then settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
                    else settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic end
                end)
            end
            if force or LastOptimize.CleanSky ~= G.CleanSky then
                LastOptimize.CleanSky = G.CleanSky
                if G.CleanSky then
                    for _, v in ipairs(Lighting:GetChildren()) do
                        if v:IsA("Sky") then v:Destroy() end
                    end
                end
            end
        end
        local function Graphics_ApplyNoScreenEffects()
            if G.NoScreenEffects then
                for _, v in pairs(Lighting:GetChildren()) do
                    for _, t in ipairs(ScreenEffectTypes) do
                        if v:IsA(t) then
                            if DisabledEffects[v] == nil then DisabledEffects[v] = v.Enabled end
                            v.Enabled = false
                        end
                    end
                end
            else
                for obj, state in pairs(DisabledEffects) do
                    if obj and obj.Parent then obj.Enabled = state end
                end
                DisabledEffects = {}
            end
        end
        Lighting.ChildAdded:Connect(function(v)
            if not G.NoScreenEffects then return end
            task.wait()
            for _, t in ipairs(ScreenEffectTypes) do
                if v:IsA(t) then
                    if DisabledEffects[v] == nil then DisabledEffects[v] = v.Enabled end
                    v.Enabled = false
                end
            end
        end)
        local function Graphics_ApplyZoom()
            if G.UnlimitedZoom then
                LocalPlayer.CameraMaxZoomDistance = G.MaxZoomDistance
                LocalPlayer.CameraMinZoomDistance = 0
            else
                LocalPlayer.CameraMaxZoomDistance = 128
                LocalPlayer.CameraMinZoomDistance = 0.5
            end
        end
        local function Graphics_ApplyFOV()
            local cam = WorkspaceSvc.CurrentCamera
            if not cam then return end
            if G.FOVEnabled then cam.FieldOfView = G.FOV
            else cam.FieldOfView = original.FOV end
        end
        local Potato_Enabled = false
        local Potato_Busy = false
        local Potato_Changed = {}
        local Potato_Connections = {}
        local POTATO_BATCH_SIZE = 40
        local POTATO_BATCH_DELAY = 1
        local function Potato_Save(obj, prop)
            if not Potato_Changed[obj] then Potato_Changed[obj] = {} end
            if Potato_Changed[obj][prop] == nil then
                local ok, val = pcall(function() return obj[prop] end)
                if ok then Potato_Changed[obj][prop] = val end
            end
        end
        local function Potato_Set(obj, prop, value)
            if not obj or not obj.Parent then return end
            Potato_Save(obj, prop)
            pcall(function() obj[prop] = value end)
        end
        local function Potato_Optimize(obj)
            if not Potato_Enabled or not obj then return end
            if obj:IsA("BasePart") then
                Potato_Set(obj, "CastShadow", false)
                Potato_Set(obj, "Reflectance", 0)
                pcall(function() Potato_Set(obj, "Material", Enum.Material.Plastic) end)
            end
            if obj:IsA("MeshPart") then
                pcall(function() Potato_Set(obj, "RenderFidelity", Enum.RenderFidelity.Performance) end)
            end
            if obj:IsA("Texture") or obj:IsA("Decal") then Potato_Set(obj, "Transparency", 1) end
            if obj:IsA("SurfaceAppearance") then
                pcall(function()
                    Potato_Set(obj, "ColorMap", ""); Potato_Set(obj, "MetalnessMap", "")
                    Potato_Set(obj, "NormalMap", ""); Potato_Set(obj, "RoughnessMap", "")
                end)
            end
            if obj:IsA("ParticleEmitter") then Potato_Set(obj, "Enabled", false) end
            if obj:IsA("Trail") then Potato_Set(obj, "Enabled", false) end
            if obj:IsA("Beam") then Potato_Set(obj, "Enabled", false) end
            if obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then Potato_Set(obj, "Enabled", false) end
            if obj:IsA("Clouds") then
                Potato_Set(obj, "Cover", 0); Potato_Set(obj, "Density", 0)
            end
        end
        local function Potato_LowLighting()
            Potato_Set(Lighting, "GlobalShadows", false)
            Potato_Set(Lighting, "Brightness", 1)
            pcall(function()
                Potato_Set(Lighting, "EnvironmentDiffuseScale", 0)
                Potato_Set(Lighting, "EnvironmentSpecularScale", 0)
            end)
        end
        local function Potato_LowTerrain()
            local Terrain = WorkspaceSvc:FindFirstChildOfClass("Terrain")
            if not Terrain then return end
            Potato_Set(Terrain, "Decoration", false)
            Potato_Set(Terrain, "WaterWaveSize", 0)
            Potato_Set(Terrain, "WaterWaveSpeed", 0)
            Potato_Set(Terrain, "WaterReflectance", 0)
        end
        local function Potato_ProcessMap()
            if Potato_Busy then return end
            Potato_Busy = true
            local objects = WorkspaceSvc:GetDescendants()
            local total = #objects
            local index = 1
            while Potato_Enabled and index <= total do
                local finish = math.min(index + POTATO_BATCH_SIZE - 1, total)
                for i = index, finish do
                    if not Potato_Enabled then break end
                    Potato_Optimize(objects[i])
                end
                RunService.Heartbeat:Wait()
                if index % (POTATO_BATCH_SIZE * 5) == 1 then task.wait(POTATO_BATCH_DELAY / 10) end
                index = finish + 1
            end
            Potato_Busy = false
        end
        local function Potato_StartNewObjectHandler()
            if Potato_Connections.NewObject then return end
            Potato_Connections.NewObject = WorkspaceSvc.DescendantAdded:Connect(function(obj)
                if not Potato_Enabled then return end
                task.defer(function() if Potato_Enabled then Potato_Optimize(obj) end end)
            end)
        end
        local function Potato_Enable()
            if Potato_Enabled then return end
            Potato_Enabled = true
            pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Level01 end)
            Potato_LowLighting(); Potato_LowTerrain(); Potato_StartNewObjectHandler()
            task.spawn(Potato_ProcessMap)
        end
        local function Potato_Disable()
            if not Potato_Enabled then return end
            Potato_Enabled = false
            for name, conn in pairs(Potato_Connections) do
                pcall(function() conn:Disconnect() end)
                Potato_Connections[name] = nil
            end
            task.spawn(function()
                local count = 0
                for obj, properties in pairs(Potato_Changed) do
                    if obj and obj.Parent then
                        for prop, value in pairs(properties) do
                            pcall(function() obj[prop] = value end)
                            count = count + 1
                            if count >= POTATO_BATCH_SIZE then task.wait(); count = 0 end
                        end
                    end
                end
                Potato_Changed = {}
            end)
            pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic end)
        end
        RunService.RenderStepped:Connect(function()
            if G.FOVEnabled then
                local cam = WorkspaceSvc.CurrentCamera
                if cam and cam.FieldOfView ~= G.FOV then cam.FieldOfView = G.FOV end
            end
        end)
        RunService.RenderStepped:Connect(function()
            if not G.UnlimitedZoom then return end
            if LocalPlayer.CameraMaxZoomDistance ~= G.MaxZoomDistance then
                LocalPlayer.CameraMaxZoomDistance = G.MaxZoomDistance
            end
            if LocalPlayer.CameraMinZoomDistance ~= 0 then LocalPlayer.CameraMinZoomDistance = 0 end
        end)
        W.Graphics_Apply             = Graphics_Apply
        W.Graphics_ApplyOptimization = Graphics_ApplyOptimization
        W.Graphics_ApplyNoScreenFx   = Graphics_ApplyNoScreenEffects
        W.Graphics_ApplyZoom         = Graphics_ApplyZoom
        W.Graphics_ApplyFOV          = Graphics_ApplyFOV
        W.Potato_SetEnabled = function(v)
            G.PotatoEnabled = v and true or false
            if G.PotatoEnabled then Potato_Enable() else Potato_Disable() end
        end
        W.Potato_IsEnabled = function() return Potato_Enabled end
        LocalPlayer.CharacterAdded:Connect(function()
            task.wait(1)
            Graphics_Apply(true); Graphics_ApplyOptimization(true)
            Graphics_ApplyNoScreenEffects(); Graphics_ApplyZoom(); Graphics_ApplyFOV()
        end)
    end

    do
        VD.SURV_AutoPallet     = VD.SURV_AutoPallet     or false
        VD.SURV_AutoPalletDist = VD.SURV_AutoPalletDist or 20
        local _lastPalletDrop = 0
        local _usedPallets    = {}
        local function Pallet_GetKillerRoot()
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer and TeamIs(plr, "Killer") and plr.Character then
                    local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then return hrp end
                end
            end
            return nil
        end
        local function Pallet_GetAllPallets()
            local list = {}
            local map = Workspace:FindFirstChild("Map")
            if not map then return list end
            for _, obj in ipairs(map:GetDescendants()) do
                if obj.Name == "Palletwrong" and (obj:IsA("Model") or obj:IsA("Folder")) then
                    table.insert(list, obj)
                end
            end
            return list
        end
        local function Pallet_IsDropped(palletModel)
            if not palletModel or not palletModel.Parent then return true end
            if _usedPallets[palletModel] then return true end
            local ok, destroyed = pcall(function() return palletModel:GetAttribute("Destroyed") end)
            if ok and destroyed == true then return true end
            local ok2, broken = pcall(function() return palletModel:GetAttribute("Broken") end)
            if ok2 and broken == true then return true end
            if not palletModel:FindFirstChildWhichIsA("BasePart", true) then return true end
            return false
        end
        local function Pallet_GetPointSlide(model)
            local slide = model:FindFirstChild("PalletPointSlide")
            if slide then return slide end
            for _, child in ipairs(model:GetDescendants()) do
                if child.Name == "PalletPointSlide" then return child end
            end
            return model:FindFirstChild("PalletPoint")
        end
        local _lastPalletScan = 0
        RunService.Heartbeat:Connect(function()
            if not VD.SURV_AutoPallet then return end
            if GetRole() ~= "Survivor" then return end
            local now = tick()
            if now - _lastPalletScan < 0.2 then return end
            _lastPalletScan = now
            if now - _lastPalletDrop < 2.5 then return end
            pcall(function()
                local char   = LocalPlayer.Character
                local myRoot = char and char:FindFirstChild("HumanoidRootPart")
                local hum    = char and char:FindFirstChildOfClass("Humanoid")
                if not myRoot or not hum or hum.Health <= 0 then return end
                local killerRoot = Pallet_GetKillerRoot()
                if not killerRoot then return end
                if (myRoot.Position - killerRoot.Position).Magnitude > (VD.SURV_AutoPalletDist or 20) then return end
                local remotes    = ReplicatedStorage:FindFirstChild("Remotes")
                local palletFold = remotes and remotes:FindFirstChild("Pallet")
                local dropEvent  = palletFold and palletFold:FindFirstChild("PalletDropEvent")
                if not dropEvent then return end
                local bestPallet, bestDist = nil, 8
                for _, pal in ipairs(Pallet_GetAllPallets()) do
                    if not Pallet_IsDropped(pal) then
                        local refPart = pal:FindFirstChild("PalletPoint")
                            or pal:FindFirstChild("PalletPointSlide")
                            or pal:FindFirstChildWhichIsA("BasePart", true)
                        if refPart then
                            local d = (myRoot.Position - refPart.Position).Magnitude
                            if d < bestDist then bestDist = d; bestPallet = pal end
                        end
                    end
                end
                if bestPallet then
                    local fireTarget = Pallet_GetPointSlide(bestPallet)
                    if fireTarget then
                        pcall(function() dropEvent:FireServer(fireTarget) end)
                        _usedPallets[bestPallet] = true
                        _lastPalletDrop = tick()
                    end
                end
            end)
        end)
        LocalPlayer.CharacterAdded:Connect(function()
            task.wait(0.5); _usedPallets = {}
        end)
        W.PalletReflex_SetEnabled = function(v)
            VD.SURV_AutoPallet = v and true or false; _usedPallets = {}
        end
        W.PalletReflex_SetDistance = function(v) VD.SURV_AutoPalletDist = tonumber(v) or 20 end
    end

    do
        VD.CamDBD_SmoothEnabled   = VD.CamDBD_SmoothEnabled   or false
        VD.CamDBD_SmoothSpeed     = VD.CamDBD_SmoothSpeed     or 5
        VD.CamDBD_POVEnabled      = VD.CamDBD_POVEnabled      or false
        VD.CamDBD_TargetPOV       = VD.CamDBD_TargetPOV       or 85
        VD.CamDBD_POVSmooth       = VD.CamDBD_POVSmooth       or 9
        local CameraBindName = "Gluto_CameraDBD_Smooth"
        local PreviousPosition = nil
        local PreviousRotation = nil
        local OriginalPOV      = 70
        pcall(function() RunService:UnbindFromRenderStep(CameraBindName) end)
        RunService:BindToRenderStep(
            CameraBindName,
            Enum.RenderPriority.Camera.Value + 1,
            function(DeltaTime)
                local Camera = Workspace.CurrentCamera
                if not Camera then return end
                if Camera.CameraType ~= Enum.CameraType.Custom
                   and Camera.CameraType ~= Enum.CameraType.Follow then
                    PreviousPosition = nil; PreviousRotation = nil; return
                end
                if VD.CamDBD_SmoothEnabled then
                    local CurrentCFrame   = Camera.CFrame
                    local CurrentPosition = CurrentCFrame.Position
                    local CurrentRotation = CurrentCFrame.Rotation
                    if not PreviousPosition or not PreviousRotation then
                        PreviousPosition = CurrentPosition
                        PreviousRotation = CurrentRotation
                    else
                        local smoothSpeed = tonumber(VD.CamDBD_SmoothSpeed) or 5
                        local posAlpha = 1 - math.exp(-smoothSpeed * DeltaTime)
                        PreviousPosition = PreviousPosition:Lerp(CurrentPosition, posAlpha)
                        local rotAlpha = 1 - math.exp(-(smoothSpeed * 1.90) * DeltaTime)
                        PreviousRotation = PreviousRotation:Lerp(CurrentRotation, rotAlpha)
                        Camera.CFrame = CFrame.new(PreviousPosition) * PreviousRotation
                    end
                else
                    PreviousPosition = nil; PreviousRotation = nil
                end
                if VD.CamDBD_POVEnabled then
                    local povSpeed = tonumber(VD.CamDBD_POVSmooth) or 9
                    local alpha = 1 - math.exp(-povSpeed * DeltaTime)
                    local target = tonumber(VD.CamDBD_TargetPOV) or 85
                    Camera.FieldOfView = Camera.FieldOfView + (target - Camera.FieldOfView) * alpha
                end
            end
        )
        LocalPlayer.CharacterAdded:Connect(function()
            task.wait(0.5); PreviousPosition = nil; PreviousRotation = nil
        end)
        W.CamDBD_SetSmooth = function(v)
            VD.CamDBD_SmoothEnabled = v and true or false
            if not v then PreviousPosition = nil; PreviousRotation = nil
            else
                local cam = Workspace.CurrentCamera
                if cam then
                    PreviousPosition = cam.CFrame.Position
                    PreviousRotation = cam.CFrame.Rotation
                end
            end
        end
        W.CamDBD_SetSmoothSpeed = function(v) VD.CamDBD_SmoothSpeed = tonumber(v) or 5 end
        W.CamDBD_SetPOVLock = function(v)
            VD.CamDBD_POVEnabled = v and true or false
            if not v then
                local cam = Workspace.CurrentCamera
                if cam then cam.FieldOfView = OriginalPOV end
            else
                local cam = Workspace.CurrentCamera
                if cam then OriginalPOV = cam.FieldOfView end
            end
        end
        W.CamDBD_SetTargetPOV = function(v) VD.CamDBD_TargetPOV = tonumber(v) or 85 end
        W.CamDBD_SetPOVSmooth = function(v) VD.CamDBD_POVSmooth = tonumber(v) or 9 end
    end

    local function CreateFloatingButton(cfg)
        local state = cfg.state
        state.Connections = state.Connections or {}

        local function ClearConns()
            for _, c in ipairs(state.Connections) do
                pcall(function() c:Disconnect() end)
            end
            state.Connections = {}
        end

        local function DestroyBtn()
            ClearConns()
            if state.Gui then
                pcall(function() state.Gui:Destroy() end)
                state.Gui = nil
            end
        end

        local function UpdateVisual()
            if not state.Gui then return end
            local main = state.Gui:FindFirstChild("MainBtn", true)
            if not main then return end
            local on = false
            pcall(function() on = cfg.isOn() end)
            local stroke = main:FindFirstChild("BtnStroke")
            if on then
                main.Text = cfg.title .. " : ON"
                main.TextColor3 = _G.GLUTO_THEME
                if stroke then stroke.Color = _G.GLUTO_THEME end
            else
                main.Text = cfg.title .. " : OFF"
                main.TextColor3 = Color3.fromRGB(170, 170, 170)
                if stroke then stroke.Color = Color3.fromRGB(170, 170, 170) end
            end
        end

        local function ToggleBtn()
            local s = not cfg.isOn()
            pcall(function() cfg.onToggle(s) end)
            task.wait(0.08)
            UpdateVisual()
            if s then VD_Notify(cfg.notifyTitle, "Enabled", 2) end
        end

        local function CreateBtn()
            DestroyBtn()
            local parent = SafeGuiParent()
            if not parent then return end

            local gui = Instance.new("ScreenGui")
            gui.Name = "Gluto" .. cfg.id .. "Btn"
            gui.ResetOnSpawn = false
            gui.IgnoreGuiInset = true
            gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            gui.Parent = parent
            state.Gui = gui

            local btn = Instance.new("TextButton")
            btn.Name = "MainBtn"
            btn.Size = UDim2.new(0, 140, 0, 40)
            btn.Position = state.SavedPos or UDim2.new(0.65, 0, 0.20, 0)
            btn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
            btn.BackgroundTransparency = 0.3
            btn.Text = cfg.title .. " : OFF"
            btn.TextColor3 = Color3.fromRGB(170, 170, 170)
            btn.TextSize = 13
            btn.Font = Enum.Font.GothamBold
            btn.AutoButtonColor = false
            btn.Parent = gui

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 10)
            corner.Parent = btn

            local stroke = Instance.new("UIStroke")
            stroke.Name = "BtnStroke"
            stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            stroke.Thickness = 1.5
            stroke.Color = Color3.fromRGB(170, 170, 170)
            stroke.Transparency = 0
            stroke.Parent = btn

            local dragging, dragInput, dragStart, startPos, moved = false, nil, nil, nil, false

            table.insert(state.Connections, btn.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    moved = false
                    dragInput = input
                    dragStart = input.Position
                    startPos = btn.Position
                end
            end))

            table.insert(state.Connections, btn.InputChanged:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                    dragInput = input
                end
            end))

            table.insert(state.Connections, UserInputService.InputChanged:Connect(function(input)
                if not dragging or input ~= dragInput then return end
                local delta = input.Position - dragStart
                if math.abs(delta.X) > 5 or math.abs(delta.Y) > 5 then moved = true end
                btn.Position = UDim2.new(
                    startPos.X.Scale, startPos.X.Offset + delta.X,
                    startPos.Y.Scale, startPos.Y.Offset + delta.Y
                )
                state.SavedPos = btn.Position
            end))

            table.insert(state.Connections, UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    if dragging and not moved then ToggleBtn() end
                    dragging = false
                end
            end))

            UpdateVisual()
        end

        state.Create = CreateBtn
        state.Destroy = DestroyBtn
        state.UpdateVisual = UpdateVisual
        state.SetEnabled = function(en)
            state.Enabled = en and true or false
            if state.Enabled then CreateBtn() else DestroyBtn() end
        end
        return state
    end

    W.CreateFloatingButton = CreateFloatingButton

    local SelfHealBtnState = { Enabled=false, DragLocked=false, Gui=nil, SavedPos=UDim2.new(0.03,0,0.28,0), Connections={} }
    local SelfHealState = CreateFloatingButton({
        id="SelfHeal", title="Heal", notifyTitle="Self Heal", state=SelfHealBtnState,
        isOn=function() return W.InstantHealSelf end,
        onToggle=function(v) W.setInstantHealSelf(v) end,
        iconRotation=0,
    })
    getgenv().Gluto_SHB_SetEnabled = function(en) SelfHealState.SetEnabled(en) end
    getgenv().Gluto_SHB_UpdateVisual = function() SelfHealState.UpdateVisual() end

    W.SelfUnhook = W.SelfUnhook or {
        Enabled=false, Following=false, FollowDuration=30, FollowDistance=20,
        MonitorConn=nil, TriggerCount=0, _lastTrigger=0, _cooldown=3,
        _hookPos=nil, _hookCFrame=nil, _activeThread=nil, _wasHooked=false
    }
    local SU = W.SelfUnhook
    function W.SU_IsHooked()
        local char = LocalPlayer.Character
        if not char then return false end
        return char:GetAttribute("IsHooked") == true or char:GetAttribute("isHooked") == true
            or char:GetAttribute("Hooked") == true or char:GetAttribute("HookedState") == true
    end
    function W.SU_GetRandomGeneratorPoint()
        local gens = W.GB_GetAllGenerators()
        if not gens or #gens == 0 then return nil end
        local valid = {}
        for _, g in ipairs(gens) do
            if g and g.Parent then
                for _, p in ipairs(W.GB_GetPoints(g)) do
                    if p and p.Parent then table.insert(valid, p) end
                end
            end
        end
        if #valid == 0 then return nil end
        return valid[math.random(1, #valid)]
    end
    function W.SU_GetKillerHRP()
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and TeamIs(p, "Killer") and p.Character then
                local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                if hrp then return hrp end
            end
        end
        return nil
    end
    function W.SU_Abort()
        SU.Following = false
        if SU._activeThread and coroutine.status(SU._activeThread) ~= "dead" then
            pcall(function() task.cancel(SU._activeThread) end)
        end
        SU._activeThread = nil
    end
    function W.SU_Trigger()
        if SU.Following then return end
        local now = tick()
        if now - SU._lastTrigger < SU._cooldown then return end
        if not W.SU_IsHooked() then return end
        SU._lastTrigger = now; SU.Following = true
        SU.TriggerCount = SU.TriggerCount + 1
        local char = LocalPlayer.Character
        if char then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then SU._hookPos = hrp.Position; SU._hookCFrame = hrp.CFrame end
        end
        SU._activeThread = task.spawn(function()
            local c = LocalPlayer.Character
            if not c then SU.Following = false; SU._activeThread = nil; return end
            local hrp = c:FindFirstChild("HumanoidRootPart")
            if not hrp then SU.Following = false; SU._activeThread = nil; return end
            local re = ReplicatedStorage:FindFirstChild("Remotes")
                and ReplicatedStorage.Remotes:FindFirstChild("Generator")
                and ReplicatedStorage.Remotes.Generator:FindFirstChild("RepairEvent")
            if not W.SU_IsHooked() then SU.Following = false; SU._activeThread = nil; return end
            local tp = W.SU_GetRandomGeneratorPoint()
            if tp then
                pcall(function() hrp.Velocity = Vector3.zero; hrp.CFrame = tp.CFrame + Vector3.new(0, 3, 0) end)
                task.wait(0.15)
                if re then
                    pcall(function() re:FireServer(tp, true) end); task.wait(0.35)
                    pcall(function() re:FireServer(tp, false) end); task.wait(0.15)
                    pcall(function() re:FireServer(tp, true) end); task.wait(0.35)
                    pcall(function() re:FireServer(tp, false) end)
                end
            end
            local fUntil = tick() + (SU.FollowDuration or 30)
            local bOff = SU.FollowDistance or 20
            while tick() < fUntil and SU.Enabled do
                if not W.SU_IsHooked() then
                    SU.Following = false; SU._activeThread = nil
                    VD_Notify("Bypass Self Unhook", "Udah lepas hook - STOP", 2)
                    return
                end
                local cc = LocalPlayer.Character
                if not cc then break end
                local r = cc:FindFirstChild("HumanoidRootPart")
                if not r then break end
                local khrp = W.SU_GetKillerHRP()
                if khrp then
                    pcall(function()
                        r.Velocity = Vector3.zero
                        local tPos = Vector3.new(khrp.Position.X, khrp.Position.Y - bOff, khrp.Position.Z)
                        r.CFrame = CFrame.new(tPos, tPos + Vector3.new(0, 0, -1))
                    end)
                end
                task.wait(0.03)
            end
            if W.SU_IsHooked() then
                local c2 = LocalPlayer.Character
                if c2 then
                    local r2 = c2:FindFirstChild("HumanoidRootPart")
                    if r2 then
                        if SU._hookCFrame then pcall(function() r2.Velocity = Vector3.zero; r2.CFrame = SU._hookCFrame end)
                        elseif SU._hookPos then pcall(function() r2.Velocity = Vector3.zero; r2.CFrame = CFrame.new(SU._hookPos + Vector3.new(0, 3, 0)) end) end
                    end
                end
            end
            SU.Following = false; SU._activeThread = nil
        end)
    end
    function W.SU_Start()
        if SU.MonitorConn then return end
        SU._wasHooked = false
        SU.MonitorConn = RunService.Heartbeat:Connect(function()
            if not SU.Enabled then return end
            local char = LocalPlayer.Character
            if not char then return end
            local isH = W.SU_IsHooked()
            if not isH then SU._wasHooked = false; return end
            if not SU._wasHooked and not SU.Following then SU._wasHooked = true; W.SU_Trigger() end
        end)
    end
    function W.SU_Stop()
        if SU.MonitorConn then SU.MonitorConn:Disconnect(); SU.MonitorConn = nil end
        W.SU_Abort(); SU._wasHooked = false
    end
    function W.SU_SetEnabled(v)
        SU.Enabled = v
        if v then W.SU_Start() else W.SU_Stop() end
    end

    local SelfUnhookBtnState = { Enabled=false, DragLocked=false, Gui=nil, SavedPos=UDim2.new(0.03,0,0.35,0), Connections={} }
    local SelfUnhookState = CreateFloatingButton({
        id="SelfUnhook", title="Hook", notifyTitle="Self Unhook", state=SelfUnhookBtnState,
        isOn=function() return W.SelfUnhook.Enabled end,
        onToggle=function(v) W.SU_SetEnabled(v) end,
        iconRotation=135,
    })
    getgenv().Gluto_SUB_SetEnabled = function(en) SelfUnhookState.SetEnabled(en) end
    getgenv().Gluto_SUB_UpdateVisual = function() SelfUnhookState.UpdateVisual() end

    local TrollBtnState = { Enabled=false, DragLocked=false, Gui=nil, SavedPos=UDim2.new(0.03,0,0.42,0), Connections={} }
    local TrollState = CreateFloatingButton({
        id="TrollTP", title="T_TP", notifyTitle="Troll Teleport", state=TrollBtnState,
        isOn=function() return W.TrollTeleport.Enabled end,
        onToggle=function(v) W.TrollTeleport_SetEnabled(v) end,
        iconRotation=225,
    })
    getgenv().Gluto_TTB_SetEnabled = function(en) TrollState.SetEnabled(en) end
    getgenv().Gluto_TTB_UpdateVisual = function() TrollState.UpdateVisual() end

    local EscapeBtnState = { Enabled=false, DragLocked=false, Gui=nil, SavedPos=UDim2.new(0.03,0,0.49,0), Connections={} }
    local EscapeState = CreateFloatingButton({
        id="Escape", title="Escape", notifyTitle="Instant Escape", state=EscapeBtnState,
        isOn=function() return W.Escape.Enabled end,
        onToggle=function(v) W.Escape.Enabled = v; if v then W.Escape_Teleport() end end,
        iconRotation=45,
    })
    getgenv().Gluto_Escape_SetEnabled = function(en) EscapeState.SetEnabled(en) end
    getgenv().Gluto_Escape_UpdateVisual = function() EscapeState.UpdateVisual() end

    local WisnuParryBtnState = { Enabled=false, DragLocked=false, Gui=nil, SavedPos=UDim2.new(0.03,0,0.56,0), Connections={} }
    local WisnuParryBtn = CreateFloatingButton({
        id="WisnuParry", title="Parry", notifyTitle="Auto Parry", state=WisnuParryBtnState,
        isOn=function() return VD.Surv_AutoParry end,
        onToggle=function(v)
            VD.Surv_AutoParry = v and true or false
            if v then VD_Notify("Auto Parry", "Enabled", 2)
            else VD_Notify("Auto Parry", "Disabled", 2) end
        end,
        iconRotation=45,
    })
    getgenv().Gluto_WisnuParryBtn_SetEnabled   = function(en) WisnuParryBtn.SetEnabled(en) end
    getgenv().Gluto_WisnuParryBtn_UpdateVisual = function() WisnuParryBtn.UpdateVisual() end

local HeadSitBtnState = {
    Enabled = false,
    DragLocked = false,
    Gui = nil,
    SavedPos = UDim2.new(0.03, 0, 0.91, 0),  -- posisi default (kiri bawah)
    Connections = {}
}
local HeadSitFloatingBtn = CreateFloatingButton({
    id = "HeadSit",
    title = "HeadSit",
    notifyTitle = "Head Sit Killer",
    state = HeadSitBtnState,
    isOn = function() return HeadSitEnabled end,
    onToggle = function(v)
        HeadSitEnabled = v
        if v then TK_HeadSit_Start() else TK_HeadSit_Stop() end
    end,
    iconRotation = 0,
})
getgenv().Gluto_HeadSitBtn_SetEnabled   = function(en) HeadSitFloatingBtn.SetEnabled(en) end
getgenv().Gluto_HeadSitBtn_UpdateVisual = function() HeadSitFloatingBtn.UpdateVisual() end

    local InvisBtnState = { Enabled=false, DragLocked=false, Gui=nil, SavedPos=UDim2.new(0.03,0,0.63,0), Connections={} }
    local InvisStateBtn = CreateFloatingButton({
        id="Invisible", title="Invis", notifyTitle="invisibilty", state=InvisBtnState,
        isOn=function()
            local MV = getgenv().GlutoInvis
            return MV and MV.Enabled or false
        end,
        onToggle=function(v) W.Invisible_SetState(v, true) end,
        iconRotation=180,
    })
    getgenv().Gluto_InvisBtn_SetEnabled   = function(en) InvisStateBtn.SetEnabled(en) end
    getgenv().Gluto_InvisBtn_UpdateVisual = function() InvisStateBtn.UpdateVisual() end

    local MyersGrabBtnState = { Enabled=false, DragLocked=false, Gui=nil, SavedPos=UDim2.new(0.03,0,0.70,0), Connections={} }
    local MyersGrabBtn = CreateFloatingButton({
        id="MyersGrab", title="Grab", notifyTitle="Myers Grab", state=MyersGrabBtnState,
        isOn=function() return W.MyersGrabData.Enabled end,
        onToggle=function(v) W.setMyersGrab(v) end,
        iconRotation=90,
    })
    getgenv().Gluto_MGrabBtn_SetEnabled   = function(en) MyersGrabBtn.SetEnabled(en) end
    getgenv().Gluto_MGrabBtn_UpdateVisual = function() MyersGrabBtn.UpdateVisual() end

    local VeilBtnState = { Enabled=false, DragLocked=false, Gui=nil, SavedPos=UDim2.new(0.03,0,0.77,0), Connections={} }
    local VeilStateBtn = CreateFloatingButton({
        id="SilentVeil", title="Veil", notifyTitle="Silent Veil V1", state=VeilBtnState,
        isOn=function() return VD.VeilEnabled end,
        onToggle=function(v)
            VD.VeilEnabled = v and true or false
            if not v then
                if W.Veil_HideAllVisuals then pcall(W.Veil_HideAllVisuals) end
            end
            if getgenv().Gluto_VeilBtn_UpdateVisual then
                pcall(getgenv().Gluto_VeilBtn_UpdateVisual)
            end
            if v then VD_Notify("Silent Veil V1", "Enabled", 2)
            else VD_Notify("Silent Veil V1", "Disabled", 2) end
        end,
        iconRotation=0,
    })
    getgenv().Gluto_VeilBtn_SetEnabled   = function(en) VeilStateBtn.SetEnabled(en) end
    getgenv().Gluto_VeilBtn_UpdateVisual = function() VeilStateBtn.UpdateVisual() end

    W.SkillCheck = W.SkillCheck or { Enabled=false, Mode="Legit", Busy=false, Connection=nil }
    local SC = W.SkillCheck
    local SC_TouchID = 8822
    local SC_ActionPath = "Survivor-mob.Controls.action.check"
    local function SC_PressSpace()
        if not VirtualInputManager then return end
        pcall(function()
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
            task.wait()
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
        end)
    end
    local function SC_GetActionTarget()
        local pGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
        if not pGui then return nil end
        local current = pGui
        for seg in string.gmatch(SC_ActionPath, "[^%.]+") do
            current = current and current:FindFirstChild(seg)
        end
        return current
    end
    local function SC_TriggerMobileButton()
        local b = SC_GetActionTarget()
        if b and b:IsA("GuiObject") then
            local p, s = b.AbsolutePosition, b.AbsoluteSize
            local i = GuiService:GetGuiInset()
            local cx, cy = p.X + (s.X/2) + i.X, p.Y + (s.Y/2) + i.Y
            pcall(function()
                VirtualInputManager:SendTouchEvent(SC_TouchID, 0, cx, cy)
                task.wait(0.01)
                VirtualInputManager:SendTouchEvent(SC_TouchID, 2, cx, cy)
            end)
        end
    end
    function W.SkillCheck_Start()
        if SC.Connection then SC.Connection:Disconnect(); SC.Connection = nil end
        SC.Connection = RunService.RenderStepped:Connect(function()
            if not SC.Enabled or SC.Busy then return end
            local pGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
            if not pGui then return end
            local prompt = pGui:FindFirstChild("SkillCheckPromptGui")
            if not prompt then return end
            local check = prompt:FindFirstChild("Check")
            if not check or not check.Visible then return end
            local line = check:FindFirstChild("Line")
            local goal = check:FindFirstChild("Goal")
            if not line or not goal then return end
            if SC.Mode == "Instant" then
                line.Rotation = goal.Rotation + 109
                SC.Busy = true
                task.spawn(function()
                    if UserInputService.TouchEnabled then SC_TriggerMobileButton() else SC_PressSpace() end
                    task.wait(0.2); SC.Busy = false
                end)
            else
                local lr = line.Rotation % 360
                local gr = goal.Rotation % 360
                local sR = (gr + 102) % 360
                local eR = (gr + 116) % 360
                local success = (sR > eR and (lr >= sR or lr <= eR)) or (lr >= sR and lr <= eR)
                if success then
                    SC.Busy = true
                    task.spawn(function()
                        if UserInputService.TouchEnabled then SC_TriggerMobileButton() else SC_PressSpace() end
                        task.wait(0.05); SC.Busy = false
                    end)
                end
            end
        end)
    end
    function W.SkillCheck_Stop()
        if SC.Connection then SC.Connection:Disconnect(); SC.Connection = nil end
        SC.Busy = false
    end
    function W.SkillCheck_SetEnabled(v)
        SC.Enabled = v and true or false
        if SC.Enabled then W.SkillCheck_Start() else W.SkillCheck_Stop() end
    end

    W.GenBypass = W.GenBypass or {
        Enabled=false, Button=nil, UI=nil, Cache={}, CacheTimer=0,
        Processed={}, HotkeyCode=Enum.KeyCode.B, TriggerRange=8
    }
    local GenBypass = W.GenBypass
    function W.GB_GetAllGeneratorsCached()
        local now = tick()
        if now - GenBypass.CacheTimer < 5 then return GenBypass.Cache end
        GenBypass.Cache = {}; GenBypass.CacheTimer = now
        local mf = Workspace:FindFirstChild("Map")
        if not mf then return GenBypass.Cache end
        pcall(function()
            for _, v in pairs(mf:GetDescendants()) do
                if not v:IsA("Model") then continue end
                if v.Name ~= "Generator" then continue end
                local real = v:GetAttribute("RepairProgress") ~= nil
                          or v:GetAttribute("kickcount") ~= nil
                          or v:GetAttribute("ProgressRepair") ~= nil
                if real then table.insert(GenBypass.Cache, v) end
            end
        end)
        return GenBypass.Cache
    end
    function W.GB_WaitRepairing(pt, t)
        local s = tick()
        while tick() - s < (t or 1) do
            if pt:GetAttribute("IsRepairing") == true then return true end
            task.wait(0.05)
        end
        return false
    end
    function W.GB_DoRepair(tp)
        local gm = tp.Parent
        if GenBypass.Processed[gm] then return end
        GenBypass.Processed[gm] = true
        local c = LocalPlayer.Character
        local hrp = c and c:FindFirstChild("HumanoidRootPart")
        if not hrp then GenBypass.Processed[gm] = nil; return end
        local re = ReplicatedStorage:FindFirstChild("Remotes")
            and ReplicatedStorage.Remotes:FindFirstChild("Generator")
            and ReplicatedStorage.Remotes.Generator:FindFirstChild("RepairEvent")
        local og = hrp.CFrame
        pcall(function()
            for _, p in pairs(W.GB_GetPoints(gm)) do
                if p ~= tp and p.Parent then
                    hrp.Anchored = true
                    hrp.CFrame = p.CFrame
                    task.wait(0.15)
                    pcall(function() if re then re:FireServer(p, true) end end)
                    if not W.GB_WaitRepairing(p, 0.8) then
                        pcall(function() if re then re:FireServer(p, false) end end)
                        task.wait(0.1)
                        hrp.CFrame = p.CFrame
                        task.wait(0.15)
                        pcall(function() if re then re:FireServer(p, true) end end)
                        W.GB_WaitRepairing(p, 0.5)
                    end
                    hrp.Anchored = false
                    task.wait(0.05)
                end
            end
        end)
        pcall(function()
            if hrp and hrp.Parent then hrp.Anchored = false; hrp.CFrame = og end
        end)
        task.wait(0.1)
        pcall(function() if re then re:FireServer(tp, false) end end)
    end
    function W.GB_GetNearestPoint()
        local c = LocalPlayer.Character
        local hrp = c and c:FindFirstChild("HumanoidRootPart")
        if not hrp then return nil end
        local best, bd = nil, math.huge
        for _, g in pairs(W.GB_GetAllGeneratorsCached()) do
            for _, p in pairs(W.GB_GetPoints(g)) do
                local d = (hrp.Position - p.Position).Magnitude
                if d < bd then bd = d; best = p end
            end
        end
        return best, bd
    end
    function W.GB_IsPromptVisible()
        local ok2, fr = pcall(function() return LocalPlayer.PlayerGui.pcpprompts.Frame.GeneratorRepair end)
        return ok2 and fr and fr.Visible
    end
    function W.GB_UpdateButton()
        if GenBypass.Enabled then
            if not GenBypass._Wrap or not GenBypass.UI or not GenBypass.UI.Parent then
                W.GB_CreateButton(); task.wait(0.05)
            end
            if GenBypass._ShowCard then GenBypass._ShowCard() end
        else
            if GenBypass._HideCard then GenBypass._HideCard() end
        end
    end
    function W.GB_CreateButton()
        local pg = SafeGuiParent()
        if not pg then return end
        local old = pg:FindFirstChild("BypassGenUI"); if old then old:Destroy() end
        if GenBypass._StopAnim then pcall(GenBypass._StopAnim); GenBypass._StopAnim = nil end
        GenBypass.UI = Instance.new("ScreenGui")
        GenBypass.UI.Name = "BypassGenUI"
        GenBypass.UI.ResetOnSpawn = false
        GenBypass.UI.IgnoreGuiInset = true
        GenBypass.UI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        GenBypass.UI.DisplayOrder = 100
        GenBypass.UI.Parent = pg
        local wrap = Instance.new("Frame")
        wrap.Name = "Wrap"; wrap.AnchorPoint = Vector2.new(1, 0)
        wrap.Position = UDim2.new(1, -20, 0.48, 0)
        wrap.Size = UDim2.fromOffset(110, 110)
        wrap.BackgroundTransparency = 1; wrap.Active = true
        wrap.ZIndex = 2; wrap.Parent = GenBypass.UI
        local glow = Instance.new("Frame")
        glow.Name = "Glow"; glow.AnchorPoint = Vector2.new(0.5, 0.5)
        glow.Position = UDim2.new(0.5, 0, 0.5, 0)
        glow.Size = UDim2.fromOffset(88, 88)
        glow.BackgroundColor3 = _G.GLUTO_THEME
        glow.BackgroundTransparency = 0.85; glow.BorderSizePixel = 0
        glow.ZIndex = 1; glow.Parent = wrap
        Instance.new("UICorner", glow).CornerRadius = UDim.new(1, 0)
        local mainCircle = Instance.new("Frame")
        mainCircle.Name = "MainCircle"; mainCircle.AnchorPoint = Vector2.new(0.5, 0.5)
        mainCircle.Position = UDim2.new(0.5, 0, 0.5, 0)
        mainCircle.Size = UDim2.fromOffset(64, 64)
        mainCircle.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        mainCircle.BackgroundTransparency = 0.05; mainCircle.BorderSizePixel = 0
        mainCircle.ZIndex = 4; mainCircle.Parent = wrap
        Instance.new("UICorner", mainCircle).CornerRadius = UDim.new(1, 0)
        local mainGrad = Instance.new("UIGradient")
        mainGrad.Rotation = 135
        mainGrad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 25, 25)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 10)),
        })
        mainGrad.Parent = mainCircle
        local mainStroke = Instance.new("UIStroke", mainCircle)
        mainStroke.Name = "MainStroke"; mainStroke.Color = _G.GLUTO_THEME
        mainStroke.Thickness = 1.6; mainStroke.Transparency = 0.15
        mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        local genText = Instance.new("TextLabel")
        genText.Name = "GenText"; genText.AnchorPoint = Vector2.new(0.5, 0.5)
        genText.Position = UDim2.new(0.5, 0, 0.5, 0)
        genText.Size = UDim2.fromOffset(60, 30)
        genText.BackgroundTransparency = 1; genText.Font = Enum.Font.GothamBlack
        genText.Text = "GEN"; genText.TextColor3 = _G.GLUTO_THEME
        genText.TextSize = 20; genText.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        genText.TextStrokeTransparency = 0.5
        genText.ZIndex = 7; genText.Parent = wrap
        local actionBtn = Instance.new("TextButton")
        actionBtn.Name = "ActionBtn"; actionBtn.Size = UDim2.fromScale(1, 1)
        actionBtn.BackgroundTransparency = 1; actionBtn.Text = ""
        actionBtn.AutoButtonColor = false; actionBtn.ZIndex = 10; actionBtn.Parent = wrap
        mainCircle.Size = UDim2.fromOffset(0, 0)
        glow.Size = UDim2.fromOffset(0, 0)
        genText.TextTransparency = 1; genText.TextStrokeTransparency = 1
        GenBypass._Wrap = wrap; GenBypass._Glow = glow
        GenBypass._MainCircle = mainCircle; GenBypass._MainStroke = mainStroke
        GenBypass._GenText = genText; GenBypass._ActionBtn = actionBtn
        local function ShowCard()
            wrap.Visible = true
            TweenService:Create(glow, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = UDim2.fromOffset(88, 88), BackgroundTransparency = 0.85,
            }):Play()
            TweenService:Create(mainCircle, TweenInfo.new(0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = UDim2.fromOffset(64, 64), BackgroundTransparency = 0.05,
            }):Play()
            TweenService:Create(genText, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                TextTransparency = 0, TextStrokeTransparency = 0.5,
            }):Play()
        end
        local function HideCard()
            TweenService:Create(glow, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Size = UDim2.fromOffset(0, 0), BackgroundTransparency = 1,
            }):Play()
            TweenService:Create(mainCircle, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Size = UDim2.fromOffset(0, 0), BackgroundTransparency = 1,
            }):Play()
            TweenService:Create(genText, TweenInfo.new(0.2), {
                TextTransparency = 1, TextStrokeTransparency = 1,
            }):Play()
            task.delay(0.3, function()
                if GenBypass._StopAnim then pcall(GenBypass._StopAnim); GenBypass._StopAnim = nil end
                if GenBypass.UI then pcall(function() GenBypass.UI:Destroy() end); GenBypass.UI = nil end
                GenBypass._Wrap = nil; GenBypass._ShowCard = nil
                GenBypass._HideCard = nil; GenBypass._SetStatus = nil
                GenBypass._Card = nil
            end)
        end
        GenBypass._ShowCard = ShowCard; GenBypass._HideCard = HideCard
        local animActive = true
        GenBypass._StopAnim = function() animActive = false end
        task.spawn(function()
            local t = 0
            while animActive and wrap.Parent do
                t = t + 0.035
                if GenBypass.Enabled then
                    local pulse = (math.sin(t * 3) + 1) * 0.5
                    mainStroke.Transparency = 0.35 - pulse * 0.2
                    mainStroke.Thickness = 1.6 + pulse * 0.4
                    glow.BackgroundTransparency = 0.85 - pulse * 0.12
                    glow.Size = UDim2.fromOffset(88 + pulse * 5, 88 + pulse * 5)
                    genText.Rotation = math.sin(t * 1.2) * 1.5
                end
                task.wait(0.03)
            end
        end)
        local function SetStatus(mode)
            mainStroke.Color = _G.GLUTO_THEME
            genText.TextColor3 = _G.GLUTO_THEME
            glow.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        end
        GenBypass._SetStatus = SetStatus
        local drag = false
        local dStart, sPos
        local dragDist = 0
        wrap.InputBegan:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                drag = true; dStart = inp.Position; sPos = wrap.Position; dragDist = 0
            end
        end)
        UserInputService.InputChanged:Connect(function(inp)
            if not drag then return end
            if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then
                local d = inp.Position - dStart
                dragDist = math.abs(d.X) + math.abs(d.Y)
                wrap.Position = UDim2.new(sPos.X.Scale, sPos.X.Offset + d.X, sPos.Y.Scale, sPos.Y.Offset + d.Y)
            end
        end)
        UserInputService.InputEnded:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                drag = false
            end
        end)
        actionBtn.MouseButton1Up:Connect(function()
            if not GenBypass.Enabled then return end
            if dragDist > 6 then return end
            TweenService:Create(mainCircle, TweenInfo.new(0.08), { Size = UDim2.fromOffset(54, 54) }):Play()
            task.delay(0.1, function()
                TweenService:Create(mainCircle, TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Size = UDim2.fromOffset(64, 64) }):Play()
            end)
            local ripple = Instance.new("Frame")
            ripple.AnchorPoint = Vector2.new(0.5, 0.5)
            ripple.Position = UDim2.new(0.5, 0, 0.5, 0)
            ripple.Size = UDim2.fromOffset(64, 64)
            ripple.BackgroundColor3 = _G.GLUTO_THEME
            ripple.BackgroundTransparency = 0.55; ripple.BorderSizePixel = 0
            ripple.ZIndex = 3; ripple.Parent = wrap
            Instance.new("UICorner", ripple).CornerRadius = UDim.new(1, 0)
            TweenService:Create(ripple, TweenInfo.new(0.6), { Size = UDim2.fromOffset(160, 160), BackgroundTransparency = 1 }):Play()
            task.delay(0.6, function() if ripple then ripple:Destroy() end end)
            SetStatus("searching")
            local bp, bd = W.GB_GetNearestPoint()
            if bp and bd <= GenBypass.TriggerRange then
                SetStatus("busy")
                task.spawn(function()
                    W.GB_DoRepair(bp); task.wait(0.5); SetStatus("ready")
                end)
            else
                task.wait(0.6); SetStatus("standby")
            end
        end)
        task.spawn(function()
            task.wait(0.1)
            if GenBypass.Enabled then ShowCard() end
        end)
    end
    W.GB_CreateButton()
    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(0.5); W.GB_CreateButton(); W.GB_UpdateButton()
    end)
    UserInputService.InputBegan:Connect(function(input, gp)
        if gp or isMobile then return end
        if input.KeyCode == GenBypass.HotkeyCode and GenBypass.Enabled then
            if not W.GB_IsPromptVisible() then return end
            local bp, bd = W.GB_GetNearestPoint()
            if not bp or bd > GenBypass.TriggerRange then return end
            if GenBypass.Processed[bp.Parent] then return end
            W.GB_DoRepair(bp)
        end
    end)
    task.spawn(function()
        while true do
            task.wait(2)
            local c = LocalPlayer.Character
            local hrp = c and c:FindFirstChild("HumanoidRootPart")
            if hrp then
                for gm in pairs(GenBypass.Processed) do
                    if not gm or not gm.Parent then GenBypass.Processed[gm] = nil; continue end
                    local near = false
                    for _, p in pairs(W.GB_GetPoints(gm)) do
                        if p.Parent and (hrp.Position - p.Position).Magnitude <= 10 then near = true; break end
                    end
                    if not near then GenBypass.Processed[gm] = nil end
                end
            end
        end
    end)
    function W.setGenBypass(v) GenBypass.Enabled = v; W.GB_UpdateButton() end

    do
        VD.FLASH_SilentAim  = VD.FLASH_SilentAim  or false
        VD.FLASH_Laser      = VD.FLASH_Laser      ~= false
        VD.FLASH_TargetPart = VD.FLASH_TargetPart or "Head"
        VD.FLASH_Range      = VD.FLASH_Range      or 120
        VD.FLASH_Smooth     = VD.FLASH_Smooth     or 0.35
        local FlashState = { Active = false, LaserBeam = nil, FlashlightPart = nil, Connection = nil, Hooked = false }
        local function Flash_GetActivateRemote()
            local r = ReplicatedStorage:FindFirstChild("Remotes")
            local i = r and r:FindFirstChild("Items")
            local f = i and i:FindFirstChild("Flashlight")
            local a = f and f:FindFirstChild("Activate")
            if a and a:IsA("RemoteEvent") then return a end
            return nil
        end
        local function Flash_GetTargetPart(char)
            if not char then return nil end
            local p = char:FindFirstChild(VD.FLASH_TargetPart or "Head")
            if p and p:IsA("BasePart") then return p end
            return char:FindFirstChild("Head") or char:FindFirstChild("UpperTorso")
                or char:FindFirstChild("Torso") or char:FindFirstChild("HumanoidRootPart")
        end
        local function Flash_IsAliveChar(char)
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if not hum or hum.Health <= 0 then return false end
            return char:GetAttribute("State") ~= "Dead"
        end
        local function Flash_GetTarget()
            local myChar = LocalPlayer.Character
            local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
            if not myRoot then return nil end
            local maxR = tonumber(VD.FLASH_Range) or 120
            local best, bd = nil, math.huge
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and Flash_IsAliveChar(p.Character) and TeamIs(p, "Killer") then
                    local part = Flash_GetTargetPart(p.Character)
                    if part then
                        local d = (myRoot.Position - part.Position).Magnitude
                        if d <= maxR and d < bd then bd = d; best = part end
                    end
                end
            end
            return best
        end
        local function Flash_ClearLaser()
            if FlashState.LaserBeam then
                pcall(function() FlashState.LaserBeam:Destroy() end)
                FlashState.LaserBeam = nil
            end
        end
        local function Flash_GetOrigin(cam)
            local src = FlashState.FlashlightPart
            if typeof and typeof(src) == "Instance" then
                if src:IsA("BasePart") then return src.Position end
                local p = src:FindFirstChildWhichIsA("BasePart", true)
                if p then return p.Position end
            end
            local c = LocalPlayer.Character
            local hand = c and (c:FindFirstChild("RightHand") or c:FindFirstChild("Right Arm") or c:FindFirstChild("HumanoidRootPart"))
            if hand and hand:IsA("BasePart") then return hand.Position end
            return cam and cam.CFrame.Position or nil
        end
        local function Flash_UpdateLaser(op, tp)
            if not FlashState.LaserBeam then
                local l = Instance.new("Part")
                l.Name = "GlutoFlashlightLaser"
                l.Anchored = true
                l.CanCollide = false
                l.CanTouch = false
                l.CanQuery = false
                l.CastShadow = false
                l.Material = Enum.Material.Neon
                l.Color = _G.GLUTO_THEME
                l.Transparency = 0
                l.Parent = Workspace
                FlashState.LaserBeam = l
            end
            local d = (tp - op).Magnitude
            if d < 0.1 then return end
            local l = FlashState.LaserBeam
            l.Size = Vector3.new(0.16, 0.16, d)
            l.CFrame = CFrame.new((op + tp) / 2, tp)
            l.Transparency = 0.35
        end
        local function Flash_Step()
            if not (VD.FLASH_SilentAim and FlashState.Active) then
                if FlashState.LaserBeam then FlashState.LaserBeam.Transparency = 1 end
                return
            end
            local cam = Workspace.CurrentCamera
            local tp = Flash_GetTarget()
            if not (cam and tp) then
                if FlashState.LaserBeam then FlashState.LaserBeam.Transparency = 1 end
                return
            end
            local smooth = math.clamp(tonumber(VD.FLASH_Smooth) or 0.35, 0.05, 1)
            local op = Flash_GetOrigin(cam)
            if VD.FLASH_Laser and op then
                pcall(Flash_UpdateLaser, op, tp.Position)
            elseif FlashState.LaserBeam then
                FlashState.LaserBeam.Transparency = 1
            end
            pcall(function() cam.CFrame = cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position, tp.Position), smooth) end)
            pcall(function()
                local c = LocalPlayer.Character
                local hrp = c and c:FindFirstChild("HumanoidRootPart")
                if hrp then hrp.CFrame = CFrame.new(hrp.Position, Vector3.new(tp.Position.X, hrp.Position.Y, tp.Position.Z)) end
            end)
        end
        local function Flash_Start()
            if FlashState.Connection then return end
            FlashState.Connection = RunService.RenderStepped:Connect(function() pcall(Flash_Step) end)
        end
        local function Flash_Stop()
            FlashState.Active = false
            FlashState.FlashlightPart = nil
            Flash_ClearLaser()
            if FlashState.Connection then
                pcall(function() FlashState.Connection:Disconnect() end)
                FlashState.Connection = nil
            end
        end
        W.Flash_SetEnabled = function(v)
            VD.FLASH_SilentAim = v and true or false
            if v then Flash_Start() else Flash_Stop() end
        end
        W.Flash_SetActive = function(active, part)
            FlashState.Active = active and true or false
            if FlashState.Active and part then
                FlashState.FlashlightPart = part
            elseif not FlashState.Active then
                FlashState.FlashlightPart = nil
            end
            if not FlashState.Active and FlashState.LaserBeam then
                FlashState.LaserBeam.Transparency = 1
            end
        end
        W.Flash_ClearLaser = Flash_ClearLaser
        task.spawn(function()
            pcall(function()
                local remote = Flash_GetActivateRemote()
                if not remote then return end
                if typeof(hookmetamethod) ~= "function" then return end
                if FlashState.Hooked then return end
                FlashState.Hooked = true
                local oldNC
                oldNC = hookmetamethod(game, "__namecall", function(self, ...)
                    if getnamecallmethod() == "FireServer" and self == remote then
                        local args = {...}
                        pcall(function() W.Flash_SetActive(args[2] == true, args[1]) end)
                    end
                    return oldNC(self, ...)
                end)
            end)
        end)
    end

    local LockPOV = { Enabled = false, LockedFOV = 80, OriginalFOV = nil, Connection = nil }
    local function LockPOV_Update()
        if not LockPOV.Enabled then return end
        local cam = Workspace.CurrentCamera
        if not cam then return end
        if math.abs(cam.FieldOfView - LockPOV.LockedFOV) > 0.1 then cam.FieldOfView = LockPOV.LockedFOV end
    end
    local function LockPOV_SetEnabled(en)
        LockPOV.Enabled = en and true or false
        if LockPOV.Enabled then
            local cam = Workspace.CurrentCamera
            if cam then
                LockPOV.OriginalFOV = cam.FieldOfView
                if LockPOV.Connection then LockPOV.Connection:Disconnect(); LockPOV.Connection = nil end
                cam.FieldOfView = LockPOV.LockedFOV
                LockPOV.Connection = RunService.RenderStepped:Connect(LockPOV_Update)
            end
        else
            if LockPOV.Connection then LockPOV.Connection:Disconnect(); LockPOV.Connection = nil end
            local cam = Workspace.CurrentCamera
            if cam and LockPOV.OriginalFOV then cam.FieldOfView = LockPOV.OriginalFOV end
        end
    end
    W.LockPOV = LockPOV
    W.LockPOV_SetEnabled = LockPOV_SetEnabled

    local ToFState = {
        Connection = nil, LaserBeam = nil, TargetGui = nil,
        InputBegan = nil, InputEnded = nil, TouchInput = nil,
        IsAiming = false, SavedUIPos = UDim2.new(0.5, -100, 0, 110),
        SCPCache = {}, SCPCacheTimer = 0
    }
    local ToFKeyCodes = { None=nil, Q=Enum.KeyCode.Q, E=Enum.KeyCode.E, R=Enum.KeyCode.R, T=Enum.KeyCode.T, F=Enum.KeyCode.F, G=Enum.KeyCode.G, H=Enum.KeyCode.H, J=Enum.KeyCode.J, K=Enum.KeyCode.K, L=Enum.KeyCode.L, X=Enum.KeyCode.X, Z=Enum.KeyCode.Z }
    local function ToF_IsDowned(c)
        if not c then return true end
        local hrp = c:FindFirstChild("HumanoidRootPart"); if not hrp then return true end
        local h = c:FindFirstChildOfClass("Humanoid"); if h and h.Health<=0 then return true end
        if c:GetAttribute("Knocked")==true then return true end
        if c:GetAttribute("IsHooked")==true then return true end
        if c:GetAttribute("IsCarried")==true then return true end
        return false
    end
    local function ToF_IsBlocked()
        if VD.TOF_BlockKnocked == false then return false end
        local c = LocalPlayer.Character
        if not c then return true end
        return ToF_IsDowned(c)
    end
    local function ToF_GetEvent()
        local r = ReplicatedStorage:FindFirstChild("Remotes")
        local i = r and r:FindFirstChild("Items")
        local t = i and i:FindFirstChild("Twist of Fate")
        local f = t and t:FindFirstChild("Fire")
        if f and f:IsA("RemoteEvent") then return f end
        return nil
    end
    local function ToF_GetGun()
        local c = LocalPlayer.Character
        if not c then return nil end
        local b = c:FindFirstChild("Twist of Fate", true)
        if not b then return nil end
        local ra = b:FindFirstChild("Right Arm")
        if ra then local g = ra:FindFirstChild("gun"); if g then return g end
            local e = ra:FindFirstChild("EmperorGun"); if e then return e end end
        return b
    end
    local function ToF_IsVisible(op, tp, tc)
        local d = tp - op; local dist = d.Magnitude
        if dist < 0.1 then return true end
        local rp = RaycastParams.new(); rp.FilterType = Enum.RaycastFilterType.Exclude
        local ex = {}
        local lc = LocalPlayer.Character
        if lc then table.insert(ex, lc) end
        if tc and tc ~= lc then table.insert(ex, tc) end
        if ToFState.LaserBeam then table.insert(ex, ToFState.LaserBeam) end
        rp.FilterDescendantsInstances = ex
        return workspace:Raycast(op, d.Unit * dist, rp) == nil
    end
    local function ToF_GetSCPs()
        if tick() - ToFState.SCPCacheTimer < 0.5 then return ToFState.SCPCache end
        local nt = {}
        local mf = workspace:FindFirstChild("Map")
        if mf then
            for _, c in pairs(mf:GetDescendants()) do
                if c:IsA("Model") then
                    local a = c:GetAttributes()
                    if c:GetAttribute("CorpseCreated0492") or next(a) ~= nil then
                        local r = c:FindFirstChild("HumanoidRootPart"); if r then table.insert(nt, r) end
                    end
                end
            end
        end
        ToFState.SCPCache = nt; ToFState.SCPCacheTimer = tick()
        return nt
    end
    local function ToF_GetTarget()
        local g = ToF_GetGun(); local c = LocalPlayer.Character
        if not (g and c) then return nil,nil,nil,nil end
        local hrp = c:FindFirstChild("HumanoidRootPart")
        if not hrp then return nil,nil,nil,nil end
        local mp = hrp.Position
        local op
        if c:GetAttribute("IsCarried") then op = hrp.Position + (hrp.CFrame.LookVector * 2)
        else
            pcall(function() op = g:IsA("BasePart") and g.Position or (g:FindFirstChildOfClass("BasePart") and g:FindFirstChildOfClass("BasePart").Position) end)
            op = op or Vector3.new(mp.X, mp.Y + 1.5, mp.Z)
        end
        local function predict(t, tc)
            local tp = t.Position
            if VD.TOF_WallCheck and not ToF_IsVisible(op, tp, tc) then return nil,nil,nil,nil end
            local tv = Vector3.new(0,0,0)
            local rp = tc and (tc:FindFirstChild("HumanoidRootPart") or t)
            if rp then tv = rp.Velocity end
            local dr = tp - op; local d = dr.Magnitude
            if d < 0.1 then return nil,nil,nil,nil end
            if d < 5 then return dr.Unit, g, op, tp end
            local tt = d/400
            local pp = tp + (tv*tt)
            for _=1,2 do local nd = (pp-op).Magnitude; tt = nd/400; pp = tp + (tv*tt) end
            local fd = pp - op
            if fd.Magnitude < 0.1 then return nil,nil,nil,nil end
            return fd.Unit, g, op, pp
        end
        local mode = VD.TOF_TargetMode or "Killer"
        if mode=="Killer" then
            local bt, bc, bs = nil, nil, math.huge
            for _,p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and TeamIs(p, "Killer") and p.Character then
                    local t = p.Character:FindFirstChild("Torso") or p.Character:FindFirstChild("UpperTorso") or p.Character:FindFirstChild("HumanoidRootPart")
                    if t then local d = (mp-t.Position).Magnitude; if d < bs then bs=d; bt=t; bc=p.Character end end
                end
            end
            if not bt then return nil,nil,nil,nil end
            return predict(bt, bc)
        elseif mode=="Survivors" then
            local bt, bc, bd = nil, nil, -math.huge
            local cam = workspace.CurrentCamera
            local cl = cam.CFrame.LookVector
            for _,p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and TeamIs(p, "Survivor") and p.Character then
                    local t = p.Character:FindFirstChild("Torso") or p.Character:FindFirstChild("UpperTorso") or p.Character:FindFirstChild("HumanoidRootPart")
                    if t then local dt = t.Position - cam.CFrame.Position
                        if dt.Magnitude>0.1 then local dot = cl:Dot(dt.Unit); if dot>0.5 and dot>bd then bd=dot; bt=t; bc=p.Character end end end
                end
            end
            if not bt then return nil,nil,nil,nil end
            return predict(bt, bc)
        elseif mode=="Zombie" then
            local bp, bd = nil, -math.huge
            local cam = workspace.CurrentCamera
            local cl = cam.CFrame.LookVector
            for _,r in ipairs(ToF_GetSCPs()) do
                if r and r.Parent then local dt = r.Position - cam.CFrame.Position
                    if dt.Magnitude>0.1 then local dot = cl:Dot(dt.Unit); if dot>0.5 and dot>bd then bd=dot; bp=r end end end
            end
            if not bp then return nil,nil,nil,nil end
            return predict(bp, bp.Parent)
        end
        return nil,nil,nil,nil
    end
    local function ToF_UpdateLaser(op, tp)
        if not ToFState.LaserBeam then
            local l = Instance.new("Part"); l.Name="ToFLaser"; l.Anchored=true; l.CanCollide=false; l.CanTouch=false; l.CastShadow=false
            l.Material=Enum.Material.Neon; l.Color=_G.GLUTO_THEME; l.Parent=workspace
            ToFState.LaserBeam = l
        end
        local d = (tp-op).Magnitude
        ToFState.LaserBeam.Size = Vector3.new(0.05,0.05,d)
        ToFState.LaserBeam.CFrame = CFrame.new((op+tp)/2, tp)
        ToFState.LaserBeam.Transparency = 0
    end
    local function ToF_ClearLaser()
        if ToFState.LaserBeam then pcall(function() ToFState.LaserBeam:Destroy() end); ToFState.LaserBeam=nil end
    end
    local function ToF_GetMobileBtn()
        local pg = LocalPlayer:FindFirstChild("PlayerGui")
        local sm = pg and pg:FindFirstChild("Survivor-mob")
        local ct = sm and sm:FindFirstChild("Controls")
        local gm = ct and ct:FindFirstChild("Gui-mob")
        if not gm then return nil end
        for _,n in ipairs({"attack","Attack","shoot","Shoot","fire","Fire"}) do local b = gm:FindFirstChild(n,true); if b and b:IsA("GuiObject") then return b end end
        for _,o in ipairs(gm:GetDescendants()) do if o:IsA("GuiButton") and o.Visible then return o end end
        return gm:IsA("GuiObject") and gm or nil
    end
    local function ToF_IsTouchShoot(input)
        local sb = ToF_GetMobileBtn()
        if not (sb and sb.Visible) then return false end
        local p = input.Position; local ap = sb.AbsolutePosition; local az = sb.AbsoluteSize
        return p.X>=ap.X and p.X<=ap.X+az.X and p.Y>=ap.Y and p.Y<=ap.Y+az.Y
    end
    local function ToF_Shoot()
        if not VD.TOF_SilentAim then return end
        if ToF_IsBlocked() then return end
        local td, g, op, tp = ToF_GetTarget()
        if not (td and g and tp and op) then return end
        local e = ToF_GetEvent()
        if not e then return end
        local fd = tp - op
        if fd.Magnitude < 0.1 then return end
        pcall(function() e:FireServer(g, fd.Unit) end)
    end
    local ToF_ModeButtons = {}
    local ToF_BgColor = Color3.fromRGB(15, 15, 15)
    local ToF_HoverColor = Color3.fromRGB(25, 25, 25)
    local ToF_ModeConfig = { Killer={Color=_G.GLUTO_THEME,Label="KILLER",Hint="K"}, Survivors={Color=_G.GLUTO_THEME,Label="SURVIVOR",Hint="J"}, Zombie={Color=_G.GLUTO_THEME,Label="ZOMBIE",Hint="L"} }
    local function ToF_RefreshButtons()
        for n, b in pairs(ToF_ModeButtons) do
            if b and b.Parent then
                local isActive = n == (VD.TOF_TargetMode or "Killer")
                local cfg = ToF_ModeConfig[n]
                local ind = b:FindFirstChild("Indicator"); local lb = b:FindFirstChild("ModeLabel"); local hn = b:FindFirstChild("HintLabel"); local st = b:FindFirstChildOfClass("UIStroke")
                if isActive then
                    TweenService:Create(b, TweenInfo.new(0.25), { BackgroundColor3 = Color3.fromRGB(30, 30, 30) }):Play()
                    if ind then TweenService:Create(ind, TweenInfo.new(0.25), { Size = UDim2.new(0, 3, 0.6, 0), BackgroundColor3 = cfg.Color, BackgroundTransparency = 0 }):Play() end
                    if lb then TweenService:Create(lb, TweenInfo.new(0.25), { TextColor3 = _G.GLUTO_THEME }):Play() end
                    if hn then TweenService:Create(hn, TweenInfo.new(0.25), { TextColor3 = cfg.Color, TextTransparency = 0 }):Play() end
                    if st then TweenService:Create(st, TweenInfo.new(0.25), { Color = _G.GLUTO_THEME, Transparency = 0.2 }):Play() end
                else
                    TweenService:Create(b, TweenInfo.new(0.25), { BackgroundColor3 = Color3.fromRGB(15, 15, 15) }):Play()
                    if ind then TweenService:Create(ind, TweenInfo.new(0.25), { Size = UDim2.new(0, 3, 0, 0), BackgroundTransparency = 1 }):Play() end
                    if lb then TweenService:Create(lb, TweenInfo.new(0.25), { TextColor3 = Color3.fromRGB(170, 170, 170) }):Play() end
                    if hn then TweenService:Create(hn, TweenInfo.new(0.25), { TextColor3 = Color3.fromRGB(120, 120, 120), TextTransparency = 0.3 }):Play() end
                    if st then TweenService:Create(st, TweenInfo.new(0.25), { Color = Color3.fromRGB(60, 60, 60), Transparency = 0.5 }):Play() end
                end
            end
        end
    end
    local function ToF_SetTargetMode(mode, notify)
        if mode ~= "Killer" and mode ~= "Survivors" and mode ~= "Zombie" then return end
        VD.TOF_TargetMode = mode
        ToF_RefreshButtons()
        if notify then VD_Notify("ToF Target", mode, 1) end
    end
    local function ToF_DestroyUI()
        if ToFState.TargetGui then pcall(function() ToFState.TargetGui:Destroy() end); ToFState.TargetGui = nil end
        ToF_ModeButtons = {}
    end
    local function ToF_CreateUI()
        local parent = SafeGuiParent()
        if not parent then return end
        if ToFState.TargetGui and ToFState.TargetGui.Parent then return end
        local old = parent:FindFirstChild("ToFTargetSelector")
        if old then pcall(function() old:Destroy() end) end
        local gui = Instance.new("ScreenGui")
        gui.Name = "ToFTargetSelector"; gui.ResetOnSpawn = false
        gui.IgnoreGuiInset = true; gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        gui.Parent = parent
        local frame = Instance.new("Frame"); frame.Name = "Main"
        frame.Size = UDim2.new(0, 200, 0, 152); frame.Position = ToFState.SavedUIPos
        frame.BackgroundColor3 = ToF_BgColor; frame.BorderSizePixel = 0; frame.Active = true
        frame.ClipsDescendants = true; frame.ZIndex = 1; frame.Parent = gui
        Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 14)
        frame.BackgroundTransparency = 0.85; frame.Size = UDim2.new(0, 160, 0, 122); frame.Rotation = 5
        local outerStroke = Instance.new("UIStroke", frame); outerStroke.Color = _G.GLUTO_THEME; outerStroke.Thickness = 1; outerStroke.Transparency = 0.3; outerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        local accentBar = Instance.new("Frame"); accentBar.Size = UDim2.new(1, -20, 0, 2); accentBar.Position = UDim2.new(0, 10, 0, 0); accentBar.BorderSizePixel = 0; accentBar.ZIndex = 2; accentBar.Parent = frame
        local acGrad = Instance.new("UIGradient", accentBar); acGrad.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, _G.GLUTO_THEME), ColorSequenceKeypoint.new(0.5, _G.GLUTO_THEME_DIM), ColorSequenceKeypoint.new(1, _G.GLUTO_THEME) })
        Instance.new("UICorner", accentBar).CornerRadius = UDim.new(1, 0)
        local header = Instance.new("Frame"); header.Name = "Header"; header.Size = UDim2.new(1, 0, 0, 38); header.BackgroundTransparency = 1; header.ZIndex = 2; header.Parent = frame
        local ic = Instance.new("Frame"); ic.Size = UDim2.fromOffset(22, 22); ic.Position = UDim2.new(0, 12, 0.5, -11); ic.BackgroundColor3 = _G.GLUTO_THEME; ic.BackgroundTransparency = 0.9; ic.BorderSizePixel = 0; ic.ZIndex = 3; ic.Parent = header
        Instance.new("UICorner", ic).CornerRadius = UDim.new(1, 0)
        local ics = Instance.new("UIStroke", ic); ics.Color = _G.GLUTO_THEME; ics.Thickness = 1.4; ics.Transparency = 0.2
        local dlH = Instance.new("Frame"); dlH.Size = UDim2.fromOffset(14, 1); dlH.Position = UDim2.new(0.5, -7, 0.5, -0.5); dlH.BackgroundColor3 = _G.GLUTO_THEME; dlH.BackgroundTransparency = 0.4; dlH.BorderSizePixel = 0; dlH.ZIndex = 3; dlH.Parent = ic
        local dlV = Instance.new("Frame"); dlV.Size = UDim2.fromOffset(1, 14); dlV.Position = UDim2.new(0.5, -0.5, 0.5, -7); dlV.BackgroundColor3 = _G.GLUTO_THEME; dlV.BackgroundTransparency = 0.4; dlV.BorderSizePixel = 0; dlV.ZIndex = 3; dlV.Parent = ic
        local dt = Instance.new("Frame"); dt.Size = UDim2.fromOffset(8, 8); dt.Position = UDim2.new(0.5, -4, 0.5, -4); dt.BackgroundColor3 = _G.GLUTO_THEME; dt.BorderSizePixel = 0; dt.ZIndex = 4; dt.Parent = ic
        Instance.new("UICorner", dt).CornerRadius = UDim.new(1, 0)
        local title = Instance.new("TextLabel"); title.Size = UDim2.new(1, -140, 0, 14); title.Position = UDim2.new(0, 42, 0, 8); title.BackgroundTransparency = 1; title.Font = Enum.Font.GothamBold; title.Text = "SILENT AIM"; title.TextColor3 = _G.GLUTO_THEME; title.TextSize = 12; title.TextXAlignment = Enum.TextXAlignment.Left; title.ZIndex = 3; title.Parent = header
        local sub = Instance.new("TextLabel"); sub.Size = UDim2.new(1, -140, 0, 10); sub.Position = UDim2.new(0, 42, 0, 22); sub.BackgroundTransparency = 1; sub.Font = Enum.Font.Gotham; sub.Text = "Twist of Fate"; sub.TextColor3 = Color3.fromRGB(170, 170, 170); sub.TextSize = 9; sub.TextXAlignment = Enum.TextXAlignment.Left; sub.ZIndex = 3; sub.Parent = header
        local sp = Instance.new("Frame"); sp.Name = "StatusPill"; sp.AnchorPoint = Vector2.new(1, 0.5); sp.Size = UDim2.fromOffset(44, 18); sp.Position = UDim2.new(1, -36, 0.5, 0); sp.BackgroundColor3 = Color3.fromRGB(30, 30, 30); sp.BorderSizePixel = 0; sp.ZIndex = 3; sp.Parent = header
        Instance.new("UICorner", sp).CornerRadius = UDim.new(1, 0)
        local sps = Instance.new("UIStroke", sp); sps.Color = _G.GLUTO_THEME; sps.Thickness = 1; sps.Transparency = 0.3
        local sd = Instance.new("Frame"); sd.Size = UDim2.fromOffset(5, 5); sd.Position = UDim2.new(0, 7, 0.5, -2.5); sd.BackgroundColor3 = _G.GLUTO_THEME; sd.BorderSizePixel = 0; sd.ZIndex = 4; sd.Parent = sp
        Instance.new("UICorner", sd).CornerRadius = UDim.new(1, 0)
        local st = Instance.new("TextLabel"); st.Size = UDim2.new(1, -16, 1, 0); st.Position = UDim2.new(0, 15, 0, 0); st.BackgroundTransparency = 1; st.Font = Enum.Font.GothamBold; st.Text = "LIVE"; st.TextColor3 = Color3.fromRGB(255, 255, 255); st.TextSize = 8; st.TextXAlignment = Enum.TextXAlignment.Center; st.ZIndex = 4; st.Parent = sp
        local minBtn = Instance.new("TextButton"); minBtn.Name = "MinBtn"; minBtn.AnchorPoint = Vector2.new(1, 0.5); minBtn.Size = UDim2.fromOffset(22, 22); minBtn.Position = UDim2.new(1, -8, 0.5, 0); minBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30); minBtn.BorderSizePixel = 0; minBtn.Text = ""; minBtn.AutoButtonColor = false; minBtn.ZIndex = 4; minBtn.Parent = header
        Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 6)
        local mS = Instance.new("UIStroke", minBtn); mS.Color = _G.GLUTO_THEME; mS.Thickness = 1; mS.Transparency = 0.3
        local mI = Instance.new("Frame"); mI.Name = "MinIcon"; mI.AnchorPoint = Vector2.new(0.5, 0.5); mI.Size = UDim2.fromOffset(10, 2); mI.Position = UDim2.new(0.5, 0, 0.5, 0); mI.BackgroundColor3 = _G.GLUTO_THEME; mI.BorderSizePixel = 0; mI.ZIndex = 5; mI.Parent = minBtn
        Instance.new("UICorner", mI).CornerRadius = UDim.new(1, 0)
        local sep = Instance.new("Frame"); sep.Name = "Separator"; sep.Size = UDim2.new(1, -24, 0, 1); sep.Position = UDim2.new(0, 12, 0, 38); sep.BackgroundColor3 = Color3.fromRGB(60, 60, 60); sep.BorderSizePixel = 0; sep.ZIndex = 2; sep.Parent = frame
        local body = Instance.new("Frame"); body.Name = "Body"; body.Size = UDim2.new(1, -16, 1, -56); body.Position = UDim2.new(0, 8, 0, 44); body.BackgroundTransparency = 1; body.ZIndex = 2; body.Parent = frame
        local bl = Instance.new("UIListLayout", body); bl.FillDirection = Enum.FillDirection.Vertical; bl.SortOrder = Enum.SortOrder.LayoutOrder; bl.Padding = UDim.new(0, 4)
        ToF_ModeButtons = {}
        for i, m in ipairs({ {Internal="Killer",Order=1}, {Internal="Survivors",Order=2}, {Internal="Zombie",Order=3} }) do
            local cfg = ToF_ModeConfig[m.Internal]
            local btn = Instance.new("TextButton"); btn.Name = "ModeBtn_" .. m.Internal; btn.Size = UDim2.new(1, 0, 0, 26); btn.BackgroundColor3 = Color3.fromRGB(15, 15, 15); btn.BorderSizePixel = 0; btn.Text = ""; btn.AutoButtonColor = false; btn.LayoutOrder = m.Order; btn.ZIndex = 3; btn.Parent = body
            btn.Position = UDim2.new(-0.6, 0, 0, 0); btn.BackgroundTransparency = 0.6
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
            local bs = Instance.new("UIStroke", btn); bs.Color = _G.GLUTO_THEME; bs.Thickness = 1; bs.Transparency = 0.5
            local ind = Instance.new("Frame"); ind.Name = "Indicator"; ind.AnchorPoint = Vector2.new(0, 0.5); ind.Size = UDim2.new(0, 3, 0, 0); ind.Position = UDim2.new(0, 6, 0.5, 0); ind.BackgroundColor3 = cfg.Color; ind.BackgroundTransparency = 1; ind.BorderSizePixel = 0; ind.ZIndex = 4; ind.Parent = btn
            Instance.new("UICorner", ind).CornerRadius = UDim.new(1, 0)
            local cd = Instance.new("Frame"); cd.Size = UDim2.fromOffset(6, 6); cd.Position = UDim2.new(0, 14, 0.5, -3); cd.BackgroundColor3 = cfg.Color; cd.BorderSizePixel = 0; cd.ZIndex = 4; cd.Parent = btn
            Instance.new("UICorner", cd).CornerRadius = UDim.new(1, 0)
            local lb = Instance.new("TextLabel"); lb.Name = "ModeLabel"; lb.Size = UDim2.new(1, -60, 1, 0); lb.Position = UDim2.new(0, 26, 0, 0); lb.BackgroundTransparency = 1; lb.Font = Enum.Font.GothamBold; lb.Text = cfg.Label; lb.TextColor3 = Color3.fromRGB(170, 170, 170); lb.TextSize = 11; lb.TextXAlignment = Enum.TextXAlignment.Left; lb.ZIndex = 4; lb.Parent = btn
            local hn = Instance.new("TextLabel"); hn.Name = "HintLabel"; hn.AnchorPoint = Vector2.new(1, 0.5); hn.Size = UDim2.fromOffset(20, 18); hn.Position = UDim2.new(1, -8, 0.5, 0); hn.BackgroundColor3 = Color3.fromRGB(30, 30, 30); hn.BorderSizePixel = 0; hn.Font = Enum.Font.GothamBold; hn.Text = cfg.Hint; hn.TextColor3 = Color3.fromRGB(120, 120, 120); hn.TextSize = 9; hn.TextTransparency = 0.3; hn.ZIndex = 4; hn.Parent = btn
            Instance.new("UICorner", hn).CornerRadius = UDim.new(0, 4)
            btn.MouseEnter:Connect(function() if VD.TOF_TargetMode ~= m.Internal then TweenService:Create(btn, TweenInfo.new(0.15), { BackgroundColor3 = ToF_HoverColor }):Play() end end)
            btn.MouseLeave:Connect(function() if VD.TOF_TargetMode ~= m.Internal then TweenService:Create(btn, TweenInfo.new(0.15), { BackgroundColor3 = Color3.fromRGB(15, 15, 15) }):Play() end end)
            btn.MouseButton1Click:Connect(function() ToF_SetTargetMode(m.Internal, false) end)
            btn.InputEnded:Connect(function(inp) if inp.UserInputType == Enum.UserInputType.Touch then ToF_SetTargetMode(m.Internal, false) end end)
            ToF_ModeButtons[m.Internal] = btn
        end
        local ft = Instance.new("Frame"); ft.Name = "Footer"; ft.AnchorPoint = Vector2.new(0.5, 1); ft.Size = UDim2.new(1, -16, 0, 18); ft.Position = UDim2.new(0.5, 0, 1, -6); ft.BackgroundTransparency = 1; ft.ZIndex = 3; ft.Parent = frame
        local flb = Instance.new("TextLabel"); flb.Size = UDim2.new(1, 0, 1, 0); flb.BackgroundTransparency = 1; flb.Font = Enum.Font.Gotham; flb.Text = "Drag header • K / J / L to swap"; flb.TextColor3 = Color3.fromRGB(120, 120, 120); flb.TextSize = 8; flb.TextXAlignment = Enum.TextXAlignment.Center; flb.ZIndex = 4; flb.Parent = ft
        ToF_RefreshButtons()
        task.spawn(function()
            task.wait(0.05)
            local eO = TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
            TweenService:Create(frame, eO, { Size = UDim2.new(0, 200, 0, 152), BackgroundTransparency = 0, Rotation = 0 }):Play()
            task.wait(0.08)
            for i, btn in ipairs(body:GetChildren()) do
                if btn:IsA("TextButton") then
                    task.delay(i * 0.06, function()
                        TweenService:Create(btn, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Position = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 0 }):Play()
                    end)
                end
            end
            task.spawn(function()
                local t0 = tick()
                while frame and frame.Parent do
                    local b = (math.sin((tick() - t0) * 1.5) + 1) * 0.5
                    if outerStroke and outerStroke.Parent then
                        outerStroke.Transparency = 0.4 - b * 0.15
                        outerStroke.Color = _G.GLUTO_THEME:Lerp(_G.GLUTO_THEME_DIM, b)
                    end
                    task.wait(0.04)
                end
            end)
        end)
        local drg = false; local ds, sps2
        header.InputBegan:Connect(function(inp) if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then ds = inp.Position; sps2 = frame.Position; drg = true end end)
        header.InputEnded:Connect(function(inp) if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then drg = false end end)
        UserInputService.InputChanged:Connect(function(inp)
            if not drg then return end
            if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then
                local d = inp.Position - ds
                local np = UDim2.new(sps2.X.Scale, sps2.X.Offset + d.X, sps2.Y.Scale, sps2.Y.Offset + d.Y)
                frame.Position = np; ToFState.SavedUIPos = np
            end
        end)
        local min = false; local origSize = UDim2.new(0, 200, 0, 152)
        minBtn.MouseButton1Click:Connect(function()
            min = not min
            if min then
                origSize = frame.Size
                TweenService:Create(frame, TweenInfo.new(0.3), { Size = UDim2.new(0, 200, 0, 38) }):Play()
                body.Visible = false; sep.Visible = false; ft.Visible = false
                TweenService:Create(mI, TweenInfo.new(0.25), { Rotation = 90 }):Play()
            else
                TweenService:Create(frame, TweenInfo.new(0.3), { Size = origSize }):Play()
                task.wait(0.15)
                body.Visible = true; sep.Visible = true; ft.Visible = true
                TweenService:Create(mI, TweenInfo.new(0.25), { Rotation = 0 }):Play()
            end
        end)
        ToFState.TargetGui = gui
    end
    local function ToF_StartConn()
        if ToFState.Connection then return end
        ToFState.Connection = RunService.Heartbeat:Connect(function()
            if ToF_IsBlocked() then ToFState.IsAiming = false; if ToFState.TouchInput then ToFState.TouchInput = nil end; if ToFState.LaserBeam then ToFState.LaserBeam.Transparency = 1 end; return end
            if not VD.TOF_SilentAim or not ToFState.IsAiming then if ToFState.LaserBeam then ToFState.LaserBeam.Transparency = 1 end; return end
            local _, _, op, tp = ToF_GetTarget()
            if op and tp then
                pcall(function()
                    local c = LocalPlayer.Character
                    local hrp = c and c:FindFirstChild("HumanoidRootPart")
                    if hrp and not c:GetAttribute("IsCarried") then hrp.CFrame = CFrame.new(hrp.Position, Vector3.new(tp.X, hrp.Position.Y, tp.Z)) end
                end)
                if VD.TOF_Laser then ToF_UpdateLaser(op, tp)
                elseif ToFState.LaserBeam then ToFState.LaserBeam.Transparency = 1 end
            elseif ToFState.LaserBeam then ToFState.LaserBeam.Transparency = 1 end
        end)
    end
    local function ToF_StopConn()
        if ToFState.Connection then pcall(function() ToFState.Connection:Disconnect() end); ToFState.Connection = nil end
        ToFState.IsAiming = false; ToF_ClearLaser()
    end
    local SetToFSilentAim
    local function ToF_EnsureInputs()
        if not ToFState.InputBegan then
            ToFState.InputBegan = UserInputService.InputBegan:Connect(function(inp, gp)
                if gp then return end
                local k = ToFKeyCodes[VD.TOF_Key or "None"]
                if k and inp.UserInputType == Enum.UserInputType.Keyboard and inp.KeyCode == k then SetToFSilentAim(not VD.TOF_SilentAim); return end
                if not VD.TOF_SilentAim then return end
                if inp.UserInputType == Enum.UserInputType.MouseButton1 or (inp.UserInputType == Enum.UserInputType.Touch and ToF_IsTouchShoot(inp)) then
                    if ToF_IsBlocked() then ToFState.IsAiming = false; return end
                    ToFState.IsAiming = true
                    if inp.UserInputType == Enum.UserInputType.Touch then ToFState.TouchInput = inp end
                    return
                end
                if inp.UserInputType == Enum.UserInputType.Keyboard then
                    if inp.KeyCode == Enum.KeyCode.K then ToF_SetTargetMode("Killer", true)
                    elseif inp.KeyCode == Enum.KeyCode.J then ToF_SetTargetMode("Survivors", true)
                    elseif inp.KeyCode == Enum.KeyCode.L then ToF_SetTargetMode("Zombie", true) end
                end
            end)
        end
        if not ToFState.InputEnded then
            ToFState.InputEnded = UserInputService.InputEnded:Connect(function(inp)
                if inp.UserInputType == Enum.UserInputType.MouseButton1 or (inp.UserInputType == Enum.UserInputType.Touch and inp == ToFState.TouchInput) then
                    local wa = ToFState.IsAiming
                    ToFState.IsAiming = false
                    if inp == ToFState.TouchInput then ToFState.TouchInput = nil end
                    if ToFState.LaserBeam then ToFState.LaserBeam.Transparency = 1 end
                    if wa then if ToF_IsBlocked() then return end; ToF_Shoot() end
                end
            end)
        end
    end
    SetToFSilentAim = function(en)
        VD.TOF_SilentAim = en and true or false
        ToF_EnsureInputs()
        if VD.TOF_SilentAim then ToF_CreateUI(); ToF_StartConn()
        else ToF_DestroyUI(); ToF_StopConn() end
    end
    W.SetToFSilentAim = SetToFSilentAim
    W.ToF_ClearLaser = ToF_ClearLaser
    W.ToF_SetTargetMode = ToF_SetTargetMode
    ToF_EnsureInputs()

    local PU = {
        SpeedEnabled = false, SpeedValue = 16,
        SkipEndScreen = false, ShiftLock = false, NoCutscene = false,
        HideSurvivorIcon = false, ShowPingFPS = false, HideName = false,
        UnlimitedZoom = false, Noclip = false,
        _Connections = {}, _FPS = { frames = 0, last = tick(), value = 0, ping = 0 },
        _origIcons = {}, _pingGui = nil, _shiftLockWasActive = false,
        _noCutsceneHooked = false, _hideNameConn = nil, _origCanCollide = {},
    }
    W.PU = PU

    table.insert(PU._Connections, RunService.Heartbeat:Connect(function()
        if not PU.SpeedEnabled then return end
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum and hum.WalkSpeed ~= PU.SpeedValue then hum.WalkSpeed = PU.SpeedValue end
    end))

    local function PU_ShowInstantResults()
        if not PU.SkipEndScreen then return end
        pcall(function()
            local cam = workspace.CurrentCamera
            if cam then cam.CameraType = Enum.CameraType.Custom; cam.FieldOfView = 70 end
            UserInputService.MouseIconEnabled = true
            LocalPlayer:SetAttribute("isspectating", true)
            local pg = LocalPlayer:FindFirstChild("PlayerGui")
            if pg then
                local Results  = pg:FindFirstChild("Results")
                local EndScreen= pg:FindFirstChild("EndScreen")
                local Darkness = pg:FindFirstChild("Darkness")
                if Results then Results.Enabled = true end
                if EndScreen then
                    EndScreen.Enabled = true
                    local bo = EndScreen:FindFirstChild("blackout")
                    if bo then bo.BackgroundTransparency = 1 end
                end
                if Darkness then
                    Darkness.Enabled = true
                    local f2 = Darkness:FindFirstChild("Frame2")
                    if f2 then f2.BackgroundTransparency = 1 end
                end
            end
        end)
    end
    task.spawn(function()
        local gf = ReplicatedStorage:WaitForChild("Remotes", 10)
        gf = gf and gf:WaitForChild("Game", 10)
        if not gf then return end
        for _, n in ipairs({"endscreencutscene","cutsceneEnd","cutsceneEnd2","cutsceneEndwithownchar"}) do
            local ev = gf:FindFirstChild(n)
            if ev and ev:IsA("RemoteEvent") then
                table.insert(PU._Connections, ev.OnClientEvent:Connect(PU_ShowInstantResults))
            end
        end
    end)

    table.insert(PU._Connections, RunService.RenderStepped:Connect(function()
        local char = LocalPlayer.Character
        if not char then return end
        local hum  = char:FindFirstChildOfClass("Humanoid")
        local root = char:FindFirstChild("HumanoidRootPart")
        local cam  = workspace.CurrentCamera
        if not (hum and root and cam) then return end
        if PU.ShiftLock then
            hum.AutoRotate = false
            PU._shiftLockWasActive = true
            local look = cam.CFrame.LookVector
            local flat = Vector3.new(look.X, 0, look.Z)
            if flat.Magnitude > 0.001 then root.CFrame = CFrame.new(root.Position, root.Position + flat.Unit) end
        elseif PU._shiftLockWasActive then
            hum.AutoRotate = true
            PU._shiftLockWasActive = false
        end
    end))

    local function PU_SetupNoCutsceneHook()
        if PU._noCutsceneHooked then return end
        PU._noCutsceneHooked = true
        pcall(function()
            local mt = getrawmetatable(game)
            if not mt then return end
            if setreadonly then setreadonly(mt, false) end
            local oldIndex = mt.__index
            local fakeBindable = Instance.new("BindableEvent")
            local fakeRemote   = Instance.new("RemoteEvent")
            mt.__index = newcclosure(function(t, k)
                if PU.NoCutscene and not checkcaller() and typeof(t) == "Instance" then
                    local nm = t.Name
                    if nm == "cutscene" and k == "Event" then
                        local p = t.Parent
                        if p and p.Name == "Game" then return fakeBindable.Event end
                    elseif nm == "cutsceneEnd" or nm == "cutsceneEnd2"
                        or nm == "cutsceneEndwithownchar" or nm == "endscreencutscene" then
                        local p = t.Parent
                        if p and p.Name == "Game" then return fakeRemote.OnClientEvent end
                    end
                end
                return oldIndex(t, k)
            end)
            if setreadonly then setreadonly(mt, true) end
        end)
    end
    task.spawn(PU_SetupNoCutsceneHook)

    local function PU_ApplyHideSurvivorIcon()
        local pg = LocalPlayer:FindFirstChild("PlayerGui")
        if not pg then return end
        for _, gui in ipairs(pg:GetChildren()) do
            if gui:IsA("ScreenGui") and gui.Name:match("%-mob$") then
                local frame = gui:FindFirstChild("Frame")
                if frame then
                    for i = 1, 5 do
                        local sf = frame:FindFirstChild("Survivor" .. i)
                        if sf then
                            local il = sf:FindFirstChild("ImageLabel")
                            local tl = sf:FindFirstChild("TextLabel")
                            if il and il:IsA("ImageLabel") then
                                if not PU._origIcons[il] then
                                    PU._origIcons[il] = { Image = il.Image, ImageTransparency = il.ImageTransparency }
                                end
                                il.Image = "rbxassetid://92826170205694"
                                il.ImageTransparency = 0
                            end
                            if tl and tl:IsA("TextLabel") then
                                if not PU._origIcons[tl] then
                                    PU._origIcons[tl] = { Text = tl.Text, TextTransparency = tl.TextTransparency }
                                end
                                tl.Text = "ALFzxzz"
                                tl.TextTransparency = 0
                            end
                        end
                    end
                end
            end
        end
    end
    local function PU_RestoreSurvivorIcon()
        for obj, data in pairs(PU._origIcons) do
            if obj and obj.Parent then
                pcall(function()
                    if data.Image ~= nil and obj:IsA("ImageLabel") then
                        obj.Image = data.Image
                        obj.ImageTransparency = data.ImageTransparency
                    end
                    if data.Text ~= nil and obj:IsA("TextLabel") then
                        obj.Text = data.Text
                        obj.TextTransparency = data.TextTransparency
                    end
                end)
            end
        end
        PU._origIcons = {}
    end
    table.insert(PU._Connections, RunService.Heartbeat:Connect(function()
        if PU.HideSurvivorIcon then PU_ApplyHideSurvivorIcon() end
    end))

    local function PU_CreatePingFPS()
        local pg = SafeGuiParent()
        if not pg then return end
        if PU._pingGui and PU._pingGui.Parent then return end
        local old = pg:FindFirstChild("GlutoPU_PingFPS")
        if old then old:Destroy() end
        local sg = Instance.new("ScreenGui")
        sg.Name = "GlutoPU_PingFPS"
        sg.ResetOnSpawn = false
        sg.IgnoreGuiInset = true
        sg.Parent = pg
        local frame = Instance.new("Frame")
        frame.Size = UDim2.fromOffset(120, 44)
        frame.Position = UDim2.new(0, 12, 0, 120)
        frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        frame.BackgroundTransparency = 0.1
        frame.BorderSizePixel = 0
        frame.Parent = sg
        Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
        local stroke = Instance.new("UIStroke", frame)
        stroke.Color = _G.GLUTO_THEME
        stroke.Thickness = 1
        local lbl = Instance.new("TextLabel")
        lbl.Name = "Label"
        lbl.Size = UDim2.new(1, -12, 1, -8)
        lbl.Position = UDim2.new(0, 6, 0, 4)
        lbl.BackgroundTransparency = 1
        lbl.Font = Enum.Font.GothamBold
        lbl.TextSize = 13
        lbl.TextColor3 = _G.GLUTO_THEME
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.TextYAlignment = Enum.TextYAlignment.Center
        lbl.Text = "PING: --ms\nFPS: --"
        lbl.Parent = frame
        PU._pingGui = sg
    end
    local function PU_GetPing()
        local ok, val = pcall(function()
            local stats = game:GetService("Stats")
            local net = stats and stats:FindFirstChild("Network")
            local sv = net and net:FindFirstChild("ServerStatsItem")
            local dp = sv and sv:FindFirstChild("Data Ping")
            if dp and dp.GetValue then return math.floor(dp:GetValue() + 0.5) end
        end)
        if ok and val then return val end
        return nil
    end
    table.insert(PU._Connections, RunService.RenderStepped:Connect(function()
        if not PU.ShowPingFPS then return end
        PU._FPS.frames = PU._FPS.frames + 1
        local now = tick()
        if now - PU._FPS.last < 0.5 then return end
        PU._FPS.value = math.floor(PU._FPS.frames / (now - PU._FPS.last) + 0.5)
        PU._FPS.ping = PU_GetPing() or 0
        PU._FPS.frames = 0
        PU._FPS.last = now
        if not (PU._pingGui and PU._pingGui.Parent) then PU_CreatePingFPS() end
        local lbl = PU._pingGui and PU._pingGui:FindFirstChild("Label", true)
        if lbl then
            lbl.Text = ("PING: %sms\nFPS: %d"):format(
                PU._FPS.ping > 0 and tostring(PU._FPS.ping) or "--",
                PU._FPS.value
            )
        end
    end))

    local function PU_ProcessHideName(obj)
        if not obj then return end
        local ok, isText = pcall(function()
            return obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox")
        end)
        if not ok or not isText then return end
        local txt = ""
        pcall(function() txt = tostring(obj.Text or "") end)
        if txt == "" then return end
        if txt == LocalPlayer.Name or txt == LocalPlayer.DisplayName
            or txt:find(LocalPlayer.Name, 1, true) ~= nil then
            pcall(function() obj.Visible = not PU.HideName end)
        end
    end
    local function PU_SetHideName(enabled)
        PU.HideName = enabled and true or false
        if PU._hideNameConn then
            pcall(function() PU._hideNameConn:Disconnect() end)
            PU._hideNameConn = nil
        end
        local pg = LocalPlayer:FindFirstChildOfClass("PlayerGui")
        if not pg then return end
        for _, d in ipairs(pg:GetDescendants()) do PU_ProcessHideName(d) end
        if PU.HideName then
            PU._hideNameConn = pg.DescendantAdded:Connect(function(obj)
                task.defer(PU_ProcessHideName, obj)
            end)
        end
    end
    W.PU_SetHideName = PU_SetHideName

    table.insert(PU._Connections, RunService.RenderStepped:Connect(function()
        if not PU.UnlimitedZoom then return end
        if LocalPlayer.CameraMaxZoomDistance ~= math.huge then LocalPlayer.CameraMaxZoomDistance = math.huge end
        if LocalPlayer.CameraMinZoomDistance ~= 0 then LocalPlayer.CameraMinZoomDistance = 0 end
    end))

    table.insert(PU._Connections, RunService.Stepped:Connect(function()
        if not PU.Noclip then return end
        local char = LocalPlayer.Character
        if not char then return end
        for _, d in ipairs(char:GetDescendants()) do
            if d:IsA("BasePart") then
                if PU._origCanCollide[d] == nil then PU._origCanCollide[d] = d.CanCollide end
                d.CanCollide = false
            end
        end
    end))
    local function PU_RestoreNoclip()
        for part, cc in pairs(PU._origCanCollide) do
            if part and part.Parent then pcall(function() part.CanCollide = cc end) end
        end
        PU._origCanCollide = {}
    end
    W.PU_RestoreNoclip = PU_RestoreNoclip
    LocalPlayer.CharacterRemoving:Connect(function(char)
        if char == LocalPlayer.Character then PU._origCanCollide = {} end
    end)

    W.EmoteSystem = W.EmoteSystem or {
        Enabled = false, CurrentTrack = nil, CurrentSound = nil,
        SelectedEmote = "Friday Night",
        Options = {
            "Friday Night", "WarCry", "24 Hour Cinderella", "Applause",
            "Arm Swing", "Backflip", "California Girls", "Christmas Spirit",
            "Floating Rest", "Ghoul", "Griddy", "Kyoufuu", "OnePlays", "Vulnerable",
        },
        Data = {
            ["Friday Night"]        = { Anim = "rbxassetid://83229063951016",  Sound = "rbxassetid://85355610204255" },
            ["WarCry"]              = { Anim = "rbxassetid://82600868380136",  Sound = "rbxassetid://120101930689931" },
            ["24 Hour Cinderella"]  = { Anim = "rbxassetid://137195203725366", Sound = "rbxassetid://121099446613414" },
            ["Applause"]            = { Anim = "rbxassetid://96328361165090",  Sound = "rbxassetid://115490787020749" },
            ["Arm Swing"]           = { Anim = "rbxassetid://80552139463944",  Sound = "rbxassetid://74216458932348" },
            ["Backflip"]            = { Anim = "rbxassetid://74705617908505",  Sound = nil },
            ["California Girls"]    = { Anim = "rbxassetid://123552803041504", Sound = "rbxassetid://87899327891544" },
            ["Christmas Spirit"]    = { Anim = "rbxassetid://137859761110514", Sound = nil },
            ["Floating Rest"]       = { Anim = "rbxassetid://114593021219597", Sound = nil },
            ["Ghoul"]               = { Anim = "rbxassetid://130415594909401", Sound = "rbxassetid://123004139176580" },
            ["Griddy"]              = { Anim = "rbxassetid://75586690784894",  Sound = nil },
            ["Kyoufuu"]             = { Anim = "rbxassetid://137322894494527", Sound = "rbxassetid://129064643026442" },
            ["OnePlays"]            = { Anim = "rbxassetid://140625405103474", Sound = "rbxassetid://94749073728335" },
            ["Vulnerable"]          = { Anim = "rbxassetid://121773684313913", Sound = "rbxassetid://135265751184744" },
        },
    }
    local ES = W.EmoteSystem
    function W.EmoteSystem_Stop()
        if ES.CurrentTrack then pcall(function() ES.CurrentTrack:Stop() end); ES.CurrentTrack = nil end
        if ES.CurrentSound then pcall(function() ES.CurrentSound:Destroy() end); ES.CurrentSound = nil end
    end
    function W.EmoteSystem_Play()
        W.EmoteSystem_Stop()
        local char = LocalPlayer.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hum or not hrp then return end
        local data = ES.Data[ES.SelectedEmote]
        if not data then return end
        if data.Anim then
            local anim = Instance.new("Animation")
            anim.AnimationId = data.Anim
            local track = hum:LoadAnimation(anim)
            track.Looped = true
            track.Priority = Enum.AnimationPriority.Action
            track:Play()
            ES.CurrentTrack = track
        end
        if data.Sound then
            local snd = Instance.new("Sound")
            snd.SoundId = data.Sound
            snd.Looped = true
            snd.Volume = 2
            snd.Parent = hrp
            snd:Play()
            ES.CurrentSound = snd
        end
    end
    function W.EmoteSystem_SetEnabled(v)
        ES.Enabled = v and true or false
        if ES.Enabled then W.EmoteSystem_Play() else W.EmoteSystem_Stop() end
    end
    function W.EmoteSystem_SelectEmote(name)
        if ES.Data[name] then
            ES.SelectedEmote = name
            if ES.Enabled then W.EmoteSystem_Play() end
        end
    end
    LocalPlayer.CharacterRemoving:Connect(function() W.EmoteSystem_Stop() end)
    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(0.5)
        if ES.Enabled then W.EmoteSystem_Play() end
    end)

    W.JerkTool = W.JerkTool or { Enabled = false, ToolName = "Jerk Off" }
    do
        local JerkTool = W.JerkTool
        local currentJerkTool = nil
        local jerkRunning = false

        function W.JerkOff_Destroy()
            if currentJerkTool then pcall(function() currentJerkTool:Destroy() end); currentJerkTool = nil end
        end

        function W.JerkOff_Create()
            W.JerkOff_Destroy()
            local character = LocalPlayer.Character
            if not character then return end
            local humanoid = character:FindFirstChildWhichIsA("Humanoid")
            local backpack = LocalPlayer:FindFirstChildWhichIsA("Backpack")
            if not humanoid or not backpack then return end

            local tool = Instance.new("Tool")
            tool.Name = JerkTool.ToolName
            tool.ToolTip = 'in the stripped club. straight up "jorking it" . and by "it" , haha, well. let\'s just say. My peanits.'
            tool.RequiresHandle = false
            tool.Parent = backpack
            currentJerkTool = tool

            local jorkin = false
            local track = nil

            local function stopTomfoolery()
                jorkin = false
                if track then pcall(function() track:Stop() end); track = nil end
            end

            tool.Equipped:Connect(function() jorkin = true end)
            tool.Unequipped:Connect(stopTomfoolery)
            if humanoid.Died then humanoid.Died:Connect(stopTomfoolery) end

            task.spawn(function()
                while jerkRunning do
                    task.wait()
                    if not JerkTool.Enabled or not jorkin then
                        if track then pcall(function() track:Stop() end) end
                        continue
                    end
                    local isR15 = humanoid.RigType == Enum.HumanoidRigType.R15
                    if not track then
                        local anim = Instance.new("Animation")
                        anim.AnimationId = not isR15 and "rbxassetid://72042024" or "rbxassetid://698251653"
                        track = humanoid:LoadAnimation(anim)
                    end
                    track:Play()
                    track:AdjustSpeed(isR15 and 0.7 or 0.65)
                    track.TimePosition = 0.6
                    task.wait(0.1)
                    while track and track.TimePosition < (not isR15 and 0.65 or 0.7) do
                        task.wait(0.1)
                    end
                    if track then pcall(function() track:Stop() end) end
                end
            end)
        end

        function W.JerkOff_SetEnabled(v)
            JerkTool.Enabled = v and true or false
            jerkRunning = JerkTool.Enabled
            if v then W.JerkOff_Create() else W.JerkOff_Destroy() end
        end

        LocalPlayer.CharacterAdded:Connect(function()
            task.wait(1)
            if JerkTool.Enabled then jerkRunning = true; W.JerkOff_Create() end
        end)
    end

    do
        local FallHookInstalled = false
        local function VD_InstallNoFallHook()
            if FallHookInstalled then return end
            FallHookInstalled = true
            task.spawn(function()
                pcall(function()
                    local mt = getrawmetatable and getrawmetatable(game)
                    if not mt then return end
                    local oldNamecall = mt.__namecall
                    if setreadonly then setreadonly(mt, false) end
                    mt.__namecall = newcclosure(function(self, ...)
                        if not checkcaller() and getgenv().VD.NoFallDamage then
                            local method = getnamecallmethod()
                            if method == "FireServer" then
                                local ok, name = pcall(function() return self.Name end)
                                if ok and name == "Fall" then
                                    local par = self.Parent
                                    if par and par.Name == "Mechanics" then
                                        return nil
                                    end
                                end
                            end
                        end
                        return oldNamecall(self, ...)
                    end)
                    if setreadonly then setreadonly(mt, true) end
                end)
            end)
        end
        VD_InstallNoFallHook()
    end

    do
        local MapPredictState = { Gui = nil, Thread = nil, Enabled = false, LastMap = "Unknown" }

        local function DetectMapName(map)
            if not map then return nil end
            if map:FindFirstChild("random shakes") or map:FindFirstChild("SCP-173 Room") or map:FindFirstChild("SCP-205 Room") then
                return "Site 68"
            elseif map:FindFirstChild("HooksMeat") then
                return "BLOODBATH! Club"
            elseif map:FindFirstChild("Gate") and map.Gate:FindFirstChild("vfx") then
                return "Firelink Shrine"
            elseif map:FindFirstChild("Bldg_Addon_RooftopUnit_A") or map:FindFirstChild("Rooftop") then
                return "Mercy Hospital Rooftop"
            elseif map:FindFirstChild("White Armored Car") then
                return "Mount Massive Asylum"
            elseif map:FindFirstChild("Dumbster") then
                return "The Bay Harbor"
            elseif map:FindFirstChild("water pump") then
                return "Valdelobos Village"
            elseif map:FindFirstChild("LargeBoulder01") then
                return "Woodview Cabin"
            end
            return nil
        end

        local function BuildMapGui()
            if MapPredictState.Gui then pcall(function() MapPredictState.Gui:Destroy() end) end
            local pg = SafeGuiParent()
            if not pg then return end

            local gui = Instance.new("ScreenGui")
            gui.Name = "GlutoMapPredict"
            gui.ResetOnSpawn = false
            gui.IgnoreGuiInset = true
            gui.DisplayOrder = 50
            gui.Parent = pg

            local frame = Instance.new("Frame")
            frame.Name = "MainFrame"
            frame.Size = UDim2.new(0, 210, 0, 54)
            frame.Position = UDim2.new(0.5, -105, 0, 110)
            frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
            frame.BackgroundTransparency = 0.15
            frame.BorderSizePixel = 0
            frame.Active = true
            frame.Parent = gui
            Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)
            local stroke = Instance.new("UIStroke", frame)
            stroke.Color = _G.GLUTO_THEME
            stroke.Thickness = 1.5
            stroke.Transparency = 0.2
            stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

            local title = Instance.new("TextLabel")
            title.Size = UDim2.new(1, 0, 0, 15)
            title.Position = UDim2.new(0, 0, 0, 5)
            title.BackgroundTransparency = 1
            title.Text = "NEXT MAP PREDICTION"
            title.TextColor3 = _G.GLUTO_THEME
            title.Font = Enum.Font.GothamBold
            title.TextSize = 10
            title.Parent = frame

            local mapName = Instance.new("TextLabel")
            mapName.Name = "MapName"
            mapName.Size = UDim2.new(1, -12, 0, 18)
            mapName.Position = UDim2.new(0, 6, 0, 21)
            mapName.BackgroundTransparency = 1
            mapName.Text = "Scanning..."
            mapName.TextColor3 = _G.GLUTO_THEME
            mapName.Font = Enum.Font.GothamBold
            mapName.TextSize = 13
            mapName.TextXAlignment = Enum.TextXAlignment.Center
            mapName.Parent = frame

            local status = Instance.new("TextLabel")
            status.Name = "StatusLabel"
            status.Size = UDim2.new(1, -12, 0, 12)
            status.Position = UDim2.new(0, 6, 0, 38)
            status.BackgroundTransparency = 1
            status.Text = "Status: Waiting"
            status.TextColor3 = Color3.fromRGB(170, 170, 170)
            status.Font = Enum.Font.GothamMedium
            status.TextSize = 9
            status.TextXAlignment = Enum.TextXAlignment.Center
            status.Parent = frame

            local dragging, dragStart, startPos = false, nil, nil
            frame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true; dragStart = input.Position; startPos = frame.Position
                end
            end)
            UserInputService.InputChanged:Connect(function(input)
                if not dragging then return end
                if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                    local d = input.Position - dragStart
                    frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
                end
            end)
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                end
            end)

            MapPredictState.Gui = gui
        end

        local function Stop()
            MapPredictState.Enabled = false
            if MapPredictState.Thread then pcall(function() task.cancel(MapPredictState.Thread) end); MapPredictState.Thread = nil end
            if MapPredictState.Gui then pcall(function() MapPredictState.Gui:Destroy() end); MapPredictState.Gui = nil end
        end

        local function Start()
            if MapPredictState.Enabled then return end
            MapPredictState.Enabled = true
            BuildMapGui()
            MapPredictState.Thread = task.spawn(function()
                local lastDetected, lastExisted = nil, false
                while MapPredictState.Enabled do
                    local map = Workspace:FindFirstChild("Map")
                    local mapExists = map ~= nil
                    local detected = mapExists and DetectMapName(map) or nil
                    local gui = MapPredictState.Gui
                    local frame = gui and gui:FindFirstChild("MainFrame")
                    local nameLabel = frame and frame:FindFirstChild("MapName")
                    local statusLabel = frame and frame:FindFirstChild("StatusLabel")
                    if nameLabel and statusLabel then
                        if lastExisted and not mapExists then
                            nameLabel.Text = lastDetected or "Unknown"
                            statusLabel.Text = "Status: Loading next map..."
                            statusLabel.TextColor3 = _G.GLUTO_THEME
                        elseif mapExists then
                            lastDetected = detected or "Unknown"
                            nameLabel.Text = detected or "Unknown"
                            statusLabel.Text = "Status: In-Game"
                            statusLabel.TextColor3 = _G.GLUTO_THEME
                        else
                            nameLabel.Text = "Waiting..."
                            statusLabel.Text = "Status: Lobby"
                            statusLabel.TextColor3 = Color3.fromRGB(170, 170, 170)
                        end
                    end
                    lastExisted = mapExists
                    task.wait(0.5)
                end
            end)
        end

        W.NextMapPredict_Start = Start
        W.NextMapPredict_Stop = Stop
        W.NextMapPredict_SetEnabled = function(v)
            VD.NextMapPredict = v and true or false
            if VD.NextMapPredict then Start() else Stop() end
        end
    end

    do
        local RepairEvent = nil
        pcall(function()
            RepairEvent = ReplicatedStorage.Remotes.Generator.RepairEvent
        end)

        local REPAIR_ANIM_ID = "rbxassetid://92960319113695"
        local ManualThread, AutoThread = nil, nil
        local ManualPoint, AutoPoint = nil, nil
        local LastFire = 0
        local RepairAnimTrack = nil

        local function IsKillerNearPos(pos, radius)
            for _, pl in ipairs(Players:GetPlayers()) do
                if pl ~= LocalPlayer and TeamIs(pl, "Killer") and pl.Character then
                    local hrp = pl.Character:FindFirstChild("HumanoidRootPart")
                    if hrp and (hrp.Position - pos).Magnitude <= radius then
                        return true
                    end
                end
            end
            return false
        end

        local function GetNearestKillerDist()
            local myChar = LocalPlayer.Character
            local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
            if not myRoot then return nil, math.huge end
            local best, dist = nil, math.huge
            for _, pl in ipairs(Players:GetPlayers()) do
                if pl ~= LocalPlayer and TeamIs(pl, "Killer") and pl.Character then
                    local hrp = pl.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local d = (hrp.Position - myRoot.Position).Magnitude
                        if d < dist then dist = d; best = hrp end
                    end
                end
            end
            return best, dist
        end

        local function PlayRepairAnim()
            local char = LocalPlayer.Character
            if not char then return end
            local hum = char:FindFirstChildOfClass("Humanoid")
            local animator = hum and hum:FindFirstChildOfClass("Animator")
            if not animator then return end
            if RepairAnimTrack and RepairAnimTrack.IsPlaying then return end
            pcall(function()
                local anim = Instance.new("Animation")
                anim.AnimationId = REPAIR_ANIM_ID
                RepairAnimTrack = animator:LoadAnimation(anim)
                RepairAnimTrack.Priority = Enum.AnimationPriority.Action
                RepairAnimTrack:Play()
            end)
        end

        local function StopRepairAnim()
            if RepairAnimTrack and RepairAnimTrack.IsPlaying then
                pcall(function() RepairAnimTrack:Stop() end)
            end
            RepairAnimTrack = nil
        end

        local function StopRepair(point)
            StopRepairAnim()
            if point and RepairEvent then
                pcall(function() RepairEvent:FireServer(point, false) end)
            end
        end

        local function IsGenDone(gen)
            local p = gen:GetAttribute("RepairProgress") or gen:GetAttribute("ProgressRepair") or 0
            return p >= 100
        end

        local function GetNearestGenPointInReach()
            local myChar = LocalPlayer.Character
            local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
            if not myRoot then return nil end
            local bestPt, bestDist = nil, 5.5
            for _, gen in ipairs(W.GB_GetAllGenerators()) do
                for _, pt in ipairs(W.GB_GetPoints(gen)) do
                    if pt and pt.Parent then
                        local d = (myRoot.Position - pt.Position).Magnitude
                        if d < bestDist then
                            bestDist = d
                            bestPt = pt
                        end
                    end
                end
            end
            return bestPt
        end

        local function GetSafeNearestGenPoint()
            local myChar = LocalPlayer.Character
            local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
            if not myRoot then return nil end
            local bestPt, bestDist = nil, math.huge
            for _, gen in ipairs(W.GB_GetAllGenerators()) do
                if IsGenDone(gen) then continue end
                local genPivot
                pcall(function() genPivot = gen:GetPivot().Position end)
                if genPivot and IsKillerNearPos(genPivot, VD.KillerEscapeDist) then
                    continue
                end
                for _, pt in ipairs(W.GB_GetPoints(gen)) do
                    if pt and pt.Parent then
                        local d = (pt.Position - myRoot.Position).Magnitude
                        if d < bestDist then
                            bestDist = d
                            bestPt = pt
                        end
                    end
                end
            end
            return bestPt
        end

        local function StartManualThread()
            if ManualThread then pcall(function() task.cancel(ManualThread) end); ManualThread = nil end
            ManualThread = task.spawn(function()
                while VD.ManualGen do
                    local myChar = LocalPlayer.Character
                    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
                    local hum = myChar and myChar:FindFirstChildOfClass("Humanoid")
                    if not myRoot or not hum or hum.Health <= 0 then task.wait(0.2); continue end

                    local _, kd = GetNearestKillerDist()
                    if kd <= VD.KillerEscapeDist then
                        if ManualPoint then
                            StopRepair(ManualPoint)
                            ManualPoint = nil
                            VD_Notify("Manual Gen", "Killer near — release repair", 2)
                        end
                        task.wait(0.3)
                        continue
                    end

                    local pt = GetNearestGenPointInReach()
                    if pt then
                        ManualPoint = pt
                        local now = tick()
                        if now - LastFire >= 0.5 then
                            pcall(function() if RepairEvent then RepairEvent:FireServer(pt, true) end end)
                            PlayRepairAnim()
                            LastFire = now
                        end
                    else
                        if ManualPoint then StopRepair(ManualPoint); ManualPoint = nil end
                    end
                    task.wait(0.1)
                end
                if ManualPoint then StopRepair(ManualPoint) end
                ManualPoint = nil
            end)
        end

        local function StopManualThread()
            if ManualThread then pcall(function() task.cancel(ManualThread) end); ManualThread = nil end
            if ManualPoint then StopRepair(ManualPoint) end
            ManualPoint = nil
        end

        local function StartAutoThread()
            if AutoThread then pcall(function() task.cancel(AutoThread) end); AutoThread = nil end
            AutoThread = task.spawn(function()
                while VD.AutoGen do
                    local myChar = LocalPlayer.Character
                    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
                    local hum = myChar and myChar:FindFirstChildOfClass("Humanoid")
                    if not myRoot or not hum or hum.Health <= 0 then task.wait(0.3); continue end

                    local _, kd = GetNearestKillerDist()
                    if kd <= VD.KillerEscapeDist then
                        if AutoPoint then StopRepair(AutoPoint); AutoPoint = nil end
                        local safePt = GetSafeNearestGenPoint()
                        if safePt then
                            AutoPoint = safePt
                            pcall(function()
                                myRoot.CFrame = CFrame.new(safePt.Position + Vector3.new(0, 3, 0))
                            end)
                            task.wait(0.2)
                        end
                        task.wait(0.2)
                        continue
                    end

                    if AutoPoint and AutoPoint.Parent then
                        local now = tick()
                        if now - LastFire >= 0.5 then
                            pcall(function() if RepairEvent then RepairEvent:FireServer(AutoPoint, true) end end)
                            PlayRepairAnim()
                            LastFire = now
                        end
                    else
                        local pt = GetNearestGenPointInReach()
                        if pt then
                            AutoPoint = pt
                        else
                            local safePt = GetSafeNearestGenPoint()
                            if safePt then
                                AutoPoint = safePt
                                pcall(function()
                                    myRoot.CFrame = CFrame.new(safePt.Position + Vector3.new(0, 3, 0))
                                end)
                                task.wait(0.2)
                            end
                        end
                    end
                    task.wait(0.1)
                end
                if AutoPoint then StopRepair(AutoPoint) end
                AutoPoint = nil
            end)
        end

        local function StopAutoThread()
            if AutoThread then pcall(function() task.cancel(AutoThread) end); AutoThread = nil end
            if AutoPoint then StopRepair(AutoPoint) end
            AutoPoint = nil
        end

        W.ManualGen_SetEnabled = function(v)
            VD.ManualGen = v and true or false
            if VD.ManualGen then StartManualThread() else StopManualThread() end
        end

        W.AutoGen_SetEnabled = function(v)
            VD.AutoGen = v and true or false
            if VD.AutoGen then StartAutoThread() else StopAutoThread() end
        end

        W.GenAuto_SetDistance = function(v)
            VD.KillerEscapeDist = tonumber(v) or 30
        end

        LocalPlayer.CharacterAdded:Connect(function()
            task.wait(1)
            if VD.ManualGen then StartManualThread() end
            if VD.AutoGen then StartAutoThread() end
        end)
    end

    VD.SURV_AutoDodgeSpear = VD.SURV_AutoDodgeSpear or false
    getgenv().GANKZ_IsDodging = false

    Workspace.ChildAdded:Connect(function(child)
        if not child or child.Name ~= "Spearprojectile" then return end
        if not VD.SURV_AutoDodgeSpear then return end
        if W.GetRole() ~= "Survivor" then return end

        task.spawn(function()
            if getgenv().GANKZ_IsDodging then return end

            local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if not root then return end

            task.wait(0.05)

            local mainPart = child:WaitForChild("Hitbox", 1)
                or child:WaitForChild("Spear1", 1)
                or child.PrimaryPart
                or child:FindFirstChildWhichIsA("BasePart")
            if not mainPart then return end

            task.wait()

            local originPos = mainPart.Position
            local spearDir  = mainPart.CFrame.UpVector
            local toPlayer  = (root.Position - originPos)
            if toPlayer.Magnitude < 0.1 then return end
            toPlayer = toPlayer.Unit

            local dot = spearDir:Dot(toPlayer)
            if dot > 0.85 then
                getgenv().GANKZ_IsDodging = true
                local originalCFrame = root.CFrame
                local rightVector    = root.CFrame.RightVector
                root.CFrame = root.CFrame + (rightVector * 8)
                VD_Notify("Auto Dodge", "Spear terdeteksi! Menghindar otomatis...", 2)
                task.wait(1)
                local r = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if r then r.CFrame = originalCFrame end
                getgenv().GANKZ_IsDodging = false
            end
        end)
    end)

    local allSections = {}
    local function MakeSection(tab, name)
        local s = tab:AddSection(name)
        table.insert(allSections, s)
        return s
    end

    local uiOK, uiErr = pcall(function()
        if not UILib then error("UILib tidak tersedia.") end
        local Window = UILib:Window({
            Title = "Promers Hub - Premium",
            LogoButtonSize = 52,
            Image = "118748055443363",
            Footer = "Violence District",
            Color = NotifyColor,
            ShowInfo = true,
            Version = 1,
            Search = true
        })
        Window:InfoTab({
            Name = "Information", Icon = "lightbulb",
            SectionTitle = "Information",
            Banner = "rbxassetid://124361049319609",
            Version = "v0.4.4",
            DiscordLink = "https://discord.gg/NvZAbsYw",
            DiscordName = "Promers Hub - Community",
            DiscordText = "Join Server Discord Promers Untuk Informasi Update Dan Giveaway.",
            Cards = { { Title = "Credits", Description = "Owner = ALFzxzzz\nDev = Vanzxzz\n" } }
        })

        local SurvivorTab = Window:AddTab({ Name = "Survivor", Icon = "user" })
        local VisualsTab  = Window:AddTab({ Name = "Visuals",  Icon = "eye" })
        local KillerTab   = Window:AddTab({ Name = "Killer",   Icon = "crosshair" })
        local MiscTab     = Window:AddTab({ Name = "Misc",     Icon = "settings-2" })
        local ConfigTab   = Window:AddTab({ Name = "Config",   Icon = "save" })

        -- ============ SURVIVOR TAB ============
        local escSection = MakeSection(SurvivorTab, "Instant Escape")
        escSection:AddToggle({ Title = "Enable Escape Button", Default = false, Callback = function(v)
            if getgenv().Gluto_Escape_SetEnabled then getgenv().Gluto_Escape_SetEnabled(v) end
            if v then VD_Notify("Escape Button", "Shown", 2) end
        end })
        escSection:AddButton({ Title = "Teleport Now", Callback = function() W.Escape_Teleport() end })

        local healSection = MakeSection(SurvivorTab, "Self Heal")
        healSection:AddToggle({ Title = "Self Heal Progress", Default = false, Callback = function(v)
            W.setInstantHealSelf(v)
            if getgenv().Gluto_SHB_UpdateVisual then getgenv().Gluto_SHB_UpdateVisual() end
            if v then VD_Notify("Self Heal", "Enabled", 2) end
        end })
        healSection:AddToggle({ Title = "Auto Heal All", Default = false, Callback = function(v)
            W.setAutoHealAll(v)
            if v then VD_Notify("Auto Heal All", "Enabled", 2) end
        end })
        healSection:AddToggle({ Title = "Show Self Heal Button", Default = false, Callback = function(v)
            if getgenv().Gluto_SHB_SetEnabled then getgenv().Gluto_SHB_SetEnabled(v) end
        end })

        local vaultSection = MakeSection(SurvivorTab, "Swift Vault")
        vaultSection:AddToggle({ Title = "Swift Vault (Auto Vault)", Content = "Auto vault window saat dekat & bergerak",
            Default = VD.SURV_AutoVault, Callback = function(v)
                W.SwiftVault_SetEnabled(v)
                if v then VD_Notify("Swift Vault", "Enabled", 2) else VD_Notify("Swift Vault", "Disabled", 2) end
            end })
        vaultSection:AddToggle({ Title = "Swift Vault V2 (Custom Speed)", Content = "Ubah kecepatan vault",
            Default = VD.SURV_FastVault, Callback = function(v)
                W.SwiftVaultV2_SetEnabled(v)
                if v then VD_Notify("Swift Vault V2", "Enabled", 2) else VD_Notify("Swift Vault V2", "Disabled", 2) end
            end })
        vaultSection:AddSlider({ Title = "Vault Speed", Min = 10, Max = 20, Default = VD.SURF_VaultSpeed, Increment = 1,
            Callback = function(v) W.SwiftVault_SetSpeed(v) end })

        local palletSection = MakeSection(SurvivorTab, "Pallet Reflex")
        palletSection:AddToggle({ Title = "Enable Pallet Reflex", Content = "Auto drop pallet saat killer dekat",
            Default = VD.SURV_AutoPallet, Callback = function(v)
                W.PalletReflex_SetEnabled(v)
                if v then VD_Notify("Pallet Reflex", "Enabled", 2) else VD_Notify("Pallet Reflex", "Disabled", 2) end
            end })
        palletSection:AddSlider({ Title = "Trigger Distance", Min = 5, Max = 50, Default = VD.SURV_AutoPalletDist,
            Increment = 1, Suffix = " studs", Callback = function(v) W.PalletReflex_SetDistance(v) end })

        local dodgeSpearSection = MakeSection(SurvivorTab, "Auto Dodge Veil Spear")
        dodgeSpearSection:AddParagraph({
            Title = "Info",
            Content = "Auto geser ke samping saat killer lempar tombak Veil (Spearprojectile)"
        })
        dodgeSpearSection:AddToggle({
            Title = "Enable Auto Dodge Spear",
            Content = "Deteksi projectile Veil → auto dodge kanan 8 studs",
            Default = false,
            Keybind = true,
            Callback = function(v)
                VD.SURV_AutoDodgeSpear = v and true or false
                if v then VD_Notify("Auto Dodge Spear", "Enabled", 2)
                else VD_Notify("Auto Dodge Spear", "Disabled", 2) end
            end
        })

        local fleeSection = MakeSection(SurvivorTab, "Auto Flee Killer")
        fleeSection:AddToggle({ Title = "Enable Auto Flee", Content = "Otomatis teleport menjauh dari killer",
            Default = VD.SURV_AutoFlee, Callback = function(v)
                VD.SURV_AutoFlee = v
                if v then VD_Notify("Auto Flee", "Enabled", 2) else VD_Notify("Auto Flee", "Disabled", 2) end
            end })
        fleeSection:AddSlider({ Title = "Detect Distance", Min = 15, Max = 150, Default = VD.SURV_AutoFleeDist,
            Increment = 5, Suffix = " studs", Callback = function(v) VD.SURV_AutoFleeDist = v end })
        fleeSection:AddSlider({ Title = "Flee Cooldown", Min = 0.5, Max = 10, Default = VD.SURV_AutoFleeCooldown,
            Increment = 0.5, Suffix = "s", Callback = function(v) VD.SURV_AutoFleeCooldown = v end })

        local fpSection = MakeSection(SurvivorTab, "Fake Perks")
        fpSection:AddToggle({ Title = "Flowstate (Buff on Vault/Slide)", Default = false, Callback = function(v)
            W.FP_SetupFlowstate(v); if v then VD_Notify("Fake Perks", "Flowstate Enabled", 2) end end })
        fpSection:AddToggle({ Title = "Quick Recovery (Buff on Heal)", Default = false, Callback = function(v)
            W.FP_SetupQuickRecovery(v); if v then VD_Notify("Fake Perks", "Quick Recovery Enabled", 2) end end })
        fpSection:AddToggle({ Title = "Perfect Landing (Buff on Land)", Default = false, Callback = function(v)
            W.FP_SetupPerfectLanding(v); if v then VD_Notify("Fake Perks", "Perfect Landing Enabled", 2) end end })
        fpSection:AddToggle({ Title = "Adrenaline Rush (Buff on Low HP)", Default = false, Callback = function(v)
            W.FP_SetupAdrenalineRush(v); if v then VD_Notify("Fake Perks", "Adrenaline Rush Enabled", 2) end end })
        fpSection:AddSlider({ Title = "Perk Cooldown", Min = 0, Max = 30, Default = 5, Increment = 1, Suffix = "s",
            Callback = function(v) W.FP.CooldownTime = v end })
        fpSection:AddButton({ Title = "Clear All Active Buffs", Callback = function()
            for k in pairs(W.FP.ActiveBuffs) do W.FP.ActiveBuffs[k] = nil end
            local c = LocalPlayer.Character
            if c then c:SetAttribute("speedboost", 1) end
            local h = c and c:FindFirstChildOfClass("Humanoid")
            if h then h.WalkSpeed = 16 end
            ForceNotify("Fake Perks", "Buffs cleared", 2)
        end })

        local skillSection = MakeSection(SurvivorTab, "Auto Skill Check")
        skillSection:AddToggle({ Title = "Enable Auto Skill Check", Default = false, Callback = function(v)
            W.SkillCheck_SetEnabled(v); if v then VD_Notify("Auto Skill Check", "Enabled", 2) end end })
        skillSection:AddDropdown({ Title = "Mode", Options = {"Legit", "Instant"}, Default = "Legit",
            Callback = function(v) W.SkillCheck.Mode = v end })

        local genSection = MakeSection(SurvivorTab, "Bypass Generator")
        genSection:AddToggle({ Title = "Enable Bypass Generator", Default = false, Callback = function(v)
            W.setGenBypass(v); if v then VD_Notify("Bypass Generator", "Enabled (Hotkey: B)", 3) end end })
        genSection:AddSlider({ Title = "Trigger Range", Min = 3, Max = 20, Default = 8, Increment = 1, Suffix = " studs",
            Callback = function(v) W.GenBypass.TriggerRange = v end })
        genSection:AddButton({ Title = "Force Repair Nearest Generator", Callback = function()
            local bp, bd = W.GB_GetNearestPoint()
            if bp and bd <= W.GenBypass.TriggerRange then W.GB_DoRepair(bp); ForceNotify("Bypass Generator", "Forcing repair...", 2)
            else ForceNotify("Bypass Generator", "Terlalu jauh", 2) end
        end })

        local UnlimitedVaultSection = MakeSection(SurvivorTab, "Unlimited Vault")
        local UnlimitedVaultEnabled = false
        local UnlimitedVaultConn = nil
        local function EnableUnlimitedVault()
            if UnlimitedVaultEnabled then return end
            UnlimitedVaultEnabled = true
            if UnlimitedVaultConn then UnlimitedVaultConn:Disconnect() end
            for _, v in ipairs(CollectionService:GetTagged("Blocked")) do
                CollectionService:RemoveTag(v, "Blocked")
            end
            UnlimitedVaultConn = CollectionService:GetInstanceAddedSignal("Blocked"):Connect(function(instance)
                CollectionService:RemoveTag(instance, "Blocked")
            end)
        end
        local function DisableUnlimitedVault()
            UnlimitedVaultEnabled = false
            if UnlimitedVaultConn then UnlimitedVaultConn:Disconnect(); UnlimitedVaultConn = nil end
        end
        UnlimitedVaultSection:AddToggle({ Title = "Unlimited Vault", Content = "Remove 'Blocked' tag dari semua vault",
            Default = false, Keybind = true,
            Callback = function(state)
                if state then EnableUnlimitedVault() else DisableUnlimitedVault() end
                VD_Notify("Unlimited Vault", state and "Enabled" or "Disabled", 2)
            end })

        local AntiSlowVaultSection = MakeSection(SurvivorTab, "Anti Slow Vault")
        local AntiSlowVaultEnabled = false
        local AntiSlowVaultConn = nil
        local function EnableAntiSlowVault()
            if AntiSlowVaultEnabled then return end
            AntiSlowVaultEnabled = true
            for _, v in ipairs(CollectionService:GetTagged("SlowVault")) do
                CollectionService:RemoveTag(v, "SlowVault")
            end
            if AntiSlowVaultConn then AntiSlowVaultConn:Disconnect() end
            AntiSlowVaultConn = CollectionService:GetInstanceAddedSignal("SlowVault"):Connect(function(instance)
                CollectionService:RemoveTag(instance, "SlowVault")
            end)
        end
        local function DisableAntiSlowVault()
            AntiSlowVaultEnabled = false
            if AntiSlowVaultConn then AntiSlowVaultConn:Disconnect(); AntiSlowVaultConn = nil end
        end
        AntiSlowVaultSection:AddToggle({ Title = "Anti Slow Vault", Content = "Remove 'SlowVault' tag — vault selalu full speed",
            Default = false, Keybind = true,
            Callback = function(state)
                if state then EnableAntiSlowVault() else DisableAntiSlowVault() end
                VD_Notify("Anti Slow Vault", state and "Enabled" or "Disabled", 2)
            end })

        local GodSection = MakeSection(SurvivorTab, "God Mode")
        local GodModeEnabled = false
        local GodModeThread = nil
        local function StartGodMode()
            if GodModeThread then task.cancel(GodModeThread) end
            GodModeThread = task.spawn(function()
                while GodModeEnabled do
                    local char = LocalPlayer.Character
                    local hum = char and char:FindFirstChildOfClass("Humanoid")
                    if hum then
                        pcall(function()
                            if hum.Health < hum.MaxHealth and hum.Health > 0 then hum.Health = hum.MaxHealth end
                        end)
                    end
                    task.wait(0.1)
                end
                GodModeThread = nil
            end)
        end
        local function StopGodMode()
            GodModeEnabled = false
            if GodModeThread then task.cancel(GodModeThread); GodModeThread = nil end
        end
        GodSection:AddToggle({ Title = "God Mode", Content = "Auto-heal terus (Health selalu MaxHealth)",
            Default = false, Keybind = true,
            Callback = function(state)
                GodModeEnabled = state
                if state then StartGodMode(); VD_Notify("God Mode", "Enabled", 2)
                else StopGodMode(); VD_Notify("God Mode", "Disabled", 2) end
            end })

        local AutoRunSection = MakeSection(SurvivorTab, "Auto Run")
        local AutoRunPCEnabled = false
        local AutoRunMobileEnabled = false
        local AutoRunPCThread = nil
        local AutoRunMobileThread = nil
        local function StartAutoRunPC()
            if AutoRunPCThread then task.cancel(AutoRunPCThread) end
            AutoRunPCThread = task.spawn(function()
                while AutoRunPCEnabled do
                    pcall(function()
                        if VirtualInputManager then
                            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.LeftShift, false, LocalPlayer:GetMouse())
                        end
                    end)
                    task.wait(0.1)
                end
                pcall(function()
                    if VirtualInputManager then VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, LocalPlayer:GetMouse()) end
                end)
                AutoRunPCThread = nil
            end)
        end
        local function StopAutoRunPC()
            AutoRunPCEnabled = false
            if AutoRunPCThread then task.cancel(AutoRunPCThread); AutoRunPCThread = nil end
            pcall(function()
                if VirtualInputManager then VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, LocalPlayer:GetMouse()) end
            end)
        end
        local function GetMobileSprintButton()
            local pg = LocalPlayer:FindFirstChild("PlayerGui"); if not pg then return nil end
            local mob = pg:FindFirstChild("Survivor-mob"); if not mob then return nil end
            local controls = mob:FindFirstChild("Controls"); if not controls then return nil end
            local sprint = controls:FindFirstChild("sprint"); if not sprint then return nil end
            if sprint:IsA("GuiButton") then return sprint end
            local icon = sprint:FindFirstChild("icon")
            if icon and icon:IsA("GuiButton") then return icon end
            if icon and icon.Parent and icon.Parent:IsA("GuiButton") then return icon.Parent end
            if sprint.Parent and sprint.Parent:IsA("GuiButton") then return sprint.Parent end
            return sprint
        end
        local function PressSprint()
            local btn = GetMobileSprintButton()
            if not btn then return false end
            pcall(function()
                if type(firesignal) == "function" then
                    firesignal(btn.MouseButton1Click)
                    firesignal(btn.MouseButton1Down)
                    task.wait(0.04)
                    firesignal(btn.MouseButton1Up)
                elseif VirtualInputManager and GuiService then
                    local pos = btn.AbsolutePosition; local size = btn.AbsoluteSize
                    local inset = GuiService:GetGuiInset()
                    local x = pos.X + size.X / 2 + inset.X
                    local y = pos.Y + size.Y / 2 + inset.Y
                    local id = 9901
                    VirtualInputManager:SendTouchEvent(id, 0, x, y)
                    task.wait(0.04)
                    VirtualInputManager:SendTouchEvent(id, 2, x, y)
                end
            end)
            return true
        end
        local function IsMoving()
            local char = LocalPlayer.Character; if not char then return false end
            local hum = char:FindFirstChildOfClass("Humanoid"); if not hum then return false end
            if hum.MoveDirection.Magnitude > 0.12 then return true end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                local v = hrp.AssemblyLinearVelocity
                if Vector3.new(v.X, 0, v.Z).Magnitude > 1.5 then return true end
            end
            return false
        end
        local function IsCrouching()
            local char = LocalPlayer.Character; if not char then return false end
            return char:GetAttribute("Crouching") == true or char:GetAttribute("Crouchingserver") == true
        end
        local function IsActuallySprinting()
            local char = LocalPlayer.Character; if not char then return false end
            return char:GetAttribute("Sprinting") == true or char:GetAttribute("IsRunning") == true
        end
        local function StartAutoRunMobile()
            if AutoRunMobileThread then return end
            AutoRunMobileThread = task.spawn(function()
                while AutoRunMobileEnabled do
                    local moving = IsMoving()
                    local crouching = IsCrouching()
                    local sprinting = IsActuallySprinting()
                    if crouching then if sprinting then PressSprint() end
                    else
                        if moving and not sprinting then PressSprint()
                        elseif not moving and sprinting then PressSprint() end
                    end
                    task.wait(0.12)
                end
                if IsActuallySprinting() then PressSprint() end
                AutoRunMobileThread = nil
            end)
        end
        local function StopAutoRunMobile() AutoRunMobileEnabled = false end
        AutoRunSection:AddToggle({ Title = "Auto Run [PC]", Content = "Auto hold LeftShift",
            Default = false, Callback = function(v)
                AutoRunPCEnabled = v
                if v then StartAutoRunPC() else StopAutoRunPC() end
                VD_Notify("Auto Run PC", v and "Enabled" or "Disabled", 2)
            end })
        AutoRunSection:AddToggle({ Title = "Auto Run [Mobile]", Content = "Auto sprint di mobile",
            Default = false, Callback = function(v)
                AutoRunMobileEnabled = v
                if v then StartAutoRunMobile(); VD_Notify("Auto Run Mobile", "Enabled", 2)
                else StopAutoRunMobile(); VD_Notify("Auto Run Mobile", "Disabled", 2) end
            end })
        LocalPlayer.CharacterAdded:Connect(function()
            task.wait(1)
            if AutoRunPCEnabled then StartAutoRunPC() end
            if AutoRunMobileEnabled then AutoRunMobileThread = nil; StartAutoRunMobile() end
        end)

        local trollSection = MakeSection(SurvivorTab, "Troll Teleport")
        trollSection:AddToggle({ Title = "Enable Troll Teleport", Default = false, Callback = function(v)
            W.TrollTeleport_SetEnabled(v)
            if getgenv().Gluto_TTB_UpdateVisual then getgenv().Gluto_TTB_UpdateVisual() end
            if v then VD_Notify("Troll Teleport", "Enabled", 2) end
        end })
        trollSection:AddToggle({ Title = "Show Troll TP Button", Default = false, Callback = function(v)
            if getgenv().Gluto_TTB_SetEnabled then getgenv().Gluto_TTB_SetEnabled(v) end
        end })

        local autoCrouchSection = MakeSection(SurvivorTab, "Auto Crouch Dodge")
        autoCrouchSection:AddToggle({ Title = "Enable Auto Crouch Dodge", Content = "Auto crouch saat killer pakai Abyssal S1",
            Default = VD.AutoCrouch, Callback = function(v)
                VD.AutoCrouch = v
                if v then VD_Notify("Auto Crouch Dodge", "Enabled", 2) else VD_Notify("Auto Crouch Dodge", "Disabled", 2) end
            end })

        local wisnuParrySection = MakeSection(SurvivorTab, "Auto Parry Feature")

        wisnuParrySection:AddToggle({
            Title = "Enable Auto Parry",
            Content = "Auto parry saat killer pakai attack anim (Wisnu method)",
            Default = VD.Surv_AutoParry,
            Keybind = true,
            Callback = function(v)
                VD.Surv_AutoParry = v and true or false
                if getgenv().Gluto_WisnuParryBtn_UpdateVisual then
                    pcall(getgenv().Gluto_WisnuParryBtn_UpdateVisual)
                end
                if v then VD_Notify("Auto Parry", "Enabled", 2)
                else VD_Notify("Auto Parry", "Disabled", 2) end
            end
        })
        wisnuParrySection:AddToggle({
            Title = "Safety Parry (Anti Fake Hit)",
            Content = "Skip parry kalau killer belakangan/miring — cuma parry kalau killer HADAP kita",
            Default = VD.Surv_ParrySafety,
            Keybind = true,
            Callback = function(v)
                VD.Surv_ParrySafety = v and true or false
                if v then VD_Notify("Auto Parry", "Anti Fake Hit: ON", 2) end
            end
        })
        wisnuParrySection:AddToggle({
            Title = "Aggressive Mode",
            Content = "Parry tanpa cek arah face killer + auto-approach radius",
            Default = VD.Surv_ParryAggressive,
            Callback = function(v) VD.Surv_ParryAggressive = v and true or false end
        })
        wisnuParrySection:AddToggle({
            Title = "Show Parry Range Circle",
            Content = "Circle muncul dengan animasi pop-in + pulse breathing",
            Default = VD.Surv_ParryCircle,
            Callback = function(v) VD.Surv_ParryCircle = v and true or false end
        })
        wisnuParrySection:AddSlider({
            Title = "Parry Radius",
            Min = 5, Max = 25, Default = VD.Surv_ParryRadius, Increment = 1, Suffix = " studs",
            Callback = function(v) VD.Surv_ParryRadius = v end
        })
        wisnuParrySection:AddSlider({
            Title = "Face Sensitivity",
            Min = -1, Max = 1, Default = VD.Surv_ParryFace, Increment = 0.05,
            Callback = function(v) VD.Surv_ParryFace = v end
        })
        wisnuParrySection:AddDropdown({
            Title = "Ignore Skills",
            Options = { "Hidden S1", "Abyssal S1" },
            Multi = true,
            Default = {},
            Callback = function(sel)
                local parsed = {}
                if type(sel) == "table" then
                    for k, v in pairs(sel) do
                        if type(k) == "string" and v then parsed[k] = true
                        elseif type(v) == "string" then parsed[v] = true end
                    end
                elseif type(sel) == "string" then
                    parsed[sel] = true
                end
                VD.Surv_IgnoredSkills = parsed
            end
        })
        wisnuParrySection:AddToggle({
            Title = "Show Floating Parry Button",
            Content = "Tampilkan tombol PARRY melayang di layar",
            Default = false,
            Callback = function(v)
                if getgenv().Gluto_WisnuParryBtn_SetEnabled then
                    getgenv().Gluto_WisnuParryBtn_SetEnabled(v)
                end
            end
        })

        local fallSection = MakeSection(SurvivorTab, "Anti Fall Damage")
        fallSection:AddToggle({
            Title = "Enable No Fall Damage",
            Content = "Block fall damage remote (Mechanics.Fall)",
            Default = false,
            Callback = function(v)
                VD.NoFallDamage = v and true or false
                if v then VD_Notify("No Fall Damage", "Enabled", 2)
                else VD_Notify("No Fall Damage", "Disabled", 2) end
            end
        })

        local mapPredictSection = MakeSection(SurvivorTab, "Next Map Prediction")
        mapPredictSection:AddToggle({
            Title = "Enable Map Prediction",
            Content = "Floating GUI shows detected/next map",
            Default = false,
            Callback = function(v)
                if W.NextMapPredict_SetEnabled then W.NextMapPredict_SetEnabled(v) end
                if v then VD_Notify("Map Prediction", "Enabled", 2)
                else VD_Notify("Map Prediction", "Disabled", 2) end
            end
        })

        local manualGenSection = MakeSection(SurvivorTab, "Manual Generator")
        manualGenSection:AddToggle({
            Title = "Enable Manual Generator",
            Content = "Auto repair nearest gen in reach. Release when killer near.",
            Default = false,
            Callback = function(v)
                if W.ManualGen_SetEnabled then W.ManualGen_SetEnabled(v) end
                if v then VD_Notify("Manual Gen", "Enabled", 2)
                else VD_Notify("Manual Gen", "Disabled", 2) end
            end
        })
        manualGenSection:AddSlider({
            Title = "Killer Escape Distance",
            Min = 10, Max = 80, Default = 30, Increment = 5, Suffix = " studs",
            Callback = function(v)
                if W.GenAuto_SetDistance then W.GenAuto_SetDistance(v) end
            end
        })

        local autoGenSection = MakeSection(SurvivorTab, "Auto Generator")
        autoGenSection:AddToggle({
            Title = "Enable Auto Generator",
            Content = "Auto TP to safe gen when killer approaches",
            Default = false,
            Callback = function(v)
                if W.AutoGen_SetEnabled then W.AutoGen_SetEnabled(v) end
                if v then VD_Notify("Auto Gen", "Enabled", 2)
                else VD_Notify("Auto Gen", "Disabled", 2) end
            end
        })

        local unhookSection = MakeSection(SurvivorTab, "Bypass Self Unhook")
        unhookSection:AddToggle({ Title = "Enable Bypass Self Unhook", Default = false, Callback = function(v)
            W.SU_SetEnabled(v)
            if getgenv().Gluto_SUB_UpdateVisual then getgenv().Gluto_SUB_UpdateVisual() end
            if v then VD_Notify("Bypass Self Unhook", "Enabled", 2) end
        end })
        unhookSection:AddToggle({ Title = "Show Self Unhook Button", Default = false, Callback = function(v)
            if getgenv().Gluto_SUB_SetEnabled then getgenv().Gluto_SUB_SetEnabled(v) end
        end })
        unhookSection:AddSlider({ Title = "Follow Duration", Min = 5, Max = 120, Default = 30, Increment = 5, Suffix = "s", Callback = function(v) W.SelfUnhook.FollowDuration = v end })
        unhookSection:AddSlider({ Title = "Follow Distance", Min = 5, Max = 60, Default = 20, Increment = 1, Suffix = " studs", Callback = function(v) W.SelfUnhook.FollowDistance = v end })

        local tofSection = MakeSection(SurvivorTab, "Silent Aim TOF")
        tofSection:AddToggle({ Title = "Enable Silent Aim", Default = VD.TOF_SilentAim, Callback = function(v)
            SetToFSilentAim(v); if v then VD_Notify("Silent Aim TOF", "Enabled", 2) end end })
        tofSection:AddKeybind({ Title = "Toggle Key", Default = Enum.KeyCode.Q, Callback = function(kc) VD.TOF_Key = kc and kc.Name or "None" end })
        tofSection:AddDropdown({ Title = "Target Mode", Options = { "Killer", "Survivors", "Zombie" }, Default = "Killer", Callback = function(v) ToF_SetTargetMode(v, true) end })
        tofSection:AddToggle({ Title = "Show Laser Beam", Default = true, Callback = function(v) VD.TOF_Laser = v; if not v then ToF_ClearLaser() end end })
        tofSection:AddToggle({ Title = "Wall Check", Default = true, Callback = function(v) VD.TOF_WallCheck = v end })
        tofSection:AddToggle({ Title = "Block When Knocked", Default = true, Callback = function(v) VD.TOF_BlockKnocked = v end })

        local flashSection = MakeSection(SurvivorTab, "Silent Flashlight")
        flashSection:AddToggle({ Title = "Enable Silent Flashlight", Content = "Auto-aim flashlight ke Killer",
            Default = VD.FLASH_SilentAim, Callback = function(v)
                W.Flash_SetEnabled(v)
                if v then VD_Notify("Silent Flashlight", "Enabled", 2) else VD_Notify("Silent Flashlight", "Disabled", 2) end
            end })
        flashSection:AddDropdown({ Title = "Target Part", Options = {"Head", "UpperTorso", "Torso", "HumanoidRootPart"},
            Default = VD.FLASH_TargetPart, Callback = function(v) VD.FLASH_TargetPart = type(v) == "table" and v[1] or v or "Head" end })
        flashSection:AddSlider({ Title = "Max Range", Min = 20, Max = 250, Default = VD.FLASH_Range, Increment = 5, Suffix = " studs", Callback = function(v) VD.FLASH_Range = v end })
        flashSection:AddSlider({ Title = "Smoothness", Min = 0.05, Max = 1, Default = VD.FLASH_Smooth, Increment = 0.05, Callback = function(v) VD.FLASH_Smooth = v end })
        flashSection:AddToggle({ Title = "Show Laser", Default = VD.FLASH_Laser, Callback = function(v)
            VD.FLASH_Laser = v; if not v and W.Flash_ClearLaser then W.Flash_ClearLaser() end end })

        local aimlockGunSection = MakeSection(SurvivorTab, "Aim Lock Gun")
        aimlockGunSection:AddToggle({
            Title = "Enable Aim Lock Gun",
            Content = "Hold M2 / attack button → camera kunci ke target",
            Default = false, Keybind = true,
            Callback = function(v)
                if W.GunAim_Cfg then W.GunAim_Cfg.Enabled = v end
                if v and W.GunAim_Start then W.GunAim_Start() end
                if v then VD_Notify("Aim Lock Gun", "Hold M2 to lock", 2) end
            end
        })
        aimlockGunSection:AddDropdown({ Title = "Target Mode", Options = { "Killer", "Survivor" }, Default = "Killer",
            Callback = function(v)
                local val = type(v) == "table" and v[1] or v
                if W.GunAim_Cfg then W.GunAim_Cfg.TargetMode = val end
            end })
        aimlockGunSection:AddSlider({ Title = "FOV Radius", Min = 50, Max = 1000, Default = 250, Increment = 10,
            Callback = function(v) if W.GunAim_Cfg then W.GunAim_Cfg.FOV = v end end })
        aimlockGunSection:AddSlider({ Title = "Aim Smoothness", Min = 0.1, Max = 1, Default = 0.5, Increment = 0.05,
            Callback = function(v) if W.GunAim_Cfg then W.GunAim_Cfg.Strength = v end end })
        aimlockGunSection:AddSlider({ Title = "Prediction Strength", Min = 0, Max = 1, Default = 0.12, Increment = 0.01,
            Callback = function(v) if W.GunAim_Cfg then W.GunAim_Cfg.PredictStrength = v end end })
        aimlockGunSection:AddToggle({ Title = "Visibility Check", Default = true,
            Callback = function(v) if W.GunAim_Cfg then W.GunAim_Cfg.VisibilityCheck = v end end })

        local MoonwalkSection = MakeSection(SurvivorTab, "Moonwalk")
        local moonwalkEnabled = false
        local moonwalkConn = nil
        local MOONWALK_SIDE_SPEED = 0.9
        local MOONWALK_BACK_SPEED = 1.2
        local MOONWALK_INTERVAL = 0.07
        local function stopMoonwalk()
            if moonwalkConn then moonwalkConn:Disconnect(); moonwalkConn = nil end
        end
        local function startMoonwalk()
            stopMoonwalk()
            local char = LocalPlayer.Character
            if not char then return end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChildOfClass("Humanoid")
            if not hrp or not hum then return end
            local lastSwitch = 0
            local direction = 1
            moonwalkConn = RunService.RenderStepped:Connect(function()
                if not moonwalkEnabled then return end
                local c = LocalPlayer.Character
                if not c then return end
                local cHrp = c:FindFirstChild("HumanoidRootPart")
                local cHum = c:FindFirstChildOfClass("Humanoid")
                if not cHrp or not cHum or cHum.Health <= 0 then return end
                local now = tick()
                if now - lastSwitch >= MOONWALK_INTERVAL then
                    direction = direction * -1
                    lastSwitch = now
                end
                local back = cHrp.CFrame.LookVector * -MOONWALK_BACK_SPEED
                local side = cHrp.CFrame.RightVector * (direction * MOONWALK_SIDE_SPEED)
                cHum:Move(back + side, false)
            end)
        end
        local function setMoonwalk(state)
            moonwalkEnabled = state
            if state then startMoonwalk() else stopMoonwalk() end
            if getgenv().Gluto_MoonwalkBtn_UpdateVisual then pcall(getgenv().Gluto_MoonwalkBtn_UpdateVisual) end
        end
        local MoonwalkBtnState = { Enabled=false, DragLocked=false, Gui=nil, SavedPos=UDim2.new(0.03,0,0.84,0), Connections={} }
        local MoonwalkFloatingState = CreateFloatingButton({
            id = "Moonwalk", title = "Moonwalk", notifyTitle = "Moonwalk", state = MoonwalkBtnState,
            isOn = function() return moonwalkEnabled end,
            onToggle = function(v) setMoonwalk(v) end, iconRotation = 0,
        })
        getgenv().Gluto_MoonwalkBtn_SetEnabled   = function(en) MoonwalkFloatingState.SetEnabled(en) end
        getgenv().Gluto_MoonwalkBtn_UpdateVisual = function() MoonwalkFloatingState.UpdateVisual() end
        MoonwalkSection:AddToggle({ Title = "Moonwalk", Content = "W424 Original: jalan mundur + geser kiri-kanan. PC: F8",
            Default = false, Keybind = true,
            Callback = function(v) setMoonwalk(v); VD_Notify("Moonwalk", v and "Enabled" or "Disabled", 2) end })
        MoonwalkSection:AddSlider({ Title = "Side Speed", Min = 0.1, Max = 3, Default = 0.9, Increment = 0.1, Callback = function(v) MOONWALK_SIDE_SPEED = v end })
        MoonwalkSection:AddSlider({ Title = "Back Speed", Min = 0.1, Max = 3, Default = 1.2, Increment = 0.1, Callback = function(v) MOONWALK_BACK_SPEED = v end })
        MoonwalkSection:AddSlider({ Title = "Switch Interval", Min = 0.02, Max = 0.5, Default = 0.07, Increment = 0.01, Callback = function(v) MOONWALK_INTERVAL = v end })
        MoonwalkSection:AddToggle({ Title = "Show Moonwalk Floating Button", Default = false, Callback = function(v)
            if getgenv().Gluto_MoonwalkBtn_SetEnabled then getgenv().Gluto_MoonwalkBtn_SetEnabled(v) end
        end })
        UserInputService.InputBegan:Connect(function(input, gp)
            if gp then return end
            if input.KeyCode == Enum.KeyCode.F8 then setMoonwalk(not moonwalkEnabled) end
        end)
        LocalPlayer.CharacterAdded:Connect(function()
            task.wait(2)
            if moonwalkEnabled then startMoonwalk() end
        end)
-- ============ TROLL KILLER ============
local TrollKillerSection = MakeSection(SurvivorTab, "Troll Killer")

-- Helper: cari killer terdekat (yang masih hidup)
local function TK_GetKillerHRP()
    local myChar = LocalPlayer.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    local best, bestDist = nil, math.huge
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and TeamIs(p, "Killer") and p.Character then
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if hrp and hum and hum.Health > 0 then
                local d = myRoot and (hrp.Position - myRoot.Position).Magnitude or 0
                if d < bestDist then bestDist = d; best = hrp end
            end
        end
    end
    return best
end

-- ====== HEAD SIT KILLER ======
local HeadSitEnabled  = false
local HeadSitConn     = nil
local HeadSitOffset   = 2.6

local function TK_HeadSit_Start()
    if HeadSitConn then HeadSitConn:Disconnect() end
    HeadSitConn = RunService.Heartbeat:Connect(function()
        if not HeadSitEnabled then return end
        local myChar = LocalPlayer.Character
        if not myChar then return end
        local myHRP = myChar:FindFirstChild("HumanoidRootPart")
        local myHum = myChar:FindFirstChildOfClass("Humanoid")
        if not myHRP or not myHum or myHum.Health <= 0 then return end
        local kHRP = TK_GetKillerHRP()
        if not kHRP then return end
        pcall(function()
            myHRP.AssemblyLinearVelocity = Vector3.zero
            myHRP.CFrame = kHRP.CFrame * CFrame.new(0, HeadSitOffset, 0)
        end)
    end)
end
local function TK_HeadSit_Stop()
    if HeadSitConn then HeadSitConn:Disconnect(); HeadSitConn = nil end
end

-- ====== FOLLOW BEHIND KILLER ======
local FollowBehindEnabled  = false
local FollowBehindConn     = nil
local FollowBehindDistance = 6
local FollowBehindHeight   = 3

local function TK_FollowBehind_Start()
    if FollowBehindConn then FollowBehindConn:Disconnect() end
    FollowBehindConn = RunService.Heartbeat:Connect(function()
        if not FollowBehindEnabled then return end
        local myChar = LocalPlayer.Character
        if not myChar then return end
        local myHRP = myChar:FindFirstChild("HumanoidRootPart")
        local myHum = myChar:FindFirstChildOfClass("Humanoid")
        if not myHRP or not myHum or myHum.Health <= 0 then return end
        local kHRP = TK_GetKillerHRP()
        if not kHRP then return end
        pcall(function()
            myHRP.AssemblyLinearVelocity = Vector3.zero
            local behindDir = kHRP.CFrame.LookVector * -FollowBehindDistance
            local targetPos = kHRP.Position + behindDir + Vector3.new(0, FollowBehindHeight, 0)
            local lookAt    = kHRP.Position + Vector3.new(0, FollowBehindHeight, 0)
            myHRP.CFrame = CFrame.new(targetPos, lookAt)
        end)
    end)
end
local function TK_FollowBehind_Stop()
    if FollowBehindConn then FollowBehindConn:Disconnect(); FollowBehindConn = nil end
end

TrollKillerSection:AddToggle({
    Title = "Head Sit Killer",
    Content = "Duduk di kepala killer, ikut kemana pun dia pergi",
    Default = false,
    Keybind = true,
    Callback = function(v)
        HeadSitEnabled = v
        if v then TK_HeadSit_Start(); VD_Notify("Troll Killer", "Head Sit: ON", 2)
        else TK_HeadSit_Stop(); VD_Notify("Troll Killer", "Head Sit: OFF", 2) end
    end
})

TrollKillerSection:AddSlider({
    Title = "Head Sit Height",
    Min = 1, Max = 5, Default = 5, Increment = 0.1, Suffix = " studs",
    Callback = function(v) HeadSitOffset = v end
})

TrollKillerSection:AddToggle({
    Title = "Show HeadSit Button",
    Content = "Tampilkan tombol HEADSIT melayang di layar",
    Default = false,
    Callback = function(v)
        if getgenv().Gluto_HeadSitBtn_SetEnabled then
            getgenv().Gluto_HeadSitBtn_SetEnabled(v)
        end
    end
})
TrollKillerSection:AddToggle({
    Title = "Follow Behind Killer",
    Content = "Ikutin killer dari belakang kayak bodyguard",
    Default = false,
    Keybind = true,
    Callback = function(v)
        FollowBehindEnabled = v
        if v then TK_FollowBehind_Start(); VD_Notify("Troll Killer", "Follow Behind: ON", 2)
        else TK_FollowBehind_Stop(); VD_Notify("Troll Killer", "Follow Behind: OFF", 2) end
    end
})

TrollKillerSection:AddSlider({
    Title = "Follow Distance",
    Min = 2, Max = 20, Default = 6, Increment = 1, Suffix = " studs",
    Callback = function(v) FollowBehindDistance = v end
})

TrollKillerSection:AddSlider({
    Title = "Follow Height",
    Min = 0, Max = 10, Default = 3, Increment = 0.5, Suffix = " studs",
    Callback = function(v) FollowBehindHeight = v end
})

-- Restart otomatis saat respawn
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    if HeadSitEnabled then TK_HeadSit_Start() end
    if FollowBehindEnabled then TK_FollowBehind_Start() end
end)

        -- ============ VISUALS TAB ============
        local ESPBox = MakeSection(VisualsTab, "Full ESP System")
        ESPBox:AddToggle({ Title = "ESP Survivor", Default = false, Callback = function(v) FESP.Survivor = v end })
        ESPBox:AddColorPicker({ Title = "Survivor Color", Default = FESPC.Survivor, Save = false, Callback = function(c) FESPC.Survivor = c end })
        ESPBox:AddToggle({ Title = "ESP Killer", Default = false, Callback = function(v) FESP.Killer = v end })
        ESPBox:AddColorPicker({ Title = "Killer Color", Default = FESPC.Killer, Save = false, Callback = function(c) FESPC.Killer = c end })
        ESPBox:AddToggle({ Title = "ESP Generator", Default = false, Callback = function(v) FESP.Generator = v end })
        ESPBox:AddColorPicker({ Title = "Generator Color", Default = FESPC.Generator, Save = false, Callback = function(c) FESPC.Generator = c end })
        ESPBox:AddToggle({ Title = "ESP Pallet", Default = false, Callback = function(v) FESP.Pallet = v end })
        ESPBox:AddColorPicker({ Title = "Pallet Color", Default = FESPC.Pallet, Save = false, Callback = function(c) FESPC.Pallet = c end })
        ESPBox:AddToggle({ Title = "ESP Window", Default = false, Callback = function(v)
            FESP.Window = v
            _G.GlutoWindowScanned = false
        end })
        ESPBox:AddColorPicker({ Title = "Window Color", Default = FESPC.Window, Save = false, Callback = function(c) FESPC.Window = c end })
        ESPBox:AddToggle({ Title = "ESP SCP", Default = false, Callback = function(v) FESP.SCP = v end })
        ESPBox:AddColorPicker({ Title = "SCP Color", Default = FESPC.SCP, Save = false, Callback = function(c) FESPC.SCP = c end })
        ESPBox:AddSlider({ Title = "ESP Radius", Min = 10, Max = 1000, Default = 500, Increment = 10, Callback = function(v) FESP.Distance = v end })

        local ESPStatusBox = MakeSection(VisualsTab, "ESP Status")
        ESPStatusBox:AddToggle({ Title = "Enable Status ESP", Default = false, Callback = function(v) FESPS.Enabled = v end })
        ESPStatusBox:AddToggle({ Title = "Show Name", Default = true, Callback = function(v) FESPS.ShowName = v end })
        ESPStatusBox:AddToggle({ Title = "Show Distance", Default = true, Callback = function(v) FESPS.ShowDistance = v end })
        ESPStatusBox:AddToggle({ Title = "Show Avatar", Default = true, Callback = function(v) FESPS.ShowAvatar = v end })
        ESPStatusBox:AddToggle({ Title = "Show Action", Default = true, Callback = function(v) FESPS.ShowAction = v end })
        ESPStatusBox:AddToggle({ Title = "Show Health Bar", Default = false, Callback = function(v) FESPS.ShowHealth = v end })
        ESPStatusBox:AddSlider({ Title = "Status Radius", Min = 20, Max = 1000, Default = 500, Increment = 10, Callback = function(v) FESPS.Radius = v end })

        local graphicsSection = MakeSection(VisualsTab, "Graphics")
        graphicsSection:AddToggle({ Title = "Fullbright", Default = false, Callback = function(v) W.Graphics.Fullbright = v; W.Graphics_Apply() end })
        graphicsSection:AddToggle({ Title = "No Shadow", Default = false, Callback = function(v) W.Graphics.NoShadow = v; W.Graphics_Apply() end })
        graphicsSection:AddToggle({ Title = "Low Graphics", Default = false, Callback = function(v) W.Graphics.LowGraphics = v; W.Graphics_ApplyOptimization() end })
        graphicsSection:AddToggle({ Title = "No Screen Effects", Default = false, Callback = function(v) W.Graphics.NoScreenEffects = v; W.Graphics_ApplyNoScreenFx() end })
        graphicsSection:AddToggle({ Title = "Clean Sky", Default = false, Callback = function(v) W.Graphics.CleanSky = v; W.Graphics_ApplyOptimization() end })
        graphicsSection:AddToggle({ Title = "Potato Mode", Content = "EXTREME low graphics", Default = false, Callback = function(v)
            if W.Potato_SetEnabled then
                W.Potato_SetEnabled(v)
                if v then VD_Notify("Potato Mode", "Enabled", 3) else VD_Notify("Potato Mode", "Disabled", 3) end
            end
        end })

        local timeSection = MakeSection(VisualsTab, "Clock & Ambient")
        timeSection:AddToggle({ Title = "Enable Clock Override", Default = false, Callback = function(v) W.Graphics.ClockTimeEnabled = v; W.Graphics_Apply() end })
        timeSection:AddSlider({ Title = "Clock Time", Min = 0, Max = 24, Default = 14, Increment = 1, Callback = function(v)
            W.Graphics.ClockTime = v; W.Graphics.ClockTimeEnabled = true; W.Graphics_Apply() end })
        timeSection:AddSlider({ Title = "Brightness", Min = 0, Max = 5, Default = 2, Increment = 0.1, Callback = function(v)
            W.Graphics.Brightness = v; W.Graphics.ClockTimeEnabled = true; W.Graphics_Apply() end })

        local zoomSection = MakeSection(VisualsTab, "Zoom & FOV")
        zoomSection:AddToggle({ Title = "Unlimited Zoom", Default = false, Callback = function(v) W.Graphics.UnlimitedZoom = v; W.Graphics_ApplyZoom() end })
        zoomSection:AddSlider({ Title = "Max Zoom Distance", Min = 100, Max = 5000, Default = 1000, Increment = 50, Callback = function(v)
            W.Graphics.MaxZoomDistance = v; if W.Graphics.UnlimitedZoom then W.Graphics_ApplyZoom() end end })
        zoomSection:AddToggle({ Title = "Custom FOV", Default = false, Callback = function(v) W.Graphics.FOVEnabled = v; W.Graphics_ApplyFOV() end })
        zoomSection:AddSlider({ Title = "Camera FOV", Min = 40, Max = 120, Default = 70, Increment = 5, Callback = function(v)
            W.Graphics.FOV = v; if W.Graphics.FOVEnabled then W.Graphics_ApplyFOV() end end })

        local POVSection = MakeSection(VisualsTab, "Lock POV")
        POVSection:AddToggle({ Title = "Enable Lock POV", Default = false, Callback = function(v) LockPOV_SetEnabled(v); if v then VD_Notify("Lock POV", "Enabled", 2) end end })
        POVSection:AddSlider({ Title = "Locked FOV", Min = 40, Max = 120, Default = 80, Increment = 5,
            Callback = function(v)
                LockPOV.LockedFOV = v
                if LockPOV.Enabled then local cam = Workspace.CurrentCamera; if cam then cam.FieldOfView = v end end
            end })

        -- ============ KILLER TAB ============
        local autoAttackSection = MakeSection(KillerTab, "Auto Attack")
        autoAttackSection:AddToggle({ Title = "Enable Auto Attack", Content = "Auto fire BasicAttack",
            Default = VD.KILLER_AutoAttack, Callback = function(v) VD.KILLER_AutoAttack = v
                if v then VD_Notify("Auto Attack", "Enabled", 2) else VD_Notify("Auto Attack", "Disabled", 2) end
            end })
        autoAttackSection:AddSlider({ Title = "Attack Range", Min = 5, Max = 30, Default = VD.KILLER_AutoAttackRange, Increment = 1, Suffix = " studs", Callback = function(v) VD.KILLER_AutoAttackRange = v end })
        autoAttackSection:AddSlider({ Title = "Attack Cooldown", Min = 0.05, Max = 1, Default = VD.KILLER_AutoAttackCooldown, Increment = 0.05, Suffix = "s", Callback = function(v) VD.KILLER_AutoAttackCooldown = v end })

        local infLungeSection = MakeSection(KillerTab, "Infinite Lunge")
        infLungeSection:AddToggle({
            Title = "Infinite Lunge (Basic Attack)",
            Default = false,
            Callback = function(v)
                VD.KILLER_InfLunge = v
            end
        })

        local veilV1Section = MakeSection(KillerTab, "Silent Veil V1")

        veilV1Section:AddToggle({
            Title = "Enable Silent Veil V1",
            Content = "Ballistic spear aimbot (fixed tracker)",
            Default = VD.VeilEnabled,
            Keybind = true,
            Callback = function(v)
                VD.VeilEnabled = v and true or false
                if getgenv().Gluto_VeilBtn_UpdateVisual then
                    pcall(getgenv().Gluto_VeilBtn_UpdateVisual)
                end
                if v then VD_Notify("Silent Veil V1", "Enabled", 2)
                else
                    VD_Notify("Silent Veil V1", "Disabled", 2)
                    if W.Veil_HideAllVisuals then pcall(W.Veil_HideAllVisuals) end
                end
            end
        })
        veilV1Section:AddToggle({
            Title = "Show FOV Circle",
            Default = VD.VeilShowFOV,
            Callback = function(v) VD.VeilShowFOV = v and true or false end
        })
        veilV1Section:AddToggle({
            Title = "Show Target Tracker",
            Content = "Auto-hide saat target keluar FOV / di belakang camera",
            Default = VD.VeilShowTracker,
            Callback = function(v) VD.VeilShowTracker = v and true or false end
        })
        veilV1Section:AddToggle({
            Title = "Auto Predict",
            Default = VD.VeilAutoPredict,
            Callback = function(v) VD.VeilAutoPredict = v and true or false end
        })
        veilV1Section:AddSlider({
            Title = "FOV Size",
            Min = 50, Max = 500, Default = VD.VeilFOV, Increment = 10,
            Callback = function(v) VD.VeilFOV = v end
        })
        veilV1Section:AddSlider({
            Title = "Max Distance",
            Min = 50, Max = 1000, Default = VD.VeilMaxDist, Increment = 10, Suffix = " studs",
            Callback = function(v) VD.VeilMaxDist = v end
        })
        veilV1Section:AddSlider({
            Title = "Spear Speed",
            Min = 50, Max = 400, Default = VD.VeilSpearSpeed, Increment = 5,
            Callback = function(v) VD.VeilSpearSpeed = v end
        })
        veilV1Section:AddSlider({
            Title = "Spear Gravity",
            Min = 10, Max = 300, Default = VD.VeilGravity, Increment = 1,
            Callback = function(v) VD.VeilGravity = v end
        })
        veilV1Section:AddSlider({
            Title = "Aura Spear Speed",
            Min = 50, Max = 400, Default = VD.VeilAuraSpearSpeed, Increment = 5,
            Callback = function(v) VD.VeilAuraSpearSpeed = v end
        })
        veilV1Section:AddSlider({
            Title = "Aura Spear Gravity",
            Min = 10, Max = 300, Default = VD.VeilAuraSpearGravity, Increment = 1,
            Callback = function(v) VD.VeilAuraSpearGravity = v end
        })
        veilV1Section:AddSlider({
            Title = "Lead Multiplier",
            Min = 0.1, Max = 5, Default = VD.VeilLeadMultiplier, Increment = 0.1,
            Callback = function(v) VD.VeilLeadMultiplier = v end
        })
        veilV1Section:AddToggle({
            Title = "Show Floating Veil Button",
            Content = "Tampilkan tombol VEIL melayang di layar",
            Default = false,
            Callback = function(v)
                if getgenv().Gluto_VeilBtn_SetEnabled then
                    getgenv().Gluto_VeilBtn_SetEnabled(v)
                end
            end
        })

        local AimLockSection = MakeSection(KillerTab, "Aim Lock Hidden")
        local AimLockEnabled = false
        local AimLockThread = nil
        local AimLockAiming = false
        local AimLockHoldKey = Enum.KeyCode.E
        local AimLockMobileHooks = {}
        local function AimLock_GetClosestTarget()
            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if not hrp then return nil end
            local myTeam = LocalPlayer.Team and LocalPlayer.Team.Name or ""
            local myIsKiller = string.find(string.lower(myTeam), "killer", 1, true) ~= nil
            local closestTarget, shortestDist = nil, math.huge
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local targetHrp = player.Character:FindFirstChild("HumanoidRootPart")
                    local hum = player.Character:FindFirstChildOfClass("Humanoid")
                    local playerTeam = player.Team and player.Team.Name or ""
                    local theirIsKiller = string.find(string.lower(playerTeam), "killer", 1, true) ~= nil
                    if targetHrp and hum and hum.Health > 0 then
                        local isEnemy = (myIsKiller and not theirIsKiller) or ((not myIsKiller) and theirIsKiller)
                        if isEnemy then
                            local dist = (targetHrp.Position - hrp.Position).Magnitude
                            if dist < shortestDist then
                                shortestDist, closestTarget = dist, targetHrp
                            end
                        end
                    end
                end
            end
            return closestTarget
        end
        local function AimLock_Start()
            if AimLockThread then task.cancel(AimLockThread) end
            AimLockThread = task.spawn(function()
                while AimLockEnabled do
                    if AimLockAiming then
                        local target = AimLock_GetClosestTarget()
                        if target then
                            pcall(function()
                                Workspace.CurrentCamera.CFrame = CFrame.new(
                                    Workspace.CurrentCamera.CFrame.Position,
                                    target.Position + Vector3.new(0, 2.5, 0)
                                )
                            end)
                        end
                    end
                    task.wait()
                end
            end)
        end
        UserInputService.InputBegan:Connect(function(input, gp)
            if gp or not AimLockEnabled then return end
            if input.UserInputType == Enum.UserInputType.MouseButton2 then AimLockAiming = true end
            if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == AimLockHoldKey then AimLockAiming = true end
        end)
        UserInputService.InputEnded:Connect(function(input)
            if not AimLockEnabled then return end
            if input.UserInputType == Enum.UserInputType.MouseButton2 then AimLockAiming = false end
            if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == AimLockHoldKey then AimLockAiming = false end
        end)
        local function AimLock_DisconnectMobile()
            for _, c in pairs(AimLockMobileHooks) do pcall(function() c:Disconnect() end) end
            AimLockMobileHooks = {}
        end
        local function AimLock_SetupMobile()
            if not UserInputService.TouchEnabled then return end
            AimLock_DisconnectMobile()
            task.spawn(function()
                local pGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
                if not pGui then return end
                local NAMES = {"attack","shoot","fire","basicattack","tembak","hidden","skill","ability","power","skill1","ability1","gui-mob"}
                local function isBtn(obj)
                    if not obj then return false end
                    if not (obj:IsA("GuiButton") or obj:IsA("ImageButton") or obj:IsA("TextButton")) then return false end
                    local l = obj.Name:lower()
                    for _, n in ipairs(NAMES) do
                        if l == n or l:find(n, 1, true) then return true end
                    end
                    return false
                end
                local function hook(btn)
                    if not btn or btn:GetAttribute("AimLockHooked") then return end
                    btn:SetAttribute("AimLockHooked", true)
                    table.insert(AimLockMobileHooks, btn.InputBegan:Connect(function(i)
                        if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
                            if AimLockEnabled then AimLockAiming = true end
                        end
                    end))
                    table.insert(AimLockMobileHooks, btn.InputEnded:Connect(function(i)
                        if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
                            AimLockAiming = false
                        end
                    end))
                    table.insert(AimLockMobileHooks, btn:GetPropertyChangedSignal("Visible"):Connect(function()
                        if not btn.Visible then AimLockAiming = false end
                    end))
                end
                local function scan()
                    for _, ch in ipairs(pGui:GetChildren()) do
                        local ctrl = ch:FindFirstChild("Controls")
                        if ctrl then
                            for _, obj in ipairs(ctrl:GetDescendants()) do
                                if isBtn(obj) then hook(obj) end
                            end
                        end
                    end
                end
                scan()
                table.insert(AimLockMobileHooks, pGui.ChildAdded:Connect(function() task.wait(0.3); scan() end))
            end)
        end
        if UserInputService.TouchEnabled then AimLock_SetupMobile() end
        LocalPlayer.CharacterAdded:Connect(function()
            AimLockAiming = false
            if UserInputService.TouchEnabled then task.wait(2); AimLock_SetupMobile() end
        end)
        AimLockSection:AddToggle({
            Title = "Aim Lock Hidden (Hold)",
            Content = "Tahan M2 / tombol attack → kamera ngunci ke target",
            Default = false,
            Keybind = true,
            Callback = function(state)
                AimLockEnabled = state
                if state then
                    AimLock_Start()
                    VD_Notify("Aim Lock Hidden", "Enabled — Hold M2/E", 2)
                else
                    AimLockAiming = false
                    if AimLockThread then task.cancel(AimLockThread); AimLockThread = nil end
                    VD_Notify("Aim Lock Hidden", "Disabled", 2)
                end
            end
        })
        AimLockSection:AddInput({
            Title = "Hold Keybind",
            Content = "Default: E",
            Default = "E",
            Placeholder = "E / Q / F / LeftShift",
            Callback = function(input)
                input = tostring(input or ""):gsub("%s+", "")
                if input == "" then return end
                local map = {
                    ["leftshift"]=Enum.KeyCode.LeftShift,["rightshift"]=Enum.KeyCode.RightShift,
                    ["leftalt"]=Enum.KeyCode.LeftAlt,["rightalt"]=Enum.KeyCode.RightAlt,
                    ["leftctrl"]=Enum.KeyCode.LeftControl,["rightctrl"]=Enum.KeyCode.RightControl,
                    ["leftcontrol"]=Enum.KeyCode.LeftControl,["rightcontrol"]=Enum.KeyCode.RightControl,
                    ["space"]=Enum.KeyCode.Space,["tab"]=Enum.KeyCode.Tab,
                }
                local newKey = map[input:lower()]
                if not newKey then
                    local ok, kc = pcall(function() return Enum.KeyCode[input:upper():sub(1,1) .. input:lower():sub(2)] end)
                    if ok and kc then newKey = kc end
                end
                if newKey then
                    AimLockHoldKey = newKey
                    VD_Notify("Aim Lock", "Hold key: " .. newKey.Name, 2)
                end
            end
        })

        local aimlockAttackSection = MakeSection(KillerTab, "Aim Lock Attack")
        aimlockAttackSection:AddToggle({
            Title = "Enable Aim Lock Attack",
            Content = "Hold M2 / attack button → camera kunci ke survivor terdekat",
            Default = false, Keybind = true,
            Callback = function(v)
                if W.AttackAim_Cfg then W.AttackAim_Cfg.Enabled = v end
                if v and W.AttackAim_Start then W.AttackAim_Start() end
                if v then VD_Notify("Aim Lock Attack", "Hold M2 to lock", 2) end
            end
        })
        aimlockAttackSection:AddSlider({ Title = "FOV Radius", Min = 50, Max = 1000, Default = 250, Increment = 10,
            Callback = function(v) if W.AttackAim_Cfg then W.AttackAim_Cfg.FOV = v end end })
        aimlockAttackSection:AddSlider({ Title = "Aim Smoothness", Min = 0.1, Max = 1, Default = 1, Increment = 0.05,
            Callback = function(v) if W.AttackAim_Cfg then W.AttackAim_Cfg.Strength = v end end })
        aimlockAttackSection:AddSlider({ Title = "Prediction Strength", Min = 0, Max = 1, Default = 0.12, Increment = 0.01,
            Callback = function(v) if W.AttackAim_Cfg then W.AttackAim_Cfg.PredictStrength = v end end })
        aimlockAttackSection:AddDropdown({ Title = "Aim Part", Options = { "Head", "HumanoidRootPart", "UpperTorso", "Torso" }, Default = "HumanoidRootPart",
            Callback = function(v)
                local val = type(v) == "table" and v[1] or v
                if W.AttackAim_Cfg then W.AttackAim_Cfg.AimPart = val end
            end })
        aimlockAttackSection:AddToggle({ Title = "Visibility Check", Default = true,
            Callback = function(v) if W.AttackAim_Cfg then W.AttackAim_Cfg.VisibilityCheck = v end end })

        local antiBlindSection = MakeSection(KillerTab, "Anti Blind")
        antiBlindSection:AddToggle({
            Title = "Anti Blind (Flashlight)",
            Content = "Block efek pusing dari flashlight survivor",
            Default = false,
            Callback = function(v)
                VD.KILLER_AntiBlind = v
                if v and W.SetupAntiBlind then pcall(W.SetupAntiBlind) end
                if v then VD_Notify("Anti Blind", "Enabled", 2) end
            end
        })

        local destroyPalletSection = MakeSection(KillerTab, "Destroy Pallet")
        destroyPalletSection:AddToggle({
            Title = "Auto Destroy Pallet",
            Content = "Auto hancurkan pallet terdekat (radius 6 studs)",
            Default = false, Keybind = true,
            Callback = function(v)
                VD.KILLER_DestroyPallets = v
                if v then VD_Notify("Destroy Pallet", "Enabled", 2) end
            end
        })

        local maskedSection = MakeSection(KillerTab, "Select Masked Power")
        maskedSection:AddDropdown({ Title = "Masked Power", Options = Masked.Powers, Default = Masked.CurrentPower,
            Callback = function(v)
                local val = type(v) == "table" and v[1] or v
                Masked.CurrentPower = val
                VD_Notify("Select Masked", "Selected: " .. val, 1)
            end })
        maskedSection:AddButton({ Title = "Activate Power", Callback = function() W.Masked_Activate() end })
        maskedSection:AddButton({ Title = "Deactivate Power", Callback = function() W.Masked_Deactivate() end })

        local bypassSection = MakeSection(KillerTab, "Bypass No Cooldown")
        bypassSection:AddToggle({ Title = "Hidden - Leap Bypass", Default = false,
            Callback = function(v) W.BYPASS_SetHiddenLeap(v); if v then VD_Notify("Bypass", "Hidden Leap: ON", 2) end end })
        bypassSection:AddToggle({ Title = "Myers - Infinite Grab", Content = "Hotkey H", Default = false,
            Callback = function(v) W.setMyersGrab(v); if v then VD_Notify("Bypass", "Inf Grab: ON (H)", 2) end end })
        bypassSection:AddToggle({ Title = "Slasher - Infinite LakeMist", Default = false,
            Callback = function(v) W.MAWWW_SetLakeMist(v) end })
        bypassSection:AddToggle({ Title = "Slasher - Infinite Pursuit", Default = false,
            Callback = function(v) W.MAWWW_SetPursuit(v) end })
        bypassSection:AddToggle({ Title = "Abyss - Bypass Cooldown", Default = false,
            Callback = function(v) W.MAWWW_SetAbyssBypass(v) end })
        bypassSection:AddToggle({ Title = "Jeff - Infinite Frenzy", Default = false,
            Callback = function(v) W.MAWWW_SetJeffFrenzy(v) end })
        bypassSection:AddButton({ Title = "Auto-Fix Boolean Math", Callback = function()
            pcall(function()
                local b = true
                local mt = debug.getmetatable(b)
                if not mt then mt = {}; debug.setmetatable(b, mt) end
                if setreadonly then setreadonly(mt, false) end
                mt.__div = function() return 0 end
                mt.__mul = function() return 0 end
                mt.__add = function() return 0 end
                mt.__sub = function() return 0 end
                if setreadonly then setreadonly(mt, true) end
            end)
            ForceNotify("Bypass", "Boolean failsafe applied", 2)
        end })

        local UnlockSkillSection = MakeSection(KillerTab, "Unlock Skill While Carrying")
        if not W.W424_CarryConfig then W.W424_CarryConfig = { Enabled = false, Hooked = false } end
        local CarryCfg = W.W424_CarryConfig
        local function SetupCarryHook()
            if CarryCfg.Hooked then return end
            if typeof(getrawmetatable) ~= "function" then return end
            pcall(function()
                local mt = getrawmetatable(game)
                if setreadonly then setreadonly(mt, false) end
                local oldNamecall = mt.__namecall
                mt.__namecall = newcclosure(function(self, ...)
                    local method = getnamecallmethod()
                    local args = {...}
                    if CarryCfg.Enabled and method == "GetAttribute" and not checkcaller() then
                        if args[1] == "IsCarrying" then return false end
                    end
                    return oldNamecall(self, ...)
                end)
                if setreadonly then setreadonly(mt, true) end
                CarryCfg.Hooked = true
            end)
        end
        UnlockSkillSection:AddToggle({
            Title = "Unlock Skill While Carrying",
            Content = "Bisa pakai skill killer walaupun sedang ngangkat survivor",
            Default = false,
            Callback = function(v)
                CarryCfg.Enabled = v
                if v then SetupCarryHook(); VD_Notify("Unlock Carry", "Enabled", 2)
                else VD_Notify("Unlock Carry", "Disabled", 2) end
            end
        })

        local spearSection = MakeSection(KillerTab, "Spear Aimbot")
        spearSection:AddToggle({ Title = "Enable Spear Aimbot", Content = "Auto-aim spear ke survivor",
            Default = VD.SPEAR_Aimbot, Callback = function(v)
                W.SpearAimbot_SetEnabled(v)
                if v then VD_Notify("Spear Aimbot", "Enabled", 2) else VD_Notify("Spear Aimbot", "Disabled", 2) end
            end })
        spearSection:AddSlider({ Title = "Spear Gravity", Min = 10, Max = 200, Default = VD.SPEAR_Gravity, Increment = 1, Callback = function(v) W.SpearAimbot_SetGravity(v) end })
        spearSection:AddSlider({ Title = "Spear Speed", Min = 50, Max = 300, Default = VD.SPEAR_Speed, Increment = 5, Callback = function(v) W.SpearAimbot_SetSpeed(v) end })

        local killerAbilitySection = MakeSection(KillerTab, "Killer Abilities")
        killerAbilitySection:AddToggle({ Title = "Auto Stalk (Myers)", Default = KA.AutoStalk, Callback = function(v)
            W.KA_SetAutoStalk(v); VD_Notify("Auto Stalk", v and "Enabled" or "Disabled", 2) end })
        killerAbilitySection:AddSlider({ Title = "Auto Stalk Range", Min = 20, Max = 500, Default = KA.AutoStalkRange, Increment = 10, Suffix = " studs", Callback = function(v) KA.AutoStalkRange = v; VD.KA_AutoStalkRange = v end })
        killerAbilitySection:AddToggle({ Title = "Auto Kill All", Default = KA.AutoKillAll, Callback = function(v)
            W.KA_SetAutoKillAll(v); VD_Notify("Auto Kill All", v and "Enabled" or "Disabled", 2) end })
        killerAbilitySection:AddToggle({ Title = "Drop All Pallet", Default = KA.DropAllPallet, Callback = function(v)
            W.KA_SetDropAllPallet(v); VD_Notify("Drop All Pallet", v and "Enabled" or "Disabled", 2) end })
        killerAbilitySection:AddToggle({ Title = "Block All Vault", Default = KA.BlockAllVault, Callback = function(v)
            W.KA_SetBlockAllVault(v); VD_Notify("Block All Vault", v and "Enabled" or "Disabled", 2) end })
        killerAbilitySection:AddButton({ Title = "Instant Auto Kill (1x)", Callback = function()
            local saved = KA.AutoKillAll; KA.AutoKillAll = true
            task.spawn(function() task.wait(0.3); KA.AutoKillAll = saved end)
            VD_Notify("Auto Kill", "Triggered once", 2)
        end })
        killerAbilitySection:AddButton({ Title = "Instant Drop All Pallet (1x)", Callback = function()
            lastDropAllPallet = 0; pcall(W.KA_DropAllPallets)
        end })
        killerAbilitySection:AddButton({ Title = "Instant Block All Vault (1x)", Callback = function()
            lastBlockVault = 0; pcall(W.KA_BlockAllVaults)
        end })
        killerAbilitySection:AddButton({ Title = "Unblock All Vault (1x)", Callback = function()
            local VaultCompleteEvent = ReplicatedStorage:FindFirstChild("Remotes")
                and ReplicatedStorage.Remotes:FindFirstChild("Window")
                and ReplicatedStorage.Remotes.Window:FindFirstChild("VaultCompleteEvent")
            if not VaultCompleteEvent then return end
            local count = 0
            local map = workspace:FindFirstChild("Map"); if not map then return end
            for _, trigger in ipairs(map:GetDescendants()) do
                if trigger.Name == "VaultPointInUse" then
                    local vaultParent = trigger.Parent
                    if vaultParent then
                        pcall(function()
                            VaultCompleteEvent:FireServer(vaultParent, false)
                            count = count + 1
                        end)
                    end
                end
            end
            ForceNotify("Block Vault", "Unblock " .. count .. " vaults!", 3)
        end })
        killerAbilitySection:AddToggle({ Title = "Auto Hook", Content = "Auto carry & hook downed survivor",
            Default = false, Keybind = true,
            Callback = function(v)
                if W.KA_SetAutoHook then W.KA_SetAutoHook(v) end
                if v then VD_Notify("Auto Hook", "Enabled", 2) else VD_Notify("Auto Hook", "Disabled", 2) end
            end })

        local counterParrySection = MakeSection(KillerTab, "Counter Parry")
        counterParrySection:AddToggle({
            Title = "Counter Auto Parry",
            Content = "Spam parry anim pas dekat survivor → burn cooldown dagger mereka",
            Default = false,
            Keybind = true,
            Callback = function(v)
                W.CounterParry_SetEnabled(v)
                if v then VD_Notify("Counter Parry", "Enabled", 2)
                else VD_Notify("Counter Parry", "Disabled", 2) end
            end
        })

        local perksDisplaySection = MakeSection(SurvivorTab, "Killer Perks Display")
        perksDisplaySection:AddToggle({
            Title = "Enable Killer Perks Display",
            Content = "Floating GUI showing killer perks",
            Default = false,
            Callback = function(v)
                if W.KillerPerksDisplay_SetEnabled then W.KillerPerksDisplay_SetEnabled(v) end
                if v then VD_Notify("Killer Perks Display", "Enabled", 2)
                else VD_Notify("Killer Perks Display", "Disabled", 2) end
            end
        })

        local flaskSection = MakeSection(KillerTab, "Silent Flask (The Cure)")
        flaskSection:AddToggle({ Title = "Enable Silent Flask", Default = VD.FLASK_SilentAim, Callback = function(v)
            W.Flask_SetEnabled(v)
            if v then VD_Notify("Silent Flask", "Enabled", 2) else VD_Notify("Silent Flask", "Disabled", 2) end
        end })
        flaskSection:AddToggle({ Title = "Show Beam", Default = VD.FLASK_ShowBeam, Callback = function(v) VD.FLASK_ShowBeam = v and true or false end })
        flaskSection:AddToggle({ Title = "Show Landing Marker", Default = VD.FLASK_ShowLanding, Callback = function(v) VD.FLASK_ShowLanding = v and true or false end })
        flaskSection:AddToggle({ Title = "Enable Prediction", Default = VD.FLASK_Predict, Callback = function(v) VD.FLASK_Predict = v and true or false end })
        flaskSection:AddColorPicker({ Title = "Beam Color", Default = VD.FLASK_BeamColor, Save = false, Callback = function(c) W.Flask_SetBeamColor(c) end })
        flaskSection:AddColorPicker({ Title = "Accent Color", Default = VD.FLASK_AccentColor, Save = false, Callback = function(c) W.Flask_SetAccentColor(c) end })
        flaskSection:AddSlider({ Title = "Flask Speed", Min = 30, Max = 200, Default = VD.FLASK_Speed, Increment = 5, Callback = function(v) W.Flask_SetSpeed(v) end })
        flaskSection:AddSlider({ Title = "Flask Gravity", Min = 50, Max = 400, Default = VD.FLASK_Gravity, Increment = 5, Callback = function(v) W.Flask_SetGravity(v) end })
        flaskSection:AddSlider({ Title = "Lead Multiplier", Min = 0, Max = 3, Default = VD.FLASK_LeadMult, Increment = 0.1, Callback = function(v) W.Flask_SetLead(v) end })
        flaskSection:AddSlider({ Title = "Max Range", Min = 50, Max = 500, Default = VD.FLASK_Range, Increment = 10, Suffix = " studs", Callback = function(v) W.Flask_SetRange(v) end })

        local dashLockSection = MakeSection(KillerTab, "Dash Lock")
        dashLockSection:AddToggle({ Title = "Enable Dash Lock", Content = "Auto-lock camera saat pakai dash",
            Default = VD.DashLockEnabled, Callback = function(v)
                W.DashLock_SetEnabled(v)
                if v then VD_Notify("Dash Lock", "Enabled", 2) else VD_Notify("Dash Lock", "Disabled", 2) end
            end })
        dashLockSection:AddSlider({ Title = "Lock Duration", Min = 0.5, Max = 5, Default = VD.DashLockDuration, Increment = 0.1, Suffix = "s", Callback = function(v) VD.DashLockDuration = v end })
        dashLockSection:AddSlider({ Title = "Camera Smoothness", Min = 0.05, Max = 1, Default = VD.DashLockSmoothness, Increment = 0.05, Callback = function(v) VD.DashLockSmoothness = v end })
        dashLockSection:AddToggle({ Title = "Freeze Character During Lock", Default = VD.FreezeDuringDashLock, Callback = function(v)
            VD.FreezeDuringDashLock = v and true or false
            if not v then
                local char = LocalPlayer.Character
                local hum = char and char:FindFirstChildOfClass("Humanoid")
                if hum and hum.WalkSpeed == 0 then hum.WalkSpeed = 16 end
            end
        end })

        -- ============ MISC TAB ============
        local settingsSection = MakeSection(MiscTab, "Settings")
        settingsSection:AddToggle({ Title = "Enable Notifications", Default = true, Callback = function(v)
            W.NotifyEnabled = v
            if v then ForceNotify("Settings", "Notifications Enabled") end
        end })

        --== MUSIC PLAYER ==--
        local MusicPlayerSongs = {
    ["Sound 1"]              = "90089940136467",
    ["Sound 2"]              = "139197283079137",
    ["Sound 3"]              = "105107170823684",
    ["Sound 4"]              = "76767355656506",
    ["Sound 5"]              = "109627753619575",
    ["Sound 6"]              = "138061809475625",
    ["Sound 7"]              = "83768816338009",
    ["Sound 8"]              = "136708860877320",
    ["Suatu Yg Sempurna"]    = "113639353301886",
    ["CRY FOR ME FUNK"]      = "125230341990848",
    ["No On Noticed"]        = "135609653444873",
    ["Stop it"]              = "72140400888980",
    ["Jangan Pura²"]         = "96568301359656",
    ["Teruskan atau lanjutkan"] = "125097664530702",
    ["Baby Rap A"]           = "1847418280",
    ["Absurd Sound"]         = "112088206507457",
    ["Sweat ice cream"]      = "73450908453508",
    ["Mamak muda"]           = "134073539670673",
    ["Sakit tapi ku rindu"]  = "116986630959929",
}
        getgenv().GlutoMusicPlayer = getgenv().GlutoMusicPlayer or {
            Sound = nil, CurrentId = nil, SelectedName = "Sound 1",
            CustomId = "", Volume = 1.5, Looped = true
        }
        local MP = getgenv().GlutoMusicPlayer

        local function MusicPlayer_Stop()
            if MP.Sound then
                pcall(function() MP.Sound:Stop(); MP.Sound:Destroy() end)
                MP.Sound = nil
                MP.CurrentId = nil
            end
        end
        local function MusicPlayer_Play(id)
            MusicPlayer_Stop()
            if not id or tostring(id) == "" then
                ForceNotify("Music Player", "ID kosong!", 2); return
            end
            local ok, snd = pcall(function()
                local s = Instance.new("Sound")
                s.Name = "GlutoMusicPlayer"
                s.SoundId = "rbxassetid://" .. tostring(id)
                s.Volume = MP.Volume or 1.5
                s.Looped = MP.Looped ~= false
                s.Parent = SoundService
                s:Play()
                return s
            end)
            if not ok or not snd then
                ForceNotify("Music Player", "Gagal play (ID invalid?)", 2); return
            end
            MP.Sound = snd
            MP.CurrentId = tostring(id)
            ForceNotify("Music Player", "▶ Playing: " .. tostring(id), 2)
        end
        task.spawn(function()
            if MP.Sound then pcall(function() MP.Sound:Stop(); MP.Sound:Destroy() end); MP.Sound = nil end
        end)

        local musicSection = MakeSection(MiscTab, "Music Player")
        musicSection:AddParagraph({
            Title = "Music Player",
            Content = "Pilih lagu preset dari dropdown, atau pakai Custom ID Roblox audio."
        })
        musicSection:AddDropdown({
    Title = "Pilih Lagu",
    Options = {
        "Sound 1", "Sound 2", "Sound 3", "Sound 4",
        "Sound 5", "Sound 6", "Sound 7", "Sound 8",
        "Suatu Yg Sempurna", "CRY FOR ME FUNK",
        "No On Noticed", "Stop it", "Jangan Pura²",
        "Teruskan atau lanjutkan", "Baby Rap A",
        "Absurd Sound", "Sweat ice cream",
        "Mamak muda", "Sakit tapi ku rindu"
    },
            Default = MP.SelectedName,
            Flag = "Misc_MusicPlayer_SelectedSong",
            Callback = function(v)
                local val = type(v) == "table" and v[1] or v
                MP.SelectedName = val or "Sound 1"
            end
        })
        musicSection:AddButton({
            Title = "▶ Play Selected Song",
            Callback = function()
                local id = MusicPlayerSongs[MP.SelectedName]
                if not id then ForceNotify("Music Player", "Lagu gak ditemukan", 2); return end
                MusicPlayer_Play(id)
            end
        })
        musicSection:AddButton({
            Title = "■ Stop Music",
            Callback = function()
                MusicPlayer_Stop()
                ForceNotify("Music Player", "■ Stopped", 2)
            end
        })
        local customMusicInput = musicSection:AddInput({
            Title = "Custom Sound ID",
            Placeholder = "contoh: 90089940136467",
            Default = MP.CustomId,
            Flag = "Misc_MusicPlayer_CustomId",
            Callback = function(text) MP.CustomId = tostring(text or "") end
        })
        musicSection:AddButton({
            Title = "▶ Play Custom ID",
            Callback = function()
                local id = customMusicInput:Get()
                if not id or id == "" then ForceNotify("Music Player", "Masukin ID dulu!", 2); return end
                id = id:gsub("rbxassetid://", ""):gsub("%s+", "")
                MusicPlayer_Play(id)
            end
        })
        musicSection:AddSlider({
            Title = "Volume",
            Min = 0, Max = 10, Default = MP.Volume or 1.5, Increment = 0.1,
            Flag = "Misc_MusicPlayer_Volume",
            Callback = function(v)
                MP.Volume = v
                if MP.Sound then MP.Sound.Volume = v end
            end
        })
        musicSection:AddToggle({
            Title = "Looped",
            Default = MP.Looped ~= false,
            Flag = "Misc_MusicPlayer_Looped",
            Callback = function(v)
                MP.Looped = v
                if MP.Sound then MP.Sound.Looped = v end
            end
        })
        musicSection:AddParagraph({
            Title = "Daftar Lagu",
            Content = "Sound 1-7 + CRY FOR ME FUNK"
        })

        local stunSection = MakeSection(MiscTab, "Stun Indicator")
        stunSection:AddToggle({ Title = "Enable Stun Indicator", Default = false, Callback = function(v)
            W.SInd_SetEnabled(v); if v then VD_Notify("Stun Indicator", "Enabled", 2) end end })
        stunSection:AddDropdown({ Title = "Stun Sound",
            Options = { "Default", "Clash Royale", "Blash", "Coin", "Kururin Kuru", "Spongebob", "Fahhhh", "Cave", "Aughhh", "Samsung", "iPhone", "Siren" },
            Default = "Default", Callback = function(v)
                local val = type(v) == "table" and v[1] or v
                SInd.SelectedSound = val
                ForceNotify("Stun Indicator", "Sound: " .. val, 2)
            end })
        stunSection:AddToggle({ Title = "Stun Sound Alert", Default = true, Callback = function(v) SInd.SoundEnabled = v end })
        stunSection:AddButton({ Title = "Preview Sound", Callback = function()
            pcall(function()
                local snd = Instance.new("Sound")
                snd.SoundId = "rbxassetid://" .. tostring(SInd_GetActiveSoundId())
                snd.Volume = SInd.SoundVolume or 1.5
                snd.Parent = LocalPlayer:FindFirstChildOfClass("PlayerGui") or Workspace
                snd:Play()
                snd.Ended:Connect(function() pcall(function() snd:Destroy() end) end)
                task.delay(5, function() pcall(function() if snd and snd.Parent then snd:Destroy() end end) end)
            end)
        end })
        stunSection:AddSlider({ Title = "Detect Range", Min = 50, Max = 2000, Default = 500, Increment = 25, Suffix = " studs", Callback = function(v) SInd.Range = v end })
        stunSection:AddSlider({ Title = "Sound Volume", Min = 0, Max = 5, Default = 1.5, Increment = 0.1, Callback = function(v) SInd.SoundVolume = v end })

        local invisSection = MakeSection(MiscTab, "Invisibilty")
        invisSection:AddParagraph({ Title = "Fitur ini bisa Membuat anda tidak terlihat oleh pemain lain kalian tetap bisa interact seperti memperbaiki generator dll", Content = "Real invisibility" })
        invisSection:AddToggle({ Title = "Enable invisibilty", Default = false, Callback = function(v)
            W.Invisible_SetState(v, false)
            if getgenv().Gluto_InvisBtn_UpdateVisual then getgenv().Gluto_InvisBtn_UpdateVisual() end
        end })
        invisSection:AddToggle({ Title = "Show invisibilty Floating Button", Default = false, Callback = function(v)
            if getgenv().Gluto_InvisBtn_SetEnabled then getgenv().Gluto_InvisBtn_SetEnabled(v) end
        end })
        invisSection:AddKeybind({ Title = "Toggle Hotkey", Default = Enum.KeyCode.G, Callback = function(kc)
            W.Invisible_SetHotkey(kc)
            ForceNotify("Invisible", "Hotkey: " .. (kc and kc.Name or "None"), 2)
        end })

        local camDBDSection = MakeSection(MiscTab, "Camera DBD")
        camDBDSection:AddToggle({ Title = "DBD Camera (Smooth Follow)", Default = false, Callback = function(v)
            W.CamDBD_SetSmooth(v); VD_Notify("Camera DBD", v and "Smooth ON" or "Smooth OFF", 2) end })
        camDBDSection:AddSlider({ Title = "Camera Smoothness", Min = 1, Max = 30, Default = 4, Increment = 1, Callback = function(v) W.CamDBD_SetSmoothSpeed(v) end })
        camDBDSection:AddToggle({ Title = "POV Lock", Default = false, Callback = function(v)
            W.CamDBD_SetPOVLock(v); VD_Notify("Camera DBD", v and "POV Lock ON" or "POV Lock OFF", 2) end })
        camDBDSection:AddSlider({ Title = "POV Value", Min = 60, Max = 120, Default = 85, Increment = 1, Suffix = "°", Callback = function(v) W.CamDBD_SetTargetPOV(v) end })
        camDBDSection:AddSlider({ Title = "POV Smoothness", Min = 3, Max = 20, Default = 9, Increment = 1, Callback = function(v) W.CamDBD_SetPOVSmooth(v) end })

        local puSection = MakeSection(MiscTab, "Player Utility")
        puSection:AddToggle({ Title = "Speed Hack", Default = false, Callback = function(v)
            PU.SpeedEnabled = v and true or false
            if not v then
                local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if hum then hum.WalkSpeed = 16 end
            end
            if v then VD_Notify("Player Utility", "Speed Hack ON", 2) end
        end })
        puSection:AddSlider({ Title = "Speed Value", Min = 16, Max = 200, Default = 16, Increment = 1, Callback = function(v) PU.SpeedValue = v end })
        puSection:AddToggle({ Title = "Skip End Screen", Default = false, Callback = function(v)
            PU.SkipEndScreen = v and true or false
            if v then VD_Notify("Player Utility", "Skip End Screen ON", 2) end
        end })
        puSection:AddToggle({ Title = "Shift Lock", Default = false, Callback = function(v)
            PU.ShiftLock = v and true or false
            if not v and PU._shiftLockWasActive then
                local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if hum then pcall(function() hum.AutoRotate = true end) end
                PU._shiftLockWasActive = false
            end
            if v then VD_Notify("Player Utility", "Shift Lock ON", 2) end
        end })
        puSection:AddToggle({ Title = "Hide Survivor Icon", Default = false, Callback = function(v)
            PU.HideSurvivorIcon = v and true or false
            if v then PU_ApplyHideSurvivorIcon() else PU_RestoreSurvivorIcon() end
        end })
        puSection:AddToggle({ Title = "Show Ping & FPS", Default = false, Callback = function(v)
            PU.ShowPingFPS = v and true or false
            if v then
                PU_CreatePingFPS()
                PU._FPS.frames = 0; PU._FPS.last = tick()
                VD_Notify("Player Utility", "Ping & FPS ON", 2)
            elseif PU._pingGui then
                pcall(function() PU._pingGui:Destroy() end)
                PU._pingGui = nil
            end
        end })
        puSection:AddToggle({ Title = "Hide Name", Default = false, Callback = function(v)
            PU_SetHideName(v); if v then VD_Notify("Player Utility", "Hide Name ON", 2) end
        end })
        puSection:AddToggle({ Title = "Unlimited Zoom", Default = false, Callback = function(v)
            PU.UnlimitedZoom = v and true or false
            if not v then
                pcall(function()
                    LocalPlayer.CameraMaxZoomDistance = 128
                    LocalPlayer.CameraMinZoomDistance = 0.5
                end)
            end
        end })
        puSection:AddToggle({ Title = "Noclip", Default = false, Callback = function(v)
            PU.Noclip = v and true or false
            if not v then PU_RestoreNoclip() end
            if v then VD_Notify("Player Utility", "Noclip ON", 2) end
        end })

        local sbSection = MakeSection(MiscTab, "Speed Boost")
        sbSection:AddToggle({
            Title = "Enable Speed Boost",
            Content = "Auto-apply WalkSpeed, disabled saat stun/attack/downed",
            Default = false,
            Keybind = true,
            Callback = function(v)
                if W.SpeedBoost_SetEnabled then W.SpeedBoost_SetEnabled(v) end
                if v then VD_Notify("Speed Boost", "Enabled", 2)
                else VD_Notify("Speed Boost", "Disabled", 2) end
            end
        })
        sbSection:AddSlider({
            Title = "Speed Value",
            Min = 16, Max = 100, Default = 30, Increment = 1,
            Callback = function(v) if W.SpeedBoost_SetValue then W.SpeedBoost_SetValue(v) end end
        })

        local cursorSection = MakeSection(MiscTab, "Cursor Feature")
        cursorSection:AddParagraph({
            Title = "Cursor Unlock",
            Content = "Unlock cursor & disable auto-rotate. Hotkey: Left/Right Alt"
        })
        cursorSection:AddToggle({
            Title = "Enable Cursor Unlock",
            Content = "Show cursor & disable camera auto-rotate (ALT toggle)",
            Default = false,
            Keybind = true,
            Callback = function(v)
                if W.Cursor_SetEnabled then W.Cursor_SetEnabled(v) end
                if v then VD_Notify("Cursor Unlock", "Enabled", 2)
                else VD_Notify("Cursor Unlock", "Disabled", 2) end
            end
        })
        cursorSection:AddButton({
            Title = "Toggle Cursor Now",
            Content = "Quick toggle without unchecking",
            Callback = function()
                if W.Cursor_SetEnabled then W.Cursor_SetEnabled(not VD.CursorEnabled) end
                VD_Notify("Cursor Unlock", VD.CursorEnabled and "ON" or "OFF", 2)
            end
        })

        local jerkSection = MakeSection(MiscTab, "Jerk Off")
        jerkSection:AddParagraph({
            Title = "Jerk Off Tool",
            Content = "Tool dengan animasi & tooltip meme. Equip buat mulai."
        })
        jerkSection:AddToggle({
            Title = "Enable Jerk Off Tool",
            Content = "Auto-spawn tool Jerk Off ke Backpack",
            Default = false,
            Keybind = true,
            Callback = function(v)
                W.JerkOff_SetEnabled(v)
                if v then VD_Notify("Jerk Off", "Tool spawned!", 2)
                else VD_Notify("Jerk Off", "Tool removed", 2) end
            end
        })

        local emoteSection = MakeSection(MiscTab, "Emote")
        emoteSection:AddToggle({ Title = "Enable Emote", Default = false, Callback = function(v)
            W.EmoteSystem_SetEnabled(v)
            if v then VD_Notify("Emote", "Playing: " .. W.EmoteSystem.SelectedEmote, 2)
            else VD_Notify("Emote", "Stopped", 2) end
        end })
        emoteSection:AddDropdown({ Title = "Select Emote", Options = W.EmoteSystem.Options, Default = "Friday Night", Multi = false,
            Callback = function(v)
                local val = type(v) == "table" and v[1] or v
                W.EmoteSystem_SelectEmote(val or "Friday Night")
                VD_Notify("Emote", "Selected: " .. W.EmoteSystem.SelectedEmote, 2)
            end })
        emoteSection:AddButton({ Title = "Stop Emote", Callback = function()
            W.EmoteSystem_Stop(); W.EmoteSystem.Enabled = false; VD_Notify("Emote", "Stopped", 2)
        end })
        emoteSection:AddButton({ Title = "Replay Current Emote", Callback = function()
            if not W.EmoteSystem.Enabled then VD_Notify("Emote", "Enable dulu!", 2); return end
            W.EmoteSystem_Play()
            VD_Notify("Emote", "Replaying: " .. W.EmoteSystem.SelectedEmote, 2)
        end })

        local FakeAvatarSection = MakeSection(MiscTab, "Fake Avatar")
        local FakeAvatarEnabled = false
        local SelectedFakeAva = LocalPlayer.UserId
        local function LoadAppearanceIntoChar(appearance, character, head)
            local items = appearance:GetChildren()
            local function applyMesh(obj)
                if obj:IsA("CharacterMesh") or obj:IsA("BodyColors") or obj:IsA("Shirt") or obj:IsA("Pants") then
                    local existing = character:FindFirstChild(obj.Name)
                    if existing and existing.ClassName == obj.ClassName then existing:Destroy() end
                    obj:Clone().Parent = character
                end
            end
            for _, item in pairs(items) do
                if item:IsA("Folder") or item:IsA("Model") then
                    for _, subItem in pairs(item:GetChildren()) do applyMesh(subItem) end
                else applyMesh(item) end
            end
            for _, item in pairs(items) do
                if item:IsA("SpecialMesh") and head then
                    local targetMesh = head:FindFirstChildOfClass("SpecialMesh") or Instance.new("SpecialMesh", head)
                    targetMesh.MeshType = Enum.MeshType.FileMesh
                    targetMesh.MeshId = item.MeshId
                    targetMesh.TextureId = item.TextureId
                elseif item:IsA("Decal") and item.Name == "face" and head then
                    if head:FindFirstChild("face") then head.face:Destroy() end
                    item:Clone().Parent = head
                end
            end
            for _, item in pairs(items) do
                if item:IsA("Accessory") then
                    local clone = item:Clone()
                    local handle = clone:FindFirstChild("Handle")
                    if handle then
                        local att = handle:FindFirstChildOfClass("Attachment")
                        if att then
                            local targetAtt = character:FindFirstChild(att.Name, true)
                            if targetAtt then
                                local weld = Instance.new("Weld")
                                weld.Part0 = handle; weld.Part1 = targetAtt.Parent
                                weld.C0 = att.CFrame; weld.C1 = targetAtt.CFrame
                                weld.Parent = handle
                            end
                        end
                        handle.CanCollide = false; handle.Massless = true; clone.Parent = character
                    end
                end
            end
        end
        local function ApplyFakeAvatar()
            local character = LocalPlayer.Character
            if not character or not SelectedFakeAva then return end
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if not humanoid then return end
            task.spawn(function()
                local success, appearance = pcall(function()
                    return game:GetService("Players"):GetCharacterAppearanceAsync(SelectedFakeAva)
                end)
                if not success or not appearance then warn("[FakeAvatar] Gagal load data avatar!"); return end
                for _, obj in pairs(character:GetChildren()) do
                    if obj:IsA("Accessory") or obj:IsA("Shirt") or obj:IsA("Pants")
                    or obj:IsA("BodyColors") or obj:IsA("CharacterMesh") or obj:IsA("ShirtGraphic") then
                        obj:Destroy()
                    end
                end
                local head = character:FindFirstChild("Head")
                if head then
                    for _, hObj in pairs(head:GetChildren()) do
                        if hObj:IsA("SpecialMesh") or hObj:IsA("Decal") then hObj:Destroy() end
                    end
                    local m = Instance.new("SpecialMesh", head)
                    m.MeshType = Enum.MeshType.Head; m.Scale = Vector3.new(1, 1, 1)
                end
                local scaleDefaults = { BodyDepthScale = 1, BodyHeightScale = 1, BodyWidthScale = 1, HeadScale = 1, BodyTypeScale = 0, BodyProportionScale = 0 }
                for scaleName, val in pairs(scaleDefaults) do
                    local s = humanoid:FindFirstChild(scaleName); if s then s.Value = val end
                end
                task.wait(0.1)
                LoadAppearanceIntoChar(appearance, character, head)
                pcall(function()
                    local info = game:GetService("Players"):GetCharacterAppearanceInfoAsync(SelectedFakeAva)
                    if head and info.assets then
                        for _, asset in pairs(info.assets) do
                            if asset.assetType.name == "Face" then
                                if head:FindFirstChild("face") then head.face:Destroy() end
                                local f = Instance.new("Decal", head)
                                f.Name = "face"; f.Texture = "rbxassetid://" .. asset.id
                                break
                            end
                        end
                    end
                end)
            end)
        end
        FakeAvatarSection:AddDropdown({ Title = "Fake Avatar Preset",
            Options = { "Self Avatar", "Random 1", "Random 2", "Random 3", "Random 4", "Random 5", "Random 6", "Random 7",
                "WoozyNate", "Nicholas", "yvlyf", "traevp", "J0LLY", "LucashDev", "CEOofIsaac", "Stealthy", "Wildes", "Talon",
                "Relukt", "Sammy", "Diesel", "S4ans03", "Aura", "iJava", "White Guy", "Purple King", "Kachaaaa Gay", "Mpruyyy" },
            Default = "Self Avatar",
            Callback = function(option)
                local ids = {
                    ["Self Avatar"] = LocalPlayer.UserId, ["Random 1"] = 2888298851, ["Random 2"] = 10074747755,
                    ["Random 3"] = 5209567453, ["Random 4"] = 8991982843, ["Random 5"] = 5796319029, ["Random 6"] = 9744452117,
                    ["Random 7"] = 8476755006, ["WoozyNate"] = 146089324, ["Nicholas"] = 909635, ["yvlyf"] = 181751703,
                    ["traevp"] = 471607078, ["J0LLY"] = 1073847038, ["LucashDev"] = 2525651744, ["CEOofIsaac"] = 63238912,
                    ["Stealthy"] = 56602747, ["Wildes"] = 40397833, ["Talon"] = 75974130, ["Relukt"] = 65042011,
                    ["Sammy"] = 2678001507, ["Diesel"] = 9123921576, ["S4ans03"] = 35439794, ["Aura"] = 2275806428,
                    ["iJava"] = 276557820, ["White Guy"] = 8843268357, ["Purple King"] = 9070758608,
                    ["Kachaaaa Gay"] = 8956318334, ["Mpruyyy"] = 8340163775
                }
                SelectedFakeAva = ids[option] or LocalPlayer.UserId
                if FakeAvatarEnabled then ApplyFakeAvatar() end
            end })
        FakeAvatarSection:AddToggle({ Title = "Enable Fake Avatar", Default = false, Keybind = true, Callback = function(state)
            FakeAvatarEnabled = state
            if state then ApplyFakeAvatar() end
        end })
        local UsernameInput = ""
        FakeAvatarSection:AddInput({ Title = "Fake Avatar Via Username", Placeholder = "username (tanpa @)",
            Callback = function(input) UsernameInput = (input or ""):gsub("^@", "") end })
        FakeAvatarSection:AddButton({ Title = "Apply From Username", Callback = function()
            if UsernameInput == "" then ForceNotify("Fake Avatar", "Masukkan username dulu!", 2); return end
            local ok, userId = pcall(function() return game:GetService("Players"):GetUserIdFromNameAsync(UsernameInput) end)
            if not ok or not userId then ForceNotify("Fake Avatar", "Username tidak ditemukan: " .. UsernameInput, 2); return end
            SelectedFakeAva = userId
            ApplyFakeAvatar()
            ForceNotify("Fake Avatar", "Applied: @" .. UsernameInput, 2)
        end })
        LocalPlayer.CharacterAdded:Connect(function()
            if FakeAvatarEnabled then task.wait(1); ApplyFakeAvatar() end
        end)

        local KorlessSection = MakeSection(MiscTab, "Fake Korless")
        local KorlessMorph = { Enabled = false, Connection = nil }
        local function ApplyKorless()
            local plr = LocalPlayer
            local function Morph()
                repeat task.wait() until plr.Character
                    and plr.Character:FindFirstChild("HumanoidRootPart")
                    and plr.Character:FindFirstChild("Right Leg")
                task.wait(0.1)
                local char = plr.Character
                pcall(function()
                    char.Head.Transparency = 1
                    local face = char.Head:FindFirstChild("face")
                    if face then face:Destroy() end
                    char["Right Leg"].Transparency = 1
                    local old = char:FindFirstChild("KorlessHead")
                    if old then old:Destroy() end
                    local mesh = Instance.new("MeshPart")
                    mesh.Name = "KorlessHead"
                    mesh.Size = Vector3.new(1.5, 1.5, 1.5)
                    mesh.CanCollide = false
                    mesh.MeshId = "rbxassetid://902942096"
                    mesh.TextureID = "rbxassetid://902843398"
                    mesh.CFrame = char["Right Leg"].CFrame * CFrame.new(0, 0.5, 0)
                    mesh.Parent = char
                    local weld = Instance.new("WeldConstraint")
                    weld.Part0 = char["Right Leg"]
                    weld.Part1 = mesh
                    weld.Parent = mesh
                end)
            end
            Morph()
            if KorlessMorph.Connection then KorlessMorph.Connection:Disconnect() end
            KorlessMorph.Connection = plr.CharacterAdded:Connect(function()
                task.wait(1)
                Morph()
            end)
        end
        local function RemoveKorless()
            local char = LocalPlayer.Character
            if char then
                local mesh = char:FindFirstChild("KorlessHead")
                if mesh then mesh:Destroy() end
                if char:FindFirstChild("Head") then char.Head.Transparency = 0 end
                if char:FindFirstChild("Right Leg") then char["Right Leg"].Transparency = 0 end
            end
            if KorlessMorph.Connection then
                KorlessMorph.Connection:Disconnect()
                KorlessMorph.Connection = nil
            end
        end
        KorlessSection:AddToggle({
            Title = "Korless Morph",
            Content = "Ganti kepala jadi Korless (mesh ditaruh di kaki kanan)",
            Default = false,
            Callback = function(v)
                KorlessMorph.Enabled = v
                if v then
                    ApplyKorless()
                    VD_Notify("Korless Morph", "Enabled", 2)
                else
                    RemoveKorless()
                    VD_Notify("Korless Morph", "Disabled", 2)
                end
            end
        })

        local HeaderSection = MakeSection(MiscTab, "Header Title")
        local HeaderEnabled = false
        local HeaderText = "ALFzxzzz"
        local HeaderState = { Billboard = nil, TextLabel = nil, ShineLabel = nil, ShineGradient = nil, SizeConnection = nil }
        local BASE_WIDTH = isMobile and 90 or 140
        local BASE_HEIGHT = isMobile and 20 or 32
        local BASE_DISTANCE = 12
        local MIN_SCALE = 0.6
        local MAX_SCALE = isMobile and 1.1 or 1.4
        local function Header_Create()
            if HeaderState.Billboard then HeaderState.Billboard:Destroy() end
            local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            if not character:FindFirstChild("Head") then return end
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "GlutoHeaderBillboard"
            billboard.Adornee = character.Head
            billboard.Size = UDim2.new(0, BASE_WIDTH, 0, BASE_HEIGHT)
            billboard.StudsOffset = Vector3.new(0, 1.5, 0)
            billboard.AlwaysOnTop = true; billboard.LightInfluence = 0
            billboard.Parent = character
            HeaderState.Billboard = billboard
            local textLabel = Instance.new("TextLabel")
            textLabel.Name = "BaseText"; textLabel.Size = UDim2.new(1, 0, 1, 0)
            textLabel.BackgroundTransparency = 1; textLabel.TextScaled = true
            textLabel.Font = Enum.Font.GothamBold; textLabel.TextStrokeTransparency = 0.5
            textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            textLabel.TextColor3 = _G.GLUTO_THEME
            textLabel.Text = HeaderText; textLabel.ZIndex = 1; textLabel.Parent = billboard
            HeaderState.TextLabel = textLabel
            local shineLabel = Instance.new("TextLabel")
            shineLabel.Name = "ShineText"; shineLabel.Size = UDim2.new(1, 0, 1, 0)
            shineLabel.BackgroundTransparency = 1; shineLabel.TextScaled = true
            shineLabel.Font = Enum.Font.GothamBold; shineLabel.TextStrokeTransparency = 1
            shineLabel.Text = HeaderText; shineLabel.TextColor3 = _G.GLUTO_THEME
            shineLabel.ZIndex = 2; shineLabel.Parent = billboard
            HeaderState.ShineLabel = shineLabel
            local shineGradient = Instance.new("UIGradient")
            shineGradient.Name = "ShineGradient"; shineGradient.Rotation = 20
            shineGradient.Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0.00, 1), NumberSequenceKeypoint.new(0.30, 1),
                NumberSequenceKeypoint.new(0.42, 0), NumberSequenceKeypoint.new(0.58, 0),
                NumberSequenceKeypoint.new(0.70, 1), NumberSequenceKeypoint.new(1.00, 1),
            })
            shineGradient.Offset = Vector2.new(-1, 0); shineGradient.Parent = shineLabel
            HeaderState.ShineGradient = shineGradient
            if HeaderState.SizeConnection then HeaderState.SizeConnection:Disconnect() end
            HeaderState.SizeConnection = RunService.RenderStepped:Connect(function()
                if not billboard or not billboard.Parent then HeaderState.SizeConnection:Disconnect(); return end
                local head = character:FindFirstChild("Head"); if not head then return end
                local dist = (Workspace.CurrentCamera.CFrame.Position - head.Position).Magnitude
                local scaleFactor = math.clamp(BASE_DISTANCE / dist, MIN_SCALE, MAX_SCALE)
                billboard.Size = UDim2.new(0, BASE_WIDTH * scaleFactor, 0, BASE_HEIGHT * scaleFactor)
            end)
            task.spawn(function()
                while shineLabel and shineLabel.Parent and shineGradient and shineGradient.Parent do
                    shineGradient.Offset = Vector2.new(-1, 0)
                    local tween = TweenService:Create(shineGradient, TweenInfo.new(4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), { Offset = Vector2.new(1, 0) })
                    tween:Play(); tween.Completed:Wait(); task.wait(2)
                end
            end)
        end
        local function Header_UpdateText(text)
            HeaderText = text or "ALFzxzzz"
            if HeaderState.TextLabel then HeaderState.TextLabel.Text = HeaderText end
            if HeaderState.ShineLabel then HeaderState.ShineLabel.Text = HeaderText end
        end
        local function Header_Toggle(enabled)
            if enabled then Header_Create()
            else
                if HeaderState.SizeConnection then HeaderState.SizeConnection:Disconnect(); HeaderState.SizeConnection = nil end
                if HeaderState.Billboard then HeaderState.Billboard:Destroy() end
                HeaderState.Billboard = nil; HeaderState.TextLabel = nil
                HeaderState.ShineLabel = nil; HeaderState.ShineGradient = nil
            end
        end
        HeaderSection:AddInput({ Title = "Header Text", Default = "ALFzxzzz", Placeholder = "Nama header lu...",
            Callback = function(input) Header_UpdateText(input) end })
        HeaderSection:AddToggle({ Title = "Enable Header Title", Default = false, Callback = function(v)
            HeaderEnabled = v; Header_Toggle(v) end })
        HeaderSection:AddColorPicker({ Title = "Header Color", Default = _G.GLUTO_THEME, Save = false,
            Callback = function(c)
                if HeaderState.TextLabel then HeaderState.TextLabel.TextColor3 = c end
                if HeaderState.ShineLabel then HeaderState.ShineLabel.TextColor3 = _G.GLUTO_THEME end
            end })
        LocalPlayer.CharacterAdded:Connect(function()
            task.wait(1)
            if HeaderEnabled then Header_Toggle(true) end
        end)

        local SpecSection = MakeSection(MiscTab, "Spectator Counter")
        local SpecEnabled = false
        local SpecGui = nil
        local SpecLabel = nil
        local SpecThread = nil
        local SpecExpanded = true
        local function Spec_CreateUI()
            if SpecGui then SpecGui:Destroy(); SpecGui = nil end
            local safeParent = SafeGuiParent()
            SpecGui = Instance.new("ScreenGui")
            SpecGui.Name = "GlutoSpectatorCounter"
            SpecGui.ResetOnSpawn = false; SpecGui.IgnoreGuiInset = true
            SpecGui.Parent = safeParent
            local mainFrame = Instance.new("Frame", SpecGui)
            mainFrame.Name = "MainBox"
            mainFrame.AnchorPoint = Vector2.new(0.5, 0)
            mainFrame.Position = UDim2.new(0.5, 0, 0.42, 0)
            mainFrame.Size = UDim2.new(0, 145, 0, 52)
            mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
            mainFrame.BackgroundTransparency = 0.1
            mainFrame.BorderSizePixel = 0; mainFrame.Active = true
            Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 6)
            local topBar = Instance.new("Frame", mainFrame)
            topBar.Name = "TopBar"; topBar.Size = UDim2.new(1, 0, 0, 4)
            topBar.BackgroundColor3 = _G.GLUTO_THEME; topBar.BorderSizePixel = 0
            Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 6)
            local header = Instance.new("Frame", mainFrame)
            header.Name = "Header"; header.Size = UDim2.new(1, 0, 0, 18)
            header.Position = UDim2.new(0, 0, 0, 4)
            header.BackgroundTransparency = 1; header.Active = true
            local title = Instance.new("TextLabel", header)
            title.Name = "Title"; title.Size = UDim2.new(1, -20, 1, 0)
            title.BackgroundTransparency = 1; title.Font = Enum.Font.GothamBold
            title.Text = "Spectators"; title.TextColor3 = _G.GLUTO_THEME
            title.TextSize = 10; title.TextXAlignment = Enum.TextXAlignment.Center
            local minBtn = Instance.new("TextButton", header)
            minBtn.Name = "MinBtn"; minBtn.Size = UDim2.new(0, 18, 0, 18)
            minBtn.Position = UDim2.new(1, -19, 0, 0)
            minBtn.BackgroundTransparency = 1; minBtn.Text = "−"
            minBtn.TextColor3 = _G.GLUTO_THEME; minBtn.Font = Enum.Font.GothamBold
            minBtn.TextSize = 13; minBtn.AutoButtonColor = false
            local divider = Instance.new("Frame", mainFrame)
            divider.Name = "Divider"; divider.Size = UDim2.new(1, -12, 0, 1)
            divider.Position = UDim2.new(0, 6, 0, 23)
            divider.BackgroundColor3 = _G.GLUTO_THEME
            divider.BackgroundTransparency = 0.7; divider.BorderSizePixel = 0
            local body = Instance.new("Frame", mainFrame)
            body.Name = "Body"; body.Size = UDim2.new(1, 0, 1, -25)
            body.Position = UDim2.new(0, 0, 0, 25); body.BackgroundTransparency = 1
            body.ClipsDescendants = true
            local bodyLayout = Instance.new("UIListLayout", body)
            bodyLayout.FillDirection = Enum.FillDirection.Horizontal
            bodyLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
            bodyLayout.VerticalAlignment = Enum.VerticalAlignment.Center
            bodyLayout.Padding = UDim.new(0, 5)
            local eye = Instance.new("ImageLabel", body)
            eye.Name = "EyeIcon"; eye.Size = UDim2.new(0, 13, 0, 13)
            eye.BackgroundTransparency = 1; eye.Image = "rbxassetid://13321848320"
            eye.ImageColor3 = _G.GLUTO_THEME; eye.LayoutOrder = 1
            SpecLabel = Instance.new("TextLabel", body)
            SpecLabel.Name = "CountLabel"; SpecLabel.BackgroundTransparency = 1
            SpecLabel.Font = Enum.Font.GothamMedium; SpecLabel.Text = "No spectators"
            SpecLabel.TextColor3 = Color3.fromRGB(255, 255, 255); SpecLabel.TextSize = 10
            SpecLabel.AutomaticSize = Enum.AutomaticSize.X; SpecLabel.LayoutOrder = 2
            local function setExpanded(state)
                SpecExpanded = state
                if state then
                    mainFrame.Size = UDim2.new(0, 145, 0, 52)
                    divider.Visible = true; body.Visible = true; minBtn.Text = "−"
                else
                    mainFrame.Size = UDim2.new(0, 145, 0, 22)
                    divider.Visible = false; body.Visible = false; minBtn.Text = "+"
                end
            end
            minBtn.MouseButton1Click:Connect(function() setExpanded(not SpecExpanded) end)
            setExpanded(true)
            local dragging, dragStart, startPos = false, nil, nil
            mainFrame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true; dragStart = input.Position; startPos = mainFrame.Position
                end
            end)
            UserInputService.InputChanged:Connect(function(input)
                if not dragging then return end
                if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                    local delta = input.Position - dragStart
                    mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
                end
            end)
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
            end)
        end
        local function Spec_Update()
            if not SpecEnabled or not SpecLabel then return end
            local count = 0
            for _, p in ipairs(Players:GetPlayers()) do
                if p.Team and p.Team.Name == "Spectator" then count = count + 1 end
            end
            if count == 0 then
                SpecLabel.Text = "No spectators"; SpecLabel.TextColor3 = Color3.fromRGB(170, 170, 170)
            else
                SpecLabel.Text = count .. " spectators"; SpecLabel.TextColor3 = _G.GLUTO_THEME
            end
        end
        SpecSection:AddToggle({ Title = "Enable Spectator Counter", Default = false, Callback = function(state)
            SpecEnabled = state
            if SpecThread then task.cancel(SpecThread); SpecThread = nil end
            if state then
                Spec_CreateUI(); Spec_Update()
                SpecThread = task.spawn(function()
                    while SpecEnabled do Spec_Update(); task.wait(1.2) end
                end)
            else
                if SpecGui then SpecGui:Destroy(); SpecGui = nil; SpecLabel = nil end
            end
        end })

        -- ============ CONFIG TAB ============
        do
            local cfgSection = MakeSection(ConfigTab, "Config Manager")
            local currentName = ""
            local selectedConfig = nil
            local configList = nil

            local function ConfigFolderPath() return "Gluto/Config" end
            local function EnsureConfigFolder()
                if isfolder and makefolder then
                    if not isfolder("Gluto") then makefolder("Gluto") end
                    if not isfolder(ConfigFolderPath()) then makefolder(ConfigFolderPath()) end
                end
            end
            EnsureConfigFolder()

            local function RefreshConfigList()
                local list = {}
                if listfiles then
                    EnsureConfigFolder()
                    local ok2, files = pcall(listfiles, ConfigFolderPath())
                    if ok2 and files then
                        for _, f in ipairs(files) do
                            local n = string.match(f, "([^/\\]+)%.json$")
                            if n and n ~= "_autoload" then table.insert(list, n) end
                        end
                    end
                end
                if configList and configList.SetValues then configList:SetValues(list, selectedConfig, true) end
                return list
            end

            local function ApplyConfig(data)
                if type(data) ~= "table" then return 0, 0 end
                local applied, missing = 0, 0
                for k, v in pairs(data) do
                    if k ~= "_version" and k ~= "_autoload" then
                        ConfigData[k] = v
                        if Elements[k] then
                            local ok = pcall(function() Elements[k]:Set(v, false) end)
                            if ok then applied = applied + 1 else missing = missing + 1 end
                        else
                            missing = missing + 1
                        end
                    end
                end
                return applied, missing
            end

            cfgSection:AddInput({
                Title = "Config Name", Placeholder = "MyConfig", Save = false,
                Callback = function(text) currentName = text end
            })

            configList = cfgSection:AddDropdown({
                Title = "Saved Configs", Multi = false, Options = {}, Save = false,
                Callback = function(v) selectedConfig = v end
            })
            task.defer(RefreshConfigList)

            cfgSection:AddButton({
                Title = "💾 Save Config",
                Callback = function()
                    if not currentName or currentName == "" then
                        ForceNotify("Config", "Isi nama config dulu!", 2); return
                    end
                    if not writefile or not HttpService then
                        ForceNotify("Config", "Executor gak support writefile", 2); return
                    end
                    EnsureConfigFolder()
                    local snapshot = {}
                    for k, v in pairs(ConfigData) do snapshot[k] = v end
                    local okEnc, encoded = pcall(function() return HttpService:JSONEncode(snapshot) end)
                    if not okEnc or not encoded then
                        ForceNotify("Config", "Gagal encode JSON", 2); return
                    end
                    local okW = pcall(writefile, ConfigFolderPath() .. "/" .. currentName .. ".json", encoded)
                    if not okW then ForceNotify("Config", "Gagal save (folder/permission)", 2); return end
                    local count = 0
                    for _ in pairs(snapshot) do count = count + 1 end
                    ForceNotify("Config", "Saved: " .. currentName .. " (" .. count .. " keys)", 3)
                    RefreshConfigList()
                end
            })

            cfgSection:AddButton({
                Title = "📂 Load Config",
                Callback = function()
                    if not selectedConfig or selectedConfig == "" then
                        ForceNotify("Config", "Pilih config dulu!", 2); return
                    end
                    if not readfile or not isfile then
                        ForceNotify("Config", "Executor gak support readfile", 2); return
                    end
                    local path = ConfigFolderPath() .. "/" .. selectedConfig .. ".json"
                    if not isfile(path) then
                        ForceNotify("Config", "File gak ketemu", 2); return
                    end
                    local okR, raw = pcall(readfile, path)
                    if not okR or not raw then ForceNotify("Config", "Gagal baca file", 2); return end
                    local okD, dec = pcall(function() return HttpService:JSONDecode(raw) end)
                    if not okD or type(dec) ~= "table" then
                        ForceNotify("Config", "File corrupt / bukan JSON", 2); return
                    end
                    local applied, missing = ApplyConfig(dec)
                    ForceNotify("Config", "Loaded: " .. selectedConfig .. " (" .. applied .. " ok, " .. missing .. " skip)", 3)
                end
            })

            cfgSection:AddButton({
                Title = "🗑 Delete Config",
                Callback = function()
                    if not selectedConfig or selectedConfig == "" then
                        ForceNotify("Config", "Pilih config dulu!", 2); return
                    end
                    local path = ConfigFolderPath() .. "/" .. selectedConfig .. ".json"
                    if isfile and delfile and isfile(path) then
                        pcall(delfile, path)
                        ForceNotify("Config", "Deleted: " .. selectedConfig, 2)
                        selectedConfig = nil
                        RefreshConfigList()
                    else
                        ForceNotify("Config", "Gagal delete / file gak ada", 2)
                    end
                end
            })

            cfgSection:AddButton({
                Title = "🔄 Refresh List",
                Callback = function()
                    RefreshConfigList()
                    ForceNotify("Config", "List refreshed", 2)
                end
            })

            local initAutoLoad = true
            cfgSection:AddToggle({
                Title = "Auto Save", Default = AutoSaveEnabled ~= false, Save = false,
                Callback = function(v)
                    AutoSaveEnabled = v
                    ForceNotify("Config", "Auto Save: " .. (v and "ON" or "OFF"), 2)
                end
            })

            cfgSection:AddToggle({
                Title = "Auto Load on Start", Default = false, Save = false,
                Callback = function(v)
                    if initAutoLoad then return end
                    if v and selectedConfig and selectedConfig ~= "" then
                        if writefile then
                            pcall(writefile, ConfigFolderPath() .. "/_autoload.json",
                                HttpService:JSONEncode({ Name = selectedConfig }))
                            ForceNotify("Config", "Auto Load: " .. selectedConfig, 2)
                        end
                    else
                        if writefile then
                            pcall(writefile, ConfigFolderPath() .. "/_autoload.json",
                                HttpService:JSONEncode({ Name = "" }))
                        end
                        if v then ForceNotify("Config", "Pilih config dulu di dropdown", 2) end
                    end
                end
            })
            initAutoLoad = false

            local importJsonStr = ""
            cfgSection:AddInput({
                Title = "Import JSON (paste di sini)",
                Placeholder = '{"Flag_Name": value, ...}',
                Save = false,
                Callback = function(text) importJsonStr = text end
            })

            cfgSection:AddButton({
                Title = "📥 Import from Input",
                Callback = function()
                    if importJsonStr == "" then ForceNotify("Config", "Paste JSON dulu", 2); return end
                    local okD, dec = pcall(function() return HttpService:JSONDecode(importJsonStr) end)
                    if not okD or type(dec) ~= "table" then ForceNotify("Config", "JSON invalid", 2); return end
                    local applied = ApplyConfig(dec)
                    ForceNotify("Config", "Imported! (" .. applied .. " keys)", 2)
                end,
                SubTitle = "📋 Import from Clipboard",
                SubCallback = function()
                    if not getclipboard then ForceNotify("Config", "Clipboard gak support", 2); return end
                    local clip = getclipboard()
                    if not clip or clip == "" then ForceNotify("Config", "Clipboard kosong", 2); return end
                    local okD, dec = pcall(function() return HttpService:JSONDecode(clip) end)
                    if not okD or type(dec) ~= "table" then ForceNotify("Config", "JSON invalid", 2); return end
                    local applied = ApplyConfig(dec)
                    ForceNotify("Config", "Imported from clipboard! (" .. applied .. " keys)", 2)
                end
            })

            cfgSection:AddButton({
                Title = "📤 Export to Clipboard",
                Callback = function()
                    if not setclipboard then ForceNotify("Config", "Clipboard gak support", 2); return end
                    local snapshot = {}
                    for k, v in pairs(ConfigData) do snapshot[k] = v end
                    local okE, encoded = pcall(function() return HttpService:JSONEncode(snapshot) end)
                    if okE and encoded then
                        setclipboard(encoded)
                        ForceNotify("Config", "Copied to clipboard!", 2)
                    else
                        ForceNotify("Config", "Gagal export", 2)
                    end
                end
            })

            local cfgInfoSection = MakeSection(ConfigTab, "Config Info")
            cfgInfoSection:AddParagraph({
                Title = "Cara Pakai Config",
                Content = "• Save: isi nama, klik Save\n• Load: pilih dropdown, klik Load\n• Auto Save / Auto Load tersedia\n• Flag format: Tab_Section_Title"
            })

            task.defer(function()
                if not isfile or not readfile then return end
                local p = ConfigFolderPath() .. "/_autoload.json"
                if not isfile(p) then return end
                local okR, raw = pcall(readfile, p)
                if not okR or not raw then return end
                local okD, dec = pcall(function() return HttpService:JSONDecode(raw) end)
                if not okD or type(dec) ~= "table" then return end
                if not dec.Name or dec.Name == "" then return end
                local path = ConfigFolderPath() .. "/" .. dec.Name .. ".json"
                if not isfile(path) then return end
                local okR2, raw2 = pcall(readfile, path)
                if not okR2 or not raw2 then return end
                local okD2, dec2 = pcall(function() return HttpService:JSONDecode(raw2) end)
                if not okD2 or type(dec2) ~= "table" then return end
                task.wait(1)
                local applied = ApplyConfig(dec2)
                ForceNotify("Config", "Auto-loaded: " .. dec.Name .. " (" .. applied .. " keys)", 3)
            end)
        end
    end)

    if not uiOK then warn("[Gluto] Gagal membuat UI:", uiErr) end

    print("[ALFzxzzz v0.4.4] Loaded! Monochrome Groupbox Theme + Working Config + Music Player")
    print("  - Section = Groupbox style (header + accent dot + divider)")
    print("  - Collapsible section (−/+) — DEFAULT CLOSED")
    print("  - Slider = round knob (grow saat di-drag)")
    print("  - Dropdown = modern (search, multi-select, animated)")
    print("  - Parent GUI: CoreGui / gethui")
    print("  - Config: working save/load/import/export")
    print("  - Music Player: 8 preset + custom ID")
    ForceNotify("ALFzxzzz v0.4.4", "Config + Music Player Loaded!", 6)

end

__Gluto_Init_Main__()