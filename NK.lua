-- ============================================================
--   VERTEZX UI  –  toque por wisnu
--   Layout em escala — funciona em qualquer resolução
-- ============================================================

local Players          = game:GetService("Players")
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService       = game:GetService("RunService")
local TextService      = game:GetService("TextService")
local StatsService     = game:GetService("Stats")

local LP = Players.LocalPlayer
while not LP do
    Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
    LP = Players.LocalPlayer
end

-- Tenta CoreGui primeiro (fica acima do menu ESC do Roblox), senão usa PlayerGui
local PGui
pcall(function() PGui = game:GetService("CoreGui") end)
if not PGui then
    PGui = LP:WaitForChild("PlayerGui", 10) or LP:FindFirstChildOfClass("PlayerGui")
end

if PGui and PGui:FindFirstChild("VertezxUI") then
    pcall(function() PGui.VertezxUI:Destroy() end)
end

-- ============================================================
--  SISTEMA COMPLETO DE TEMAS & PALETAS PROFISSIONAIS
-- ============================================================
local Themes = {
    ["Dark"] = {
        WIN        = Color3.fromRGB(20, 20, 22),
        HUB_CARD   = Color3.fromRGB(32, 32, 36),
        PROF_CARD  = Color3.fromRGB(32, 32, 36),
        NAVBAR     = Color3.fromRGB(26, 26, 30),
        TAB_ACT    = Color3.fromRGB(42, 42, 48),
        BOX_BG     = Color3.fromRGB(24, 24, 28),
        BOX_STROKE = Color3.fromRGB(44, 44, 52),
        BTN_BG     = Color3.fromRGB(30, 30, 36),
        BTN_HOV    = Color3.fromRGB(40, 40, 48),
        DIVIDER    = Color3.fromRGB(44, 44, 50),
        STROKE     = Color3.fromRGB(55, 55, 65),
        TXT        = Color3.fromRGB(230, 230, 235),
        TXT_DIM    = Color3.fromRGB(115, 115, 128),
        TXT_MUTED  = Color3.fromRGB(130, 130, 145),
        ICON_ON    = Color3.fromRGB(230, 230, 235),
        ICON_OFF   = Color3.fromRGB(115, 115, 128),
        T_OFF      = Color3.fromRGB(42, 42, 50),
        T_ON       = Color3.fromRGB(152, 185, 245),
        T_KNOB_ON  = Color3.fromRGB(18, 24, 38),
        T_KNOB_OFF = Color3.fromRGB(160, 160, 175),
        SLIDER_FILL= Color3.fromRGB(152, 185, 245),
        SLIDER_BG  = Color3.fromRGB(42, 42, 52),
        NOTIF_BG   = Color3.fromRGB(18, 18, 22),
        GLOW_HEAD  = Color3.fromRGB(255, 255, 255),
        GLOW_MID   = Color3.fromRGB(200, 200, 220),
        GLOW_TAIL  = Color3.fromRGB(80, 80, 100),
    },
    ["Midnight"] = {
        WIN        = Color3.fromRGB(11, 15, 25),
        HUB_CARD   = Color3.fromRGB(17, 24, 39),
        PROF_CARD  = Color3.fromRGB(17, 24, 39),
        NAVBAR     = Color3.fromRGB(15, 23, 42),
        TAB_ACT    = Color3.fromRGB(30, 41, 59),
        BOX_BG     = Color3.fromRGB(15, 23, 42),
        BOX_STROKE = Color3.fromRGB(30, 58, 95),
        BTN_BG     = Color3.fromRGB(20, 32, 55),
        BTN_HOV    = Color3.fromRGB(28, 45, 78),
        DIVIDER    = Color3.fromRGB(30, 41, 59),
        STROKE     = Color3.fromRGB(37, 52, 75),
        TXT        = Color3.fromRGB(241, 245, 249),
        TXT_DIM    = Color3.fromRGB(120, 140, 165),
        TXT_MUTED  = Color3.fromRGB(148, 163, 184),
        ICON_ON    = Color3.fromRGB(241, 245, 249),
        ICON_OFF   = Color3.fromRGB(120, 140, 165),
        T_OFF      = Color3.fromRGB(25, 36, 58),
        T_ON       = Color3.fromRGB(56, 189, 248),
        T_KNOB_ON  = Color3.fromRGB(12, 28, 48),
        T_KNOB_OFF = Color3.fromRGB(148, 163, 184),
        SLIDER_FILL= Color3.fromRGB(56, 189, 248),
        SLIDER_BG  = Color3.fromRGB(25, 36, 58),
        NOTIF_BG   = Color3.fromRGB(10, 14, 24),
        GLOW_HEAD  = Color3.fromRGB(255, 255, 255),
        GLOW_MID   = Color3.fromRGB(56, 189, 248),
        GLOW_TAIL  = Color3.fromRGB(14, 50, 95),
    },
    ["Obsidian"] = {
        WIN        = Color3.fromRGB(8, 8, 8),
        HUB_CARD   = Color3.fromRGB(18, 18, 18),
        PROF_CARD  = Color3.fromRGB(18, 18, 18),
        NAVBAR     = Color3.fromRGB(14, 14, 14),
        TAB_ACT    = Color3.fromRGB(32, 32, 32),
        BOX_BG     = Color3.fromRGB(16, 16, 16),
        BOX_STROKE = Color3.fromRGB(38, 38, 38),
        BTN_BG     = Color3.fromRGB(22, 22, 22),
        BTN_HOV    = Color3.fromRGB(34, 34, 34),
        DIVIDER    = Color3.fromRGB(32, 32, 32),
        STROKE     = Color3.fromRGB(48, 48, 48),
        TXT        = Color3.fromRGB(245, 245, 245),
        TXT_DIM    = Color3.fromRGB(115, 115, 115),
        TXT_MUTED  = Color3.fromRGB(140, 140, 140),
        ICON_ON    = Color3.fromRGB(245, 245, 245),
        ICON_OFF   = Color3.fromRGB(115, 115, 115),
        T_OFF      = Color3.fromRGB(32, 32, 32),
        T_ON       = Color3.fromRGB(235, 235, 240),
        T_KNOB_ON  = Color3.fromRGB(15, 15, 15),
        T_KNOB_OFF = Color3.fromRGB(160, 160, 160),
        SLIDER_FILL= Color3.fromRGB(235, 235, 240),
        SLIDER_BG  = Color3.fromRGB(35, 35, 35),
        NOTIF_BG   = Color3.fromRGB(10, 10, 10),
        GLOW_HEAD  = Color3.fromRGB(255, 255, 255),
        GLOW_MID   = Color3.fromRGB(210, 210, 215),
        GLOW_TAIL  = Color3.fromRGB(60, 60, 65),
    },
    ["Dracula"] = {
        WIN        = Color3.fromRGB(30, 31, 41),
        HUB_CARD   = Color3.fromRGB(40, 42, 54),
        PROF_CARD  = Color3.fromRGB(40, 42, 54),
        NAVBAR     = Color3.fromRGB(33, 34, 44),
        TAB_ACT    = Color3.fromRGB(68, 71, 90),
        BOX_BG     = Color3.fromRGB(38, 40, 52),
        BOX_STROKE = Color3.fromRGB(68, 71, 90),
        BTN_BG     = Color3.fromRGB(46, 48, 62),
        BTN_HOV    = Color3.fromRGB(60, 63, 82),
        DIVIDER    = Color3.fromRGB(68, 71, 90),
        STROKE     = Color3.fromRGB(80, 83, 105),
        TXT        = Color3.fromRGB(248, 248, 242),
        TXT_DIM    = Color3.fromRGB(140, 145, 175),
        TXT_MUTED  = Color3.fromRGB(165, 170, 200),
        ICON_ON    = Color3.fromRGB(248, 248, 242),
        ICON_OFF   = Color3.fromRGB(140, 145, 175),
        T_OFF      = Color3.fromRGB(50, 52, 68),
        T_ON       = Color3.fromRGB(189, 147, 249),
        T_KNOB_ON  = Color3.fromRGB(25, 26, 36),
        T_KNOB_OFF = Color3.fromRGB(170, 175, 205),
        SLIDER_FILL= Color3.fromRGB(189, 147, 249),
        SLIDER_BG  = Color3.fromRGB(50, 52, 68),
        NOTIF_BG   = Color3.fromRGB(24, 25, 34),
        GLOW_HEAD  = Color3.fromRGB(255, 255, 255),
        GLOW_MID   = Color3.fromRGB(189, 147, 249),
        GLOW_TAIL  = Color3.fromRGB(85, 55, 125),
    },
    ["Emerald"] = {
        WIN        = Color3.fromRGB(9, 20, 16),
        HUB_CARD   = Color3.fromRGB(13, 31, 25),
        PROF_CARD  = Color3.fromRGB(13, 31, 25),
        NAVBAR     = Color3.fromRGB(11, 26, 20),
        TAB_ACT    = Color3.fromRGB(20, 53, 43),
        BOX_BG     = Color3.fromRGB(13, 31, 25),
        BOX_STROKE = Color3.fromRGB(26, 71, 57),
        BTN_BG     = Color3.fromRGB(18, 44, 35),
        BTN_HOV    = Color3.fromRGB(25, 60, 48),
        DIVIDER    = Color3.fromRGB(26, 71, 57),
        STROKE     = Color3.fromRGB(32, 85, 68),
        TXT        = Color3.fromRGB(236, 253, 245),
        TXT_DIM    = Color3.fromRGB(110, 165, 140),
        TXT_MUTED  = Color3.fromRGB(130, 190, 160),
        ICON_ON    = Color3.fromRGB(236, 253, 245),
        ICON_OFF   = Color3.fromRGB(110, 165, 140),
        T_OFF      = Color3.fromRGB(22, 50, 40),
        T_ON       = Color3.fromRGB(16, 185, 129),
        T_KNOB_ON  = Color3.fromRGB(6, 32, 22),
        T_KNOB_OFF = Color3.fromRGB(130, 190, 160),
        SLIDER_FILL= Color3.fromRGB(16, 185, 129),
        SLIDER_BG  = Color3.fromRGB(22, 50, 40),
        NOTIF_BG   = Color3.fromRGB(7, 16, 13),
        GLOW_HEAD  = Color3.fromRGB(255, 255, 255),
        GLOW_MID   = Color3.fromRGB(52, 211, 153),
        GLOW_TAIL  = Color3.fromRGB(6, 78, 59),
    },
    ["Crimson"] = {
        WIN        = Color3.fromRGB(20, 9, 11),
        HUB_CARD   = Color3.fromRGB(31, 13, 17),
        PROF_CARD  = Color3.fromRGB(31, 13, 17),
        NAVBAR     = Color3.fromRGB(26, 11, 14),
        TAB_ACT    = Color3.fromRGB(56, 20, 28),
        BOX_BG     = Color3.fromRGB(31, 13, 17),
        BOX_STROKE = Color3.fromRGB(76, 29, 39),
        BTN_BG     = Color3.fromRGB(42, 17, 23),
        BTN_HOV    = Color3.fromRGB(58, 24, 32),
        DIVIDER    = Color3.fromRGB(76, 29, 39),
        STROKE     = Color3.fromRGB(95, 35, 48),
        TXT        = Color3.fromRGB(255, 241, 242),
        TXT_DIM    = Color3.fromRGB(170, 120, 128),
        TXT_MUTED  = Color3.fromRGB(200, 140, 150),
        ICON_ON    = Color3.fromRGB(255, 241, 242),
        ICON_OFF   = Color3.fromRGB(170, 120, 128),
        T_OFF      = Color3.fromRGB(48, 20, 26),
        T_ON       = Color3.fromRGB(244, 63, 94),
        T_KNOB_ON  = Color3.fromRGB(35, 8, 14),
        T_KNOB_OFF = Color3.fromRGB(200, 140, 150),
        SLIDER_FILL= Color3.fromRGB(244, 63, 94),
        SLIDER_BG  = Color3.fromRGB(48, 20, 26),
        NOTIF_BG   = Color3.fromRGB(16, 7, 9),
        GLOW_HEAD  = Color3.fromRGB(255, 255, 255),
        GLOW_MID   = Color3.fromRGB(251, 113, 133),
        GLOW_TAIL  = Color3.fromRGB(115, 18, 38),
    },
}

local currentTheme = "Obsidian"
local N3K0P01_FLOATING_BG_ASSET = "rbxassetid://72979436943855"
local C = {}
for k, v in pairs(Themes["Obsidian"]) do C[k] = v end
C.DOT_Y  = Color3.fromRGB(255, 189, 46)
C.DOT_R  = Color3.fromRGB(255, 95,  87)
C.STATUS = Color3.fromRGB(60,  200, 90)
C.DECO   = Color3.fromRGB(36,  36,  42)

-- Registros de elementos com suporte a temas dinâmicos
local ThemedObjects  = {}
local GlowGradients  = {}
local ToggleUpdaters = {}

local function RegisterThemed(inst, prop, key)
    if not inst then return end
    table.insert(ThemedObjects, { inst = inst, prop = prop, key = key })
end

local function RegisterGlow(grad)
    if not grad then return end
    table.insert(GlowGradients, grad)
end

local function RegisterToggleUpdater(fn)
    table.insert(ToggleUpdaters, fn)
end

local function ApplyTheme(name)
    local palette = Themes[name] or Themes["Dark"]
    currentTheme = Themes[name] and name or "Dark"

    -- 1. Atualiza a tabela C em tempo de execução
    for k, v in pairs(palette) do
        C[k] = v
    end

    -- 2. Transição suave em todos os objetos registrados da interface
    for i = #ThemedObjects, 1, -1 do
        local item = ThemedObjects[i]
        local inst = item.inst
        if inst and inst.Parent then
            local targetCol = palette[item.key]
            if targetCol then
                TweenService:Create(inst, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    [item.prop] = targetCol
                }):Play()
            end
        else
            table.remove(ThemedObjects, i)
        end
    end

    -- 3. Atualiza todas as bordas giratórias ativas com o gradiente do tema
    local newGradSeq = ColorSequence.new({
        ColorSequenceKeypoint.new(0,    palette.GLOW_HEAD or Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(0.15, palette.GLOW_MID  or Color3.fromRGB(200, 200, 220)),
        ColorSequenceKeypoint.new(0.3,  palette.GLOW_TAIL or Color3.fromRGB(80,  80,  100)),
        ColorSequenceKeypoint.new(1,    palette.GLOW_TAIL or Color3.fromRGB(80,  80,  100)),
    })
    for i = #GlowGradients, 1, -1 do
        local grad = GlowGradients[i]
        if grad and grad.Parent then
            grad.Color = newGradSeq
        else
            table.remove(GlowGradients, i)
        end
    end

    -- 4. Atualiza cores dos toggles ativos/inativos na tela
    for _, fn in ipairs(ToggleUpdaters) do
        pcall(fn)
    end

    -- 5. Atualiza BottomNav e botões de abas se já inicializados
    if _G._VertexUpdateNavTheme then
        pcall(_G._VertexUpdateNavTheme, palette)
    end

    -- 5b. Re-renderiza lista de configs com novas cores
    if _G._VertexRefreshConfigList then
        pcall(_G._VertexRefreshConfigList)
    end

    -- 6. Atualiza Sub-Abas do Player se já inicializadas
    if _G._VertexUpdateSubTabTheme then
        pcall(_G._VertexUpdateSubTabTheme, palette)
    end

    -- 7. Atualiza gradiente do HCard (Hub Card)
    if _G._VertexUpdateHCardGradient then
        pcall(_G._VertexUpdateHCardGradient, palette)
    end

    -- 8. Atualiza Logo do Hub de acordo com o tema
    if _G._VertexUpdateLogo then
        pcall(_G._VertexUpdateLogo, currentTheme)
    end

    -- 9. Atualiza Badges de Usuários Wisnu no Lobby
    if _G.UpdateAllWisnuBadges then
        pcall(_G.UpdateAllWisnuBadges)
    end
end

_G.ApplyTheme = ApplyTheme

-- Logo personalizado do N3K0P01 HUB (mantido em todos os temas)
local HUB_LOGO = "rbxassetid://74606313974329"
local ThemeLogos = {
    ["Dark"]     = HUB_LOGO,
    ["Midnight"] = HUB_LOGO,
    ["Obsidian"] = HUB_LOGO,
    ["Dracula"]  = HUB_LOGO,
    ["Emerald"]  = HUB_LOGO,
    ["Crimson"]  = HUB_LOGO,
}

local _logoAssetCache = {}
for tName, assetId in pairs(ThemeLogos) do
    _logoAssetCache[tName] = assetId
end

local function _fetchLogoAsset(themeName)
    themeName = themeName or currentTheme or "Dark"
    return ThemeLogos[themeName] or ThemeLogos["Dark"]
end

local ICO = {
    ATOM     = ThemeLogos["Dark"], -- Substituído pelo ID oficial dos temas
    PLAYER   = "rbxassetid://114567720540659",
    ESP      = "rbxassetid://127234874352422",
    MISC     = "rbxassetid://137086737657962",
    VISUAL   = "rbxassetid://132705178126217",
    SETTINGS = "rbxassetid://123222732420633",
}

-- ============================================================
--  HELPERS
-- ============================================================
local function R(n, p)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, n); c.Parent = p; return c
end

local function F(bg, sz, pos, par)
    local f = Instance.new("Frame")
    f.BackgroundColor3 = bg; f.BorderSizePixel = 0
    f.Size = sz; f.Position = pos or UDim2.new(0,0,0,0)
    f.Parent = par

    -- Auto-register themed color based on palette match
    for key, val in pairs(C) do
        if typeof(val) == "Color3" and val == bg then
            RegisterThemed(f, "BackgroundColor3", key)
            break
        end
    end

    return f
end

local function FT(sz, pos, par)
    local f = Instance.new("Frame")
    f.BackgroundTransparency = 1; f.BorderSizePixel = 0
    f.Size = sz; f.Position = pos or UDim2.new(0,0,0,0)
    f.Parent = par; return f
end

local function IL(id, sz, col, par, pos)
    local i = Instance.new("ImageLabel")
    i.Size = UDim2.fromOffset(sz,sz)
    i.Position = pos or UDim2.new(0,0,0.5,-sz/2)
    i.BackgroundTransparency = 1
    i.Image = id; i.ImageColor3 = col or C.ICON_OFF
    i.ScaleType = Enum.ScaleType.Fit
    i.Parent = par

    -- Auto-register themed color based on palette match
    local resolvedCol = col or C.ICON_OFF
    for key, val in pairs(C) do
        if typeof(val) == "Color3" and val == resolvedCol then
            RegisterThemed(i, "ImageColor3", key)
            break
        end
    end

    return i
end

local function TL(txt, size, col, bold, par, pos, sz, xa)
    local l = Instance.new("TextLabel")
    l.Text = txt; l.TextSize = size
    l.TextColor3 = col or C.TXT
    l.Font = bold and Enum.Font.GothamBold or Enum.Font.Gotham
    l.BackgroundTransparency = 1
    l.TextXAlignment = xa or Enum.TextXAlignment.Left
    l.TextTruncate = Enum.TextTruncate.AtEnd
    l.Size = sz or UDim2.new(1,0,1,0)
    l.Position = pos or UDim2.new(0,0,0,0)
    l.Parent = par

    -- Auto-register themed color based on palette match
    local resolvedCol = col or C.TXT
    for key, val in pairs(C) do
        if typeof(val) == "Color3" and val == resolvedCol then
            RegisterThemed(l, "TextColor3", key)
            break
        end
    end

    return l
end

local function getRoot()
    return LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
end

-- getRoot defined in top helpers

local function Stroke(col, thick, par)
    local s = Instance.new("UIStroke")
    s.Color = col; s.Thickness = thick or 1
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Parent = par

    -- Auto-register themed color based on palette match
    for key, val in pairs(C) do
        if typeof(val) == "Color3" and val == col then
            RegisterThemed(s, "Color", key)
            break
        end
    end

    return s
end

local function Drag(win, handle)
    local dr, ds, sp = false, nil, nil
    handle.InputBegan:Connect(function(i)
        if _G.UISliderDragging then return end
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dr=true; ds=i.Position; sp=win.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if dr and not _G.UISliderDragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
            local d=i.Position-ds
            win.Position=UDim2.new(sp.X.Scale,sp.X.Offset+d.X,sp.Y.Scale,sp.Y.Offset+d.Y)
        end
    end)
    local function EndDrag(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
            dr=false
        end
    end
    UserInputService.InputEnded:Connect(EndDrag)
end

-- ============================================================
--  EFEITO: LUZ BRANCA GIRANDO AO REDOR DAS JANELAS E DA NAVBAR
--  UIGradient dentro de UIStroke com TweenService infinito
-- ============================================================
local function AddGlowBorder(target, thickness, speed)
    local oldStroke = target:FindFirstChildOfClass("UIStroke")
    if oldStroke then oldStroke:Destroy() end

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Thickness = thickness or 2
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = target

    local curPalette = Themes[currentTheme] or Themes["Dark"]
    local grad = Instance.new("UIGradient")
    grad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0,    curPalette.GLOW_HEAD or Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(0.15, curPalette.GLOW_MID  or Color3.fromRGB(200, 200, 220)),
        ColorSequenceKeypoint.new(0.3,  curPalette.GLOW_TAIL or Color3.fromRGB(80,  80,  100)),
        ColorSequenceKeypoint.new(1,    curPalette.GLOW_TAIL or Color3.fromRGB(80,  80,  100)),
    })
    grad.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0,    0.0),
        NumberSequenceKeypoint.new(0.12, 0.3),
        NumberSequenceKeypoint.new(0.3,  0.85),
        NumberSequenceKeypoint.new(1,    0.92),
    })
    grad.Rotation = 0
    grad.Parent = stroke

    RegisterGlow(grad)

    local tweenInfo = TweenInfo.new(
        speed or 3,
        Enum.EasingStyle.Linear,
        Enum.EasingDirection.In,
        -1,
        false
    )
    local tween = TweenService:Create(grad, tweenInfo, {Rotation = 360})
    tween:Play()

    return stroke, grad
end

-- ============================================================
--  GUI
-- ============================================================
local Gui = Instance.new("ScreenGui")
Gui.Name="N3K0P01_UI"; Gui.ResetOnSpawn=false
Gui.IgnoreGuiInset=true
Gui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
Gui.DisplayOrder=99; Gui.Enabled=true; Gui.Parent=PGui

-- ============================================================
--  JANELA  –  630×415px compacto
-- ============================================================
-- Overlay invisível em tela cheia para manter Modal ativo e capturar cliques no fundo do jogo (ativo apenas durante partida)
local BgOverlay = Instance.new("TextButton")
BgOverlay.Name = "MouseUnlockOverlay"
BgOverlay.Size = UDim2.new(1, 0, 1, 0)
BgOverlay.Position = UDim2.new(0, 0, 0, 0)
BgOverlay.BackgroundTransparency = 1
BgOverlay.Text = ""
BgOverlay.AutoButtonColor = false
BgOverlay.Active = false
BgOverlay.Modal = false
BgOverlay.ZIndex = 1
BgOverlay.Visible = false
BgOverlay.Parent = Gui

local Win = Instance.new("Frame")
Win.Name = "Window"
Win.Size = UDim2.fromOffset(630, 415)
Win.Position = UDim2.fromScale(0.5, 0.47)
Win.AnchorPoint = Vector2.new(0.5, 0.5)
Win.BackgroundColor3 = C.WIN
Win.BorderSizePixel = 0
Win.ClipsDescendants = false
Win.ZIndex = 10
Win.Active = true
Win.Visible = true
Win.Parent = Gui
RegisterThemed(Win, "BackgroundColor3", "WIN")

-- Background image personalizado; transparansi dijaga agar teks dan kontrol tetap terbaca.
local WindowBackground = Instance.new("ImageLabel")
WindowBackground.Name = "CustomWindowBackground"
WindowBackground.Size = UDim2.new(1, 0, 1, 0)
WindowBackground.Position = UDim2.fromOffset(0, 0)
WindowBackground.BackgroundTransparency = 1
WindowBackground.Image = "rbxassetid://72979436943855"
WindowBackground.ImageTransparency = 0.72
WindowBackground.ImageColor3 = Color3.fromRGB(190, 190, 190)
WindowBackground.ScaleType = Enum.ScaleType.Crop
WindowBackground.ZIndex = 1
WindowBackground.Parent = Win
R(16, WindowBackground)

-- Controle neutro do mouse para uma biblioteca reutilizável.
local toggleKey = Enum.KeyCode.RightControl

local function SetMouseUnlocked(open)
    BgOverlay.Visible = false
    BgOverlay.Modal = false
    UserInputService.MouseIconEnabled = true
    UserInputService.MouseBehavior = Enum.MouseBehavior.Default
end

local MobileBtn  -- forward declaration

local function ToggleUI()
    local nextVis = not Win.Visible
    Win.Visible = nextVis
    SetMouseUnlocked(nextVis)

    -- Tampilkan floating logo button saat window di-hide
    if MobileBtn then
        local mobile = UserInputService.TouchEnabled
            and not (UserInputService.KeyboardEnabled and UserInputService.MouseEnabled)
        if mobile then
            MobileBtn.Visible = true          -- mobile: selalu tampil
        else
            MobileBtn.Visible = not nextVis   -- PC: tampil hanya saat window hidden
        end
    end
end

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == toggleKey then
        ToggleUI()
    end

    if input.KeyCode == Enum.KeyCode.End and _G.N3K0P01_UI then
        _G.N3K0P01_UI:Unload()
    end
end)

-- ============================================================
--  BOTÃO FLUTUANTE PARA MOBILE (Abre/Fecha Menu)
--  Aparece automaticamente apenas em dispositivos móveis
-- ============================================================
local isMobile = UserInputService.TouchEnabled and not (UserInputService.KeyboardEnabled and UserInputService.MouseEnabled)

MobileBtn = Instance.new("ImageButton")
MobileBtn.Name = "MobileToggleBtn"
MobileBtn.Size = UDim2.fromOffset(48, 48)
MobileBtn.Position = UDim2.new(0, 39, 0.45, 0)
MobileBtn.AnchorPoint = Vector2.new(0.5, 0.5)
MobileBtn.BackgroundColor3 = C.NAVBAR
MobileBtn.BorderSizePixel = 0
MobileBtn.ZIndex = 100
MobileBtn.AutoButtonColor = false
MobileBtn.Active = true
MobileBtn.Visible = isMobile
MobileBtn.Parent = Gui

R(12, MobileBtn)
local mStroke = Stroke(C.BOX_STROKE, 1.5, MobileBtn)
RegisterThemed(MobileBtn, "BackgroundColor3", "NAVBAR")
RegisterThemed(mStroke, "Color", "BOX_STROKE")

local mobileIcon = Instance.new("ImageLabel")
mobileIcon.Name = "Icon"
mobileIcon.Size = UDim2.fromOffset(36, 36)
mobileIcon.AnchorPoint = Vector2.new(0.5, 0.5)
mobileIcon.Position = UDim2.new(0.5, -1, 0.5, 3)
mobileIcon.BackgroundTransparency = 1
mobileIcon.Image = ThemeLogos[currentTheme] or ThemeLogos["Dark"]
mobileIcon.ScaleType = Enum.ScaleType.Fit
mobileIcon.ZIndex = 101
mobileIcon.Parent = MobileBtn

-- Arrasto suave com detecção de clique/toque (arrastar move, toque abre/fecha)
local mDragging = false
local mStartPos = nil
local mStartBtnPos = nil
local mMoved = false

MobileBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        mDragging = true
        mStartPos = input.Position
        mStartBtnPos = MobileBtn.Position
        mMoved = false

        TweenService:Create(MobileBtn, TweenInfo.new(0.1), {Size = UDim2.fromOffset(44, 44)}):Play()
        TweenService:Create(mobileIcon, TweenInfo.new(0.1), {Size = UDim2.fromOffset(32, 32)}):Play()
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if mDragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = input.Position - mStartPos
        if delta.Magnitude > 6 then
            mMoved = true
        end
        MobileBtn.Position = UDim2.new(
            mStartBtnPos.X.Scale,
            mStartBtnPos.X.Offset + delta.X,
            mStartBtnPos.Y.Scale,
            mStartBtnPos.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        if mDragging then
            mDragging = false
            TweenService:Create(MobileBtn, TweenInfo.new(0.15, Enum.EasingStyle.Back), {Size = UDim2.fromOffset(48, 48)}):Play()
            TweenService:Create(mobileIcon, TweenInfo.new(0.15, Enum.EasingStyle.Back), {Size = UDim2.fromOffset(36, 36)}):Play()

            if not mMoved then
                ToggleUI()
            end
        end
    end
end)

-- Inicia liberando o mouse já que a UI inicia aberta
SetMouseUnlocked(true)
R(16, Win)
local winStroke = Stroke(C.STROKE, 1.5, Win)
RegisterThemed(winStroke, "Color", "STROKE")

-- Barra superior dedicada para arrastar a janela (não interfere com sliders ou conteúdo interno)
local WinTopDrag = Instance.new("Frame")
WinTopDrag.Name = "WinTopDrag"
WinTopDrag.Size = UDim2.new(1, -60, 0, 46)
WinTopDrag.Position = UDim2.new(0, 0, 0, 0)
WinTopDrag.BackgroundTransparency = 1
WinTopDrag.ZIndex = 12
WinTopDrag.Parent = Win
Drag(Win, WinTopDrag)

-- Escala da UI (padrão 70% ao executar)
local WinScale = Instance.new("UIScale")
WinScale.Scale = 0.70
WinScale.Parent = Win

-- === TUNABLE: sesuaikan 2 angka ini kalau masih kerasa kegedean/kekecilan ===
--   0.42 = window mengisi ~42% viewport. Kecilin angkanya = window lebih kecil.
local AUTO_TARGET_HEIGHT_PCT = 0.42   -- sebelumnya 0.55
local AUTO_TARGET_WIDTH_PCT  = 0.42   -- sebelumnya 0.50
local UI_SCALE_MIN   = 0.70
local UI_SCALE_MAX   = 1.40           -- sebelumnya 1.6
local UI_SCALE_RANGE = UI_SCALE_MAX - UI_SCALE_MIN
_G._VertexAutoScaleDisabled = false

local function _VertexGetAutoScale()
    local cam = workspace.CurrentCamera
    local vp  = (cam and cam.ViewportSize) or Vector2.new(1920, 1080)
    if vp.X < 1 or vp.Y < 1 then vp = Vector2.new(1920, 1080) end
    local scaleByHeight = (vp.Y * AUTO_TARGET_HEIGHT_PCT) / 415
    local scaleByWidth  = (vp.X * AUTO_TARGET_WIDTH_PCT)  / 630
    return math.clamp(math.min(scaleByHeight, scaleByWidth), UI_SCALE_MIN, UI_SCALE_MAX)
end

_G._VertexSetAutoScaleDisabled = function(v)
    _G._VertexAutoScaleDisabled = (v == true)
end

_G._VertexAutoApplyScale = function()
    if _G._VertexAutoScaleDisabled then return end
    WinScale.Scale = _VertexGetAutoScale()
    if _G._VertexSyncScaleSlider then pcall(_G._VertexSyncScaleSlider) end
end

-- Terapkan saat startup
_G._VertexAutoApplyScale()

-- Re-apply kalau viewport berubah (resize window / rotasi device)
task.spawn(function()
    local lastVp = nil
    while true do
        task.wait(0.4)
        local cam = workspace.CurrentCamera
        if cam then
            local vp = cam.ViewportSize
            if not lastVp or vp.X ~= lastVp.X or vp.Y ~= lastVp.Y then
                lastVp = vp
                _G._VertexAutoApplyScale()
            end
        end
    end
end)

-- dots amarelo + vermelho (top-right)
local dY = F(C.DOT_Y, UDim2.fromOffset(12,12), UDim2.new(1,-48,0,13), Win); R(6,dY)
local dR = F(C.DOT_R, UDim2.fromOffset(12,12), UDim2.new(1,-30,0,13), Win); R(6,dR)

local function DotButton(dot, callback)
    local b = Instance.new("TextButton")
    b.BackgroundTransparency = 1
    b.Text = ""
    b.Size = UDim2.fromOffset(20, 20)
    b.Position = UDim2.new(0.5, -10, 0.5, -10)
    b.ZIndex = 20
    b.Parent = dot
    b.Activated:Connect(callback)
end
DotButton(dY, function() ToggleUI() end)

-- ============================================================
--  KONFIRMASI CLOSE (dot merah)
-- ============================================================
do
    local ConfirmOverlay = Instance.new("Frame")
    ConfirmOverlay.Name = "CloseConfirmOverlay"
    ConfirmOverlay.Size = UDim2.new(1, 0, 1, 0)
    ConfirmOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    ConfirmOverlay.BackgroundTransparency = 0.45
    ConfirmOverlay.BorderSizePixel = 0
    ConfirmOverlay.Active = true -- blok klik ke belakang
    ConfirmOverlay.Visible = false
    ConfirmOverlay.ZIndex = 1000
    ConfirmOverlay.Parent = Gui

    local Card = Instance.new("Frame")
    Card.Name = "ConfirmCard"
    Card.AnchorPoint = Vector2.new(0.5, 0.5)
    Card.Position = UDim2.fromScale(0.5, 0.5)
    Card.Size = UDim2.fromOffset(320, 150)
    Card.BackgroundColor3 = C.WIN
    Card.BorderSizePixel = 0
    Card.ZIndex = 1001
    Card.Parent = ConfirmOverlay
    R(14, Card)
    RegisterThemed(Card, "BackgroundColor3", "WIN")
    local cardStroke = Stroke(C.STROKE, 1.5, Card)
    RegisterThemed(cardStroke, "Color", "STROKE")

    local CardScale = Instance.new("UIScale")
    CardScale.Scale = 1
    CardScale.Parent = Card

    local Title = Instance.new("TextLabel")
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.fromOffset(20, 16)
    Title.Size = UDim2.new(1, -40, 0, 22)
    Title.Font = Enum.Font.GothamBold
    Title.Text = "Close Script?"
    Title.TextSize = 16
    Title.TextColor3 = C.TXT
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.ZIndex = 1002
    Title.Parent = Card
    RegisterThemed(Title, "TextColor3", "TXT")

    local Msg = Instance.new("TextLabel")
    Msg.BackgroundTransparency = 1
    Msg.Position = UDim2.fromOffset(20, 44)
    Msg.Size = UDim2.new(1, -40, 0, 40)
    Msg.Font = Enum.Font.Gotham
    Msg.Text = "Are you sure you want to close the window?"
    Msg.TextSize = 12
    Msg.TextWrapped = true
    Msg.TextColor3 = C.TXT_DIM
    Msg.TextXAlignment = Enum.TextXAlignment.Left
    Msg.TextYAlignment = Enum.TextYAlignment.Top
    Msg.ZIndex = 1002
    Msg.Parent = Card
    RegisterThemed(Msg, "TextColor3", "TXT_DIM")

    local function makeBtn(text, xScale, xOffset, filled)
        local b = Instance.new("TextButton")
        b.AutoButtonColor = false
        b.Size = UDim2.new(0.5, -26, 0, 36)
        b.Position = UDim2.new(xScale, xOffset, 1, -52)
        b.BorderSizePixel = 0
        b.Font = Enum.Font.GothamBold
        b.TextSize = 13
        b.Text = text
        b.ZIndex = 1002
        b.Parent = Card
        R(9, b)
        if filled then
            b.BackgroundColor3 = Color3.fromRGB(235, 70, 70)
            b.TextColor3 = Color3.fromRGB(255, 255, 255)
        else
            b.BackgroundColor3 = C.BTN_BG
            b.TextColor3 = C.TXT
            local s = Stroke(C.BOX_STROKE, 1, b)
            RegisterThemed(s, "Color", "BOX_STROKE")
            RegisterThemed(b, "BackgroundColor3", "BTN_BG")
            RegisterThemed(b, "TextColor3", "TXT")
        end
        return b
    end

    local YesBtn = makeBtn("Yes", 0, 20, true)
    local NoBtn  = makeBtn("No", 0.5, 6, false)

    YesBtn.MouseEnter:Connect(function()
        TweenService:Create(YesBtn, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(255, 95, 95)}):Play()
    end)
    YesBtn.MouseLeave:Connect(function()
        TweenService:Create(YesBtn, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(235, 70, 70)}):Play()
    end)
    NoBtn.MouseEnter:Connect(function()
        TweenService:Create(NoBtn, TweenInfo.new(0.12), {BackgroundColor3 = C.BTN_HOV}):Play()
    end)
    NoBtn.MouseLeave:Connect(function()
        TweenService:Create(NoBtn, TweenInfo.new(0.12), {BackgroundColor3 = C.BTN_BG}):Play()
    end)

    local function ShowConfirm()
        CardScale.Scale = 0.9
        ConfirmOverlay.Visible = true
        TweenService:Create(CardScale, TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
    end
    local function HideConfirm()
        ConfirmOverlay.Visible = false
    end

    NoBtn.Activated:Connect(HideConfirm)
    YesBtn.Activated:Connect(function()
        HideConfirm()
        if _G.N3K0P01_UI then _G.N3K0P01_UI:Unload() end
    end)

    DotButton(dR, ShowConfirm)
end

-- ============================================================
--  PAINEL ESQUERDO  (34% da janela)
-- ============================================================
local LP_PCT = 0.34

local LPanel = Instance.new("Frame")
LPanel.Size = UDim2.new(LP_PCT, 0, 1, 0)
LPanel.Position = UDim2.new(0,0,0,0)
LPanel.BackgroundTransparency = 1
LPanel.BorderSizePixel = 0
LPanel.Parent = Win

-- ── Card Hub ─────────────────────────────────────────────────
local HCard = Instance.new("Frame")
HCard.Size = UDim2.new(1,-24,0,86)
HCard.Position = UDim2.fromOffset(12,10)
HCard.BackgroundColor3 = Color3.fromRGB(255,255,255) -- branco (gradiente controla cor)
HCard.BorderSizePixel = 0
HCard.ClipsDescendants = true
HCard.Parent = LPanel
R(12, HCard)
Drag(Win, HCard)

-- Gradiente: spotlight que gira ao redor do card
local waterGrad = Instance.new("UIGradient")

-- Função para atualizar gradiente do HCard com base no tema
local function UpdateHCardGradient(palette)
    local base = palette.HUB_CARD
    local r, g, b = math.floor(base.R*255), math.floor(base.G*255), math.floor(base.B*255)
    waterGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0,    Color3.fromRGB(r+10, g+10, b+16)),
        ColorSequenceKeypoint.new(0.35, Color3.fromRGB(r+40, g+40, b+58)),
        ColorSequenceKeypoint.new(0.5,  Color3.fromRGB(r+10, g+10, b+16)),
        ColorSequenceKeypoint.new(1,    Color3.fromRGB(math.max(0,r-2), math.max(0,g-2), math.max(0,b))),
    })
end
UpdateHCardGradient(C)

waterGrad.Rotation = 0
waterGrad.Parent = HCard

-- Rotação infinita 0→360° (spotlight gira suavemente)
local waterTween = TweenService:Create(waterGrad,
    TweenInfo.new(6, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1, false),
    { Rotation = 360 }
)
waterTween:Play()

-- Stroke
local hStroke = Instance.new("UIStroke")
hStroke.Color = C.BOX_STROKE
hStroke.Thickness = 1
hStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
hStroke.Parent = HCard
RegisterThemed(hStroke, "Color", "BOX_STROKE")

_G._VertexUpdateHCardGradient = UpdateHCardGradient

-- Ícone infinito — 72px
local infI = Instance.new("ImageLabel")
infI.Size = UDim2.fromOffset(72, 72)
infI.Position = UDim2.fromOffset(4, 7)
infI.BackgroundTransparency = 1
infI.ScaleType = Enum.ScaleType.Fit
infI.ZIndex = 3
infI.Parent = HCard

-- Atualizador de Logo do Hub sincronizado com o tema ativo

local function UpdateHubLogo(themeName)
    themeName = themeName or currentTheme or "Dark"
    local asset = HUB_LOGO

    if infI then
        infI.Image = asset
    end
    if mobileIcon then
        mobileIcon.Image = asset
    end
    if moonwalkLogoRef then
        moonwalkLogoRef.Image = asset
    end
end

_G._VertexUpdateLogo = UpdateHubLogo

-- Carrega o logo do tema atual imediatamente
pcall(function() UpdateHubLogo(currentTheme) end)

local hTitle = TL("N3K0P01 HUB", 15, C.TXT, true, HCard,
   UDim2.fromOffset(80,20), UDim2.new(1,-86,0,22))
hTitle.ZIndex = 3
RegisterThemed(hTitle, "TextColor3", "TXT")
local hVer = TL("Premium Script", 10, C.TXT_DIM, false, HCard,
   UDim2.fromOffset(80,44), UDim2.new(1,-86,0,14))
hVer.ZIndex = 3
RegisterThemed(hVer, "TextColor3", "TXT_DIM")

-- ── Card Perfil (Controlado pelo toggle Show Profile) ──────────
local PCard = F(C.PROF_CARD,
    UDim2.new(1,-24,0,64), UDim2.fromOffset(12,120), LPanel)
R(12, PCard)
RegisterThemed(PCard, "BackgroundColor3", "PROF_CARD")

local avF = F(C.DIVIDER, UDim2.fromOffset(42,42), UDim2.fromOffset(12,11), PCard)
R(10, avF)
RegisterThemed(avF, "BackgroundColor3", "DIVIDER")
avF.ClipsDescendants = true

local avI = Instance.new("ImageLabel")
avI.Size = UDim2.new(1,0,1,0); avI.BackgroundTransparency = 1
avI.Image = "https://www.roblox.com/headshot-thumbnail/image?userId="
          ..tostring(LP.UserId).."&width=60&height=60&format=png"
avI.ScaleType = Enum.ScaleType.Crop; avI.Parent = avF; R(10, avI)
avI.ZIndex = 2
avI.Visible = true

-- Ícone exibido quando a foto está desativada (sem foto de fundo)
local avIcon = IL(ICO.PLAYER, 22, C.ICON_ON, avF, UDim2.new(0.5, -11, 0.5, -11))
avIcon.ZIndex = 2
avIcon.Visible = false

local profDisplayName = TL(LP.DisplayName, 13, C.TXT, true, PCard,
   UDim2.fromOffset(62,13), UDim2.new(1,-68,0,18))
profDisplayName.ZIndex = 2
RegisterThemed(profDisplayName, "TextColor3", "TXT")

local profUserName = TL("@"..LP.Name, 11, C.TXT_DIM, false, PCard,
   UDim2.fromOffset(62,33), UDim2.new(1,-68,0,14))
profUserName.ZIndex = 2
RegisterThemed(profUserName, "TextColor3", "TXT_DIM")

-- ── Divisor vertical com gradiente (escuro→claro→escuro) ─────
local Div = F(C.DIVIDER, UDim2.new(0,1,1,0), UDim2.new(LP_PCT,0,0,0), Win)
RegisterThemed(Div, "BackgroundColor3", "DIVIDER")
local DivGrad = Instance.new("UIGradient")
DivGrad.Rotation = 90
DivGrad.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0,   1),
    NumberSequenceKeypoint.new(0.2, 0.3),
    NumberSequenceKeypoint.new(0.5, 0),
    NumberSequenceKeypoint.new(0.8, 0.3),
    NumberSequenceKeypoint.new(1,   1),
})
DivGrad.Parent = Div

-- ============================================================
--  CONTEÚDO  (66% restante da janela)
-- ============================================================
local Cont = Instance.new("Frame")
Cont.Size = UDim2.new(1-LP_PCT,-1,1,0)
Cont.Position = UDim2.new(LP_PCT,1,0,0)
Cont.BackgroundTransparency = 1
Cont.BorderSizePixel = 0
Cont.ClipsDescendants = true
Cont.Parent = Win

local HDR_H = 46
local hdr = FT(UDim2.new(1,0,0,HDR_H), nil, Cont)
Drag(Win, hdr)

local ContentIcon = IL(ICO.PLAYER,17,C.ICON_OFF,hdr,UDim2.fromOffset(20,14))
RegisterThemed(ContentIcon, "ImageColor3", "ICON_OFF")
local ContentTitle = TL("Player",15,C.TXT,true,hdr,
    UDim2.fromOffset(44,0),UDim2.new(0,116,1,0))
RegisterThemed(ContentTitle, "TextColor3", "TXT")

local contentDiv = F(C.DIVIDER,UDim2.new(1,0,0,1),UDim2.fromOffset(0,HDR_H),Cont)
RegisterThemed(contentDiv, "BackgroundColor3", "DIVIDER")

-- ScrollFrame Principal
local Sc=Instance.new("ScrollingFrame")
Sc.Size=UDim2.new(1,0,1,-(HDR_H+1))
Sc.Position=UDim2.fromOffset(0,HDR_H+1)
Sc.BackgroundTransparency=1; Sc.BorderSizePixel=0
Sc.ScrollBarThickness=3; Sc.ScrollBarImageColor3=C.DIVIDER
RegisterThemed(Sc, "ScrollBarImageColor3", "DIVIDER")
Sc.CanvasSize=UDim2.fromOffset(0,0)
Sc.AutomaticCanvasSize=Enum.AutomaticSize.Y
Sc.Parent=Cont

local ScLL=Instance.new("UIListLayout")
ScLL.Padding=UDim.new(0,12); ScLL.SortOrder=Enum.SortOrder.LayoutOrder
ScLL.Parent=Sc

local ScPad=Instance.new("UIPadding")
ScPad.PaddingLeft=UDim.new(0,14); ScPad.PaddingRight=UDim.new(0,14)
ScPad.PaddingTop=UDim.new(0,10); ScPad.PaddingBottom=UDim.new(0,20)
ScPad.Parent=Sc

-- ============================================================
--  SISTEMA DE CAIXAS (BOX CONTAINER DA REFERÊNCIA)
--  Caixa arredondada escura dentro da janela com as funções agrupadas
-- ============================================================
local function CreateBox(parent, order, title, icon)
    local box = Instance.new("Frame")
    box.Name = title and ("Box_" .. title:gsub("%s+", "")) or "BoxContainer"
    box.BackgroundColor3 = C.BOX_BG
    box.BorderSizePixel = 0
    box.Size = UDim2.new(1, 0, 0, 0)
    box.AutomaticSize = Enum.AutomaticSize.Y
    box.LayoutOrder = order or 1
    box.Parent = parent
    R(12, box)
    local bStroke = Stroke(C.BOX_STROKE, 1, box)
    RegisterThemed(box, "BackgroundColor3", "BOX_BG")
    RegisterThemed(bStroke, "Color", "BOX_STROKE")

    local pad = Instance.new("UIPadding")
    pad.PaddingLeft = UDim.new(0, 16)
    pad.PaddingRight = UDim.new(0, 16)
    pad.PaddingTop = UDim.new(0, 14)
    pad.PaddingBottom = UDim.new(0, 14)
    pad.Parent = box

    local ll = Instance.new("UIListLayout")
    ll.Padding = UDim.new(0, 12)
    ll.SortOrder = Enum.SortOrder.LayoutOrder
    ll.Parent = box

    if title then
        local header = Instance.new("Frame")
        header.Name = "BoxHeader"
        header.BackgroundTransparency = 1
        header.Size = UDim2.new(1, 0, 0, 24)
        header.LayoutOrder = 0
        header.Parent = box

        local titleX = 0
        if icon then
            IL(icon, 15, C.T_ON, header, UDim2.fromOffset(0, 4))
            titleX = 22
        end

        TL(title, 13, C.TXT, true, header,
           UDim2.fromOffset(titleX, 0), UDim2.new(1, -titleX, 1, 0))

        local sep = F(C.DIVIDER, UDim2.new(1, 0, 0, 1), UDim2.new(0, 0, 1, 3), header)
    end

    return box
end

local function AddDivider(box)
    local d = F(C.DIVIDER, UDim2.new(1, 0, 0, 1), nil, box)
    return d
end

-- ============================================================
--  SISTEMA DE NOTIFICAÇÕES (Toast Notifications - Estilo da Referência)
-- ============================================================
local NotifContainer = Instance.new("Frame")
NotifContainer.Name = "NotificationContainer"
NotifContainer.Size = UDim2.new(0, 280, 1, -40)
NotifContainer.Position = UDim2.new(1, -20, 1, -20)
NotifContainer.AnchorPoint = Vector2.new(1, 1)
NotifContainer.BackgroundTransparency = 1
NotifContainer.BorderSizePixel = 0
NotifContainer.ZIndex = 200
NotifContainer.Parent = Gui

local notifLayout = Instance.new("UIListLayout")
notifLayout.FillDirection = Enum.FillDirection.Vertical
notifLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
notifLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
notifLayout.SortOrder = Enum.SortOrder.LayoutOrder
notifLayout.Padding = UDim.new(0, 8)
notifLayout.Parent = NotifContainer

local NotificationsEnabled = true
_G.NotificationsEnabled = NotificationsEnabled

local lastNotificationKey = ""
local lastNotificationTime = 0

local function Notify(title, message, duration)
    if not NotificationsEnabled then return end
    local now = tick()
    local notifKey = tostring(title) .. "::" .. tostring(message)
    if notifKey == lastNotificationKey and (now - lastNotificationTime) < 0.8 then
        return
    end
    lastNotificationKey = notifKey
    lastNotificationTime = now
    duration = duration or 3
    task.spawn(function()
        local card = Instance.new("Frame")
        card.Name = "ToastNotification"
        card.Size = UDim2.new(1, 0, 0, 0)
        card.AutomaticSize = Enum.AutomaticSize.Y
        card.BackgroundColor3 = C.NOTIF_BG or Color3.fromRGB(18, 18, 22)
        card.BorderSizePixel = 0
        card.BackgroundTransparency = 1
        card.ZIndex = 201
        card.Parent = NotifContainer
        R(10, card)
        RegisterThemed(card, "BackgroundColor3", "NOTIF_BG")

        -- Borda branca girando ao redor da notificação (igual navbar, janela, etc.)
        local cardStroke, cardGrad = AddGlowBorder(card, 1.5, 2.5)
        cardStroke.Transparency = 1

        local pad = Instance.new("UIPadding")
        pad.PaddingLeft = UDim.new(0, 14)
        pad.PaddingRight = UDim.new(0, 14)
        pad.PaddingTop = UDim.new(0, 10)
        pad.PaddingBottom = UDim.new(0, 12)
        pad.Parent = card

        local list = Instance.new("UIListLayout")
        list.SortOrder = Enum.SortOrder.LayoutOrder
        list.Padding = UDim.new(0, 4)
        list.Parent = card

        local titleLbl = Instance.new("TextLabel")
        titleLbl.Name = "Title"
        titleLbl.Size = UDim2.new(1, 0, 0, 16)
        titleLbl.BackgroundTransparency = 1
        titleLbl.Font = Enum.Font.GothamBold
        titleLbl.TextSize = 13
        titleLbl.TextColor3 = C.TXT
        titleLbl.TextTransparency = 1
        titleLbl.TextXAlignment = Enum.TextXAlignment.Left
        titleLbl.Text = title or "Notification"
        titleLbl.ZIndex = 202
        titleLbl.LayoutOrder = 1
        titleLbl.Parent = card

        local descLbl = Instance.new("TextLabel")
        descLbl.Name = "Description"
        descLbl.Size = UDim2.new(1, 0, 0, 0)
        descLbl.AutomaticSize = Enum.AutomaticSize.Y
        descLbl.BackgroundTransparency = 1
        descLbl.Font = Enum.Font.Gotham
        descLbl.TextSize = 11
        descLbl.TextColor3 = C.TXT_DIM
        descLbl.TextTransparency = 1
        descLbl.TextWrapped = true
        descLbl.TextXAlignment = Enum.TextXAlignment.Left
        descLbl.Text = message or ""
        descLbl.ZIndex = 202
        descLbl.LayoutOrder = 2
        descLbl.Parent = card

        -- Animação de Entrada (Fade in)
        TweenService:Create(card, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { BackgroundTransparency = 0 }):Play()
        TweenService:Create(cardStroke, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Transparency = 0 }):Play()
        TweenService:Create(titleLbl, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { TextTransparency = 0 }):Play()
        TweenService:Create(descLbl, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { TextTransparency = 0 }):Play()

        task.wait(duration)

        -- Animação de Saída (Fade out)
        local tCard = TweenService:Create(card, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { BackgroundTransparency = 1 })
        TweenService:Create(cardStroke, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { Transparency = 1 }):Play()
        TweenService:Create(titleLbl, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { TextTransparency = 1 }):Play()
        TweenService:Create(descLbl, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { TextTransparency = 1 }):Play()
        tCard:Play()
        tCard.Completed:Wait()
        card:Destroy()
    end)
end

_G.Notify = Notify

-- ============================================================
--  SISTEMA DE CONFIGURAÇÃO (Config Registry)
-- ============================================================
local CONFIG_FOLDER = "wisnuconfig"
local CONFIG_META   = CONFIG_FOLDER .. "/meta.json"
local HttpService   = game:GetService("HttpService")

local ConfigRegistry = {}
local function RegSetting(key, sType, getFn, setFn)
    ConfigRegistry[key] = { type = sType, get = getFn, set = setFn }
end

-- 1. Componente Toggle (Estilo Referência: Pill azul suave + Knob escuro ativo)
local function AddToggle(box, text, defOn, callback, description)
    local hasDescription = type(description) == "string" and description ~= ""
    local row = FT(UDim2.new(1, 0, 0, hasDescription and 42 or 28), nil, box)

    if hasDescription then
        TL(text, 12, C.TXT, false, row, UDim2.new(0, 0, 0, 1), UDim2.new(1, -48, 0, 18))
        local desc = TL(description, 9, C.TXT_DIM, false, row,
            UDim2.new(0, 0, 0, 19), UDim2.new(1, -48, 0, 21))
        desc.TextWrapped = true
        desc.TextYAlignment = Enum.TextYAlignment.Top
    else
        TL(text, 13, C.TXT, false, row, UDim2.new(0, 0, 0, 0), UDim2.new(1, -48, 1, 0))
    end

    local pill = F(defOn == true and C.T_ON or C.T_OFF,
                   UDim2.fromOffset(40, 22), UDim2.new(1, -40, 0.5, -11), row)
    R(11, pill)

    local thumb = F(defOn and C.T_KNOB_ON or C.T_KNOB_OFF,
                    UDim2.fromOffset(16, 16),
                    defOn and UDim2.fromOffset(21, 3) or UDim2.fromOffset(3, 3), pill)
    R(8, thumb)

    local on = (defOn == true)
    local function setVisual(val, fireCallback)
        on = val
        TweenService:Create(pill, TweenInfo.new(0.18), {
            BackgroundColor3 = on and C.T_ON or C.T_OFF
        }):Play()
        TweenService:Create(thumb, TweenInfo.new(0.18), {
            BackgroundColor3 = on and C.T_KNOB_ON or C.T_KNOB_OFF,
            Position = on and UDim2.fromOffset(21, 3) or UDim2.fromOffset(3, 3)
        }):Play()
        if fireCallback and callback then callback(on) end
    end

    pill.InputBegan:Connect(function(i)
        if i.UserInputType ~= Enum.UserInputType.MouseButton1 and i.UserInputType ~= Enum.UserInputType.Touch then return end
        local nextState = not on
        setVisual(nextState, true)
        Notify(text, nextState and "Enabled" or "Disabled", 2)
    end)

    RegisterToggleUpdater(function()
        setVisual(on, false)
    end)

    RegSetting(text, "toggle", function() return on end, function(val) setVisual(val, true) end)

    return row, setVisual, function() return on end
end

-- 2. Componente Botão (Estilo Referência: Cartão escuro arredondado full-width)
local function AddButton(box, text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 36)
    btn.BackgroundColor3 = C.BTN_BG
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    btn.Text = ""
    btn.Parent = box
    R(8, btn)
    local btnStroke = Stroke(C.BOX_STROKE, 1, btn)
    RegisterThemed(btn, "BackgroundColor3", "BTN_BG")
    RegisterThemed(btnStroke, "Color", "BOX_STROKE")

    local btnLbl = TL(text, 13, C.TXT, false, btn,
       UDim2.new(0, 0, 0, 0), UDim2.new(1, 0, 1, 0), Enum.TextXAlignment.Center)

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.12), {BackgroundColor3 = C.BTN_HOV}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.12), {BackgroundColor3 = C.BTN_BG}):Play()
    end)
    btn.MouseButton1Click:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.08), {BackgroundColor3 = Color3.fromRGB(50, 50, 62)}):Play()
        task.delay(0.1, function()
            TweenService:Create(btn, TweenInfo.new(0.12), {BackgroundColor3 = C.BTN_BG}):Play()
        end)
        if callback then callback() end
    end)
    return btn
end

-- 3. Componente Slider (Estilo Referência: UI Scale + valor percentual + linha azul + thumb branco)
local function AddSlider(box, text, minVal, maxVal, defVal, suffix, callback, increment)
    local row = FT(UDim2.new(1, 0, 0, 48), nil, box)

    TL(text, 13, C.TXT, false, row, UDim2.new(0, 0, 0, 0), UDim2.new(0.6, 0, 0, 18))

    local valLbl = TL(tostring(defVal) .. (suffix or ""), 12, C.TXT_MUTED, false, row,
                      UDim2.new(0.6, 0, 0, 0), UDim2.new(0.4, 0, 0, 18), Enum.TextXAlignment.Right)

    local barArea = Instance.new("TextButton")
    barArea.Name = "SliderTrackButton"
    barArea.Size = UDim2.new(1, 0, 0, 20)
    barArea.Position = UDim2.new(0, 0, 0, 24)
    barArea.BackgroundTransparency = 1
    barArea.Text = ""
    barArea.AutoButtonColor = false
    barArea.Active = true
    barArea.Parent = row

    local bgTrack = F(C.SLIDER_BG, UDim2.new(1, 0, 0, 4), UDim2.new(0, 0, 0.5, -2), barArea)
    R(2, bgTrack)
    RegisterThemed(bgTrack, "BackgroundColor3", "SLIDER_BG")

    minVal = tonumber(minVal) or 0
    maxVal = tonumber(maxVal) or 100
    if maxVal < minVal then minVal, maxVal = maxVal, minVal end
    local step = tonumber(increment) or 1
    if step <= 0 then step = 1 end
    local function snapValue(value)
        value = math.clamp(tonumber(value) or minVal, minVal, maxVal)
        local steps = math.floor(((value - minVal) / step) + 0.5)
        local snapped = math.clamp(minVal + steps * step, minVal, maxVal)
        return math.floor(snapped * 10000 + 0.5) / 10000
    end
    local currentVal = snapValue(defVal)
    local pct = (maxVal == minVal) and 0 or math.clamp((currentVal - minVal) / (maxVal - minVal), 0, 1)
    local fill = F(C.SLIDER_FILL, UDim2.new(pct, 0, 1, 0), UDim2.new(0, 0, 0, 0), bgTrack)
    R(2, fill)
    RegisterThemed(fill, "BackgroundColor3", "SLIDER_FILL")

    local knob = F(Color3.fromRGB(255, 255, 255), UDim2.fromOffset(14, 14),
                   UDim2.new(pct, 0, 0.5, 0), barArea)
    knob.AnchorPoint = Vector2.new(0.5, 0.5)
    R(7, knob)

    local function formatSliderValue(value)
        local formatted = string.format("%.4f", value):gsub("0+$", ""):gsub("%.$", "")
        return formatted
    end

    local function setValue(val, fireCallback)
        currentVal = snapValue(val)
        local ratio = (maxVal == minVal) and 0 or math.clamp((currentVal - minVal) / (maxVal - minVal), 0, 1)
        fill.Size = UDim2.new(ratio, 0, 1, 0)
        knob.Position = UDim2.new(ratio, 0, 0.5, 0)
        valLbl.Text = formatSliderValue(currentVal) .. (suffix or "")
        if fireCallback and callback then callback(currentVal) end
    end

    local dragging = false
    local function Update(input)
        local posX = input.Position.X - bgTrack.AbsolutePosition.X
        local ratio = math.clamp(posX / bgTrack.AbsoluteSize.X, 0, 1)
        local val = minVal + (maxVal - minVal) * ratio
        setValue(val, true)
    end

    barArea.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            _G.UISliderDragging = true
            Update(i)
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
            Update(i)
        end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            if dragging then
                dragging = false
                _G.UISliderDragging = false
            end
        end
    end)

    RegSetting(text, "slider", function() return currentVal end, function(val) setValue(val, true) end)

    return row, setValue, function() return currentVal end
end

-- 4. Componente Dropdown (Estilo ReferÃªncia: Label Ã  esquerda + Pill com valor e Ã­cone â‰¡ Ã  direita)
local function AddDropdown(box, text, options, defOption, callback)
    local row = FT(UDim2.new(1, 0, 0, 32), nil, box)

    TL(text, 13, C.TXT, false, row, UDim2.new(0, 0, 0, 0), UDim2.new(0.5, 0, 1, 0))

    local dropBtn = Instance.new("TextButton")
    dropBtn.Size = UDim2.fromOffset(130, 30)
    dropBtn.Position = UDim2.new(1, -130, 0.5, -15)
    dropBtn.BackgroundColor3 = C.BTN_BG
    dropBtn.BorderSizePixel = 0
    dropBtn.AutoButtonColor = false
    dropBtn.Text = ""
    dropBtn.Parent = row
    R(8, dropBtn)
    local dropStroke = Stroke(C.BOX_STROKE, 1, dropBtn)
    RegisterThemed(dropBtn, "BackgroundColor3", "BTN_BG")
    RegisterThemed(dropStroke, "Color", "BOX_STROKE")

    options = type(options) == "table" and options or {}
    local currentIdx = 1
    for idx, opt in ipairs(options) do
        if tostring(opt) == tostring(defOption) then
            currentIdx = idx
            break
        end
    end

    local selLbl = TL(tostring(options[currentIdx] or "None"), 12, C.TXT_MUTED, false, dropBtn,
                      UDim2.new(0, 12, 0, 0), UDim2.new(1, -34, 1, 0))

    local dropIcon = IL("rbxassetid://117942349521535", 14, C.TXT_MUTED, dropBtn, UDim2.new(1, -22, 0.5, -7))

    dropBtn.MouseEnter:Connect(function()
        TweenService:Create(dropBtn, TweenInfo.new(0.12), {BackgroundColor3 = C.BTN_HOV}):Play()
        TweenService:Create(dropIcon, TweenInfo.new(0.12), {ImageColor3 = C.TXT}):Play()
    end)
    dropBtn.MouseLeave:Connect(function()
        TweenService:Create(dropBtn, TweenInfo.new(0.12), {BackgroundColor3 = C.BTN_BG}):Play()
        TweenService:Create(dropIcon, TweenInfo.new(0.12), {ImageColor3 = C.TXT_MUTED}):Play()
    end)
    local function setOption(optName, fireCallback)
        for idx, opt in ipairs(options) do
            if tostring(opt):lower() == tostring(optName):lower() or opt == optName then
                currentIdx = idx
                selLbl.Text = tostring(options[currentIdx])
                if fireCallback and callback then callback(options[currentIdx]) end
                return true
            end
        end
        return false
    end

    local function setValues(newOptions, selected, fireCallback)
        options = type(newOptions) == "table" and newOptions or {}
        currentIdx = 1
        if #options > 0 then
            if selected ~= nil then
                for idx, opt in ipairs(options) do
                    if tostring(opt) == tostring(selected) then currentIdx = idx; break end
                end
            end
            selLbl.Text = tostring(options[currentIdx])
            if fireCallback and callback then callback(options[currentIdx]) end
        else
            selLbl.Text = "None"
        end
    end

    dropBtn.MouseButton1Click:Connect(function()
        if #options == 0 then return end
        currentIdx = (currentIdx % #options) + 1
        selLbl.Text = tostring(options[currentIdx])
        if callback then callback(options[currentIdx]) end
    end)

    RegSetting(text, "dropdown", function() return options[currentIdx] end, function(opt) setOption(opt, true) end)

    return row, setOption, setValues, function() return options[currentIdx] end
end

-- 5. Componente Keybind (Estilo ReferÃªncia: Tag arredondada clicÃ¡vel Ã  direita com tecla)
local function AddKeybind(box, text, defKey, callback)
    local row = FT(UDim2.new(1, 0, 0, 32), nil, box)
    TL(text, 13, C.TXT, false, row, UDim2.new(0, 0, 0, 0), UDim2.new(1, -95, 1, 0))

    local currentKey = defKey
    local listening = false

    local keyBtn = Instance.new("TextButton")
    keyBtn.Size = UDim2.fromOffset(88, 24)
    keyBtn.Position = UDim2.new(1, -88, 0.5, -12)
    keyBtn.BackgroundColor3 = C.BTN_BG
    keyBtn.BorderSizePixel = 0
    keyBtn.AutoButtonColor = false
    keyBtn.Text = ""
    keyBtn.Parent = row
    R(6, keyBtn)
    local s = Stroke(C.BOX_STROKE, 1, keyBtn)
    RegisterThemed(keyBtn, "BackgroundColor3", "BTN_BG")
    RegisterThemed(s, "Color", "BOX_STROKE")

    local keyLbl = TL("[" .. currentKey.Name .. "]", 11, C.TXT_MUTED, true, keyBtn,
                      UDim2.new(0, 0, 0, 0), UDim2.new(1, 0, 1, 0), Enum.TextXAlignment.Center)
    RegisterThemed(keyLbl, "TextColor3", "TXT_MUTED")

    local function setKey(key, fireCallback)
        if typeof(key) == "EnumItem" then
            currentKey = key
            keyLbl.Text = "[" .. currentKey.Name .. "]"
            if fireCallback and callback then callback(currentKey) end
        end
    end

    keyBtn.MouseEnter:Connect(function()
        if not listening then
            TweenService:Create(keyBtn, TweenInfo.new(0.12), {BackgroundColor3 = C.BTN_HOV}):Play()
        end
    end)
    keyBtn.MouseLeave:Connect(function()
        if not listening then
            TweenService:Create(keyBtn, TweenInfo.new(0.12), {BackgroundColor3 = C.BTN_BG}):Play()
        end
    end)

    keyBtn.MouseButton1Click:Connect(function()
        if listening then return end
        listening = true
        keyLbl.Text = "[ ... ]"
        keyLbl.TextColor3 = Color3.fromRGB(255, 220, 100)
        s.Color = Color3.fromRGB(152, 185, 245)

        local conn
        conn = UserInputService.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Keyboard then
                conn:Disconnect()
                listening = false
                currentKey = input.KeyCode
                keyLbl.Text = "[" .. currentKey.Name .. "]"
                keyLbl.TextColor3 = C.TXT_MUTED
                s.Color = C.BOX_STROKE
                TweenService:Create(keyBtn, TweenInfo.new(0.12), {BackgroundColor3 = C.BTN_BG}):Play()
                if callback then callback(currentKey) end
            end
        end)
    end)

    RegSetting(text, "keybind", function() return currentKey end, function(key) setKey(key, true) end)

    return row, setKey, function() return currentKey end
end

-- ============================================================
--  MODAL COLOR PICKER (JANELA DEDICADA COM BORDA GIRATÓRIA)
--  Estilo idÃªntico Ã  referÃªncia: Canvas 2D + Hue + Alpha + Inputs +
--  Borda branca que gira (AddGlowBorder) e cores padrão da UI
-- ============================================================
local ColorPickerModal = nil
local OpenColorPicker = nil

local function EnsureColorPickerModal()
    if ColorPickerModal then return end

    ColorPickerModal = Instance.new("Frame")
    ColorPickerModal.Name = "ColorPickerModal"
    ColorPickerModal.Size = UDim2.fromOffset(430, 280)
    ColorPickerModal.Position = UDim2.new(0.5, -215, 0.5, -140)
    ColorPickerModal.BackgroundColor3 = C.WIN
    ColorPickerModal.BorderSizePixel = 0
    ColorPickerModal.ZIndex = 150
    ColorPickerModal.Visible = false
    ColorPickerModal.Parent = Gui
    R(16, ColorPickerModal)
    RegisterThemed(ColorPickerModal, "BackgroundColor3", "WIN")

    -- Borda branca que gira com AddGlowBorder (idÃªntico Ã  janela principal!)
    AddGlowBorder(ColorPickerModal, 2, 3)

    -- Header com Título e Botão de Fechar
    local header = Instance.new("Frame")
    header.Name = "Header"
    header.BackgroundTransparency = 1
    header.Size = UDim2.new(1, 0, 0, 38)
    header.ZIndex = 151
    header.Parent = ColorPickerModal

    local titleLbl = TL("Color Picker", 15, Color3.fromRGB(245, 245, 250), true, header,
                        UDim2.new(0, 18, 0, 0), UDim2.new(1, -55, 1, 0))
    titleLbl.ZIndex = 151

    local closeBtn = Instance.new("ImageButton")
    closeBtn.Name = "CloseBtn"
    closeBtn.Size = UDim2.fromOffset(18, 18)
    closeBtn.Position = UDim2.new(1, -32, 0.5, -9)
    closeBtn.BackgroundTransparency = 1
    closeBtn.Image = "rbxassetid://116396312853810"
    closeBtn.ImageColor3 = C.TXT_MUTED
    closeBtn.ScaleType = Enum.ScaleType.Fit
    closeBtn.ZIndex = 151
    closeBtn.Parent = header
    RegisterThemed(closeBtn, "ImageColor3", "TXT_MUTED")

    closeBtn.MouseEnter:Connect(function()
        TweenService:Create(closeBtn, TweenInfo.new(0.12), {ImageColor3 = Color3.fromRGB(255, 255, 255)}):Play()
    end)
    closeBtn.MouseLeave:Connect(function()
        TweenService:Create(closeBtn, TweenInfo.new(0.12), {ImageColor3 = C.TXT_MUTED}):Play()
    end)

    Drag(ColorPickerModal, header)

    -- Corpo do Modal
    local body = Instance.new("Frame")
    body.Name = "Body"
    body.BackgroundTransparency = 1
    body.Size = UDim2.new(1, -36, 0, 172)
    body.Position = UDim2.new(0, 18, 0, 42)
    body.ZIndex = 151
    body.Parent = ColorPickerModal

    local curH, curS, curV = 0, 1, 1
    local curA = 1
    local origColor = Color3.fromRGB(255, 0, 0)
    local activeCallback = nil

    -- 1. Canvas 2D (Saturação x Brilho/Value)
    local canvasFrame = Instance.new("Frame")
    canvasFrame.Name = "Canvas2D"
    canvasFrame.Size = UDim2.fromOffset(145, 132)
    canvasFrame.Position = UDim2.new(0, 0, 0, 0)
    canvasFrame.BackgroundColor3 = Color3.fromHSV(curH, 1, 1)
    canvasFrame.BorderSizePixel = 0
    canvasFrame.ClipsDescendants = true
    canvasFrame.ZIndex = 152
    canvasFrame.Parent = body
    R(8, canvasFrame)

    local whiteLayer = Instance.new("Frame")
    whiteLayer.Size = UDim2.new(1, 0, 1, 0)
    whiteLayer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    whiteLayer.BorderSizePixel = 0
    whiteLayer.ZIndex = 152
    whiteLayer.Parent = canvasFrame
    local wGrad = Instance.new("UIGradient")
    wGrad.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(1, 1)
    })
    wGrad.Rotation = 0
    wGrad.Parent = whiteLayer

    local blackLayer = Instance.new("Frame")
    blackLayer.Size = UDim2.new(1, 0, 1, 0)
    blackLayer.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    blackLayer.BorderSizePixel = 0
    blackLayer.ZIndex = 153
    blackLayer.Parent = canvasFrame
    local bGrad = Instance.new("UIGradient")
    bGrad.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(1, 0)
    })
    bGrad.Rotation = 90
    bGrad.Parent = blackLayer

    local canvasKnob = Instance.new("Frame")
    canvasKnob.Name = "CanvasKnob"
    canvasKnob.Size = UDim2.fromOffset(16, 16)
    canvasKnob.AnchorPoint = Vector2.new(0.5, 0.5)
    canvasKnob.Position = UDim2.new(curS, 0, 1 - curV, 0)
    canvasKnob.BackgroundColor3 = Color3.fromHSV(curH, curS, curV)
    canvasKnob.BorderSizePixel = 0
    canvasKnob.ZIndex = 154
    canvasKnob.Parent = canvasFrame
    R(8, canvasKnob)
    Stroke(Color3.fromRGB(255, 255, 255), 2, canvasKnob)

    -- Pílulas Original vs Nova
    local previewPills = Instance.new("Frame")
    previewPills.BackgroundTransparency = 1
    previewPills.Size = UDim2.fromOffset(145, 26)
    previewPills.Position = UDim2.new(0, 0, 0, 140)
    previewPills.ZIndex = 152
    previewPills.Parent = body

    local oldColorPill = Instance.new("TextButton")
    oldColorPill.Name = "OldColorPill"
    oldColorPill.Size = UDim2.new(0.48, -2, 1, 0)
    oldColorPill.Position = UDim2.new(0, 0, 0, 0)
    oldColorPill.BackgroundColor3 = origColor
    oldColorPill.BorderSizePixel = 0
    oldColorPill.AutoButtonColor = false
    oldColorPill.Text = ""
    oldColorPill.ZIndex = 152
    oldColorPill.Parent = previewPills
    R(7, oldColorPill)
    Stroke(Color3.fromRGB(50, 50, 60), 1, oldColorPill)

    local newColorPill = Instance.new("Frame")
    newColorPill.Name = "NewColorPill"
    newColorPill.Size = UDim2.new(0.48, -2, 1, 0)
    newColorPill.Position = UDim2.new(0.52, 2, 0, 0)
    newColorPill.BackgroundColor3 = Color3.fromHSV(curH, curS, curV)
    newColorPill.BorderSizePixel = 0
    newColorPill.ZIndex = 152
    newColorPill.Parent = previewPills
    R(7, newColorPill)
    Stroke(Color3.fromRGB(90, 90, 110), 1, newColorPill)

    -- 2. Barra de Hue (Vertical)
    local hueBar = Instance.new("Frame")
    hueBar.Name = "HueBar"
    hueBar.Size = UDim2.fromOffset(12, 166)
    hueBar.Position = UDim2.new(0, 157, 0, 0)
    hueBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    hueBar.BorderSizePixel = 0
    hueBar.ZIndex = 152
    hueBar.Parent = body
    R(6, hueBar)

    local hueGrad = Instance.new("UIGradient")
    hueGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0,    Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 255)),
        ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
        ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
        ColorSequenceKeypoint.new(1,    Color3.fromRGB(255, 0, 0)),
    })
    hueGrad.Rotation = 90
    hueGrad.Parent = hueBar

    local hueKnob = Instance.new("Frame")
    hueKnob.Name = "HueKnob"
    hueKnob.Size = UDim2.fromOffset(18, 18)
    hueKnob.AnchorPoint = Vector2.new(0.5, 0.5)
    hueKnob.Position = UDim2.new(0.5, 0, curH, 0)
    hueKnob.BackgroundColor3 = Color3.fromHSV(curH, 1, 1)
    hueKnob.BorderSizePixel = 0
    hueKnob.ZIndex = 153
    hueKnob.Parent = hueBar
    R(9, hueKnob)
    Stroke(Color3.fromRGB(255, 255, 255), 2, hueKnob)

    -- 3. Barra de Alpha (Vertical)
    local alphaBar = Instance.new("Frame")
    alphaBar.Name = "AlphaBar"
    alphaBar.Size = UDim2.fromOffset(12, 166)
    alphaBar.Position = UDim2.new(0, 178, 0, 0)
    alphaBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    alphaBar.BorderSizePixel = 0
    alphaBar.ZIndex = 152
    alphaBar.Parent = body
    R(6, alphaBar)

    local alphaGrad = Instance.new("UIGradient")
    alphaGrad.Color = ColorSequence.new(Color3.fromHSV(curH, curS, curV))
    alphaGrad.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(1, 1)
    })
    alphaGrad.Rotation = 90
    alphaGrad.Parent = alphaBar

    local alphaKnob = Instance.new("Frame")
    alphaKnob.Name = "AlphaKnob"
    alphaKnob.Size = UDim2.fromOffset(18, 18)
    alphaKnob.AnchorPoint = Vector2.new(0.5, 0.5)
    alphaKnob.Position = UDim2.new(0.5, 0, 1 - curA, 0)
    alphaKnob.BackgroundColor3 = Color3.fromHSV(curH, curS, curV)
    alphaKnob.BorderSizePixel = 0
    alphaKnob.ZIndex = 153
    alphaKnob.Parent = alphaBar
    R(9, alphaKnob)
    Stroke(Color3.fromRGB(255, 255, 255), 2, alphaKnob)

    -- 4. Caixas de Valores (Hex, Red, Green, Blue, Alpha)
    local boxesContainer = Instance.new("Frame")
    boxesContainer.Name = "Boxes"
    boxesContainer.BackgroundTransparency = 1
    boxesContainer.Size = UDim2.new(1, -202, 0, 166)
    boxesContainer.Position = UDim2.new(0, 202, 0, 0)
    boxesContainer.ZIndex = 152
    boxesContainer.Parent = body

    local boxLayout = Instance.new("UIListLayout")
    boxLayout.SortOrder = Enum.SortOrder.LayoutOrder
    boxLayout.Padding = UDim.new(0, 6)
    boxLayout.Parent = boxesContainer

    local function CreateValueBox(name, defVal, order)
        local bFrame = Instance.new("Frame")
        bFrame.Name = "Box_" .. name
        bFrame.BackgroundColor3 = C.BOX_BG
    RegisterThemed(bFrame, "BackgroundColor3", "BOX_BG")
        bFrame.BorderSizePixel = 0
        bFrame.Size = UDim2.new(1, 0, 0, 28)
        bFrame.LayoutOrder = order
        bFrame.ZIndex = 152
        bFrame.Parent = boxesContainer
        R(7, bFrame)
        local valBoxStroke = Stroke(C.BOX_STROKE, 1, bFrame)
        RegisterThemed(valBoxStroke, "Color", "BOX_STROKE")

        local valLbl = Instance.new("TextLabel")
        valLbl.Size = UDim2.new(1, -48, 1, 0)
        valLbl.Position = UDim2.new(0, 10, 0, 0)
        valLbl.BackgroundTransparency = 1
        valLbl.Font = Enum.Font.Code
        valLbl.TextSize = 12
        valLbl.TextColor3 = C.TXT
        valLbl.Text = defVal
        valLbl.TextXAlignment = Enum.TextXAlignment.Left
        valLbl.ZIndex = 153
        valLbl.Parent = bFrame
        RegisterThemed(valLbl, "TextColor3", "TXT")

        local tagLbl = Instance.new("TextLabel")
        tagLbl.Size = UDim2.new(0, 42, 1, 0)
        tagLbl.Position = UDim2.new(1, -46, 0, 0)
        tagLbl.BackgroundTransparency = 1
        tagLbl.Font = Enum.Font.Gotham
        tagLbl.TextSize = 11
        tagLbl.TextColor3 = C.TXT_MUTED
        tagLbl.Text = name
        tagLbl.TextXAlignment = Enum.TextXAlignment.Right
        tagLbl.ZIndex = 153
        tagLbl.Parent = bFrame
        RegisterThemed(tagLbl, "TextColor3", "TXT_MUTED")

        return valLbl
    end

    local hexValLbl   = CreateValueBox("Hex",   "#ff0000", 1)
    local redValLbl   = CreateValueBox("Red",   "255",     2)
    local greenValLbl = CreateValueBox("Green", "0",       3)
    local blueValLbl  = CreateValueBox("Blue",  "0",       4)
    local alphaValLbl = CreateValueBox("Alpha", "100%",    5)

    local function UpdateVisuals()
        local col = Color3.fromHSV(curH, curS, curV)
        canvasFrame.BackgroundColor3 = Color3.fromHSV(curH, 1, 1)
        canvasKnob.Position = UDim2.new(curS, 0, 1 - curV, 0)
        canvasKnob.BackgroundColor3 = col

        hueKnob.Position = UDim2.new(0.5, 0, curH, 0)
        hueKnob.BackgroundColor3 = Color3.fromHSV(curH, 1, 1)

        alphaGrad.Color = ColorSequence.new(col)
        alphaKnob.Position = UDim2.new(0.5, 0, 1 - curA, 0)
        alphaKnob.BackgroundColor3 = col

        newColorPill.BackgroundColor3 = col

        local r = math.round(col.R * 255)
        local g = math.round(col.G * 255)
        local b = math.round(col.B * 255)

        hexValLbl.Text   = string.format("#%02x%02x%02x", r, g, b)
        redValLbl.Text   = tostring(r)
        greenValLbl.Text = tostring(g)
        blueValLbl.Text  = tostring(b)
        alphaValLbl.Text = math.round(curA * 100) .. "%"
    end

    local dragCanvas = false
    canvasFrame.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dragCanvas = true
            local relX = math.clamp((i.Position.X - canvasFrame.AbsolutePosition.X) / canvasFrame.AbsoluteSize.X, 0, 1)
            local relY = math.clamp((i.Position.Y - canvasFrame.AbsolutePosition.Y) / canvasFrame.AbsoluteSize.Y, 0, 1)
            curS = relX
            curV = 1 - relY
            UpdateVisuals()
        end
    end)

    local dragHue = false
    hueBar.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dragHue = true
            curH = math.clamp((i.Position.Y - hueBar.AbsolutePosition.Y) / hueBar.AbsoluteSize.Y, 0, 1)
            UpdateVisuals()
        end
    end)

    local dragAlpha = false
    alphaBar.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dragAlpha = true
            curA = 1 - math.clamp((i.Position.Y - alphaBar.AbsolutePosition.Y) / alphaBar.AbsoluteSize.Y, 0, 1)
            UpdateVisuals()
        end
    end)

    UserInputService.InputChanged:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch then
            if dragCanvas then
                local relX = math.clamp((i.Position.X - canvasFrame.AbsolutePosition.X) / canvasFrame.AbsoluteSize.X, 0, 1)
                local relY = math.clamp((i.Position.Y - canvasFrame.AbsolutePosition.Y) / canvasFrame.AbsoluteSize.Y, 0, 1)
                curS = relX
                curV = 1 - relY
                UpdateVisuals()
            elseif dragHue then
                curH = math.clamp((i.Position.Y - hueBar.AbsolutePosition.Y) / hueBar.AbsoluteSize.Y, 0, 1)
                UpdateVisuals()
            elseif dragAlpha then
                curA = 1 - math.clamp((i.Position.Y - alphaBar.AbsolutePosition.Y) / alphaBar.AbsoluteSize.Y, 0, 1)
                UpdateVisuals()
            end
        end
    end)

    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dragCanvas = false
            dragHue = false
            dragAlpha = false
        end
    end)

    oldColorPill.MouseButton1Click:Connect(function()
        curH, curS, curV = Color3.toHSV(origColor)
        UpdateVisuals()
    end)

    -- 5. Rodapé: Cancelar e Apply
    local footer = Instance.new("Frame")
    footer.Name = "Footer"
    footer.BackgroundTransparency = 1
    footer.Size = UDim2.new(1, -36, 0, 36)
    footer.Position = UDim2.new(0, 18, 1, -48)
    footer.ZIndex = 152
    footer.Parent = ColorPickerModal

    local cancelBtn = Instance.new("TextButton")
    cancelBtn.Name = "CancelBtn"
    cancelBtn.Size = UDim2.new(0.48, -4, 1, 0)
    cancelBtn.Position = UDim2.new(0, 0, 0, 0)
    cancelBtn.BackgroundColor3 = C.BTN_BG
    RegisterThemed(cancelBtn, "BackgroundColor3", "BTN_BG")
    cancelBtn.BorderSizePixel = 0
    cancelBtn.AutoButtonColor = false
    cancelBtn.Text = "Cancelar"
    cancelBtn.Font = Enum.Font.GothamBold
    cancelBtn.TextSize = 13
    cancelBtn.TextColor3 = C.TXT
    cancelBtn.ZIndex = 153
    cancelBtn.Parent = footer
    R(10, cancelBtn)
    Stroke(C.BOX_STROKE, 1, cancelBtn)

    cancelBtn.MouseEnter:Connect(function()
        TweenService:Create(cancelBtn, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(44, 44, 54)}):Play()
    end)
    cancelBtn.MouseLeave:Connect(function()
        TweenService:Create(cancelBtn, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(34, 34, 42)}):Play()
    end)
    cancelBtn.MouseButton1Click:Connect(function()
        ColorPickerModal.Visible = false
    end)
    closeBtn.MouseButton1Click:Connect(function()
        ColorPickerModal.Visible = false
    end)

    local applyBtn = Instance.new("TextButton")
    applyBtn.Name = "ApplyBtn"
    applyBtn.Size = UDim2.new(0.52, -4, 1, 0)
    applyBtn.Position = UDim2.new(0.48, 8, 0, 0)
    applyBtn.BackgroundColor3 = Color3.fromRGB(225, 225, 232)
    applyBtn.BorderSizePixel = 0
    applyBtn.AutoButtonColor = false
    applyBtn.Text = "Apply"
    applyBtn.Font = Enum.Font.GothamBold
    applyBtn.TextSize = 13
    applyBtn.TextColor3 = Color3.fromRGB(20, 20, 25)
    applyBtn.ZIndex = 153
    applyBtn.Parent = footer
    R(10, applyBtn)

    applyBtn.MouseEnter:Connect(function()
        TweenService:Create(applyBtn, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(245, 245, 250)}):Play()
    end)
    applyBtn.MouseLeave:Connect(function()
        TweenService:Create(applyBtn, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(225, 225, 232)}):Play()
    end)
    applyBtn.MouseButton1Click:Connect(function()
        local finalColor = Color3.fromHSV(curH, curS, curV)
        ColorPickerModal.Visible = false
        if activeCallback then activeCallback(finalColor, curA) end
    end)

    OpenColorPicker = function(titleText, initialColor, onApply)
        titleLbl.Text = titleText or "Color Picker"
        origColor = initialColor or Color3.fromRGB(255, 0, 0)
        oldColorPill.BackgroundColor3 = origColor
        curH, curS, curV = Color3.toHSV(origColor)
        curA = 1
        activeCallback = onApply
        UpdateVisuals()

        ColorPickerModal.Visible = true
        ColorPickerModal.Position = UDim2.new(0.5, -215, 0.5, -140)
    end
end

-- 6. Componente Toggle com Seletor de Cores Expansível (Arrow + Drawer + Color Square -> Color Picker Modal)
local function AddToggleWithColor(box, text, defOn, toggleCallback, colorLabel, defColor, colorCallback)
    local container = Instance.new("Frame")
    container.Name = "ToggleColor_" .. text
    container.BackgroundTransparency = 1
    container.BorderSizePixel = 0
    container.Size = UDim2.new(1, 0, 0, 0)
    container.AutomaticSize = Enum.AutomaticSize.Y
    container.Parent = box

    local containerLayout = Instance.new("UIListLayout")
    containerLayout.SortOrder = Enum.SortOrder.LayoutOrder
    containerLayout.Padding = UDim.new(0, 6)
    containerLayout.Parent = container

    -- 1. Linha Principal (Seta + Título + Toggle Pill)
    local row = Instance.new("Frame")
    row.Name = "MainRow"
    row.BackgroundTransparency = 1
    row.BorderSizePixel = 0
    row.Size = UDim2.new(1, 0, 0, 28)
    row.LayoutOrder = 1
    row.Parent = container

    -- Ãcone lateral expansÃ­vel Ã  esquerda do tÃ­tulo (asset id 88468571469051)
    local arrowBtn = Instance.new("TextButton")
    arrowBtn.Name = "ArrowBtn"
    arrowBtn.Size = UDim2.fromOffset(24, 28)
    arrowBtn.Position = UDim2.new(0, 0, 0, 0)
    arrowBtn.BackgroundTransparency = 1
    arrowBtn.Text = ""
    arrowBtn.Parent = row

    local arrowIcon = Instance.new("ImageLabel")
    arrowIcon.Name = "ArrowIcon"
    arrowIcon.Size = UDim2.fromOffset(15, 15)
    arrowIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
    arrowIcon.AnchorPoint = Vector2.new(0.5, 0.5)
    arrowIcon.BackgroundTransparency = 1
    arrowIcon.Image = "rbxassetid://88468571469051"
    arrowIcon.ImageColor3 = C.TXT_MUTED
    arrowIcon.ScaleType = Enum.ScaleType.Fit
    arrowIcon.Parent = arrowBtn
    RegisterThemed(arrowIcon, "ImageColor3", "TXT_MUTED")

    -- Título da opção clicável também para expandir
    local titleBtn = Instance.new("TextButton")
    titleBtn.Name = "TitleBtn"
    titleBtn.Size = UDim2.new(1, -72, 1, 0)
    titleBtn.Position = UDim2.new(0, 26, 0, 0)
    titleBtn.BackgroundTransparency = 1
    titleBtn.Text = ""
    titleBtn.Parent = row

    local titleLbl = TL(text, 13, C.TXT, false, titleBtn, UDim2.new(0, 0, 0, 0), UDim2.new(1, 0, 1, 0))

    -- Pill Toggle na direita
    local pill = F(defOn and C.T_ON or C.T_OFF,
                   UDim2.fromOffset(40, 22), UDim2.new(1, -40, 0.5, -11), row)
    R(11, pill)

    local thumb = F(defOn and C.T_KNOB_ON or C.T_KNOB_OFF,
                    UDim2.fromOffset(16, 16),
                    defOn and UDim2.fromOffset(21, 3) or UDim2.fromOffset(3, 3), pill)
    R(8, thumb)

    local on = defOn
    local function setVisual(val, fireCallback)
        on = val
        TweenService:Create(pill, TweenInfo.new(0.18), {
            BackgroundColor3 = on and C.T_ON or C.T_OFF
        }):Play()
        TweenService:Create(thumb, TweenInfo.new(0.18), {
            BackgroundColor3 = on and C.T_KNOB_ON or C.T_KNOB_OFF,
            Position = on and UDim2.fromOffset(21, 3) or UDim2.fromOffset(3, 3)
        }):Play()
        if fireCallback and toggleCallback then toggleCallback(on) end
    end

    pill.InputBegan:Connect(function(i)
        if i.UserInputType ~= Enum.UserInputType.MouseButton1 and i.UserInputType ~= Enum.UserInputType.Touch then return end
        local nextState = not on
        setVisual(nextState, true)
        Notify(text, nextState and "Enabled" or "Disabled", 2)
    end)

    -- 2. Drawer Expansível (Abaixo da opção)
    local drawer = Instance.new("Frame")
    drawer.Name = "ColorDrawer"
    drawer.BackgroundColor3 = C.BOX_BG
    RegisterThemed(drawer, "BackgroundColor3", "BOX_BG")
    drawer.BorderSizePixel = 0
    drawer.Size = UDim2.new(1, 0, 0, 0)
    drawer.AutomaticSize = Enum.AutomaticSize.Y
    drawer.LayoutOrder = 2
    drawer.Visible = false
    drawer.Parent = container
    R(8, drawer)
    Stroke(C.BOX_STROKE, 1, drawer)

    local drawerPad = Instance.new("UIPadding")
    drawerPad.PaddingLeft = UDim.new(0, 12)
    drawerPad.PaddingRight = UDim.new(0, 12)
    drawerPad.PaddingTop = UDim.new(0, 10)
    drawerPad.PaddingBottom = UDim.new(0, 10)
    drawerPad.Parent = drawer

    local drawerLayout = Instance.new("UIListLayout")
    drawerLayout.SortOrder = Enum.SortOrder.LayoutOrder
    drawerLayout.Padding = UDim.new(0, 10)
    drawerLayout.Parent = drawer

    local expanded = false
    local function ToggleExpand()
        expanded = not expanded
        drawer.Visible = expanded
        TweenService:Create(arrowIcon, TweenInfo.new(0.18), {
            Rotation = expanded and 90 or 0,
            ImageColor3 = expanded and C.TXT or C.TXT_MUTED
        }):Play()
    end

    arrowBtn.MouseButton1Click:Connect(ToggleExpand)
    titleBtn.MouseButton1Click:Connect(ToggleExpand)

    arrowBtn.MouseEnter:Connect(function()
        TweenService:Create(arrowIcon, TweenInfo.new(0.12), {ImageColor3 = C.TXT}):Play()
    end)
    arrowBtn.MouseLeave:Connect(function()
        if not expanded then
            TweenService:Create(arrowIcon, TweenInfo.new(0.12), {ImageColor3 = C.TXT_MUTED}):Play()
        end
    end)

    -- Linha de Resumo de Cor: "Color <Item>" + Quadrado com a cor
    local colorRow = Instance.new("Frame")
    colorRow.Name = "ColorSummaryRow"
    colorRow.BackgroundTransparency = 1
    colorRow.Size = UDim2.new(1, 0, 0, 26)
    colorRow.LayoutOrder = 1
    colorRow.Parent = drawer

    TL(colorLabel or ("Color " .. text), 12, C.TXT, false, colorRow,
       UDim2.new(0, 0, 0, 0), UDim2.new(1, -40, 1, 0))

    -- Quadrado com a cor
    local curColor = defColor or Color3.fromRGB(255, 60, 60)

    local colorBtn = Instance.new("TextButton")
    colorBtn.Name = "ColorSquare"
    colorBtn.Size = UDim2.fromOffset(26, 26)
    colorBtn.Position = UDim2.new(1, -26, 0.5, -13)
    colorBtn.BackgroundColor3 = curColor
    colorBtn.BorderSizePixel = 0
    colorBtn.AutoButtonColor = false
    colorBtn.Text = ""
    colorBtn.Parent = colorRow
    R(6, colorBtn)
    local colorStroke = Stroke(Color3.fromRGB(80, 80, 95), 1.5, colorBtn)

    colorBtn.MouseEnter:Connect(function()
        TweenService:Create(colorBtn, TweenInfo.new(0.12), {Size = UDim2.fromOffset(28, 28), Position = UDim2.new(1, -27, 0.5, -14)}):Play()
        colorStroke.Color = Color3.fromRGB(255, 255, 255)
    end)
    colorBtn.MouseLeave:Connect(function()
        TweenService:Create(colorBtn, TweenInfo.new(0.12), {Size = UDim2.fromOffset(26, 26), Position = UDim2.new(1, -26, 0.5, -13)}):Play()
        colorStroke.Color = Color3.fromRGB(80, 80, 95)
    end)

    local finalColorLabel = colorLabel or (text .. " Color")
    local function setColorVisual(col, fireCallback)
        curColor = col
        colorBtn.BackgroundColor3 = col
        if fireCallback and colorCallback then colorCallback(col) end
    end

    -- Clique no quadrado abre a janela modal de cores (estilo referência!)
    colorBtn.MouseButton1Click:Connect(function()
        EnsureColorPickerModal()
        OpenColorPicker(finalColorLabel, curColor, function(newColor, alpha)
            setColorVisual(newColor, true)
        end)
    end)

    RegisterToggleUpdater(function()
        setVisual(on, false)
    end)

    RegSetting(text, "toggle", function() return on end, function(val) setVisual(val, true) end)
    RegSetting(finalColorLabel, "color", function() return curColor end, function(col) setColorVisual(col, true) end)

    return container, setVisual, setColorVisual
end

-- ============================================================
--  COMPONENTES BLOQUEADOS PARA O PAINEL FREE (COM CADEADO)
--  Asset ID do cadeado solicitado: 119765975153029
-- ============================================================
local LOCK_ICON_ASSET = "rbxassetid://119765975153029"

-- 1. Toggle Bloqueado (Cadeado exatamente ao lado da chave de ativação)
local function AddLockedToggle(box, text, defOn, callback)
    local row = FT(UDim2.new(1, 0, 0, 28), nil, box)

    TL(text, 13, C.TXT, false, row, UDim2.new(0, 0, 0, 0), UDim2.new(1, -72, 1, 0))

    -- Cadeado posicionado imediatamente ao lado esquerdo da chave de ativação
    local lockIcon = IL(LOCK_ICON_ASSET, 15, C.TXT_MUTED, row, UDim2.new(1, -64, 0.5, -7.5))

    local pill = F(C.T_OFF, UDim2.fromOffset(40, 22), UDim2.new(1, -40, 0.5, -11), row)
    R(11, pill)

    local thumb = F(C.T_KNOB_OFF, UDim2.fromOffset(16, 16), UDim2.fromOffset(3, 3), pill)
    R(8, thumb)

    local lastNotify = 0
    local function notifyLocked()
        local now = tick()
        if now - lastNotify < 0.8 then return end
        lastNotify = now
        Notify("Premium Feature", text .. " is exclusive to Premium keys!", 2.5)
    end

    row.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            notifyLocked()
        end
    end)

    local function setVisual(val, fireCallback)
        -- No painel free, a opção permanece sempre desativada
    end

    return row, setVisual
end

-- 2. Toggle com cor bloqueado (Ex: Veil Show Target Laser)
local function AddLockedToggleWithColor(box, text, defOn, toggleCallback, colorLabel, defColor, colorCallback)
    local container = Instance.new("Frame")
    container.Name = "LockedToggleColor_" .. text
    container.BackgroundTransparency = 1
    container.BorderSizePixel = 0
    container.Size = UDim2.new(1, 0, 0, 28)
    container.Parent = box

    TL(text, 13, C.TXT, false, container, UDim2.new(0, 0, 0, 0), UDim2.new(1, -72, 1, 0))

    -- Cadeado posicionado ao lado da chave de ativação
    local lockIcon = IL(LOCK_ICON_ASSET, 15, C.TXT_MUTED, container, UDim2.new(1, -64, 0.5, -7.5))

    local pill = F(C.T_OFF, UDim2.fromOffset(40, 22), UDim2.new(1, -40, 0.5, -11), container)
    R(11, pill)

    local thumb = F(C.T_KNOB_OFF, UDim2.fromOffset(16, 16), UDim2.fromOffset(3, 3), pill)
    R(8, thumb)

    local lastNotify = 0
    local function notifyLocked()
        local now = tick()
        if now - lastNotify < 0.8 then return end
        lastNotify = now
        Notify("Premium Feature", text .. " is exclusive to Premium keys!", 2.5)
    end

    container.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            notifyLocked()
        end
    end)

    local function setVisual(val, fireCallback) end
    local function setColorVisual(col, fireCallback) end

    return container, setVisual, setColorVisual
end

-- 3. Slider Bloqueado com Cadeado
local function AddLockedSlider(box, text, minVal, maxVal, defVal, suffix, callback)
    local row = FT(UDim2.new(1, 0, 0, 46), nil, box)

    local titleLbl = TL(text, 13, C.TXT, false, row, UDim2.new(0, 0, 0, 0), UDim2.new(0.65, 0, 0, 20))

    -- ExibiÃ§Ã£o de valor com cadeado Ã  direita
    local valLbl = TL(tostring(defVal) .. (suffix or ""), 12, C.TXT_MUTED, false, row,
                      UDim2.new(0.65, 0, 0, 0), UDim2.new(0.35, -22, 0, 20), Enum.TextXAlignment.Right)

    local lockIcon = IL(LOCK_ICON_ASSET, 14, C.TXT_MUTED, row, UDim2.new(1, -16, 0, 3))

    local sliderBg = F(C.SLIDER_BG, UDim2.new(1, 0, 0, 4), UDim2.new(0, 0, 0, 28), row)
    R(2, sliderBg)

    local pct = math.clamp((defVal - minVal) / (maxVal - minVal), 0, 1)
    local fill = F(Color3.fromRGB(70, 70, 80), UDim2.new(pct, 0, 1, 0), UDim2.new(0, 0, 0, 0), sliderBg)
    R(2, fill)

    local thumb = F(Color3.fromRGB(110, 110, 120), UDim2.fromOffset(12, 12), UDim2.new(pct, -6, 0.5, -6), sliderBg)
    R(6, thumb)

    local lastSliderNotify = 0
    row.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            local now = tick()
            if now - lastSliderNotify < 0.8 then return end
            lastSliderNotify = now
            Notify("Premium Feature", text .. " is exclusive to Premium keys!", 2)
        end
    end)

    return row
end

-- 4. Keybind Bloqueado com Cadeado
local function AddLockedKeybind(box, text, defKey, callback)
    local row = FT(UDim2.new(1, 0, 0, 32), nil, box)
    TL(text, 13, C.TXT, false, row, UDim2.new(0, 0, 0, 0), UDim2.new(1, -118, 1, 0))

    local lockIcon = IL(LOCK_ICON_ASSET, 14, C.TXT_MUTED, row, UDim2.new(1, -112, 0.5, -7))

    local keyBtn = Instance.new("TextButton")
    keyBtn.Size = UDim2.fromOffset(88, 24)
    keyBtn.Position = UDim2.new(1, -88, 0.5, -12)
    keyBtn.BackgroundColor3 = C.BTN_BG
    keyBtn.BorderSizePixel = 0
    keyBtn.AutoButtonColor = false
    keyBtn.Text = ""
    keyBtn.Parent = row
    R(6, keyBtn)
    local s = Stroke(C.BOX_STROKE, 1, keyBtn)

    local keyLbl = TL("[" .. (defKey and defKey.Name or "G") .. "]", 11, C.TXT_MUTED, true, keyBtn,
                      UDim2.new(0, 0, 0, 0), UDim2.new(1, 0, 1, 0), Enum.TextXAlignment.Center)

    local lastKeyNotify = 0
    keyBtn.MouseButton1Click:Connect(function()
        local now = tick()
        if now - lastKeyNotify < 0.8 then return end
        lastKeyNotify = now
        Notify("Premium Feature", text .. " is exclusive to Premium keys!", 2)
    end)

    return row
end

-- 5. Dropdown Bloqueado (com o cadeado ao lado direito no lugar da seta)
local function AddLockedDropdown(box, text, currentOption)
    local row = FT(UDim2.new(1, 0, 0, 32), nil, box)

    TL(text, 13, C.TXT, false, row, UDim2.new(0, 0, 0, 0), UDim2.new(0.5, 0, 1, 0))

    local dropBtn = Instance.new("TextButton")
    dropBtn.Size = UDim2.fromOffset(130, 30)
    dropBtn.Position = UDim2.new(1, -130, 0.5, -15)
    dropBtn.BackgroundColor3 = C.BTN_BG
    dropBtn.BorderSizePixel = 0
    dropBtn.AutoButtonColor = false
    dropBtn.Text = ""
    dropBtn.Parent = row
    R(8, dropBtn)
    local dropStroke = Stroke(C.BOX_STROKE, 1, dropBtn)
    RegisterThemed(dropBtn, "BackgroundColor3", "BTN_BG")
    RegisterThemed(dropStroke, "Color", "BOX_STROKE")

    local selLbl = TL(currentOption or "Obsidian", 12, C.TXT_MUTED, false, dropBtn,
                      UDim2.new(0, 12, 0, 0), UDim2.new(1, -38, 1, 0))

    -- Cadeado oficial solicitado (119765975153029) exatamente como na Imagem 1
    local lockIcon = IL(LOCK_ICON_ASSET, 16, C.TXT_MUTED, dropBtn, UDim2.new(1, -24, 0.5, -8))

    dropBtn.MouseEnter:Connect(function()
        TweenService:Create(dropBtn, TweenInfo.new(0.12), {BackgroundColor3 = C.BTN_HOV}):Play()
        TweenService:Create(lockIcon, TweenInfo.new(0.12), {ImageColor3 = Color3.fromRGB(255, 190, 60)}):Play()
    end)
    dropBtn.MouseLeave:Connect(function()
        TweenService:Create(dropBtn, TweenInfo.new(0.12), {BackgroundColor3 = C.BTN_BG}):Play()
        TweenService:Create(lockIcon, TweenInfo.new(0.12), {ImageColor3 = C.TXT_MUTED}):Play()
    end)

    local lastDropNotify = 0
    dropBtn.MouseButton1Click:Connect(function()
        local now = tick()
        if now - lastDropNotify < 0.8 then return end
        lastDropNotify = now
        Notify("Premium Feature", "Theme customization is exclusive to Premium keys!", 2.5)
    end)

    return row
end

-- ============================================================
--  API DA UI LIBRARY (SEM FEATURES ESPECIFICAS DO JOGO)
-- ============================================================
local Pages = {}
local Tabs = {}
local TabButtons = {}
local ActiveTab = nil
local SectionOrders = {}

local Nav = F(C.NAVBAR, UDim2.fromOffset(600, 48), UDim2.new(0.5, 0, 1, 8), Win)
Nav.Name = "BottomNav"
Nav.AnchorPoint = Vector2.new(0.5, 0)
Nav.ClipsDescendants = false
R(12, Nav)
local navStroke = Stroke(C.BOX_STROKE, 1, Nav)
RegisterThemed(Nav, "BackgroundColor3", "NAVBAR")
RegisterThemed(navStroke, "Color", "BOX_STROKE")

-- UI Scale ditempatkan di ruang kosong sisi kanan bar statistik perangkat.
local ScaleControl = Instance.new("Frame")
ScaleControl.Name = "UIScaleControl"
ScaleControl.AnchorPoint = Vector2.new(1, 0.5)
ScaleControl.Position = UDim2.new(1, -8, 0.5, 0)
ScaleControl.Size = UDim2.fromOffset(190, 38)
ScaleControl.BackgroundColor3 = C.BTN_BG
ScaleControl.BackgroundTransparency = 0.04
ScaleControl.BorderSizePixel = 0
ScaleControl.ZIndex = 40
ScaleControl.Parent = Nav
R(8, ScaleControl)
local scaleStroke = Stroke(C.BOX_STROKE, 1, ScaleControl)
RegisterThemed(ScaleControl, "BackgroundColor3", "BTN_BG")
RegisterThemed(scaleStroke, "Color", "BOX_STROKE")

local scaleTitle = Instance.new("TextLabel")
scaleTitle.Name = "ScaleTitle"
scaleTitle.BackgroundTransparency = 1
scaleTitle.Position = UDim2.fromOffset(9, 4)
scaleTitle.Size = UDim2.new(1, -60, 0, 12)
scaleTitle.Font = Enum.Font.GothamBold
scaleTitle.Text = "UI SCALE"
scaleTitle.TextSize = 9
scaleTitle.TextXAlignment = Enum.TextXAlignment.Left
scaleTitle.TextColor3 = C.TXT_DIM
scaleTitle.ZIndex = 41
scaleTitle.Parent = ScaleControl
RegisterThemed(scaleTitle, "TextColor3", "TXT_DIM")

local scaleValue = Instance.new("TextLabel")
scaleValue.Name = "ScaleValue"
scaleValue.BackgroundTransparency = 1
scaleValue.Position = UDim2.new(1, -48, 0, 3)
scaleValue.Size = UDim2.fromOffset(39, 13)
scaleValue.Font = Enum.Font.GothamBold
scaleValue.Text = "70%"
scaleValue.TextSize = 10
scaleValue.TextXAlignment = Enum.TextXAlignment.Right
scaleValue.TextColor3 = C.TXT
scaleValue.ZIndex = 41
scaleValue.Parent = ScaleControl
RegisterThemed(scaleValue, "TextColor3", "TXT")

local scaleTrack = Instance.new("TextButton")
scaleTrack.Name = "ScaleTrack"
scaleTrack.Position = UDim2.new(0, 9, 0, 23)
scaleTrack.Size = UDim2.new(1, -18, 0, 7)
scaleTrack.BackgroundColor3 = C.SLIDER_BG
scaleTrack.BorderSizePixel = 0
scaleTrack.Text = ""
scaleTrack.AutoButtonColor = false
scaleTrack.Active = true
scaleTrack.ZIndex = 41
scaleTrack.Parent = ScaleControl
R(4, scaleTrack)
RegisterThemed(scaleTrack, "BackgroundColor3", "SLIDER_BG")

local scaleFill = Instance.new("Frame")
scaleFill.Name = "Fill"
scaleFill.Size = UDim2.new(0, 0, 1, 0)
scaleFill.BackgroundColor3 = C.SLIDER_FILL
scaleFill.BorderSizePixel = 0
scaleFill.ZIndex = 42
scaleFill.Parent = scaleTrack
R(4, scaleFill)
RegisterThemed(scaleFill, "BackgroundColor3", "SLIDER_FILL")

local scaleKnob = Instance.new("Frame")
scaleKnob.Name = "Knob"
scaleKnob.AnchorPoint = Vector2.new(0.5, 0.5)
scaleKnob.Position = UDim2.new(0, 0, 0.5, 0)
scaleKnob.Size = UDim2.fromOffset(11, 11)
scaleKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
scaleKnob.BorderSizePixel = 0
scaleKnob.ZIndex = 43
scaleKnob.Parent = scaleTrack
R(6, scaleKnob)
_G._VertexSyncScaleSlider = function()
    local s = WinScale.Scale
    local visualRatio = math.clamp((s - UI_SCALE_MIN) / UI_SCALE_RANGE, 0, 1)
    scaleFill.Size = UDim2.new(visualRatio, 0, 1, 0)
    scaleKnob.Position = UDim2.new(visualRatio, 0, 0.5, 0)
    scaleValue.Text = tostring(math.round(s * 100)) .. "%"
end

local scaleDragging = false
local function SetWindowScaleFromInput(input)
    local width = math.max(scaleTrack.AbsoluteSize.X, 1)
    local ratio = math.clamp((input.Position.X - scaleTrack.AbsolutePosition.X) / width, 0, 1)
    local newScale = math.floor((UI_SCALE_MIN + ratio * UI_SCALE_RANGE) * 100 + 0.5) / 100
    WinScale.Scale = newScale
    local visualRatio = (newScale - UI_SCALE_MIN) / UI_SCALE_RANGE
    scaleFill.Size = UDim2.new(visualRatio, 0, 1, 0)
    scaleKnob.Position = UDim2.new(visualRatio, 0, 0.5, 0)
    scaleValue.Text = tostring(math.round(newScale * 100)) .. "%"
    -- User geser manual → matikan auto-scale
    _G._VertexAutoScaleDisabled = true
end

-- Sinkronkan tampilan slider dengan WinScale.Scale aktual (bisa beda dari 70% karena auto-scale)
pcall(_G._VertexSyncScaleSlider)

scaleTrack.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        scaleDragging = true
        SetWindowScaleFromInput(input)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if scaleDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        SetWindowScaleFromInput(input)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        scaleDragging = false
    end
end)

-- Area statistik perangkat menggantikan tombol default bertuliskan "Main".
local StatsPanel = FT(UDim2.new(1, -224, 1, -8), UDim2.fromOffset(5, 4), Nav)
StatsPanel.Name = "DeviceStatsPanel"
local StatsLayout = Instance.new("UIListLayout")
StatsLayout.FillDirection = Enum.FillDirection.Horizontal
StatsLayout.SortOrder = Enum.SortOrder.LayoutOrder
StatsLayout.Padding = UDim.new(0, 4)
StatsLayout.VerticalAlignment = Enum.VerticalAlignment.Center
StatsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
StatsLayout.Parent = StatsPanel

local function MakeStatCard(name, title, width, order, initialValue)
    local card = Instance.new("Frame")
    card.Name = name
    card.Size = UDim2.fromOffset(width, 36)
    card.BackgroundColor3 = C.BTN_BG
    card.BackgroundTransparency = 0.06
    card.BorderSizePixel = 0
    card.LayoutOrder = order
    card.Parent = StatsPanel
    R(7, card)
    RegisterThemed(card, "BackgroundColor3", "BTN_BG")

    local cardStroke = Stroke(C.STROKE, 0.7, card)
    RegisterThemed(cardStroke, "Color", "STROKE")

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Caption"
    titleLabel.Size = UDim2.new(1, -4, 0, 11)
    titleLabel.Position = UDim2.fromOffset(2, 3)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = C.TXT_DIM
    titleLabel.TextSize = 8
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Center
    titleLabel.Parent = card
    RegisterThemed(titleLabel, "TextColor3", "TXT_DIM")

    local valueLabel = Instance.new("TextLabel")
    valueLabel.Name = "Value"
    valueLabel.Size = UDim2.new(1, -4, 0, 17)
    valueLabel.Position = UDim2.fromOffset(2, 15)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = initialValue or "--"
    valueLabel.TextColor3 = C.TXT
    valueLabel.TextSize = 11
    valueLabel.Font = Enum.Font.GothamBold
    valueLabel.TextXAlignment = Enum.TextXAlignment.Center
    valueLabel.TextTruncate = Enum.TextTruncate.AtEnd
    valueLabel.Parent = card
    RegisterThemed(valueLabel, "TextColor3", "TXT")

    return valueLabel
end

local deviceType = (UserInputService.TouchEnabled and not (UserInputService.KeyboardEnabled and UserInputService.MouseEnabled)) and "MOBILE" or "PC"
local DeviceValue = MakeStatCard("DeviceCard", "DEVICE", 64, 1, deviceType)
local FPSValue    = MakeStatCard("FPSCard", "FPS", 52, 2, "--")
local PingValue   = MakeStatCard("PingCard", "PING", 52, 3, "--")
local MemoryValue = MakeStatCard("MemoryCard", "MEM", 60, 4, "--")
local CPUValue    = MakeStatCard("CPUCard", "CPU ms", 52, 5, "--")
local GPUValue    = MakeStatCard("GPUCard", "GPU ms", 52, 6, "--")

-- FPS, ping, dan penggunaan memori aplikasi diperbarui berkala.
-- Roblox tidak menyediakan pembacaan CPU/GPU perangkat secara langsung ke LocalScript.
local statFrames = 0
local statElapsed = 0
local function ReadPingMs()
    local pingMs
    pcall(function()
        local network = StatsService:FindFirstChild("Network")
        local serverStats = network and network:FindFirstChild("ServerStatsItem")
        local pingItem = serverStats and serverStats:FindFirstChild("Data Ping")
        if pingItem then
            local raw = pingItem:GetValueString()
            pingMs = tonumber(tostring(raw):match("[%d%.]+"))
        end
    end)
    return pingMs
end

local statsConnection = RunService.RenderStepped:Connect(function(deltaTime)
    statFrames = statFrames + 1
    statElapsed = statElapsed + deltaTime
    if statElapsed >= 1 then
        local fps = math.floor((statFrames / statElapsed) + 0.5)
        FPSValue.Text = tostring(fps)

        local ping = ReadPingMs()
        PingValue.Text = ping and (tostring(math.floor(ping + 0.5)) .. " ms") or "--"

        local memoryMb
        pcall(function() memoryMb = StatsService:GetTotalMemoryUsageMb() end)
        MemoryValue.Text = memoryMb and (tostring(math.floor(memoryMb + 0.5)) .. " MB") or "--"

        -- RenderCPUFrameTime / RenderGPUFrameTime adalah waktu proses render, bukan persentase load.
        local cpuFrameTime, gpuFrameTime
        pcall(function() cpuFrameTime = StatsService.RenderCPUFrameTime end)
        pcall(function() gpuFrameTime = StatsService.RenderGPUFrameTime end)
        CPUValue.Text = (type(cpuFrameTime) == "number" and cpuFrameTime >= 0)
            and (string.format("%.1fms", cpuFrameTime * 1000)) or "--"
        GPUValue.Text = (type(gpuFrameTime) == "number" and gpuFrameTime >= 0)
            and (string.format("%.1fms", gpuFrameTime * 1000)) or "--"

        statFrames = 0
        statElapsed = 0
    end
end)
Gui.Destroying:Connect(function()
    if statsConnection then
        statsConnection:Disconnect()
        statsConnection = nil
    end
end)

-- Tab kategori memakai ruang kosong di bawah kartu profil.
local CategoryHeader = TL("CATEGORIES", 9, C.TXT_DIM, true, LPanel,
    UDim2.fromOffset(14, 194), UDim2.new(1, -28, 0, 15))
local NList = FT(UDim2.new(1, -24, 0, 190), UDim2.fromOffset(12, 213), LPanel)
NList.Name = "TabButtonsArea"
local NLL = Instance.new("UIListLayout")
NLL.FillDirection = Enum.FillDirection.Vertical
NLL.SortOrder = Enum.SortOrder.LayoutOrder
NLL.Padding = UDim.new(0, 5)
NLL.VerticalAlignment = Enum.VerticalAlignment.Top
NLL.HorizontalAlignment = Enum.HorizontalAlignment.Center
NLL.Parent = NList

local function SelectTab(tabName)
    local entry = Tabs[tabName]
    if not entry then return end
    ActiveTab = tabName

    for name, page in pairs(Pages) do
        page.Visible = (name == tabName)
    end

    for name, item in pairs(TabButtons) do
        local selected = (name == tabName)
        item.btn.BackgroundColor3 = selected and C.TAB_ACT or C.NAVBAR
        item.btn.BackgroundTransparency = selected and 0 or 1
        item.lbl.Font = selected and Enum.Font.GothamBold or Enum.Font.Gotham
        item.lbl.TextColor3 = selected and C.TXT or C.TXT_DIM
        if item.ic then
            item.ic.ImageColor3 = selected and C.ICON_ON or C.ICON_OFF
        end
    end

    ContentTitle.Text = tabName
    if entry.icon and entry.icon ~= "" then
        ContentIcon.Image = entry.icon
        ContentIcon.Visible = true
    else
        ContentIcon.Visible = false
    end
end

local VertexUI = {}
VertexUI.Gui = Gui
VertexUI.Window = Win
VertexUI.Content = Cont
VertexUI.Scroll = Sc
VertexUI.Themes = Themes
VertexUI.Pages = Pages
VertexUI.TabButtons = TabButtons

function VertexUI:CreateTab(name, icon)
    name = tostring(name or "Tab")
    if Pages[name] then return Pages[name] end

    local page = Instance.new("Frame")
    page.Name = "Page_" .. name:gsub("%W+", "_")
    page.Size = UDim2.new(1, 0, 0, 0)
    page.AutomaticSize = Enum.AutomaticSize.Y
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.Visible = false
    page.Parent = Sc

    local pageLayout = Instance.new("UIListLayout")
    pageLayout.Padding = UDim.new(0, 10)
    pageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    pageLayout.Parent = page

    Pages[name] = page
    SectionOrders[name] = 0

    -- Halaman Main tetap dibuat dan dipilih, tetapi tombolnya diganti oleh panel statistik.
    if name == "Main" and next(TabButtons) == nil then
        Tabs[name] = { page = page, icon = icon }
        if not ActiveTab then
            SelectTab(name)
        end
        return page
    end

    local btn = Instance.new("TextButton")
    btn.Name = "Tab_" .. name:gsub("%W+", "_")
    btn.BackgroundColor3 = C.NAVBAR
    btn.BackgroundTransparency = 1
    btn.BorderSizePixel = 0
    btn.Text = ""
    btn.AutoButtonColor = false
    local nextTabOrder = 1
    for _ in pairs(TabButtons) do nextTabOrder = nextTabOrder + 1 end
    btn.LayoutOrder = nextTabOrder
    btn.Parent = NList
    R(8, btn)

    local inner = FT(UDim2.new(1, 0, 1, 0), nil, btn)
    local innerLayout = Instance.new("UIListLayout")
    innerLayout.FillDirection = Enum.FillDirection.Horizontal
    innerLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    innerLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    innerLayout.Padding = UDim.new(0, 8)
    innerLayout.SortOrder = Enum.SortOrder.LayoutOrder
    innerLayout.Parent = inner

    local tabIcon = nil
    if icon and icon ~= "" then
        local iconFrame = FT(UDim2.fromOffset(16, 16), nil, inner)
        iconFrame.LayoutOrder = 1
        tabIcon = IL(icon, 15, C.ICON_OFF, iconFrame, UDim2.fromOffset(0, 0))
    end

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -42, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = name
    lbl.TextSize = 11
    lbl.Font = Enum.Font.GothamSemibold
    lbl.TextColor3 = C.TXT_DIM
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.LayoutOrder = 2
    lbl.Parent = inner

    Tabs[name] = { page = page, icon = icon }
    TabButtons[name] = { btn = btn, ic = tabIcon, lbl = lbl }

    btn.MouseEnter:Connect(function()
        if ActiveTab ~= name then
            btn.BackgroundColor3 = C.BTN_HOV
            btn.BackgroundTransparency = 0
        end
    end)
    btn.MouseLeave:Connect(function()
        if ActiveTab ~= name then
            btn.BackgroundTransparency = 1
        end
    end)
    btn.MouseButton1Click:Connect(function()
        SelectTab(name)
    end)

    -- Divide a largura igualmente entre as abas criadas.
    btn.Size = UDim2.new(1, 0, 0, 32)

    if not ActiveTab then
        SelectTab(name)
    end
    return page
end

function VertexUI:SelectTab(name)
    SelectTab(name)
end

function VertexUI:CreateSection(tab, title, icon)
    local page = type(tab) == "string" and Pages[tab] or tab
    if not page then
        page = Pages[ActiveTab]
    end
    assert(page and page:IsA("GuiObject"), "CreateSection: tab/page tidak ditemukan")

    local tabName = page.Name:gsub("^Page_", "")
    SectionOrders[tabName] = (SectionOrders[tabName] or 0) + 1
    return CreateBox(page, SectionOrders[tabName], title, icon)
end

function VertexUI:AddDivider(section)
    return AddDivider(section)
end

function VertexUI:AddToggle(section, label, defaultValue, callback, description)
    return AddToggle(section, label, defaultValue, callback, description)
end

function VertexUI:AddButton(section, label, callback)
    return AddButton(section, label, callback)
end

function VertexUI:AddSlider(section, label, minValue, maxValue, defaultValue, suffix, callback, increment)
    return AddSlider(section, label, minValue, maxValue, defaultValue, suffix, callback, increment)
end

function VertexUI:AddDropdown(section, label, options, defaultValue, callback)
    return AddDropdown(section, label, options, defaultValue, callback)
end

function VertexUI:AddKeybind(section, label, defaultKey, callback)
    return AddKeybind(section, label, defaultKey, callback)
end

function VertexUI:AddToggleWithColor(section, label, defaultValue, toggleCallback, colorLabel, defaultColor, colorCallback)
    return AddToggleWithColor(section, label, defaultValue, toggleCallback, colorLabel, defaultColor, colorCallback)
end

function VertexUI:AddLockedToggle(section, label, defaultValue, callback)
    return AddLockedToggle(section, label, defaultValue, callback)
end

function VertexUI:AddLockedSlider(section, label, minValue, maxValue, defaultValue, suffix, callback)
    return AddLockedSlider(section, label, minValue, maxValue, defaultValue, suffix, callback)
end

function VertexUI:AddLockedDropdown(section, label, currentOption)
    return AddLockedDropdown(section, label, currentOption)
end

function VertexUI:AddLockedKeybind(section, label, defaultKey, callback)
    return AddLockedKeybind(section, label, defaultKey, callback)
end

function VertexUI:Notify(title, message, duration)
    return Notify(title, message, duration)
end

function VertexUI:SetTheme(themeName)
    ApplyTheme(themeName)
end

function VertexUI:SetScale(scale)
    local value = math.clamp(tonumber(scale) or 0.70, UI_SCALE_MIN, UI_SCALE_MAX)
    if _G._VertexSetAutoScaleDisabled then _G._VertexSetAutoScaleDisabled(true) end
    WinScale.Scale = value
    if _G._VertexSyncScaleSlider then pcall(_G._VertexSyncScaleSlider) end
end

function VertexUI:ResetAutoScale()
    if _G._VertexSetAutoScaleDisabled then _G._VertexSetAutoScaleDisabled(false) end
    if _G._VertexAutoApplyScale then pcall(_G._VertexAutoApplyScale) end
end

function VertexUI:GetScale()
    return WinScale.Scale
end

_G._VertexUpdateNavTheme = function(palette)
    for name, item in pairs(TabButtons) do
        local selected = (name == ActiveTab)
        item.btn.BackgroundColor3 = selected and palette.TAB_ACT or palette.NAVBAR
        item.btn.BackgroundTransparency = selected and 0 or 1
        item.lbl.TextColor3 = selected and palette.TXT or palette.TXT_DIM
        if item.ic then
            item.ic.ImageColor3 = selected and palette.ICON_ON or palette.ICON_OFF
        end
    end
end

function VertexUI:SetVisible(visible)
    Win.Visible = visible == true
    SetMouseUnlocked(Win.Visible)
end

function VertexUI:Toggle()
    ToggleUI()
end

function VertexUI:Unload()
    if VertexUI._unloading then return end
    VertexUI._unloading = true

    -- INSTAN: window nutup di frame ini juga, 0ms delay
    pcall(function()
        if Gui and Gui.Parent then Gui:Destroy() end
    end)
    pcall(function()
        UserInputService.MouseIconEnabled = true
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
    end)
    _G.N3K0P01_UI = nil
    _G.__N3K0P01_FEATURE_RUNTIME_RUNNING = false

    -- BACKGROUND: cuma putus connection & cancel thread.
    -- Nggak ada workspace sweep, nggak ada graphics restore, nggak ada feature setter.
    -- Ini yang bikin close kerasa INSTAN.
    task.spawn(function()
        local J = _G.__N3K0P01_J
        if not J then return end
        for i, c in ipairs(J.conns) do
            pcall(function() c:Disconnect() end)
            if i % 100 == 0 then task.wait() end
        end
        J.conns = {}
        local me = coroutine.running()
        for i, t in ipairs(J.threads) do
            if t ~= me then pcall(task.cancel, t) end
            if i % 50 == 0 then task.wait() end
        end
        J.threads = {}
    end)
end

function VertexUI:GetPage(name)
    return Pages[name]
end

function VertexUI:GetActiveTab()
    return ActiveTab
end



-- ============================================================
-- N3K0P01 FEATURE PORT: source features -> Premium Script UI
-- The source feature logic is kept intact; only its UI adapter is replaced.
-- ============================================================
do
-- N3K0P01 HUB
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local ContentProvider = game:GetService("ContentProvider")

local player = Players.LocalPlayer
if not player then
    return
end

local GUI_NAME = "N3K0P01_Cyber_3Stage"

local BACKGROUND = "rbxassetid://95927259266131"
local FLOATING_BUTTON_BACKGROUND = N3K0P01_FLOATING_BG_ASSET

local function PreloadFloatingPhoto(imageObject)
    pcall(function() ContentProvider:PreloadAsync({imageObject}) end)
end
local LOGO = "rbxassetid://125701269163711"

pcall(function()
    local old = CoreGui:FindFirstChild(GUI_NAME)
    if old then
        old:Destroy()
    end
end)

pcall(function()
    local old = player:WaitForChild("PlayerGui"):FindFirstChild(GUI_NAME)
    if old then
        old:Destroy()
    end
end)

local parent = CoreGui
local parentOK = pcall(function()
    assert(CoreGui ~= nil)
end)

if not parentOK then
    parent = player:WaitForChild("PlayerGui")
end

local function new(className, props, parentObject)
    local obj = Instance.new(className)

    for k, v in pairs(props or {}) do
        pcall(function()
            obj[k] = v
        end)
    end

    obj.Parent = parentObject
    return obj
end

local function corner(parentObject, radius)
    return new("UICorner", {
        CornerRadius = UDim.new(0, radius or 10),
    }, parentObject)
end

local function stroke(parentObject, color, thickness, transparency)
    return new("UIStroke", {
        Color = color,
        Thickness = thickness or 1,
        Transparency = transparency or 0,
    }, parentObject)
end

local function tween(object, duration, properties)
    return TweenService:Create(
        object,
        TweenInfo.new(duration, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
        properties
    )
end

local COLORS = {
    Background = Color3.fromRGB(7, 9, 16),
    Panel = Color3.fromRGB(14, 17, 27),
    Panel2 = Color3.fromRGB(19, 23, 35),
    Panel3 = Color3.fromRGB(26, 31, 46),
    Text = Color3.fromRGB(255, 255, 255),
    SubText = Color3.fromRGB(220, 228, 240),
    Muted = Color3.fromRGB(164, 177, 197),
    Stroke = Color3.fromRGB(112, 146, 190),
    Blue = Color3.fromRGB(72, 166, 255),
    Cyan = Color3.fromRGB(71, 224, 255),
    Purple = Color3.fromRGB(145, 93, 255),
    Green = Color3.fromRGB(82, 231, 154),
    Red = Color3.fromRGB(255, 76, 92),
}

local function addBackground(parentObject, transparency)
    local image = new("ImageLabel", {
        BackgroundColor3 = COLORS.Background,
        BackgroundTransparency = 0,
        BorderSizePixel = 0,
        Image = BACKGROUND,
        ImageTransparency = 0,
        ScaleType = Enum.ScaleType.Crop,
        Size = UDim2.fromScale(1, 1),
        ZIndex = 0,
    }, parentObject)

    local imageCorner = parentObject:FindFirstChildOfClass("UICorner")
    if imageCorner then
        corner(image, imageCorner.CornerRadius.Offset)
    end

    new("Frame", {
        BackgroundColor3 = Color3.fromRGB(3, 8, 18),
        BackgroundTransparency = transparency or 0.28,
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
        ZIndex = 1,
    }, parentObject)

    return image
end

local function addLogo(parentObject, position, size, z)
    local holder = new("Frame", {
        BackgroundColor3 = COLORS.Panel3,
        BackgroundTransparency = 0,
        BorderSizePixel = 0,
        Position = position,
        Size = UDim2.fromOffset(size, size),
        ClipsDescendants = true,
        ZIndex = z or 5,
    }, parentObject)
    corner(holder, 14)

    local logoCorner = math.max(9, math.floor(size * 0.29))

    local crop = math.max(16, math.floor(size * 0.38))
    local image = new("ImageLabel", {
        BackgroundTransparency = 1,
        Image = LOGO,
        ScaleType = Enum.ScaleType.Crop,
        Position = UDim2.fromOffset(-crop, -crop),
        Size = UDim2.new(1, crop * 2, 1, crop * 2),
        ZIndex = (z or 5) + 1,
    }, holder)
    corner(image, logoCorner)

    return holder
end

local function makeLabel(parentObject, text, size, position, dimensions, font, color, z)
    return new("TextLabel", {
        BackgroundTransparency = 1,
        Text = text,
        Font = font or Enum.Font.Gotham,
        TextSize = size or 12,
        TextColor3 = color or COLORS.Text,
        TextXAlignment = Enum.TextXAlignment.Center,
        TextYAlignment = Enum.TextYAlignment.Center,
        Position = position,
        Size = dimensions,
        ZIndex = z or 5,
    }, parentObject)
end

local function makeRGBBorder(target, inset, radius, zBoost)

    inset = inset or 2
    radius = radius or 16
    zBoost = zBoost or 1

    local borderFrame = Instance.new("Frame")
    borderFrame.Name = "RGBBorderFrame"
    borderFrame.BackgroundTransparency = 1
    borderFrame.BorderSizePixel = 0
    borderFrame.Position = UDim2.fromOffset(inset, inset)
    borderFrame.Size = UDim2.new(1, -(inset * 2), 1, -(inset * 2))
    borderFrame.ClipsDescendants = true
    borderFrame.ZIndex = target.ZIndex + zBoost
    borderFrame.Parent = target
    corner(borderFrame, radius)

    local uiStroke = Instance.new("UIStroke")
    uiStroke.Name = "RGBBorder"
    uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    uiStroke.Thickness = 1.8
    uiStroke.Transparency = 0.04
    uiStroke.LineJoinMode = Enum.LineJoinMode.Round
    uiStroke.Color = Color3.fromRGB(80, 210, 255)
    uiStroke.Parent = borderFrame

    local gradient = Instance.new("UIGradient")
    gradient.Name = "RGBGradient"
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(55, 135, 255)),
        ColorSequenceKeypoint.new(0.20, Color3.fromRGB(70, 220, 255)),
        ColorSequenceKeypoint.new(0.40, Color3.fromRGB(245, 250, 255)),
        ColorSequenceKeypoint.new(0.58, Color3.fromRGB(145, 165, 185)),
        ColorSequenceKeypoint.new(0.76, Color3.fromRGB(60, 195, 255)),
        ColorSequenceKeypoint.new(0.90, Color3.fromRGB(120, 235, 255)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(55, 135, 255)),
    })
    gradient.Parent = uiStroke

    local connection
    connection = RunService.RenderStepped:Connect(function(dt)
        if not target.Parent or not borderFrame.Parent then
            connection:Disconnect()
            return
        end
        -- Match the reference library's smooth rotating-gradient pace (45 deg/sec).
        gradient.Rotation = (gradient.Rotation + (dt * 45)) % 360
    end)
    return uiStroke
end

local __N3K0P01_UI_ADAPTER
local __N3K0P01_FEATURE_RUNTIME_STARTED = false
local __N3K0P01_FEATURE_RUNTIME_RUNNING = false

local function __n3k_feature_safeText(v)
    if v == nil then return "" end
    return tostring(v)
end

local function __n3k_feature_notify(hostGui, title, message, duration)
    pcall(function()
        local holder = new("Frame", {
            AnchorPoint = Vector2.new(1, 0),
            Position = UDim2.new(1, -14, 0, 14),
            Size = UDim2.fromOffset(285, 62),
            BackgroundColor3 = COLORS.Panel2,
            BackgroundTransparency = 0.05,
            BorderSizePixel = 0,
            ZIndex = 9000,
        }, hostGui)
        corner(holder, 11)
        stroke(holder, COLORS.Stroke, 1, 0.25)

        local titleLabel = new("TextLabel", {
            BackgroundTransparency = 1,
            Position = UDim2.fromOffset(12, 7),
            Size = UDim2.new(1, -24, 0, 19),
            Font = Enum.Font.GothamBold,
            Text = __n3k_feature_safeText(title),
            TextColor3 = COLORS.Text,
            TextSize = 11,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 9001,
        }, holder)

        local bodyLabel = new("TextLabel", {
            BackgroundTransparency = 1,
            Position = UDim2.fromOffset(12, 27),
            Size = UDim2.new(1, -24, 0, 27),
            Font = Enum.Font.Gotham,
            Text = __n3k_feature_safeText(message),
            TextColor3 = COLORS.SubText,
            TextSize = 9,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 9001,
        }, holder)

        task.delay(tonumber(duration) or 2, function()
            pcall(function()
                if holder and holder.Parent then
                    holder:Destroy()
                end
            end)
        end)
    end)
end

local function __n3k_feature_makeAdapter(ctx)
    local adapter = {}

    local tabPages = {}
    local tabObjects = {}
    local currentTabName = nil

    local function normalizedName(name)
        local s = string.lower(__n3k_feature_safeText(name))
        if s == "information" then return "INFORMATION" end
        if s == "survivor" then return "SURVIVE" end
        if s == "visuals" or s == "visual" then return "VISUAL" end
        if s == "killer" then return "KILLER" end
        if s == "misc" then return "MISC" end
        if s == "config" or s == "save" then return "SAVE" end
        return string.upper(__n3k_feature_safeText(name))
    end

    local function getPage(name)
        local key = normalizedName(name)
        if tabPages[key] then return tabPages[key], key end

        if key == "INFORMATION" and ctx.infoPage then
            tabPages[key] = ctx.infoPage
            return ctx.infoPage, key
        end

        local page = new("ScrollingFrame", {
            Name = "FeaturePage_" .. key:gsub("%W", "_"),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Position = UDim2.fromOffset(8, 8),
            Size = UDim2.new(1, -16, 1, -16),
            CanvasSize = UDim2.new(0, 0, 0, 0),
            ScrollBarThickness = 4,
            ScrollBarImageTransparency = 0.35,
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            Visible = false,
            ZIndex = 20,
        }, ctx.page)

        local padding = new("UIPadding", {
            PaddingTop = UDim.new(0, 2),
            PaddingBottom = UDim.new(0, 8),
            PaddingLeft = UDim.new(0, 2),
            PaddingRight = UDim.new(0, 8),
        }, page)

        local layout = new("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 7),
        }, page)

        tabPages[key] = page
        return page, key
    end

    local function showTab(name)
        local page, key = getPage(name)
        currentTabName = key
        for k, p in pairs(tabPages) do
            p.Visible = (k == key)
        end
        if ctx.pageTitle then
            ctx.pageTitle.Text = key
        end
        if ctx.pageSubtitle then
            ctx.pageSubtitle.Text = "N3K0P01 HUB • " .. __n3k_feature_safeText(ctx.scriptName)
        end
        if ctx.buttons then
            for buttonName, button in pairs(ctx.buttons) do
                pcall(function()
                    button.BackgroundColor3 =
                        (buttonName == key)
                        and Color3.fromRGB(24, 91, 130)
                        or COLORS.Panel2
                    button.TextColor3 =
                        (buttonName == key)
                        and COLORS.Cyan
                        or COLORS.Text
                end)
            end
        end
        return page
    end

    adapter.__N3K0P01_GetSearchPages = function()
        return tabPages
    end
    adapter.__N3K0P01_ShowSearchTab = function(name)
        return showTab(name)
    end

    local function makeSection(tabPage, title)
        local box = new("Frame", {
            BackgroundColor3 = COLORS.Panel2,
            BackgroundTransparency = 0.12,
            BorderSizePixel = 0,
            Size = UDim2.new(1, -2, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            LayoutOrder = #tabPage:GetChildren() + 1,
            ZIndex = 21,
        }, tabPage)
        corner(box, 10)
        stroke(box, COLORS.Stroke, 1, 0.55)

        new("TextLabel", {
            BackgroundTransparency = 1,
            Position = UDim2.fromOffset(11, 7),
            Size = UDim2.new(1, -22, 0, 22),
            Font = Enum.Font.GothamBold,
            Text = __n3k_feature_safeText(title),
            TextColor3 = COLORS.Text,
            TextSize = 10,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 22,
        }, box)

        local content = new("Frame", {
            BackgroundTransparency = 1,
            Position = UDim2.fromOffset(9, 32),
            Size = UDim2.new(1, -18, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            ZIndex = 22,
        }, box)

        local layout = new("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 5),
        }, content)

        new("UIPadding", {
            PaddingBottom = UDim.new(0, 9),
        }, content)

        pcall(function()
            box:SetAttribute("N3K0P01_SearchSection", true)
            box:SetAttribute("N3K0P01_SearchSectionTitle", __n3k_feature_safeText(title))
            box:SetAttribute("N3K0P01_SearchPage", tostring(tabPage.Name or "FeaturePage"))
        end)

        local section = {}
        section.__configPrefix = tostring(tabPage.Name or "FeaturePage") .. "::" .. tostring(title or "Section")

        local function __n3k_registerSearchControl(holder, titleText, contentText)

            pcall(function()
                holder:SetAttribute("N3K0P01_SearchChild", true)
                holder:SetAttribute("N3K0P01_FeatureTitle", __n3k_feature_safeText(titleText))
                holder:SetAttribute("N3K0P01_FeatureContent", __n3k_feature_safeText(contentText or ""))
            end)
            return holder
        end

        local function __n3k_registerConfigControl(opts, control, getter, setter)
            if not opts or opts.Save == false then return control end
            local env = getgenv()
            env.__N3K0P01_ConfigElements = env.__N3K0P01_ConfigElements or {}
            env.Elements = env.__N3K0P01_ConfigElements
            local Elements = env.__N3K0P01_ConfigElements
            local configKey = tostring(opts.ConfigId or opts.Title or "Control")

            configKey = section.__configPrefix .. "::" .. configKey

            Elements[configKey] = {
                Control = control,
                Get = getter,
                Set = setter,
                Title = tostring(opts.Title or "Control"),
                ConfigId = tostring(opts.ConfigId or opts.Title or "Control"),
                Section = tostring(title or "Section"),
                Page = tostring(tabPage.Name or "FeaturePage"),
                StableId = "N3K0P01::" .. tostring(opts.ConfigId or opts.Title or "Control"),
            }
            return control
        end

        local function controlHeight(desc)
            return desc and desc ~= "" and 56 or 39
        end

        local function makeControl(titleText, contentText)
            local h = controlHeight(contentText)
            local holder = new("Frame", {
                BackgroundColor3 = COLORS.Panel3,
                BackgroundTransparency = 0.18,
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 0, h),
                ZIndex = 23,
            }, content)
            corner(holder, 8)

            local label = new("TextLabel", {
                BackgroundTransparency = 1,
                Position = UDim2.fromOffset(10, 6),
                Size = UDim2.new(1, -20, 0, 18),
                Font = Enum.Font.GothamSemibold,
                Text = __n3k_feature_safeText(titleText),
                TextColor3 = COLORS.Text,
                TextSize = 9,
                TextXAlignment = Enum.TextXAlignment.Left,
                ZIndex = 24,
            }, holder)

            local descLabel
            if contentText and contentText ~= "" then
                descLabel = new("TextLabel", {
                    BackgroundTransparency = 1,
                    Position = UDim2.fromOffset(10, 25),
                    Size = UDim2.new(1, -20, 0, 25),
                    Font = Enum.Font.Gotham,
                    Text = __n3k_feature_safeText(contentText),
                    TextColor3 = COLORS.Muted,
                    TextSize = 8,
                    TextWrapped = true,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 24,
                }, holder)
            end

            __n3k_registerSearchControl(holder, titleText, contentText)
            return holder
        end

        function section:AddToggle(opts)
            opts = opts or {}
            local holder = makeControl(opts.Title or "Toggle", opts.Content)
            local button = new("TextButton", {
                AnchorPoint = Vector2.new(1, 0.5),
                Position = UDim2.new(1, -8, 0.5, 0),
                Size = UDim2.fromOffset(72, 25),
                BackgroundColor3 = COLORS.Panel,
                BorderSizePixel = 0,
                Text = "",
                AutoButtonColor = false,
                ZIndex = 25,
            }, holder)
            corner(button, 8)
            stroke(button, COLORS.Stroke, 1, 0.35)

            local state = opts.Default == true
            local function render()
                button.Text = state and "ON" or "OFF"
                button.TextColor3 = state and COLORS.Green or COLORS.Muted
                button.BackgroundColor3 = state
                    and Color3.fromRGB(20, 65, 52)
                    or COLORS.Panel
            end
            render()

            local function fire()
                pcall(function()
                    if type(opts.Callback) == "function" then opts.Callback(state) end
                end)
            end

            button.Activated:Connect(function()
                state = not state
                render()
                fire()
            end)

            return __n3k_registerConfigControl(opts, button,
                function() return state end,
                function(v, silent)
                    state = (v == true)
                    render()
                    if not silent then fire() end
                end)
        end

        function section:AddButton(opts)
            opts = opts or {}
            local holder = makeControl(opts.Title or "Button", opts.Content)
            local button = new("TextButton", {
                AnchorPoint = Vector2.new(1, 0.5),
                Position = UDim2.new(1, -8, 0.5, 0),
                Size = UDim2.fromOffset(100, 25),
                BackgroundColor3 = COLORS.Blue,
                BorderSizePixel = 0,
                Text = "RUN",
                Font = Enum.Font.GothamBold,
                TextSize = 8,
                TextColor3 = COLORS.Text,
                AutoButtonColor = false,
                ZIndex = 25,
            }, holder)
            corner(button, 8)
            button.Activated:Connect(function()
                pcall(function()
                    if type(opts.Callback) == "function" then
                        opts.Callback()
                    end
                end)
            end)
            return button
        end

        function section:AddSlider(opts)
            opts = opts or {}
            local holder = makeControl(opts.Title or "Slider", opts.Content)
            local minV = tonumber(opts.Min) or 0
            local maxV = tonumber(opts.Max) or 100
            if maxV < minV then minV, maxV = maxV, minV end
            local value = tonumber(opts.Default)
            if value == nil then value = minV end
            value = math.clamp(value, minV, maxV)

            local input = new("TextBox", {
                AnchorPoint = Vector2.new(1, 0.5),
                Position = UDim2.new(1, -8, 0.5, 0),
                Size = UDim2.fromOffset(92, 25),
                BackgroundColor3 = COLORS.Panel,
                BorderSizePixel = 0,
                ClearTextOnFocus = false,
                Font = Enum.Font.GothamBold,
                Text = tostring(value),
                TextColor3 = COLORS.Cyan,
                TextSize = 9,
                TextXAlignment = Enum.TextXAlignment.Center,
                ZIndex = 25,
            }, holder)
            corner(input, 8)
            stroke(input, COLORS.Stroke, 1, 0.35)

            local function apply()
                local n = tonumber(input.Text)
                if n == nil then
                    input.Text = tostring(value)
                    return
                end
                n = math.clamp(n, minV, maxV)
                local inc = tonumber(opts.Increment)
                if inc and inc > 0 then
                    n = math.floor((n - minV) / inc + 0.5) * inc + minV
                    n = math.clamp(n, minV, maxV)
                end
                value = n
                input.Text = tostring(n)
                pcall(function()
                    if type(opts.Callback) == "function" then
                        opts.Callback(n)
                    end
                end)
            end
            input.FocusLost:Connect(apply)
            return __n3k_registerConfigControl(opts, input,
                function() return value end,
                function(v, silent)
                    local n = tonumber(v)
                    if n == nil then return end
                    n = math.clamp(n, minV, maxV)
                    value = n
                    input.Text = tostring(n)
                    if not silent then
                        pcall(function() if type(opts.Callback) == "function" then opts.Callback(n) end end)
                    end
                end)
        end

        function section:AddDropdown(opts)
            opts = opts or {}
            local dropdownApis = getgenv().__N3K0P01_DropdownAPIs
            if type(dropdownApis) ~= "table" then
                dropdownApis = {}
                getgenv().__N3K0P01_DropdownAPIs = dropdownApis
            end
            local holder = makeControl(opts.Title or "Dropdown", opts.Content)
            local options = opts.Options or {}
            local index = 1
            local defaultValue = opts.Default
            if type(defaultValue) == "table" then defaultValue = defaultValue[1] end
            for i, option in ipairs(options) do
                if tostring(option) == tostring(defaultValue) then
                    index = i
                    break
                end
            end

            local button = new("TextButton", {
                AnchorPoint = Vector2.new(1, 0.5),
                Position = UDim2.new(1, -8, 0.5, 0),
                Size = UDim2.fromOffset(120, 25),
                BackgroundColor3 = COLORS.Panel,
                BorderSizePixel = 0,
                Font = Enum.Font.GothamBold,
                TextSize = 8,
                TextColor3 = COLORS.Cyan,
                AutoButtonColor = false,
                ZIndex = 25,
            }, holder)
            corner(button, 8)
            stroke(button, COLORS.Stroke, 1, 0.35)

            local function current()
                return options[index]
            end
            local function render()
                button.Text = tostring(current() or "None")
            end
            render()

            local function fire()
                pcall(function()
                    if type(opts.Callback) == "function" then opts.Callback(current()) end
                end)
            end

            button.Activated:Connect(function()
                if #options == 0 then return end
                index = (index % #options) + 1
                render()
                fire()
            end)

            dropdownApis[button] = {
                SetValues = function(newOptions, selected, silent)
                    options = type(newOptions) == "table" and newOptions or {}
                    index = 1
                    if selected ~= nil then
                        for i, option in ipairs(options) do
                            if tostring(option) == tostring(selected) then index = i; break end
                        end
                    end
                    render()
                    if not silent then fire() end
                end,
                GetValues = function() return options end,
            }

            return __n3k_registerConfigControl(opts, button,
                function() return current() end,
                function(v, silent)
                    for i, option in ipairs(options) do
                        if tostring(option) == tostring(v) then
                            index = i
                            render()
                            if not silent then fire() end
                            return
                        end
                    end
                end)
        end

        function section:AddInput(opts)
            opts = opts or {}
            local holder = makeControl(opts.Title or "Input", opts.Content)
            local input = new("TextBox", {
                AnchorPoint = Vector2.new(1, 0.5),
                Position = UDim2.new(1, -8, 0.5, 0),
                Size = UDim2.fromOffset(145, 25),
                BackgroundColor3 = COLORS.Panel,
                BorderSizePixel = 0,
                ClearTextOnFocus = false,
                Font = Enum.Font.Gotham,
                PlaceholderText = __n3k_feature_safeText(opts.Placeholder),
                Text = __n3k_feature_safeText(opts.Default),
                TextColor3 = COLORS.Text,
                TextSize = 8,
                ZIndex = 25,
            }, holder)
            corner(input, 8)
            stroke(input, COLORS.Stroke, 1, 0.35)
            local function fire()
                pcall(function()
                    if type(opts.Callback) == "function" then opts.Callback(input.Text) end
                end)
            end
            input.FocusLost:Connect(fire)
            return __n3k_registerConfigControl(opts, input,
                function() return input.Text end,
                function(v, silent)
                    input.Text = __n3k_feature_safeText(v)
                    if not silent then fire() end
                end)
        end

        function section:AddKeybind(opts)
            opts = opts or {}
            local holder = makeControl(opts.Title or "Keybind", opts.Content)
            local button = new("TextButton", {
                AnchorPoint = Vector2.new(1, 0.5),
                Position = UDim2.new(1, -8, 0.5, 0),
                Size = UDim2.fromOffset(92, 25),
                BackgroundColor3 = COLORS.Panel,
                BorderSizePixel = 0,
                Text = __n3k_feature_safeText(opts.Default or "None"),
                Font = Enum.Font.GothamBold,
                TextSize = 8,
                TextColor3 = COLORS.Cyan,
                AutoButtonColor = false,
                ZIndex = 25,
            }, holder)
            corner(button, 8)
            stroke(button, COLORS.Stroke, 1, 0.35)
            return button
        end

        function section:AddColorPicker(opts)
            opts = opts or {}
            local holder = makeControl(opts.Title or "Color", opts.Content)
            local color = opts.Default
            local button = new("TextButton", {
                AnchorPoint = Vector2.new(1, 0.5),
                Position = UDim2.new(1, -8, 0.5, 0),
                Size = UDim2.fromOffset(92, 25),
                BackgroundColor3 = (typeof(color) == "Color3" and color) or COLORS.Blue,
                BorderSizePixel = 0,
                Text = "COLOR",
                Font = Enum.Font.GothamBold,
                TextSize = 8,
                TextColor3 = COLORS.Text,
                AutoButtonColor = false,
                ZIndex = 25,
            }, holder)
            corner(button, 8)
            button.Activated:Connect(function()

                local palette = {
                    Color3.fromRGB(255,255,255),
                    Color3.fromRGB(255,90,90),
                    Color3.fromRGB(90,180,255),
                    Color3.fromRGB(110,255,160),
                    Color3.fromRGB(190,110,255),
                }
                local current = button.BackgroundColor3
                local nextIndex = 1
                for i, c in ipairs(palette) do
                    if math.abs(c.R - current.R) < 0.01
                        and math.abs(c.G - current.G) < 0.01
                        and math.abs(c.B - current.B) < 0.01 then
                        nextIndex = (i % #palette) + 1
                        break
                    end
                end
                button.BackgroundColor3 = palette[nextIndex]
                pcall(function()
                    if type(opts.Callback) == "function" then opts.Callback(button.BackgroundColor3) end
                end)
            end)

            return __n3k_registerConfigControl(opts, button,
                function() return button.BackgroundColor3 end,
                function(v, silent)
                    if typeof(v) ~= "Color3" then return end
                    button.BackgroundColor3 = v
                    if not silent then
                        pcall(function() if type(opts.Callback) == "function" then opts.Callback(v) end end)
                    end
                end)
        end

        function section:AddParagraph(opts)
            opts = opts or {}
            local holder = makeControl(opts.Title or "Info", opts.Content or opts.Description)
            return holder
        end

        return section
    end

    function adapter:Window(opts)
        opts = opts or {}
        local window = {}

        function window:InfoTab(_)
            return getPage("INFORMATION")
        end

        function window:AddTab(opts2)
            opts2 = opts2 or {}
            local name = opts2.Name or "Tab"
            local page = getPage(name)
            local key = normalizedName(name)
            local tab = {}
            tab.Name = key

            function tab:AddSection(title)
                return makeSection(page, title)
            end

            tabObjects[key] = tab
            showTab(key)
            return tab
        end

        return window
    end

    function adapter:MakeNotify(opts)
        opts = opts or {}
        __n3k_feature_notify(ctx.featureGui, opts.Title, opts.Content, opts.Delay or 2)
    end

    return adapter
end

local function __N3K0P01_START()
    getgenv().VD = getgenv().VD or {}
    local W = getgenv()

    VD.AutoCrouch           = false
    VD.KILLER_AutoAttack         = VD.KILLER_AutoAttack or false
    VD.KILLER_AutoAttackRange    = VD.KILLER_AutoAttackRange or 12
    VD.KILLER_AutoAttackCooldown = VD.KILLER_AutoAttackCooldown or 0.15
    VD.SURV_AutoFlee        = VD.SURV_AutoFlee or false
    VD.SURV_AutoFleeDist    = VD.SURV_AutoFleeDist or 40
    VD.SURV_AutoFleeCooldown= VD.SURV_AutoFleeCooldown or 1.5





    VD.KILLER_AntiBlind      = VD.KILLER_AntiBlind      or false
    VD.KILLER_DestroyPallets = VD.KILLER_DestroyPallets or false
    VD.KILLER_InfLunge       = VD.KILLER_InfLunge       or false
    VD.KILLER_AutoHook       = VD.KILLER_AutoHook       or false

    VD.KA_AutoStalk       = VD.KA_AutoStalk       or false
    VD.KA_AutoStalkRange  = VD.KA_AutoStalkRange  or 150
    VD.KA_AutoKillAll     = VD.KA_AutoKillAll     or false
    VD.KA_DropAllPallet   = VD.KA_DropAllPallet   or false
    VD.KA_BlockAllVault   = VD.KA_BlockAllVault   or false


    VD.NoFallDamage         = VD.NoFallDamage or false
    VD.NextMapPredict       = VD.NextMapPredict or false
    VD.ManualGen            = VD.ManualGen or false
    VD.AutoGen              = VD.AutoGen or false
    VD.KillerEscapeDist     = VD.KillerEscapeDist or 30

    VD.Wisnu_IgnoredSkills   = VD.Wisnu_IgnoredSkills   or {}



    VD.KillerPerksDisplay   = VD.KillerPerksDisplay   or false
    VD.SpeedBoostEnabled    = VD.SpeedBoostEnabled    or false
    VD.SpeedBoostValue      = VD.SpeedBoostValue      or 30
    VD.CursorEnabled        = VD.CursorEnabled        or false

    W.InstantHealSelf = W.InstantHealSelf or false
    W.AutoHealAll     = W.AutoHealAll or false

    _G.GLUTO_ACCENT     = Color3.fromRGB(120, 120, 120)
    _G.GLUTO_ACCENT_BG  = Color3.fromRGB(0, 0, 0)
    _G.GLUTO_NEUTRAL    = Color3.fromRGB(90, 90, 90)
    _G.GLUTO_STROKE_OFF = Color3.fromRGB(25, 25, 25)
    _G.GLUTO_BG_OFF     = Color3.fromRGB(0, 0, 0)

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

        local LocalPlayer = Players.LocalPlayer
        local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
        local VirtualInputManager = nil
        pcall(function() VirtualInputManager = game:GetService("VirtualInputManager") end)


        local UILib = __N3K0P01_UI_ADAPTER
        if not UILib then
            warn("[N3K0P01] Feature UI adapter tidak tersedia.")
            return
        end


        do
            local function FixText(inst)
                if not inst then return end
                if inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox") then
                    local txt = inst.Text
                    if txt and (string.find(txt, "Close Windows", 1, true) or string.find(txt, "Close Windows", 1, true)) then
                        pcall(function()
                            inst.Text = txt:gsub("Close Windows", "Close Windows"):gsub("Close Windows", "Close Windows")
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

        local NotifyColor = Color3.fromRGB(255, 255, 255)
        W.NotifyEnabled = W.NotifyEnabled ~= false

        local function ShowNotify(title, message, duration)
            if not W.NotifyEnabled then return end
            if not UILib or not UILib.MakeNotify then return end
            pcall(function()
                UILib:MakeNotify({
                    Title = title or "N3K0P01 HUB", Description = "Info",
                    Content = message or "", Color = NotifyColor,
                    Time = 0.4, Delay = duration or 2, Icon = "80227588329123"
                })
            end)
        end
        local function VD_Notify(title, content, duration) ShowNotify(title, content, duration) end
        local function ForceNotify(title, message, duration)
            if not UILib or not UILib.MakeNotify then return end
            pcall(function()
                UILib:MakeNotify({
                    Title = title or "N3K0P01 HUB", Description = "Info",
                    Content = message or "", Color = NotifyColor,
                    Time = 0.4, Delay = duration or 2, Icon = "80227588329123"
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

        -- Standalone Auto Crouch Dodge animation detector.
        do
            local CROUCH_DODGE_ANIMATION_ID = "100014992013740"
            local watchedCharacters = setmetatable({}, { __mode = "k" })
            local watchedAnimators = setmetatable({}, { __mode = "k" })

            local function attachCrouchDodgeAnimator(killerCharacter, animator)
                if not animator or watchedAnimators[animator] then return end
                watchedAnimators[animator] = true
                animator.AnimationPlayed:Connect(function(track)
                    if not VD.AutoCrouch then return end
                    local animation = track and track.Animation
                    local animationId = animation and animation.AnimationId or ""
                    if animationId:match("%d+") ~= CROUCH_DODGE_ANIMATION_ID then return end

                    local myCharacter = LocalPlayer.Character
                    if not myCharacter then return end
                    local state = myCharacter:GetAttribute("State")
                    if myCharacter:GetAttribute("Knocked") == true
                        or myCharacter:GetAttribute("IsHooked") == true
                        or state == "Downed" or state == "Dead" then return end

                    local myRoot = myCharacter:FindFirstChild("HumanoidRootPart")
                    local killerRoot = killerCharacter and killerCharacter:FindFirstChild("HumanoidRootPart")
                    if myRoot and killerRoot and (myRoot.Position - killerRoot.Position).Magnitude <= 40 then
                        TriggerCrouch()
                    end
                end)
            end

            local function attachCrouchDodgeCharacter(killerCharacter)
                if not killerCharacter or watchedCharacters[killerCharacter] then return end
                watchedCharacters[killerCharacter] = true
                local humanoid = killerCharacter:FindFirstChildOfClass("Humanoid")
                    or killerCharacter:WaitForChild("Humanoid", 5)
                if not humanoid then return end

                local animator = humanoid:FindFirstChildOfClass("Animator")
                    or humanoid:WaitForChild("Animator", 5)
                if animator then attachCrouchDodgeAnimator(killerCharacter, animator) end
                humanoid.ChildAdded:Connect(function(child)
                    if child:IsA("Animator") then
                        attachCrouchDodgeAnimator(killerCharacter, child)
                    end
                end)
            end

            local function watchCrouchDodgePlayer(player)
                if player == LocalPlayer then return end
                local function tryAttach()
                    if player.Team and player.Team.Name == "Killer" and player.Character then
                        attachCrouchDodgeCharacter(player.Character)
                    end
                end
                player.CharacterAdded:Connect(function()
                    task.wait(0.2)
                    tryAttach()
                end)
                player:GetPropertyChangedSignal("Team"):Connect(tryAttach)
                tryAttach()
            end

            for _, player in ipairs(Players:GetPlayers()) do
                watchCrouchDodgePlayer(player)
            end
            Players.PlayerAdded:Connect(watchCrouchDodgePlayer)
        end

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

        _G.Ox = _G.Ox or {}
        _G.Ox.AntiBlindEnabled = false
        _G.Ox.GotBlindedRemote = nil
        _G.Ox.NoSlowdownEnabled = false
        _G.Ox.BypassLeapEnabled = false
        _G.Ox.InfAbyssalEnabled = false
        _G.Ox.KILLER_SilentAimFlask = false
        _G.Ox.KILLER_FlaskLaser = false
        _G.Ox.NEX_CureFlaskLaserThread = nil
        _G.Ox.NEX_CureFlaskLaserPart = nil
        _G.Ox.InfiniteLungeEnabled = false

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

        W.StunSounds = W.StunSounds or {
            ["Default"]="18843924331",["Clash Royale"]="114072050006157",["Blash"]="89068385567682",["antek asing"]="129760109847577",["hidup Jokowi"]="116121992738402",
            ["Kururin Kuru"]="119896940405402",["Spongebob"]="6835794541",
            ["Fahhhh"]="123562480982353",["Aughhh"]="9095205664",
            ["iPhone"]="4203251375",["Siren"]="130677853589923",["an anime"]="128090092396552",
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
            p1s.Color = Color3.fromRGB(255, 255, 255)
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
            p2s.Color = Color3.fromRGB(200, 200, 210)
            p2s.Thickness = 1.8
            p2s.Transparency = 0.4
            p2s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            local main = Instance.new("Frame")
            main.Name = "Main"
            main.Size = UDim2.new(0, 140, 0, 34)
            main.Position = UDim2.new(0, 0, 0, 4)
            main.BackgroundTransparency = 1
            main.BorderSizePixel = 0
            main.ZIndex = 1
            main.ClipsDescendants = true
            main.Parent = bbg
            Instance.new("UICorner", main).CornerRadius = UDim.new(0, 9)

            local stunnedBg = Instance.new("ImageLabel")
            stunnedBg.Name = "BackgroundImage"
            stunnedBg.Size = UDim2.fromScale(1, 1)
            stunnedBg.Position = UDim2.fromScale(0, 0)
            stunnedBg.BackgroundTransparency = 1
            stunnedBg.BorderSizePixel = 0
            stunnedBg.Image = FLOATING_BUTTON_BACKGROUND
            stunnedBg.ScaleType = Enum.ScaleType.Crop
            stunnedBg.ImageTransparency = 0
            stunnedBg.Active = false
            stunnedBg.ZIndex = 1
            stunnedBg.Parent = main
            Instance.new("UICorner", stunnedBg).CornerRadius = UDim.new(0, 9)
            task.spawn(PreloadFloatingPhoto, stunnedBg)
            local mainStroke = Instance.new("UIStroke", main)
            mainStroke.Name = "MainStroke"
            mainStroke.Color = Color3.fromRGB(255, 255, 255)
            mainStroke.Thickness = 1.3
            mainStroke.Transparency = 0.15
            mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            local iconHolder = Instance.new("Frame")
            iconHolder.Name = "IconHolder"
            iconHolder.Size = UDim2.fromOffset(24, 24)
            iconHolder.Position = UDim2.new(0, 5, 0.5, -12)
            iconHolder.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
            iconHolder.BorderSizePixel = 0
            iconHolder.ZIndex = 3
            iconHolder.Parent = main
            Instance.new("UICorner", iconHolder).CornerRadius = UDim.new(1, 0)
            local iconGrad = Instance.new("UIGradient", iconHolder)
            iconGrad.Rotation = 135
            iconGrad.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(38, 38, 44)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(14, 14, 18)),
            })
            local iconStroke = Instance.new("UIStroke", iconHolder)
            iconStroke.Color = Color3.fromRGB(255, 255, 255)
            iconStroke.Thickness = 1
            iconStroke.Transparency = 0.25
            local starIcon = Instance.new("TextLabel")
            starIcon.Name = "StarIcon"
            starIcon.Size = UDim2.fromScale(1, 1)
            starIcon.BackgroundTransparency = 1
            starIcon.Font = Enum.Font.GothamBlack
            starIcon.Text = "★"
            starIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
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
            title.TextColor3 = Color3.fromRGB(255, 255, 255)
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
            sub.TextColor3 = Color3.fromRGB(170, 170, 180)
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
            accent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
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
            Generator = false, Pumpkin = false, Pallet = false, Window = false, SCP = false,
            Distance = 500,
        }
        W.FullESPStatus = W.FullESPStatus or {
            Enabled = false,
            ShowName = true, ShowDistance = true, ShowHealth = false,
            ShowAvatar = true, ShowAction = true, Radius = 500,
        }
        W.FullESPColors = W.FullESPColors or {
            Survivor  = Color3.fromRGB(0, 255, 255), Killer    = Color3.fromRGB(255, 0, 0),
            Generator = Color3.fromRGB(0, 255, 0), Pumpkin = Color3.fromRGB(255, 140, 0),
            Window    = Color3.fromRGB(255, 255, 255),
            Pallet    = Color3.fromRGB(255, 255, 255), SCP       = Color3.fromRGB(255, 165, 0),
        }
        local FESP  = W.FullESP
        local FESPS = W.FullESPStatus
        local FESPC = W.FullESPColors

        -- Fixed colors for the requested ESP categories. Window keeps its original RGB cycle.
        FESPC.Survivor  = Color3.fromRGB(0, 255, 255) -- Cyan
        FESPC.Killer    = Color3.fromRGB(255, 0, 0)   -- Red
        FESPC.Generator = Color3.fromRGB(0, 255, 0)   -- Green
        FESPC.Pumpkin   = FESPC.Pumpkin or Color3.fromRGB(255, 140, 0) -- Orange
        FESPC.Pallet    = Color3.fromRGB(255, 255, 255) -- White
        FESPC.SCP       = Color3.fromRGB(255, 165, 0) -- Orange

        local function GetESPColor(category)
            -- These categories use a fixed color instead of cycling through RGB palettes.
            if category ~= "Window" then
                return FESPC[category] or Color3.new(1, 1, 1)
            end

            -- Preserve the original RGB animation for Window ESP only.
            local palette = {
                Color3.fromRGB(0, 255, 255),
                Color3.fromRGB(70, 130, 255),
                Color3.fromRGB(190, 90, 255),
            }
            local phase = (tick() * 0.65) % #palette
            local index = math.floor(phase) + 1
            local nextIndex = (index % #palette) + 1
            return palette[index]:Lerp(palette[nextIndex], phase - math.floor(phase))
        end

        do
            local ESPObjects = {}
            local StatusESP  = {}
            local CachedSCP     = {}
            local CachedGen     = {}
            local CachedPumpkin = {}
            local PumpkinLabels = {}
            local CachedPallet  = {}
            local CachedWindow  = {}
            local WindowObjects = {}

            local function IsPumpkinObject(obj)
                if not obj or not (obj:IsA("Model") or obj:IsA("BasePart")) then
                    return false
                end
                local map = Workspace:FindFirstChild("Map")
                local pumpkins = map and map:FindFirstChild("Pumpkins")
                return pumpkins ~= nil
                    and obj.Parent == pumpkins
                    and string.match(obj.Name, "^Pumpkin%d+$") ~= nil
            end

            local function CacheObject(obj)
                if not obj then return end
                local ln = string.lower(obj.Name)
                if string.find(ln, "scp", 1, true) then CachedSCP[obj] = true end
                if IsPumpkinObject(obj) then CachedPumpkin[obj] = true end
                if obj.Name == "Generator" then
                    CachedGen[obj] = true
                elseif obj.Name == "Pallet" or obj.Name == "Palletwrong" then
                    CachedPallet[obj] = true
                end
            end

            for _, obj in ipairs(Workspace:GetDescendants()) do CacheObject(obj) end
            Workspace.DescendantAdded:Connect(CacheObject)
            Workspace.DescendantRemoving:Connect(function(obj)
                CachedSCP[obj] = nil; CachedGen[obj] = nil; CachedPumpkin[obj] = nil
                CachedPallet[obj] = nil; CachedWindow[obj] = nil
                if PumpkinLabels[obj] then
                    pcall(function() PumpkinLabels[obj]:Destroy() end)
                    PumpkinLabels[obj] = nil
                end
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
                if not char or not hum then return "IDLE", Color3.fromRGB(150, 150, 150) end
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
                    if speed > 2 then return "MOVE", Color3.fromRGB(200, 200, 220) end
                end
                return "IDLE", Color3.fromRGB(150, 150, 150)
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

                local accentColor = Color3.fromRGB(255, 255, 255)
                if TeamIs(plr, "Killer") then accentColor = GetESPColor("Killer")
                elseif TeamIs(plr, "Survivor") then accentColor = GetESPColor("Survivor") end
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
                    bb.StudsOffset = Vector3.new(0, 2.5, 0)
                    bb.Size = UDim2.fromOffset(260, 40)
                    bb.Parent = char

                    local scaleObj = Instance.new("UIScale")
                    scaleObj.Name = "DistScale"
                    scaleObj.Scale = 1
                    scaleObj.Parent = bb

                    local nameLbl = Instance.new("TextLabel")
                    nameLbl.Name = "NameLbl"
                    nameLbl.BackgroundTransparency = 1
                    nameLbl.Size = UDim2.new(1, 0, 0, 16)
                    nameLbl.Position = UDim2.new(0, 0, 0, 0)
                    nameLbl.Font = Enum.Font.GothamBold
                    nameLbl.TextSize = 13
                    nameLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
                    nameLbl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                    nameLbl.TextStrokeTransparency = 0.2
                    nameLbl.TextXAlignment = Enum.TextXAlignment.Center
                    nameLbl.TextYAlignment = Enum.TextYAlignment.Center
                    nameLbl.TextTruncate = Enum.TextTruncate.AtEnd
                    nameLbl.Parent = bb

                    local pill = Instance.new("Frame")
                    pill.Name = "Pill"
                    pill.AnchorPoint = Vector2.new(0.5, 0)
                    pill.Position = UDim2.new(0.5, 0, 0, 18)
                    pill.Size = UDim2.fromOffset(120, 22)
                    pill.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
                    pill.BackgroundTransparency = 0.15
                    pill.BorderSizePixel = 0
                    pill.Parent = bb
                    Instance.new("UICorner", pill).CornerRadius = UDim.new(1, 0)

                    local pillStroke = Instance.new("UIStroke", pill)
                    pillStroke.Name = "PillStroke"
                    pillStroke.Color = accentColor
                    pillStroke.Thickness = 1
                    pillStroke.Transparency = 0.5
                    pillStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                    local layout = Instance.new("UIListLayout", pill)
                    layout.FillDirection = Enum.FillDirection.Horizontal
                    layout.Padding = UDim.new(0, 5)
                    layout.SortOrder = Enum.SortOrder.LayoutOrder
                    layout.VerticalAlignment = Enum.VerticalAlignment.Center
                    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

                    local pad = Instance.new("UIPadding", pill)
                    pad.PaddingLeft = UDim.new(0, 6)
                    pad.PaddingRight = UDim.new(0, 8)

                    local avatarHolder = Instance.new("Frame")
                    avatarHolder.Name = "AvatarHolder"
                    avatarHolder.Size = UDim2.fromOffset(18, 18)
                    avatarHolder.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
                    avatarHolder.BorderSizePixel = 0
                    avatarHolder.LayoutOrder = 1
                    avatarHolder.ClipsDescendants = true
                    avatarHolder.Parent = pill
                    Instance.new("UICorner", avatarHolder).CornerRadius = UDim.new(1, 0)

                    local avatarStroke = Instance.new("UIStroke", avatarHolder)
                    avatarStroke.Name = "AvatarStroke"
                    avatarStroke.Color = accentColor
                    avatarStroke.Thickness = 1.2
                    avatarStroke.Transparency = 0.3
                    avatarStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                    local avatarImg = Instance.new("ImageLabel")
                    avatarImg.Name = "AvatarImg"
                    avatarImg.Size = UDim2.fromScale(1, 1)
                    avatarImg.BackgroundTransparency = 1
                    avatarImg.Image = "rbxthumb://type=AvatarHeadShot&id=" .. plr.UserId .. "&w=150&h=150"
                    avatarImg.Parent = avatarHolder

                    local dot = Instance.new("Frame")
                    dot.Name = "Dot"
                    dot.Size = UDim2.fromOffset(7, 7)
                    dot.BackgroundColor3 = accentColor
                    dot.BorderSizePixel = 0
                    dot.LayoutOrder = 1
                    dot.Visible = false
                    dot.Parent = pill
                    Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)

                    local distLbl = Instance.new("TextLabel")
                    distLbl.Name = "DistLbl"
                    distLbl.BackgroundTransparency = 1
                    distLbl.Size = UDim2.fromOffset(32, 14)
                    distLbl.Font = Enum.Font.GothamBold
                    distLbl.TextSize = 11
                    distLbl.TextColor3 = Color3.fromRGB(220, 220, 230)
                    distLbl.Text = "0m"
                    distLbl.LayoutOrder = 2
                    distLbl.Parent = pill

                    local actionLbl = Instance.new("TextLabel")
                    actionLbl.Name = "ActionLbl"
                    actionLbl.BackgroundTransparency = 1
                    actionLbl.Size = UDim2.fromOffset(50, 14)
                    actionLbl.Font = Enum.Font.GothamBold
                    actionLbl.TextSize = 10
                    actionLbl.TextColor3 = actionColor
                    actionLbl.Text = "IDLE"
                    actionLbl.LayoutOrder = 3
                    actionLbl.Parent = pill

                    local hpBarBg = Instance.new("Frame")
                    hpBarBg.Name = "HPBarBg"
                    hpBarBg.Size = UDim2.fromOffset(38, 4)
                    hpBarBg.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
                    hpBarBg.BorderSizePixel = 0
                    hpBarBg.LayoutOrder = 4
                    hpBarBg.Parent = pill
                    Instance.new("UICorner", hpBarBg).CornerRadius = UDim.new(1, 0)

                    local hpBarFill = Instance.new("Frame")
                    hpBarFill.Name = "HPBarFill"
                    hpBarFill.Size = UDim2.new(1, 0, 1, 0)
                    hpBarFill.BackgroundColor3 = hpColor
                    hpBarFill.BorderSizePixel = 0
                    hpBarFill.Parent = hpBarBg
                    Instance.new("UICorner", hpBarFill).CornerRadius = UDim.new(1, 0)

                    local downPill = Instance.new("Frame")
                    downPill.Name = "DownPill"
                    downPill.Size = UDim2.fromOffset(36, 14)
                    downPill.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
                    downPill.BackgroundTransparency = 0.1
                    downPill.BorderSizePixel = 0
                    downPill.Visible = false
                    downPill.LayoutOrder = 5
                    downPill.Parent = pill
                    Instance.new("UICorner", downPill).CornerRadius = UDim.new(1, 0)

                    local downLbl = Instance.new("TextLabel")
                    downLbl.Name = "DownLbl"
                    downLbl.Size = UDim2.new(1, 0, 1, 0)
                    downLbl.BackgroundTransparency = 1
                    downLbl.Font = Enum.Font.GothamBold
                    downLbl.TextSize = 9
                    downLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
                    downLbl.Text = "DOWN"
                    downLbl.Parent = downPill

                    StatusESP[char] = bb
                end

                local nameLbl = bb:FindFirstChild("NameLbl")
                local pill = bb:FindFirstChild("Pill")
                if not pill then return end
                local pillStroke = pill:FindFirstChild("PillStroke")
                local avatarHolder = pill:FindFirstChild("AvatarHolder")
                local avatarImg = avatarHolder and avatarHolder:FindFirstChild("AvatarImg")
                local avatarStroke = avatarHolder and avatarHolder:FindFirstChild("AvatarStroke")
                local dot = pill:FindFirstChild("Dot")
                local distLbl = pill:FindFirstChild("DistLbl")
                local actionLbl = pill:FindFirstChild("ActionLbl")
                local hpBarBg = pill:FindFirstChild("HPBarBg")
                local hpBarFill = hpBarBg and hpBarBg:FindFirstChild("HPBarFill")
                local downPill = pill:FindFirstChild("DownPill")
                local distScale = bb:FindFirstChild("DistScale")

                if pillStroke then
                    pillStroke.Color = accentColor
                    pillStroke.Transparency = isDown and 0.2 or 0.5
                end
                if avatarHolder then
                    avatarHolder.Visible = FESPS.ShowAvatar == true
                    if avatarStroke then avatarStroke.Color = accentColor end
                    if avatarImg and avatarImg.Image == "" then
                        avatarImg.Image = "rbxthumb://type=AvatarHeadShot&id=" .. plr.UserId .. "&w=150&h=150"
                    end
                end
                if dot then
                    dot.Visible = (FESPS.ShowAvatar ~= true)
                    dot.BackgroundColor3 = accentColor
                end
                if nameLbl then
                    nameLbl.Text = plr.Name
                    nameLbl.Visible = FESPS.ShowName
                    nameLbl.TextColor3 = isDown and Color3.fromRGB(255, 100, 100) or Color3.fromRGB(255, 255, 255)
                end
                if distLbl then
                    distLbl.Text = string.format("%.0fm", dist)
                    distLbl.Visible = FESPS.ShowDistance
                end
                if actionLbl then
                    actionLbl.Text = actionText
                    actionLbl.TextColor3 = actionColor
                    actionLbl.Visible = FESPS.ShowAction == true
                    if actionText == "IDLE" then
                        actionLbl.TextColor3 = Color3.fromRGB(150, 150, 150)
                    end
                end
                if hpBarBg and hpBarFill then
                    hpBarFill.Size = UDim2.new(hpPct, 0, 1, 0)
                    hpBarFill.BackgroundColor3 = hpColor
                    hpBarBg.Visible = FESPS.ShowHealth
                end
                if downPill then downPill.Visible = isDown end

                local totalW = 14
                local count = 0
                if FESPS.ShowAvatar then totalW = totalW + 18; count = count + 1
                else totalW = totalW + 7; count = count + 1 end
                if FESPS.ShowDistance then totalW = totalW + 32; count = count + 1 end
                if FESPS.ShowAction then totalW = totalW + 50; count = count + 1 end
                if FESPS.ShowHealth then totalW = totalW + 38; count = count + 1 end
                if isDown then totalW = totalW + 36; count = count + 1 end
                totalW = totalW + math.max(count - 1, 0) * 5
                if totalW < 50 then totalW = 50 end
                if totalW > 240 then totalW = 240 end
                pill.Size = UDim2.fromOffset(totalW, 22)

                local showPill = FESPS.ShowDistance or FESPS.ShowHealth or isDown
                    or FESPS.ShowAction or FESPS.ShowAvatar
                pill.Visible = showPill

                local h = 16 + (showPill and 24 or 0)
                bb.Size = UDim2.fromOffset(260, h)

                if distScale then
                    local scaleVal = 1 - (dist - 50) / 500
                    scaleVal = math.clamp(scaleVal, 0.5, 1.05)
                    distScale.Scale = scaleVal
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
                if percent >= 100 then if bb then bb:Destroy() end; return end
                local color = GetESPColor("Generator")
                local text = string.format("[%.0f%%]", percent)
                if not bb then
                    bb = Instance.new("BillboardGui")
                    bb.Name = "GenESP"
                    bb.Size = UDim2.new(0, 100, 0, 30)
                    bb.AlwaysOnTop = true
                    local lbl = Instance.new("TextLabel")
                    lbl.Size = UDim2.new(1, 0, 1, 0)
                    lbl.BackgroundTransparency = 1
                    lbl.Text = text
                    lbl.TextColor3 = color
                    lbl.TextStrokeTransparency = 0
                    lbl.Font = Enum.Font.GothamBold
                    lbl.TextSize = 12
                    lbl.Parent = bb
                    bb.Adornee = gen
                    bb.Parent = gen
                else
                    local lbl = bb:FindFirstChildOfClass("TextLabel")
                    if lbl then lbl.Text = text; lbl.TextColor3 = color end
                end
                local h = gen:FindFirstChild("GenHighlight") or Instance.new("Highlight")
                h.Name = "GenHighlight"
                h.Adornee = gen
                h.FillColor = color
                h.OutlineColor = color
                h.FillTransparency = 0.9
                h.OutlineTransparency = 0.3
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
                        CreateESP(obj, GetESPColor("Pallet"))
                    else
                        RemoveESP(obj)
                    end
                end
            end

            local function RemovePumpkinLabel(obj)
                local label = PumpkinLabels[obj]
                if label then
                    pcall(function() label:Destroy() end)
                    PumpkinLabels[obj] = nil
                end
            end

            local function GetPumpkinPosition(obj)
                if obj:IsA("BasePart") then
                    return obj.Position, obj
                elseif obj:IsA("Model") then
                    local part = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart", true)
                    local ok, pivot = pcall(function() return obj:GetPivot().Position end)
                    if ok then return pivot, part end
                    return part and part.Position or nil, part
                end
                return nil, nil
            end

            local function UpdatePumpkinESP(root)
                if not FESP.Pumpkin then
                    for obj in pairs(CachedPumpkin) do
                        RemoveESP(obj)
                        RemovePumpkinLabel(obj)
                    end
                    return
                end

                for obj in pairs(CachedPumpkin) do
                    if not obj or not obj.Parent then
                        RemoveESP(obj)
                        RemovePumpkinLabel(obj)
                        CachedPumpkin[obj] = nil
                    else
                        local pos, adornee = GetPumpkinPosition(obj)
                        if pos and adornee and (pos - root.Position).Magnitude <= FESP.Distance then
                            CreateESP(obj, GetESPColor("Pumpkin"))

                            local label = PumpkinLabels[obj]
                            if not label or not label.Parent then
                                label = Instance.new("BillboardGui")
                                label.Name = "N3K0P01_PumpkinESPLabel"
                                label.Size = UDim2.new(0, 150, 0, 28)
                                label.StudsOffset = Vector3.new(0, 3, 0)
                                label.AlwaysOnTop = true
                                label.Adornee = adornee

                                local text = Instance.new("TextLabel")
                                text.Name = "Label"
                                text.Size = UDim2.new(1, 0, 1, 0)
                                text.BackgroundTransparency = 1
                                text.TextColor3 = GetESPColor("Pumpkin")
                                text.TextStrokeTransparency = 0.15
                                text.Font = Enum.Font.GothamBold
                                text.TextSize = 12
                                text.Parent = label

                                label.Parent = adornee
                                PumpkinLabels[obj] = label
                            else
                                label.Adornee = adornee
                            end

                            local text = label:FindFirstChild("Label")
                            if text then
                                local dist = (pos - root.Position).Magnitude
                                text.Text = string.format("PUMPKIN [%d studs]", math.floor(dist + 0.5))
                                text.TextColor3 = GetESPColor("Pumpkin")
                            end
                        else
                            RemoveESP(obj)
                            RemovePumpkinLabel(obj)
                        end
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
                                CreateESP(obj, GetESPColor("SCP"))
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
                box.Color3 = GetESPColor("Window")
                box.Transparency = 0.3
                box.AlwaysOnTop = true
                box.ZIndex = 5
                box.Parent = bottomPart

                local hl = Instance.new("Highlight")
                hl.Name = "GlutoWindowHighlight"
                hl.Adornee = winModel
                hl.FillColor = GetESPColor("Window")
                hl.FillTransparency = 0.9
                hl.OutlineColor = GetESPColor("Window")
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
                                        CreateESP(char, GetESPColor("Survivor"))
                                    elseif FESP.Killer and TeamIs(p, "Killer") then
                                        CreateESP(char, GetESPColor("Killer"))
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
                UpdatePumpkinESP(root)
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
                local pg = LocalPlayer:FindFirstChild("PlayerGui")
                if gethui then
                    local ok, hui = pcall(gethui)
                    if ok and hui then pg = hui end
                end
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
                frame.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
                frame.BackgroundTransparency = 0.1
                frame.BorderSizePixel = 0
                frame.Active = true
                frame.Parent = gui
                Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

                local stroke = Instance.new("UIStroke", frame)
                stroke.Color = Color3.fromRGB(255, 255, 255)
                stroke.Thickness = 1.2
                stroke.Transparency = 0.2
                stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                local topBar = Instance.new("Frame", frame)
                topBar.Name = "TopBar"
                topBar.Size = UDim2.new(1, 0, 0, 3)
                topBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
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
                title.TextColor3 = Color3.fromRGB(255, 255, 255)
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
                killerName.TextColor3 = Color3.fromRGB(220, 220, 220)
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
                minBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
                minBtn.Font = Enum.Font.GothamBold
                minBtn.TextSize = 13
                minBtn.AutoButtonColor = false
                minBtn.Parent = header

                local divider = Instance.new("Frame", frame)
                divider.Name = "Divider"
                divider.Size = UDim2.new(1, -12, 0, 1)
                divider.Position = UDim2.new(0, 6, 0, 25)
                divider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
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
                    lbl.TextColor3 = Color3.fromRGB(180, 180, 180)
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
                        lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
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

        local KillerAttackAnimSet = {
            ["78432063483146"] = true, ["121216847022485"] = true, ["74968262036854"] = true,
            ["132817836308238"] = true, ["82666958311998"] = true, ["111920872708571"] = true,
            ["106871536134254"] = true, ["109402730355822"] = true, ["130593238885843"] = true,
            ["138720291317243"] = true, ["139369275981139"] = true, ["133963973694098"] = true,
            ["78935059863801"] = true,
            ["118907603246885"] = true, ["135002183282873"] = true, ["113255068724446"] = true,
            ["129784271201071"] = true, ["105374834496520"] = true, ["117070354890871"] = true,
            ["115244153053858"] = true, ["110355011987939"] = true, ["117042998468241"] = true,
            ["122812055447896"] = true,
        }

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
                                if id and KillerAttackAnimSet[id] then return true end
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
            VD.FLASK_SilentAim    = VD.FLASK_SilentAim    or false
            VD.FLASK_ShowBeam     = VD.FLASK_ShowBeam     ~= false
            VD.FLASK_ShowLanding  = VD.FLASK_ShowLanding  ~= false
            VD.FLASK_Predict      = VD.FLASK_Predict      ~= false
            VD.FLASK_Speed        = VD.FLASK_Speed        or 90
            VD.FLASK_Gravity      = VD.FLASK_Gravity      or 196
            VD.FLASK_LeadMult     = VD.FLASK_LeadMult     or 1.0
            VD.FLASK_Range        = VD.FLASK_Range        or 200
            VD.FLASK_BeamColor    = VD.FLASK_BeamColor    or Color3.fromRGB(255, 255, 255)
            VD.FLASK_AccentColor  = VD.FLASK_AccentColor  or Color3.fromRGB(25, 25, 25)
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
                    beam.Color = VD.FLASK_BeamColor or Color3.fromRGB(255, 255, 255)
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
                    accent.Color = VD.FLASK_AccentColor or Color3.fromRGB(25, 25, 25)
                    accent.Transparency = 0.35
                    accent.Parent = Workspace
                    FlaskState.AccentPart = accent
                end
                if FlaskState.BeamPart then FlaskState.BeamPart.Color = VD.FLASK_BeamColor or Color3.fromRGB(255, 255, 255) end
                if FlaskState.AccentPart then FlaskState.AccentPart.Color = VD.FLASK_AccentColor or Color3.fromRGB(25, 25, 25) end
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
                    ring.Color = VD.FLASK_BeamColor or Color3.fromRGB(255, 255, 255)
                    ring.Size = Vector3.new(0.2, 5, 5)
                    ring.Parent = Workspace
                    FlaskState.LandingRing = ring
                end
                FlaskState.LandingRing.Color = VD.FLASK_BeamColor or Color3.fromRGB(255, 255, 255)
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
                local pg = LocalPlayer:FindFirstChild("PlayerGui")
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
                SpearBtnData.Button.BackgroundColor3 = Color3.fromRGB(30, 10, 10)
                SpearBtnData.Button.BackgroundTransparency = 0.15
                SpearBtnData.Button.AutoButtonColor = true
                SpearBtnData.Button.Text = "SPEAR\nAIM"
                SpearBtnData.Button.TextColor3 = Color3.fromRGB(255, 100, 100)
                SpearBtnData.Button.TextSize = 11
                SpearBtnData.Button.Font = Enum.Font.GothamBold
                SpearBtnData.Button.Visible = false
                SpearBtnData.Button.ZIndex = 10
                SpearBtnData.Button.Parent = SpearBtnData.UI
                Instance.new("UICorner", SpearBtnData.Button).CornerRadius = UDim.new(1, 0)
                local spearStk = Instance.new("UIStroke", SpearBtnData.Button)
                spearStk.Color = Color3.fromRGB(255, 80, 80)
                spearStk.Thickness = 2
                spearStk.Transparency = 0.2
                local lockBtn = Instance.new("TextButton")
                lockBtn.Name = "LockDrag"
                lockBtn.Size = UDim2.new(0, 22, 0, 22)
                lockBtn.Position = UDim2.new(1, -5, 0, -5)
                lockBtn.AnchorPoint = Vector2.new(1, 0)
                lockBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                lockBtn.BackgroundTransparency = 0.3
                lockBtn.Text = "L"
                lockBtn.TextSize = 10
                lockBtn.Font = Enum.Font.GothamBold
                lockBtn.TextColor3 = Color3.new(1, 1, 1)
                lockBtn.ZIndex = 11
                lockBtn.Parent = SpearBtnData.Button
                Instance.new("UICorner", lockBtn).CornerRadius = UDim.new(1, 0)
                lockBtn.MouseButton1Click:Connect(function()
                    SpearBtnData.DragLocked = not SpearBtnData.DragLocked
                    lockBtn.Text = SpearBtnData.DragLocked and "X" or "L"
                    lockBtn.BackgroundColor3 = SpearBtnData.DragLocked and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(60, 60, 60)
                end)
                local targetLabel = Instance.new("TextLabel")
                targetLabel.Name = "SpearTargetLabel"
                targetLabel.Size = UDim2.new(0, 90, 0, 18)
                targetLabel.Position = UDim2.new(0.5, 0, 0, -22)
                targetLabel.AnchorPoint = Vector2.new(0.5, 0)
                targetLabel.BackgroundTransparency = 1
                targetLabel.Text = "AUTO"
                targetLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
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
                leftArrow.BackgroundColor3 = Color3.fromRGB(30, 10, 10)
                leftArrow.BackgroundTransparency = 0.15
                leftArrow.Text = "<"
                leftArrow.TextColor3 = Color3.fromRGB(158, 158, 158)
                leftArrow.TextSize = 16
                leftArrow.Font = Enum.Font.GothamBold
                leftArrow.ZIndex = 10
                leftArrow.Parent = SpearBtnData.Button
                Instance.new("UICorner", leftArrow).CornerRadius = UDim.new(1, 0)
                local leftStk = Instance.new("UIStroke", leftArrow)
                leftStk.Color = Color3.fromRGB(255, 80, 80)
                leftStk.Thickness = 1.5
                leftStk.Transparency = 0.3
                SpearBtnData.LeftArrow = leftArrow
                leftArrow.MouseButton1Click:Connect(function() Spear_CycleTarget(-1) end)
                local rightArrow = Instance.new("TextButton")
                rightArrow.Name = "SpearTargetRight"
                rightArrow.Size = UDim2.new(0, 28, 0, 28)
                rightArrow.Position = UDim2.new(1, 34, 0.5, 0)
                rightArrow.AnchorPoint = Vector2.new(0.5, 0.5)
                rightArrow.BackgroundColor3 = Color3.fromRGB(30, 10, 10)
                rightArrow.BackgroundTransparency = 0.15
                rightArrow.Text = ">"
                rightArrow.TextColor3 = Color3.fromRGB(255, 150, 150)
                rightArrow.TextSize = 16
                rightArrow.Font = Enum.Font.GothamBold
                rightArrow.ZIndex = 10
                rightArrow.Parent = SpearBtnData.Button
                Instance.new("UICorner", rightArrow).CornerRadius = UDim.new(1, 0)
                local rightStk = Instance.new("UIStroke", rightArrow)
                rightStk.Color = Color3.fromRGB(255, 80, 80)
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
                        SpearBtnData.Button.BackgroundColor3 = Color3.fromRGB(10, 40, 10)
                        SpearBtnData.Button.TextColor3 = Color3.fromRGB(80, 255, 120)
                        spearStk.Color = Color3.fromRGB(80, 255, 120)
                        VD_Notify("Spear Aimbot", "Spear Aimbot AKTIF!", 3)
                    else
                        SpearBtnData.Button.BackgroundColor3 = Color3.fromRGB(30, 10, 10)
                        SpearBtnData.Button.TextColor3 = Color3.fromRGB(255, 100, 100)
                        spearStk.Color = Color3.fromRGB(255, 80, 80)
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
            VD.SURV_AutoVault  = VD.SURV_AutoVault  or false
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
            local DBD_Config = {
                Enabled = false,
                Distance = 25,
                FOV = 120,
                Height = 0,
                CharScale = 0.05,
                UseCharScale = true,
            }

            local DBD_DefaultFOV = 70
            local DBD_DefaultMinZoom = 0.5
            local DBD_DefaultMaxZoom = 128
            local DBD_Conn = nil

            task.spawn(function()
                while not Workspace.CurrentCamera do task.wait(0.1) end
                DBD_DefaultFOV = Workspace.CurrentCamera.FieldOfView
                DBD_DefaultMinZoom = LocalPlayer.CameraMinZoomDistance
                DBD_DefaultMaxZoom = LocalPlayer.CameraMaxZoomDistance
            end)

            local function DBD_ApplyCharScale()
                if not DBD_Config.UseCharScale then return end
                local char = LocalPlayer.Character
                if not char then return end
                local hum = char:FindFirstChildOfClass("Humanoid")
                if not hum then return end
                local scale = DBD_Config.CharScale
                pcall(function()
                    hum.BodyHeightScale = scale
                    hum.BodyWidthScale = scale
                    hum.BodyDepthScale = scale
                    hum.HeadScale = scale
                end)
            end

            local function DBD_ResetAll()
                local char = LocalPlayer.Character
                if char then
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if hum then
                        pcall(function()
                            hum.BodyHeightScale = 1
                            hum.BodyWidthScale = 1
                            hum.BodyDepthScale = 1
                            hum.HeadScale = 1
                            hum.CameraOffset = Vector3.new(0, 0, 0)
                        end)
                    end
                end
                local cam = Workspace.CurrentCamera
                if cam then cam.FieldOfView = DBD_DefaultFOV end
                LocalPlayer.CameraMaxZoomDistance = DBD_DefaultMaxZoom
                LocalPlayer.CameraMinZoomDistance = DBD_DefaultMinZoom
            end

            local function DBD_StartLoop()
                if DBD_Conn then return end
                DBD_Conn = RunService.RenderStepped:Connect(function()
                    if not DBD_Config.Enabled then return end
                    local cam = Workspace.CurrentCamera
                    if not cam then return end
                    cam.FieldOfView = DBD_Config.FOV
                    local d = DBD_Config.Distance
                    LocalPlayer.CameraMaxZoomDistance = d + 0.5
                    LocalPlayer.CameraMinZoomDistance = math.max(0.1, d - 0.5)
                    local char = LocalPlayer.Character
                    if char then
                        local hum = char:FindFirstChildOfClass("Humanoid")
                        if hum and hum.CameraOffset.Y ~= DBD_Config.Height then
                            hum.CameraOffset = Vector3.new(0, DBD_Config.Height, 0)
                        end
                    end
                end)
            end

            local function DBD_StopLoop()
                if DBD_Conn then
                    DBD_Conn:Disconnect()
                    DBD_Conn = nil
                end
            end

            local function DBD_SetEnabled(on)
                DBD_Config.Enabled = on and true or false
                if DBD_Config.Enabled then
                    DBD_ApplyCharScale()
                    DBD_StartLoop()
                    print("[DBD Camera] ON | Dist:", DBD_Config.Distance, "FOV:", DBD_Config.FOV, "H:", DBD_Config.Height)
                else
                    DBD_StopLoop()
                    DBD_ResetAll()
                    print("[DBD Camera] OFF")
                end
            end

            LocalPlayer.CharacterAdded:Connect(function()
                task.wait(0.35)
                if DBD_Config.Enabled then
                    DBD_ApplyCharScale()
                    DBD_StartLoop()
                end
            end)

            W.CamDBD_SetSmooth = DBD_SetEnabled
            W.CamDBD_SetDistance = function(v)
                DBD_Config.Distance = math.clamp(tonumber(v) or 25, 1, 60)
            end
            W.CamDBD_SetFOV = function(v)
                DBD_Config.FOV = math.clamp(tonumber(v) or 120, 50, 120)
            end
            W.CamDBD_SetHeight = function(v)
                DBD_Config.Height = math.clamp(tonumber(v) or 0, -5, 10)
            end
            W.CamDBD_SetCharScale = function(v)
                DBD_Config.CharScale = math.clamp(tonumber(v) or 0.05, 0.01, 1)
                if DBD_Config.Enabled then DBD_ApplyCharScale() end
            end
            W.CamDBD_SetUseCharScale = function(v)
                DBD_Config.UseCharScale = v and true or false
                if DBD_Config.Enabled then
                    if DBD_Config.UseCharScale then
                        DBD_ApplyCharScale()
                    else
                        local char = LocalPlayer.Character
                        local hum = char and char:FindFirstChildOfClass("Humanoid")
                        if hum then
                            pcall(function()
                                hum.BodyHeightScale = 1
                                hum.BodyWidthScale = 1
                                hum.BodyDepthScale = 1
                                hum.HeadScale = 1
                            end)
                        end
                    end
                end
            end

            W.CamDBD_SetSmoothSpeed = function(v) end
            W.CamDBD_SetPOVLock = function(v) DBD_SetEnabled(v) end
            W.CamDBD_SetTargetPOV = W.CamDBD_SetFOV
            W.CamDBD_SetPOVSmooth = function(v) end

            getgenv().GANKZ_SetDBDCamera = DBD_SetEnabled
        end

        local function CreateFloatingButton(cfg)
            local state = cfg.state
            state.Connections = state.Connections or {}
            local function ClearConns()
                for _, c in ipairs(state.Connections) do pcall(function() c:Disconnect() end) end
                state.Connections = {}
            end
            local function DestroyBtn()
                ClearConns()
                if state.Gui then pcall(function() state.Gui:Destroy() end); state.Gui = nil end
            end
            local function UpdateVisual()
                if not state.Gui then return end
                local main = state.Gui:FindFirstChild("MainBtn", true)
                if not main then return end
                local isOn = cfg.isOn()
                local sp = main:FindFirstChild("StatusPill")
                local st = sp and sp:FindFirstChild("StatusText")
                local sd = sp and sp:FindFirstChild("StatusDot")
                local str = main:FindFirstChild("MainStroke")
                local ic = main:FindFirstChild("IconCircle")
                local idot = ic and ic:FindFirstChild("IconDot")

                if isOn then
                    if ic then TweenService:Create(ic, TweenInfo.new(0.25), { BackgroundColor3 = _G.GLUTO_ACCENT, BackgroundTransparency = 0.15 }):Play() end
                    if idot then TweenService:Create(idot, TweenInfo.new(0.25), { BackgroundColor3 = Color3.fromRGB(0, 0, 0) }):Play() end
                    if sp then TweenService:Create(sp, TweenInfo.new(0.25), { BackgroundColor3 = Color3.fromRGB(0, 0, 0) }):Play() end
                    if st then st.Text = "ON"; TweenService:Create(st, TweenInfo.new(0.25), { TextColor3 = _G.GLUTO_ACCENT }):Play() end
                    if sd then TweenService:Create(sd, TweenInfo.new(0.25), { BackgroundColor3 = _G.GLUTO_ACCENT }):Play() end
                    if str then TweenService:Create(str, TweenInfo.new(0.25), { Color = Color3.fromRGB(255, 255, 255) }):Play() end
                else
                    if ic then TweenService:Create(ic, TweenInfo.new(0.25), { BackgroundColor3 = _G.GLUTO_NEUTRAL, BackgroundTransparency = 0.4 }):Play() end
                    if idot then TweenService:Create(idot, TweenInfo.new(0.25), { BackgroundColor3 = Color3.fromRGB(0, 0, 0) }):Play() end
                    if sp then TweenService:Create(sp, TweenInfo.new(0.25), { BackgroundColor3 = Color3.fromRGB(0, 0, 0) }):Play() end
                    if st then st.Text = "OFF"; TweenService:Create(st, TweenInfo.new(0.25), { TextColor3 = Color3.fromRGB(120, 120, 120) }):Play() end
                    if sd then TweenService:Create(sd, TweenInfo.new(0.25), { BackgroundColor3 = _G.GLUTO_NEUTRAL }):Play() end
                    if str then TweenService:Create(str, TweenInfo.new(0.25), { Color = _G.GLUTO_STROKE_OFF }):Play() end
                end
            end
            local function ToggleBtn()
                local s = not cfg.isOn()
                cfg.onToggle(s)
                UpdateVisual()
                if s then VD_Notify(cfg.notifyTitle, "Enabled", 2) end
            end
            local function CreateBtn()
                DestroyBtn()
                local parent = LocalPlayer:FindFirstChild("PlayerGui")
                if gethui then local ok2, hui = pcall(gethui); if ok2 and hui then parent = hui end end
                if not parent then return end
                local gui = Instance.new("ScreenGui")
                gui.Name = "Gluto" .. cfg.id .. "Btn"; gui.ResetOnSpawn = false
                gui.IgnoreGuiInset = true; gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                gui.Parent = parent
                state.Gui = gui

                local container = Instance.new("Frame")
                container.Name = "Container"
                container.Size = UDim2.fromOffset(180, 40)
                container.Position = state.SavedPos
                container.BackgroundTransparency = 1
                container.Parent = gui

                local main = Instance.new("Frame")
                main.Name = "MainBtn"
                main.Size = UDim2.fromOffset(132, 40)
                main.BackgroundTransparency = 1
                main.BorderSizePixel = 0
                main.ZIndex = 1
                main.ClipsDescendants = true
                main.Parent = container
                Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

                local mainBg = Instance.new("ImageLabel")
                mainBg.Name = "BackgroundImage"
                mainBg.Size = UDim2.fromScale(1, 1)
                mainBg.Position = UDim2.fromScale(0, 0)
                mainBg.BackgroundTransparency = 1
                mainBg.BorderSizePixel = 0
                mainBg.Image = FLOATING_BUTTON_BACKGROUND
                mainBg.ScaleType = Enum.ScaleType.Crop
                mainBg.ImageTransparency = 0
                mainBg.Active = false
                mainBg.ZIndex = 1
                mainBg.Parent = main
                Instance.new("UICorner", mainBg).CornerRadius = UDim.new(0, 12)
                task.spawn(PreloadFloatingPhoto, mainBg)

                local mainStroke = Instance.new("UIStroke", main)
                mainStroke.Name = "MainStroke"
                mainStroke.Color = _G.GLUTO_STROKE_OFF
                mainStroke.Thickness = 1.2
                mainStroke.Transparency = 0.2

                local ic = Instance.new("Frame")
                ic.Name = "IconCircle"
                ic.Size = UDim2.fromOffset(24, 24)
                ic.Position = UDim2.new(0, 8, 0.5, -12)
                ic.BackgroundColor3 = _G.GLUTO_NEUTRAL
                ic.BackgroundTransparency = 0.4
                ic.BorderSizePixel = 0
                ic.ZIndex = 2
                ic.Parent = main
                Instance.new("UICorner", ic).CornerRadius = UDim.new(1, 0)

                local idot = Instance.new("Frame")
                idot.Name = "IconDot"
                idot.Size = UDim2.fromOffset(10, 10)
                idot.Position = UDim2.new(0.5, -5, 0.5, -5)
                idot.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                idot.BorderSizePixel = 0
                idot.ZIndex = 3
                idot.Rotation = cfg.iconRotation or 0
                idot.Parent = ic
                Instance.new("UICorner", idot).CornerRadius = UDim.new(0, 2)

                local ml = Instance.new("TextLabel")
                ml.Name = "MainLabel"
                ml.Size = UDim2.new(1, -70, 1, 0)
                ml.Position = UDim2.new(0, 38, 0, 0)
                ml.BackgroundTransparency = 1
                ml.Font = Enum.Font.GothamBold
                ml.Text = cfg.title
                ml.TextColor3 = Color3.fromRGB(240, 240, 245)
                ml.TextSize = 13
                ml.TextXAlignment = Enum.TextXAlignment.Left
                ml.ZIndex = 2
                ml.Parent = main

                local sp = Instance.new("Frame")
                sp.Name = "StatusPill"
                sp.AnchorPoint = Vector2.new(1, 0.5)
                sp.Size = UDim2.fromOffset(42, 20)
                sp.Position = UDim2.new(1, -8, 0.5, 0)
                sp.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                sp.BackgroundTransparency = 0.18
                sp.BorderSizePixel = 0
                sp.ZIndex = 2
                sp.Parent = main
                Instance.new("UICorner", sp).CornerRadius = UDim.new(1, 0)

                local sd = Instance.new("Frame")
                sd.Name = "StatusDot"
                sd.Size = UDim2.fromOffset(6, 6)
                sd.Position = UDim2.new(0, 7, 0.5, -3)
                sd.BackgroundColor3 = _G.GLUTO_NEUTRAL
                sd.BorderSizePixel = 0
                sd.ZIndex = 3
                sd.Parent = sp
                Instance.new("UICorner", sd).CornerRadius = UDim.new(1, 0)

                local st = Instance.new("TextLabel")
                st.Name = "StatusText"
                st.Size = UDim2.new(1, -18, 1, 0)
                st.Position = UDim2.new(0, 16, 0, 0)
                st.BackgroundTransparency = 1
                st.Font = Enum.Font.GothamBold
                st.Text = "OFF"
                st.TextColor3 = Color3.fromRGB(140, 140, 152)
                st.TextSize = 10
                st.TextXAlignment = Enum.TextXAlignment.Center
                st.ZIndex = 3
                st.Parent = sp

                local lock = Instance.new("TextButton")
                lock.Name = "LockBtn"
                lock.Size = UDim2.fromOffset(40, 40)
                lock.Position = UDim2.new(1, -44, 0, 0)
                lock.BackgroundTransparency = 1
                lock.BorderSizePixel = 0
                lock.ClipsDescendants = true
                lock.Text = ""
                lock.AutoButtonColor = false
                lock.ZIndex = 1
                lock.Parent = container
                Instance.new("UICorner", lock).CornerRadius = UDim.new(0, 12)

                local lockBg = Instance.new("ImageLabel")
                lockBg.Name = "BackgroundImage"
                lockBg.Size = UDim2.fromScale(1, 1)
                lockBg.Position = UDim2.fromScale(0, 0)
                lockBg.BackgroundTransparency = 1
                lockBg.BorderSizePixel = 0
                lockBg.Image = FLOATING_BUTTON_BACKGROUND
                lockBg.ScaleType = Enum.ScaleType.Crop
                lockBg.ImageTransparency = 0
                lockBg.Active = false
                lockBg.ZIndex = 1
                lockBg.Parent = lock
                Instance.new("UICorner", lockBg).CornerRadius = UDim.new(0, 12)
                task.spawn(PreloadFloatingPhoto, lockBg)

                local ls = Instance.new("UIStroke", lock)
                ls.Color = _G.GLUTO_STROKE_OFF
                ls.Thickness = 1.2
                ls.Transparency = 0.2
                ls.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                local li = Instance.new("TextLabel")
                li.Name = "LockIcon"
                li.Size = UDim2.fromScale(1, 1)
                li.BackgroundTransparency = 1
                li.Font = Enum.Font.GothamBold
                li.Text = "🔓"
                li.TextColor3 = Color3.fromRGB(180, 180, 190)
                li.TextSize = 16
                li.ZIndex = 2
                li.Parent = lock

                local function UpdateLockVisual()
                    if state.DragLocked then
                        li.Text = "🔒"
                        TweenService:Create(ls, TweenInfo.new(0.2), { Color = _G.GLUTO_ACCENT, Transparency = 0, Thickness = 1.5 }):Play()
                        TweenService:Create(li, TweenInfo.new(0.2), { TextColor3 = _G.GLUTO_ACCENT }):Play()
                    else
                        li.Text = "🔓"
                        TweenService:Create(ls, TweenInfo.new(0.2), { Color = _G.GLUTO_STROKE_OFF, Transparency = 0.2, Thickness = 1.2 }):Play()
                        TweenService:Create(li, TweenInfo.new(0.2), { TextColor3 = Color3.fromRGB(180, 180, 190) }):Play()
                    end
                end

                local cd = Instance.new("TextButton")
                cd.Name = "ClickDetect"
                cd.Size = UDim2.fromScale(1, 1)
                cd.BackgroundTransparency = 1
                cd.Text = ""
                cd.AutoButtonColor = false
                cd.ZIndex = 5
                cd.Parent = main

                local drag = false
                local dStart, sPos
                local dDist = 0
                table.insert(state.Connections, cd.InputBegan:Connect(function(inp)
                    if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                        dStart = inp.Position
                        sPos = container.Position
                        dDist = 0
                        if not state.DragLocked then drag = true end
                    end
                end))
                table.insert(state.Connections, cd.InputEnded:Connect(function(inp)
                    if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                        if drag then drag = false; state.SavedPos = container.Position end
                        if dDist < 8 then ToggleBtn() end
                    end
                end))
                table.insert(state.Connections, UserInputService.InputChanged:Connect(function(inp)
                    if not drag then return end
                    if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then
                        local d = inp.Position - dStart
                        dDist = math.abs(d.X) + math.abs(d.Y)
                        container.Position = UDim2.new(sPos.X.Scale, sPos.X.Offset + d.X, sPos.Y.Scale, sPos.Y.Offset + d.Y)
                    end
                end))
                table.insert(state.Connections, lock.MouseButton1Click:Connect(function()
                    state.DragLocked = not state.DragLocked
                    if state.DragLocked then drag = false end
                    UpdateLockVisual()
                    VD_Notify(cfg.notifyTitle .. " Button", state.DragLocked and "Locked" or "Unlocked", 1)
                end))
                UpdateVisual()
                UpdateLockVisual()
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

            -- Removed by request: Troll Teleport floating button

        local EscapeBtnState = { Enabled=false, DragLocked=false, Gui=nil, SavedPos=UDim2.new(0.03,0,0.49,0), Connections={} }
        local EscapeState = CreateFloatingButton({
            id="Escape", title="Escape", notifyTitle="Instant Escape", state=EscapeBtnState,
            isOn=function() return W.Escape.Enabled end,
            onToggle=function(v) W.Escape.Enabled = v; if v then W.Escape_Teleport() end end,
            iconRotation=45,
        })
        getgenv().Gluto_Escape_SetEnabled = function(en) EscapeState.SetEnabled(en) end
        getgenv().Gluto_Escape_UpdateVisual = function() EscapeState.UpdateVisual() end



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
                local trapPerfect = check:FindFirstChild("TrapPerfect")
                local trapGoal = check:FindFirstChild("TrapGoal")
                if (trapPerfect and trapPerfect.Visible) or (trapGoal and trapGoal.Visible) then return end
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

        -- Auto Skill Check Traps (separate from generator skill checks)
        W.SkillCheckTrap = W.SkillCheckTrap or { Enabled=false, Mode="Legit", Busy=false, Connection=nil }
        local SCT = W.SkillCheckTrap
        function W.SkillCheckTrap_Start()
            if SCT.Connection then SCT.Connection:Disconnect(); SCT.Connection = nil end
            SCT.Connection = RunService.RenderStepped:Connect(function()
                if not SCT.Enabled or SCT.Busy then return end
                local pGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
                if not pGui then return end
                for _, guiName in ipairs({ "SkillCheckPromptGui", "SkillCheckPromptGui-con" }) do
                    local prompt = pGui:FindFirstChild(guiName)
                    if prompt and prompt.Enabled ~= false then
                        local check = prompt:FindFirstChild("Check")
                        if check and check.Visible then
                            local line = check:FindFirstChild("Line")
                            if not line then return end
                            local trapTarget
                            for _, targetName in ipairs({ "TrapPerfect", "TrapGoal" }) do
                                local candidate = check:FindFirstChild(targetName)
                                if candidate and candidate.Visible then
                                    trapTarget = candidate
                                    break
                                end
                            end
                            if not trapTarget then return end
                            local shouldPress = false
                            if SCT.Mode == "Instant" then
                                line.Rotation = trapTarget.Rotation + 109
                                shouldPress = true
                            else
                                local lr = line.Rotation % 360
                                local gr = trapTarget.Rotation % 360
                                local startAngle = (gr + 102) % 360
                                local endAngle = (gr + 116) % 360
                                shouldPress = (startAngle > endAngle and (lr >= startAngle or lr <= endAngle))
                                    or (lr >= startAngle and lr <= endAngle)
                            end
                            if shouldPress then
                                SCT.Busy = true
                                task.spawn(function()
                                    if UserInputService.TouchEnabled then
                                        SC_TriggerMobileButton()
                                    else
                                        SC_PressSpace()
                                    end
                                    task.wait(SCT.Mode == "Instant" and 0.4 or 0.05)
                                    SCT.Busy = false
                                end)
                            end
                            return
                        end
                    end
                end
            end)
        end
        function W.SkillCheckTrap_Stop()
            if SCT.Connection then SCT.Connection:Disconnect(); SCT.Connection = nil end
            SCT.Busy = false
        end
        function W.SkillCheckTrap_SetEnabled(v)
            SCT.Enabled = v and true or false
            if SCT.Enabled then W.SkillCheckTrap_Start() else W.SkillCheckTrap_Stop() end
        end

        do
            local lp = LocalPlayer
            local AP = { Enabled = false, Mode = "Killer Hit", Range = 11, ShowRange = false }
            W.N3K0P01_AutoParry = AP

            ---------------- config internal (nggak ada di UI) ----------------
            local ATTR = "LowerBodyStabilize"
            local DEBUG = true               -- false = nggak ada log di console
            local PARRY_DELAY = 0

            -- hitbox killer (mode Killer)
            local KB_LEN = 6                 -- panjang ke depan (studs)
            local KB_WIDTH = 4               -- lebar kiri-kanan
            local KB_HEIGHT = 7              -- tinggi
            local KB_OFFSET = 0              -- jarak mulai kotak dari tengah badan killer
            local KB_MARGIN = 0              -- toleransi tambahan (studs)
            local KB_WINDOW = 100            -- ms sejak attribute nyala; di luar ini hit dianggap nggak valid
            local SHOW_KHB = true            -- tampilkan kotak merah saat mode Killer
            local COLOR_KILLER_HB = Color3.fromRGB(255, 40, 40)
            local COLOR_KILLER_HIT = Color3.fromRGB(255, 220, 40)

            -- ring range
            local RING_SEGMENTS = 30
            local RING_ALPHA = 0.2
            local RING_THICK = 0.3
            local RING_HEIGHT = 0.1
            local RING_LIFT = 0.2
            local RING_DROP = 1.2

            local function dbg(...)
                if DEBUG then print("[AutoParry]", ...) end
            end

            -- sisa instance dari eksekusi sebelumnya
            pcall(function()
                local old = W.__N3K0P01_APFolder
                if old then old:Destroy() end
            end)
            local apFolder = Instance.new("Folder")
            apFolder.Name = "N3K0P01_AutoParry"
            apFolder.Parent = Workspace
            W.__N3K0P01_APFolder = apFolder

            ---------------- state ----------------
            local fired = false
            local lastAttr = false
            local attrTrueAt = -100
            local lateLogged = false

            ---------------- helper ----------------
            local function getRoot(char)
                local r = char and char:FindFirstChild("HumanoidRootPart")
                if r and r:IsA("BasePart") then return r end
            end

            local function getKiller()
                for _, plr in ipairs(Players:GetPlayers()) do
                    if plr ~= lp and TeamIs(plr, "Killer") then
                        local char = Workspace:FindFirstChild(plr.Name) or plr.Character
                        if char then return plr, char end
                    end
                end
            end

            ---------------- core parry ----------------
            local ParryClient = nil
            local function getParryClient()
                if ParryClient then return ParryClient end
                local ok, mod = pcall(function()
                    return require(ReplicatedStorage.Modules.Items.ParryingDagger.ParryClient)
                end)
                if ok and mod then ParryClient = mod end
                return ParryClient
            end

            local cached
            local function validInstance(p)
                if not p then return false end
                local ok, eq = pcall(p._isEquipped, p)
                return (ok and eq) and true or false
            end

            local function findParry()
                if validInstance(cached) then return cached end
                cached = nil
                local PC = getParryClient()
                if not PC or typeof(getgc) ~= "function" then return nil end
                for _, v in ipairs(getgc(true)) do
                    if typeof(v) == "table"
                        and getmetatable(v) == PC
                        and rawget(v, "player") == lp
                        and validInstance(v)
                    then
                        cached = v
                        return v
                    end
                end
            end

            local function ensureEquipped()
                local char = lp.Character
                local hum = char and char:FindFirstChildOfClass("Humanoid")
                if not hum then return end
                if char:FindFirstChild("Parrying Dagger") then return end
                local tool = lp.Backpack:FindFirstChild("Parrying Dagger")
                if tool then
                    hum:EquipTool(tool)
                    task.wait(0.1)
                end
            end

            local function whyNot(p)
                local function flag(name)
                    local ok, v = pcall(function() return p[name] end)
                    return ok and tostring(v) or "?"
                end
                local ok1, b = pcall(p._isBusy, p)
                local ok2, lo = pcall(p._isLowHealth, p)
                local hum = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
                local hp = hum and string.format("%.0f/%.0f", hum.Health, hum.MaxHealth) or "?"
                return string.format("cooldown=%s resolving=%s silenced=%s busy=%s lowHP=%s | HP=%s",
                    flag("isParryOnCooldown"), flag("isParryResolving"), flag("isSilenced"),
                    ok1 and tostring(b) or "?", ok2 and tostring(lo) or "?", hp)
            end

            local busy = false
            local function doParry(src)
                if busy then return end
                busy = true
                task.spawn(function()
                    local t0 = os.clock()
                    local ok, err = pcall(function()
                        ensureEquipped()
                        local p = findParry()
                        if not p then
                            dbg("GAGAL: instance ParryClient nggak ketemu (dagger ke-equip?)")
                            return
                        end
                        if not p:CanUse() then
                            dbg("GAGAL: CanUse=false |", whyNot(p))
                            return
                        end
                        dbg(string.format("PARRY dari %s (+%.0f ms)", tostring(src or "?"), (os.clock() - t0) * 1000))
                        p:Parry()
                    end)
                    if not ok then warn("[AutoParry] error:", err) end
                    busy = false
                end)
            end

            local function triggerParry(src)
                if PARRY_DELAY > 0 then
                    task.delay(PARRY_DELAY, doParry, src)
                else
                    doParry(src)
                end
            end

            local function watchChar(char)
                if not char then return end
                char.ChildAdded:Connect(function(c)
                    if AP.Enabled and c:IsA("Tool") and c.Name == "Parrying Dagger" then
                        task.wait(0.5)
                        findParry()
                    end
                end)
            end
            watchChar(LocalPlayer.Character)
            LocalPlayer.CharacterAdded:Connect(watchChar)

            ---------------- ring range ----------------
            local segments = {}
            local rayParams = RaycastParams.new()
            rayParams.FilterType = Enum.RaycastFilterType.Exclude

            local function resizeRing()
                local segLen = (2 * math.pi * AP.Range / RING_SEGMENTS) * 1.05
                for _, p in ipairs(segments) do
                    p.Size = Vector3.new(RING_THICK, RING_HEIGHT, segLen)
                end
            end

            local function ensureRing()
                if #segments > 0 and segments[1].Parent then return end
                segments = {}
                for i = 1, RING_SEGMENTS do
                    local p = Instance.new("Part")
                    p.Name = "Seg" .. i
                    p.Anchored = true
                    p.CanCollide = false
                    p.CanQuery = false
                    p.CanTouch = false
                    p.CastShadow = false
                    p.Material = Enum.Material.Neon
                    p.Color = Color3.fromRGB(255, 0, 0)
                    p.Transparency = RING_ALPHA
                    p.Size = Vector3.new(RING_THICK, RING_HEIGHT, 1)
                    p.Parent = apFolder
                    segments[i] = p
                end
                resizeRing()
            end

            local function destroyRing()
                if #segments == 0 then return end
                for _, p in ipairs(segments) do pcall(function() p:Destroy() end) end
                segments = {}
            end

            local function updateRing(center)
                for i, p in ipairs(segments) do
                    local theta = (i - 1) / RING_SEGMENTS * math.pi * 2
                    p.CFrame = CFrame.new(center) * CFrame.Angles(0, theta, 0) * CFrame.new(AP.Range, 0, 0)
                end
            end

            local function getFloorY(char, myRoot)
                rayParams.FilterDescendantsInstances = { char, apFolder }
                local result = Workspace:Raycast(myRoot.Position, Vector3.new(0, -30, 0), rayParams)
                if result then return result.Position.Y + RING_LIFT end
                local hum = char:FindFirstChildOfClass("Humanoid")
                local hip = hum and hum.HipHeight or 2
                return myRoot.Position.Y - (myRoot.Size.Y / 2 + hip) - RING_DROP + RING_LIFT
            end

            ---------------- hitbox killer (merah, di depan killer) ----------------
            -- Roblox: depan = -Z lokal.
            local killerBox

            local function makeKillerBox()
                local p = Instance.new("Part")
                p.Name = "KillerHitbox"
                p.Anchored = true
                p.CanCollide = false
                p.CanQuery = false
                p.CanTouch = false
                p.CastShadow = false
                p.Material = Enum.Material.Neon
                p.Color = COLOR_KILLER_HB
                p.Transparency = 0.6
                p.Size = Vector3.new(KB_WIDTH, KB_HEIGHT, KB_LEN)
                p.Parent = apFolder
                return p
            end

            local function destroyKillerBox()
                if killerBox then
                    pcall(function() killerBox:Destroy() end)
                    killerBox = nil
                end
            end

            -- true kalau salah satu bagian badan (anak langsung karakter) nyentuh kotak
            local function bodyPartInBox(box, char)
                local cf, half = box.CFrame, box.Size / 2
                local hx, hy, hz = half.X + KB_MARGIN, half.Y + KB_MARGIN, half.Z + KB_MARGIN
                for _, part in ipairs(char:GetChildren()) do
                    if part:IsA("BasePart") then
                        local s = part.Size / 2
                        local minX, minY, minZ = math.huge, math.huge, math.huge
                        local maxX, maxY, maxZ = -math.huge, -math.huge, -math.huge
                        for sx = -1, 1, 2 do
                            for sy = -1, 1, 2 do
                                for sz = -1, 1, 2 do
                                    local p = cf:PointToObjectSpace((part.CFrame * Vector3.new(s.X * sx, s.Y * sy, s.Z * sz)))
                                    minX, maxX = math.min(minX, p.X), math.max(maxX, p.X)
                                    minY, maxY = math.min(minY, p.Y), math.max(maxY, p.Y)
                                    minZ, maxZ = math.min(minZ, p.Z), math.max(maxZ, p.Z)
                                end
                            end
                        end
                        if maxX >= -hx and minX <= hx
                            and maxY >= -hy and minY <= hy
                            and maxZ >= -hz and minZ <= hz then
                            return true, part.Name
                        end
                    end
                end
                return false
            end

            -- update kotak (visual + cek). return inside, namaPart
            local function updateKillerBox(kchar, myChar)
                local kRoot = kchar and getRoot(kchar)
                if not kRoot then
                    destroyKillerBox()
                    return false
                end
                if not killerBox or not killerBox.Parent then
                    killerBox = makeKillerBox()
                end
                killerBox.Size = Vector3.new(KB_WIDTH, KB_HEIGHT, KB_LEN)
                killerBox.CFrame = kRoot.CFrame * CFrame.new(0, 0, -(KB_LEN / 2 + KB_OFFSET))
                killerBox.Transparency = SHOW_KHB and 0.6 or 1

                local inside, partName = false, nil
                if myChar then
                    inside, partName = bodyPartInBox(killerBox, myChar)
                end
                killerBox.Color = inside and COLOR_KILLER_HIT or COLOR_KILLER_HB
                return inside, partName
            end

            ---------------- loop utama ----------------
            local overlapParams = OverlapParams.new()
            overlapParams.FilterType = Enum.RaycastFilterType.Include

            RunService.Heartbeat:Connect(function()
                if not AP.Enabled then
                    if #segments > 0 then destroyRing() end
                    if killerBox then destroyKillerBox() end
                    fired = false
                    lastAttr = false
                    lateLogged = false
                    return
                end

                local char = lp.Character
                local myRoot = getRoot(char)
                if not myRoot then return end

                if AP.ShowRange then
                    ensureRing()
                    updateRing(Vector3.new(myRoot.Position.X, getFloorY(char, myRoot), myRoot.Position.Z))
                else
                    destroyRing()
                end

                local plr, kchar = getKiller()
                local active = (kchar ~= nil) and (kchar:GetAttribute(ATTR) == true) or false

                local killerIn, killerPart = false, nil
                if AP.Mode == "Killer" then
                    killerIn, killerPart = updateKillerBox(kchar, char)
                else
                    destroyKillerBox()
                end

                if active ~= lastAttr then
                    lastAttr = active
                    if active then
                        attrTrueAt = os.clock()
                        local kRoot = getRoot(kchar)
                        local d = kRoot and (kRoot.Position - myRoot.Position).Magnitude or -1
                        dbg(string.format("%s %s = true | jarak %.1f", plr and plr.Name or "killer", ATTR, d))
                    else
                        dbg(plr and plr.Name or "killer", ATTR, "= false")
                    end
                end

                if not active then
                    fired = false
                    lateLogged = false
                    return
                end
                if fired then return end

                if AP.Mode == "Range" then
                    overlapParams.FilterDescendantsInstances = { kchar }
                    local hits = Workspace:GetPartBoundsInRadius(myRoot.Position, AP.Range, overlapParams)
                    if #hits > 0 then
                        fired = true
                        local kRoot = getRoot(kchar)
                        local d = kRoot and (kRoot.Position - myRoot.Position).Magnitude or -1
                        dbg(string.format("RANGE trigger | jarak %.1f | +%.2fs sejak attr nyala", d, os.clock() - attrTrueAt))
                        triggerParry("range")
                    end
                else
                    if killerIn then
                        local since = os.clock() - attrTrueAt
                        if since * 1000 <= KB_WINDOW then
                            fired = true
                            dbg(string.format("KILLER trigger | part %s | +%.3fs sejak attr nyala", tostring(killerPart), since))
                            triggerParry("killer hitbox")
                        elseif not lateLogged then
                            lateLogged = true
                            dbg(string.format("KILLER diabaikan: masuk kotak telat (+%.3fs > %d ms)", since, KB_WINDOW))
                        end
                    end
                end
            end)

            ---------------- API buat UI ----------------
            function AP.SetEnabled(v)
                AP.Enabled = v == true
                fired = false
                lateLogged = false
                if AP.Enabled then task.spawn(findParry) end
            end
            function AP.SetMode(v)
                AP.Mode = (tostring(v) == "Range") and "Range" or "Killer"
                fired = false
                lateLogged = false
            end
            function AP.SetRange(v)
                AP.Range = math.clamp(tonumber(v) or 11, 3, 60)
                resizeRing()
            end
            function AP.SetShowRange(v)
                AP.ShowRange = v == true
                if not AP.ShowRange then destroyRing() end
            end

            -- bersihin saat hub di-unload
            pcall(function()
                Gui.Destroying:Connect(function()
                    AP.Enabled = false
                    pcall(function() apFolder:Destroy() end)
                end)
            end)
        end



        -- =====================================================================
        -- SILENT AIM TOF (harness v8 terintegrasi)
        -- Spoof UpdateCharacterLook + redirect Fire + lead + tracer + hapus peluru asli
        -- API: W.N3K0P01_TOF
        -- =====================================================================
        do
            local T = {
                Enabled = false,
                SpoofLook = true,
                Lead = true,
                Speed = 150,
                Gravity = 0,
                Tracer = true,
                TracerSpeed = 180,
                TracerColor = Color3.fromRGB(255, 255, 255),
                RemoveOriginal = true,
                HideInstead = true,
                Window = 1.5,
                PreWindow = 0.6,
                Debug = false,
                ShowLaser = false,   -- baru
                Radius = 200,       -- baru
            }
            W.N3K0P01_TOF = T

            local GUN_NAME = "Twist of Fate"
            local state = { lastFire = 0, watchUntil = 0 }
            local pending, recent = {}, {}
            local bulletNames = {}
            local fireRemote, lookRemote
            local lastLookArgs
            local addedConn

            local function dbg(...) if T.Debug then print("[TOF]", ...) end end

            local function resolveRemotes()
                if not (fireRemote and fireRemote.Parent) then
                    local r = ReplicatedStorage:FindFirstChild("Remotes")
                    local items = r and r:FindFirstChild("Items")
                    local tof = items and items:FindFirstChild(GUN_NAME)
                    fireRemote = tof and tof:FindFirstChild("Fire")
                end
                if not (lookRemote and lookRemote.Parent) then
                    local r = ReplicatedStorage:FindFirstChild("Remotes")
                    local g = r and r:FindFirstChild("Game")
                    lookRemote = g and g:FindFirstChild("UpdateCharacterLook")
                end
                return fireRemote, lookRemote
            end

            local function loadBulletNames()
                table.clear(bulletNames)
                pcall(function()
                    local folder = ReplicatedStorage.Items[GUN_NAME].Bullets
                    for _, b in ipairs(folder:GetChildren()) do bulletNames[b.Name:lower()] = true end
                end)
            end

            local function armed()
                local c = LocalPlayer.Character
                return c and c:FindFirstChild(GUN_NAME) ~= nil
            end

            local function killerPart()
                local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if not myRoot then return nil end
                local best, bd = nil, math.huge
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and TeamIs(p, "Killer") and p.Character then
                        local hum = p.Character:FindFirstChildOfClass("Humanoid")
                        local part = p.Character:FindFirstChild("HumanoidRootPart")
                        if hum and hum.Health > 0 and part then
                            local d = (part.Position - myRoot.Position).Magnitude
                            if d <= T.Radius and d < bd then bd, best = d, part end
                        end
                    end
                end
                return best
            end

            local function originOf(inst)
                if typeof(inst) ~= "Instance" then return nil end
                if inst:IsA("BasePart") then return inst.Position end
                local ok, cf = pcall(function() return inst:GetPivot() end)
                if ok and cf then return cf.Position end
                local bp = inst:FindFirstChildWhichIsA("BasePart", true)
                return bp and bp.Position
            end

            local function mk(ty, d)
                if ty == "vector" and vector and vector.create then return vector.create(d.X, d.Y, d.Z) end
                return Vector3.new(d.X, d.Y, d.Z)
            end

            local function aimPoint(origin, part)
                local pos, vel = part.Position, part.AssemblyLinearVelocity
                if not T.Lead then return pos, 0 end
                local speed = math.max(tonumber(T.Speed) or 150, 1)
                local flat = Vector3.new(vel.X, 0, vel.Z)
                local t = (pos - origin).Magnitude / speed
                for _ = 1, 4 do t = ((pos + flat * t) - origin).Magnitude / speed end
                return pos + flat * t + Vector3.new(0, 0.5 * (tonumber(T.Gravity) or 0) * t * t, 0), t
            end

            local function spawnTracer(from, to)
                local dist = (to - from).Magnitude
                if dist < 1 then return end
                local p = Instance.new("Part")
                p.Name = "TOF_Tracer"
                p:SetAttribute("TOF_Own", true)
                p.Anchored, p.CanCollide, p.CanQuery, p.CanTouch, p.CastShadow = true, false, false, false, false
                p.Material = Enum.Material.Neon
                p.Color = T.TracerColor
                p.Size = Vector3.new(0.15, 0.15, 1.6)
                p.CFrame = CFrame.lookAt(from, to)
                p.Parent = Workspace
                local tw = TweenService:Create(p,
                    TweenInfo.new(dist / math.max(tonumber(T.TracerSpeed) or 180, 1), Enum.EasingStyle.Linear),
                    { CFrame = CFrame.lookAt(to, to + (to - from)) })
                tw:Play()
                tw.Completed:Connect(function() p:Destroy() end)
                task.delay(3, function() if p.Parent then p:Destroy() end end)
            end

            -- ===== penghapus peluru asli =====
            local function relevant(d)
                if d:GetAttribute("TOF_Own") then return false end
                if not bulletNames[d.Name:lower()] then return false end
                if not d:IsDescendantOf(Workspace) then return false end
                local a = d.Parent
                while a and a ~= Workspace do
                    if Players:GetPlayerFromCharacter(a) then return false end
                    a = a.Parent
                end
                return true
            end

            local function hideAll(d)
                local function apply()
                    local list = d:GetDescendants()
                    list[#list + 1] = d
                    for _, x in ipairs(list) do
                        if x:IsA("BasePart") or x:IsA("Decal") or x:IsA("Texture") then x.Transparency = 1
                        elseif x:IsA("ParticleEmitter") or x:IsA("Trail") or x:IsA("Beam") then x.Enabled = false end
                    end
                end
                apply()
                local t0, c = os.clock(), nil
                c = RunService.RenderStepped:Connect(function()
                    if not d.Parent or os.clock() - t0 > 3 then c:Disconnect() return end
                    apply()
                end)
            end

            local function kill(d)
                dbg("hapus:", d.Name, d.ClassName, d:GetFullName())
                if T.HideInstead then pcall(hideAll, d) else pcall(function() d:Destroy() end) end
            end

            local function onAdded(d)
                local now = os.clock()
                recent[#recent + 1] = { d = d, t = now }
                if #recent > 60 then table.remove(recent, 1) end
                if T.Debug and now < state.watchUntil and not d:GetAttribute("TOF_Own") and d.Name ~= "TOF_Tracer" then
                    print(("[TOF] +%.3fs spawn: %s (%s) @ %s"):format(now - state.lastFire, d.Name, d.ClassName, d:GetFullName()))
                end
                if not T.RemoveOriginal then return end
                task.defer(function()
                    if not d.Parent or not relevant(d) then return end
                    if os.clock() - state.lastFire <= T.Window then kill(d)
                    else pending[#pending + 1] = { d = d, t = now } end
                end)
            end

            -- ===== handler hook =====
            W.N3K0P01_TOF_HANDLER = function(self, args)
                -- di awal W.N3K0P01_TOF_HANDLER
                if T.Debug then
                    local s = {}
                    for i = 1, args.n do s[#s + 1] = i .. "=" .. typeof(args[i]) end
                    print("[TOF]", self.Name, table.concat(s, " "))
                end
                if not T.Enabled then return nil end
                local fire, look = resolveRemotes()
                if self == look then
                    lastLookArgs = table.clone(args)
                    if T.SpoofLook and armed() then
                        local t = killerPart()
                        local head = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head")
                        local ty = typeof(args[6])
                        if t and head and (ty == "Vector3" or ty == "vector") then
                            args[6] = mk(ty, (aimPoint(head.Position, t) - head.Position).Unit)
                            return args
                        end
                    end
                elseif self == fire then
                    local now = os.clock()
                    state.lastFire, state.watchUntil = now, now + 0.8
                    local t, o = killerPart(), originOf(args[1])
                    dbg(("FIRE kena hook | killer=%s | origin=%s"):format(tostring(t), tostring(o)))
                    if T.RemoveOriginal then
                        for i = #pending, 1, -1 do
                            local p = pending[i]
                            if now - p.t <= T.PreWindow and p.d.Parent then kill(p.d) end
                            pending[i] = nil
                        end
                    end
                    if t and o then
                        local p = aimPoint(o, t)
                        local dir = (p - o).Unit
                        args[2] = mk(typeof(args[2]), dir)

                        -- kirim look yang sudah di-spoof tepat sebelum Fire
                        if T.SpoofLook and lastLookArgs and look then
                            local head = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head")
                            local ty = typeof(lastLookArgs[6])
                            if head and (ty == "Vector3" or ty == "vector") then
                                local la = table.clone(lastLookArgs)
                                la[6] = mk(ty, (aimPoint(head.Position, t) - head.Position).Unit)
                                pcall(function() look:FireServer(table.unpack(la, 1, la.n)) end)
                            end
                        end

                        if T.Tracer then task.spawn(spawnTracer, o, p) end
                        return args
                    end
                end
                return nil
            end

            local function installHook()
                -- flag di workspace: otomatis hilang tiap rejoin (nggak basi kayak getgenv)
                if Workspace:GetAttribute("N3K0P01_TOF_HOOKED") then return true end
                if type(hookmetamethod) ~= "function" or type(getnamecallmethod) ~= "function" then
                    return false, "executor tidak mendukung hookmetamethod"
                end
                local wrap = newcclosure or function(f) return f end
                local setnc = setnamecallmethod or function() end
                local ok, err = pcall(function()
                    local old
                    old = hookmetamethod(game, "__namecall", wrap(function(self, ...)
                        local method = getnamecallmethod()
                        if (method == "FireServer" or method == "fireServer")
                            and not (type(checkcaller) == "function" and checkcaller())
                            and T.Enabled and W.N3K0P01_TOF_HANDLER then
                            local okH, res = pcall(W.N3K0P01_TOF_HANDLER, self, table.pack(...))
                            if not okH then
                                warn("[TOF] handler error:", res)
                            elseif res then
                                setnc(method)
                                return old(self, table.unpack(res, 1, res.n))
                            end
                        end
                        setnc(method)
                        return old(self, ...)
                    end))
                end)
                if not ok then return false, tostring(err) end
                Workspace:SetAttribute("N3K0P01_TOF_HOOKED", true)
                return true
            end

            -- ===== laser =====
            local laserPart, laserConn
            local laserRay = RaycastParams.new()
            laserRay.FilterType = Enum.RaycastFilterType.Exclude

            local function hideLaser()
                if laserPart then laserPart.Transparency = 1 end
            end

            local function destroyLaser()
                if laserConn then laserConn:Disconnect(); laserConn = nil end
                if laserPart then pcall(function() laserPart:Destroy() end); laserPart = nil end
            end

            -- true kalau ada tembok/part solid di antara origin dan target
            local function laserBlocked(origin, targetPart)
                local ignore = { LocalPlayer.Character, targetPart.Parent }
                local dir = targetPart.Position - origin
                for _ = 1, 6 do
                    laserRay.FilterDescendantsInstances = ignore
                    local res = Workspace:Raycast(origin, dir, laserRay)
                    if not res then return false end
                    local inst = res.Instance
                    if inst.CanCollide == false or inst.Transparency >= 0.95 then
                        ignore[#ignore + 1] = inst   -- part tembus pandang, lewati
                    else
                        return true
                    end
                end
                return true
            end

            local function updateLaser()
                if not (T.Enabled and T.ShowLaser and armed()) then return hideLaser() end
                local char = LocalPlayer.Character
                local origin = char and (char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart"))
                local target = killerPart()   -- sudah dicek radius
                if not (origin and target) then return hideLaser() end
                if laserBlocked(origin.Position, target) then return hideLaser() end

                if not (laserPart and laserPart.Parent) then
                    local p = Instance.new("Part")
                    p.Name = "TOF_Laser"
                    p:SetAttribute("TOF_Own", true)
                    p.Anchored, p.CanCollide, p.CanQuery, p.CanTouch, p.CastShadow = true, false, false, false, false
                    p.Material = Enum.Material.Neon
                    p.Color = Color3.fromRGB(255, 60, 60)
                    p.Parent = Workspace
                    laserPart = p
                end
                local from, to = origin.Position, target.Position
                local dist = (to - from).Magnitude
                if dist < 0.5 then return hideLaser() end
                laserPart.Size = Vector3.new(0.12, 0.12, dist)
                laserPart.CFrame = CFrame.lookAt((from + to) / 2, to)
                laserPart.Transparency = 0.25
            end

            function T.setEnabled(v)
                T.Enabled = v == true
                if T.Enabled then
                    local ok, err = installHook()
                    if not ok then
                        T.Enabled = false
                        pcall(VD_Notify, "Silent Aim TOF", "Gagal: " .. tostring(err), 3)
                        return false
                    end
                    loadBulletNames()
                    if addedConn then addedConn:Disconnect() end
                    addedConn = Workspace.DescendantAdded:Connect(onAdded)
                    if laserConn then laserConn:Disconnect() end
                    laserConn = RunService.RenderStepped:Connect(function() pcall(updateLaser) end)
                else
                    if addedConn then addedConn:Disconnect(); addedConn = nil end
                    table.clear(pending)
                    destroyLaser()
                end
                return true
            end
            function T.setShowLaser(v) T.ShowLaser = v == true; if not T.ShowLaser then hideLaser() end end
            function T.setRadius(v)    T.Radius = math.clamp(tonumber(v) or 200, 20, 500) end
            function T.setSpoofLook(v)     T.SpoofLook = v == true end
            function T.setLead(v)          T.Lead = v == true end
            function T.setSpeed(v)         T.Speed = math.max(tonumber(v) or 150, 1) end
            function T.setGravity(v)       T.Gravity = tonumber(v) or 0 end
            function T.setTracer(v)        T.Tracer = v == true end
            function T.setTracerSpeed(v)   T.TracerSpeed = math.max(tonumber(v) or 180, 1) end
            function T.setTracerColor(c)   if typeof(c) == "Color3" then T.TracerColor = c end end
            function T.setRemoveOriginal(v) T.RemoveOriginal = v == true end
            function T.setHideInstead(v)   T.HideInstead = v == true end
            function T.setDebug(v)         T.Debug = v == true end
        end


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
                    l.Color = Color3.fromRGB(255, 255, 255)
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



        -- ============================================================

        local PU = {
            SpeedEnabled = false, SpeedValue = 16,
            SkipEndScreen = false, ShiftLock = false, NoCutscene = false,
            HideSurvivorIcon = false, ShowPingFPS = false, HideName = false,
            UnlimitedZoom = false, Noclip = false,
            _Connections = {}, _FPS = { frames = 0, last = tick(), value = 0, ping = 0 },
            _pingGui = nil, _shiftLockWasActive = false,
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

        -- ===== Hide Survivor Icon (persistent) =====
        local HIDE_ICON_ID   = "rbxassetid://125701269163711"
        local HIDE_ICON_TEXT = "N3K0P01"

        local HIDE_OVERLAY_NAME = "N3K0P01_HideIconOverlay"

        local function PU_MakeOverlay(vf)
            local ov = Instance.new("ImageLabel")
            ov.Name = HIDE_OVERLAY_NAME
            ov.BackgroundTransparency = 1
            ov.BorderSizePixel = 0
            ov.AnchorPoint = Vector2.new(0, 0)
            ov.Position = UDim2.fromScale(0, 0)
            ov.Size = UDim2.fromScale(1, 1)
            ov.Image = HIDE_ICON_ID
            ov.ImageTransparency = 0
            ov.ScaleType = Enum.ScaleType.Crop
            ov.ZIndex = 50
            ov.Active = false
            local c = Instance.new("UICorner")
            c.CornerRadius = UDim.new(0, 8)
            c.Parent = ov
            ov.Parent = vf
            task.spawn(PreloadFloatingPhoto, ov)
            return ov
        end

        PU._slotData      = {}
        PU._slotAddedConn = nil
        PU._slotRenderConn = nil
        PU._matchAccum    = 0
        PU._matchInterval = 0.25   -- interval re-scan ImageLabel pencocok VF (detik)

        local function PU_IsSurvivorSlot(inst)
            return inst:IsA("Frame") and inst.Name:match("^Survivor%d+$") ~= nil
        end

        local function PU_Near(a, b, tol)
            tol = tol or 3
            return math.abs(a.X - b.X) <= tol and math.abs(a.Y - b.Y) <= tol
        end

        -- ImageLabel dianggap "sama" dengan ViewportFrame kalau size & posisinya mendekati
        local function PU_MatchesVF(il, vf)
            if not (il and vf and il.Parent and vf.Parent) then return false end
            if il.AbsoluteSize.X <= 1 or il.AbsoluteSize.Y <= 1 then return false end
            return PU_Near(il.AbsoluteSize, vf.AbsoluteSize)
                and PU_Near(il.AbsolutePosition, vf.AbsolutePosition)
        end

        local function PU_HookViewportFrame(vf)
            if PU._slotData[vf] then return end
            local d = {
                orig  = { ImageTransparency = vf.ImageTransparency },
                conns = {},
                overlay = nil,
            }
            PU._slotData[vf] = d

            local function enforce()
                if not PU.HideSurvivorIcon then return end
                if vf.ImageTransparency ~= 1 then
                    pcall(function() vf.ImageTransparency = 1 end)
                end
                -- pastikan gambar neko selalu ada (dibuat ulang kalau game menghapusnya)
                local ov = d.overlay
                if not ov or ov.Parent ~= vf then
                    if ov then pcall(function() ov:Destroy() end) end
                    d.overlay = PU_MakeOverlay(vf)
                end
            end
            enforce()

            pcall(function()
                table.insert(d.conns, vf:GetPropertyChangedSignal("ImageTransparency"):Connect(enforce))
            end)
            pcall(function()
                table.insert(d.conns, vf.ChildRemoved:Connect(function(child)
                    if child == d.overlay then d.overlay = nil end
                end))
            end)
            d.enforce = enforce
        end

        local function PU_HookIcon(il)
            if PU._slotData[il] then return end
            local d = {
                orig = {
                    Image             = il.Image,
                    ImageRectOffset   = il.ImageRectOffset,
                    ImageRectSize     = il.ImageRectSize,
                    ImageTransparency = il.ImageTransparency,
                    Visible           = il.Visible,
                },
                conns = {},
            }
            PU._slotData[il] = d

            local function enforce()
                if not PU.HideSurvivorIcon then return end
                if il.Image             ~= HIDE_ICON_ID then il.Image = HIDE_ICON_ID end
                if il.ImageRectSize     ~= Vector2.zero then il.ImageRectSize = Vector2.zero end
                if il.ImageRectOffset   ~= Vector2.zero then il.ImageRectOffset = Vector2.zero end
                if il.ImageTransparency ~= 0 then il.ImageTransparency = 0 end
                if il.Visible           ~= true then il.Visible = true end
            end
            enforce()

            for _, prop in ipairs({ "Image", "ImageRectSize", "ImageRectOffset", "ImageTransparency", "Visible" }) do
                pcall(function()
                    table.insert(d.conns, il:GetPropertyChangedSignal(prop):Connect(enforce))
                end)
            end
            d.enforce = enforce
        end

        local function PU_HookText(tl)
            if PU._slotData[tl] then return end
            local d = {
                orig  = { Text = tl.Text, TextTransparency = tl.TextTransparency },
                conns = {},
            }
            PU._slotData[tl] = d

            local function enforce()
                if not PU.HideSurvivorIcon then return end
                if tl.Text ~= HIDE_ICON_TEXT then tl.Text = HIDE_ICON_TEXT end
                if tl.TextTransparency ~= 0 then tl.TextTransparency = 0 end
            end
            enforce()

            table.insert(d.conns, tl:GetPropertyChangedSignal("Text"):Connect(enforce))
            table.insert(d.conns, tl:GetPropertyChangedSignal("TextTransparency"):Connect(enforce))
            d.enforce = enforce
        end

        -- Cari ImageLabel di dalam slot yang match dengan salah satu ViewportFrame
        local function PU_HookMatchingImageLabels(slot)
            local vfs = {}
            for _, d in ipairs(slot:GetDescendants()) do
                if d:IsA("ViewportFrame") then table.insert(vfs, d) end
            end
            if #vfs == 0 then return end

            for _, il in ipairs(slot:GetDescendants()) do
                if il:IsA("ImageLabel") then
                    if il.Name == HIDE_OVERLAY_NAME then continue end   -- << TAMBAH
                    for _, vf in ipairs(vfs) do
                        if PU_MatchesVF(il, vf) then
                            PU_HookIcon(il)
                            break
                        end
                    end
                end
            end
        end

        local function PU_HookSlot(slot)
            if PU._slotData[slot] then return end

            for _, d in ipairs(slot:GetDescendants()) do
                if d:IsA("ViewportFrame") then
                    PU_HookViewportFrame(d)
                elseif d:IsA("TextLabel") then
                    PU_HookText(d)
                end
            end
            PU_HookMatchingImageLabels(slot)

            -- kalau game bikin ulang / menambah child
            local conn = slot.DescendantAdded:Connect(function(d)
                if not PU.HideSurvivorIcon then return end
                task.defer(function()
                    if not d.Parent then return end
                    if d.Name == HIDE_OVERLAY_NAME then return end   -- << TAMBAH
                    if d:IsA("ViewportFrame") then
                        PU_HookViewportFrame(d)
                        PU_HookMatchingImageLabels(slot)
                    elseif d:IsA("ImageLabel") then
                        for _, vf in ipairs(slot:GetDescendants()) do
                            if vf:IsA("ViewportFrame") and PU_MatchesVF(d, vf) then
                                PU_HookIcon(d)
                                break
                            end
                        end
                    elseif d:IsA("TextLabel") then
                        PU_HookText(d)
                    end
                end)
            end)
            PU._slotData[slot] = { conns = { conn } }
        end

        local function PU_ApplyHideSurvivorIcon()
            local pg = LocalPlayer:FindFirstChild("PlayerGui")
            if not pg then return end

            for _, inst in ipairs(pg:GetDescendants()) do
                if PU_IsSurvivorSlot(inst) and not PU._slotData[inst] then
                    PU_HookSlot(inst)
                end
            end

            if not PU._slotAddedConn then
                PU._slotAddedConn = pg.DescendantAdded:Connect(function(inst)
                    if PU.HideSurvivorIcon and PU_IsSurvivorSlot(inst) then
                        task.defer(PU_HookSlot, inst)
                    end
                end)
            end

            if not PU._slotRenderConn then
                PU._slotRenderConn = RunService.RenderStepped:Connect(function(dt)
                    if not PU.HideSurvivorIcon then return end

                    -- 1) enforce semua instance yang sudah ter-hook
                    for inst, d in pairs(PU._slotData) do
                        if d.enforce then
                            if inst.Parent then
                                d.enforce()
                            else
                                PU._slotData[inst] = nil
                            end
                        end
                    end

                    -- 2) re-scan ImageLabel pencocok VF tiap interval
                    PU._matchAccum = PU._matchAccum + dt
                    if PU._matchAccum >= PU._matchInterval then
                        PU._matchAccum = 0
                        for inst in pairs(PU._slotData) do
                            if typeof(inst) == "Instance" and inst.Parent and PU_IsSurvivorSlot(inst) then
                                PU_HookMatchingImageLabels(inst)
                            end
                        end
                    end
                end)
            end
        end

        local function PU_RestoreSurvivorIcon()
            if PU._slotAddedConn then PU._slotAddedConn:Disconnect(); PU._slotAddedConn = nil end
            if PU._slotRenderConn then PU._slotRenderConn:Disconnect(); PU._slotRenderConn = nil end

            for inst, d in pairs(PU._slotData) do
                for _, c in ipairs(d.conns or {}) do pcall(function() c:Disconnect() end) end
                if d.overlay then pcall(function() d.overlay:Destroy() end) end   -- tambahan
                if d.orig and inst.Parent then
                    pcall(function()
                        for prop, val in pairs(d.orig) do inst[prop] = val end
                    end)
                end
            end
            PU._slotData   = {}
            PU._matchAccum = 0
        end

        local function PU_CreatePingFPS()
            local pg = LocalPlayer:FindFirstChild("PlayerGui")
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
            frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            frame.BackgroundTransparency = 0.1
            frame.BorderSizePixel = 0
            frame.Parent = sg
            Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
            local stroke = Instance.new("UIStroke", frame)
            stroke.Color = Color3.fromRGB(255, 255, 255)
            stroke.Thickness = 1
            local lbl = Instance.new("TextLabel")
            lbl.Name = "Label"
            lbl.Size = UDim2.new(1, -12, 1, -8)
            lbl.Position = UDim2.new(0, 6, 0, 4)
            lbl.BackgroundTransparency = 1
            lbl.Font = Enum.Font.GothamBold
            lbl.TextSize = 13
            lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
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

        getgenv().__N3K0P01_ConfigRegistryGeneration =
            (tonumber(getgenv().__N3K0P01_ConfigRegistryGeneration) or 0) + 1
        getgenv().__N3K0P01_ConfigElements = {}
        getgenv().Elements = getgenv().__N3K0P01_ConfigElements
        Elements = getgenv().__N3K0P01_ConfigElements

        if type(getgenv().ConfigData) ~= "table" then getgenv().ConfigData = {} end
        ConfigData = getgenv().ConfigData
        if type(AutoSaveEnabled) ~= "boolean" then AutoSaveEnabled = true end
        ActiveConfigName = ActiveConfigName or nil
        ActiveConfigPath = ActiveConfigPath or nil
        ActiveConfigMode = ActiveConfigMode or nil
        if type(SetActiveConfig) ~= "function" then
            function SetActiveConfig(name, path, enabled, mode)
                ActiveConfigName = name
                ActiveConfigPath = path
                AutoSaveEnabled = enabled
                ActiveConfigMode = mode
            end
        end
        do
            local function PackConfigValue(value, depth)
                depth = depth or 0
                if depth > 8 then return nil end

                local valueType = typeof(value)
                if valueType == "nil" or valueType == "boolean" or valueType == "number" or valueType == "string" then
                    return value
                elseif valueType == "Color3" then
                    return {
                        __n3k_type = "Color3",
                        r = value.R,
                        g = value.G,
                        b = value.B,
                    }
                elseif valueType == "EnumItem" then
                    return {
                        __n3k_type = "EnumItem",
                        enumType = tostring(value.EnumType):gsub("^Enum%.", ""),
                        name = value.Name,
                    }
                elseif valueType == "table" then
                    local out = {}
                    for k, v in pairs(value) do
                        local packed = PackConfigValue(v, depth + 1)
                        if packed ~= nil then
                            out[tostring(k)] = packed
                        end
                    end
                    return out
                end
                return nil
            end

            local function UnpackConfigValue(value, depth)
                depth = depth or 0
                if depth > 8 then return nil end
                if type(value) ~= "table" then return value end

                if value.__n3k_type == "Color3" then
                    local r, g, b = tonumber(value.r), tonumber(value.g), tonumber(value.b)
                    if r and g and b then return Color3.new(r, g, b) end
                    return nil
                elseif value.__n3k_type == "EnumItem" then
                    local enumType = tostring(value.enumType or "")
                    local enumName = tostring(value.name or "")
                    local enumObj = Enum[enumType]
                    if enumObj and enumObj[enumName] then return enumObj[enumName] end
                    return nil
                end

                local out = {}
                for k, v in pairs(value) do
                    out[k] = UnpackConfigValue(v, depth + 1)
                end
                return out
            end

            ConfigData = ConfigData or {}
            Elements = Elements or {}
            function GetConfigSnapshot()
                local snap = {}
                local meta = {}
                local ignored = {
                    ["Config Name"] = true,
                    ["Saved Configs"] = true,
                    ["Auto Save"] = true,
                    ["Auto Load"] = true,
                    ["Import JSON"] = true,
                }
                local registry = getgenv().__N3K0P01_ConfigElements or Elements or {}
                for key, control in pairs(registry) do
                    if control and type(control.Get) == "function" then
                        local short = tostring(key):match("::([^:]+)$") or tostring(key)
                        if not ignored[short] then
                            local ok, value = pcall(control.Get)
                            if ok then
                                local packed = PackConfigValue(value)
                                if packed ~= nil then
                                    snap[key] = packed
                                    meta[#meta + 1] = {
                                        Key = tostring(key),
                                        StableId = tostring(control.StableId or ""),
                                        ConfigId = tostring(control.ConfigId or short),
                                        Title = tostring(control.Title or short),
                                        Section = tostring(control.Section or ""),
                                        Page = tostring(control.Page or ""),
                                        Value = packed,
                                    }
                                end
                            end
                        end
                    end
                end
                snap.__n3k_controls = meta
                return snap
            end

            ConfigData = ConfigData or {}
            ConfigData.__UnpackConfigValue = UnpackConfigValue
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
                local pg = LocalPlayer:FindFirstChild("PlayerGui")
                if gethui then
                    local ok, hui = pcall(gethui)
                    if ok and hui then pg = hui end
                end
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
                frame.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
                frame.BackgroundTransparency = 0.15
                frame.BorderSizePixel = 0
                frame.Active = true
                frame.Parent = gui
                Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)
                local stroke = Instance.new("UIStroke", frame)
                stroke.Color = Color3.fromRGB(255, 255, 255)
                stroke.Thickness = 1.5
                stroke.Transparency = 0.2
                stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                local title = Instance.new("TextLabel")
                title.Size = UDim2.new(1, 0, 0, 15)
                title.Position = UDim2.new(0, 0, 0, 5)
                title.BackgroundTransparency = 1
                title.Text = "NEXT MAP PREDICTION"
                title.TextColor3 = Color3.fromRGB(150, 180, 255)
                title.Font = Enum.Font.GothamBold
                title.TextSize = 10
                title.Parent = frame

                local mapName = Instance.new("TextLabel")
                mapName.Name = "MapName"
                mapName.Size = UDim2.new(1, -12, 0, 18)
                mapName.Position = UDim2.new(0, 6, 0, 21)
                mapName.BackgroundTransparency = 1
                mapName.Text = "Scanning..."
                mapName.TextColor3 = Color3.fromRGB(255, 255, 255)
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
                status.TextColor3 = Color3.fromRGB(150, 150, 150)
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
                                statusLabel.TextColor3 = Color3.fromRGB(255, 200, 50)
                            elseif mapExists then
                                lastDetected = detected or "Unknown"
                                nameLabel.Text = detected or "Unknown"
                                statusLabel.Text = "Status: In-Game"
                                statusLabel.TextColor3 = Color3.fromRGB(120, 255, 120)
                            else
                                nameLabel.Text = "Waiting..."
                                statusLabel.Text = "Status: Lobby"
                                statusLabel.TextColor3 = Color3.fromRGB(150, 150, 160)
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


        -- Integrated Fake Perks backend (no secondary UI window).
        do
            local Players = game:GetService("Players")
            local localPlayer = Players.LocalPlayer
_G.Ox = _G.Ox or {}
_G.Ox.FakePerks = {
    QuickRecoveryEnabled = false,
    PerfectLandingEnabled = false,
    FlowstateEnabled = false,
    FakeAdrenalineRush = false,
    PerkCooldown = 10,
    boostActive = false,
    perfectLandingBoostActive = false,
    fsOnCooldown = false,
    lastQRTime = 0,
    lastPLTime = 0,
    lastFSTime = 0,
    qrConnection = nil,
    plConnection = nil,
    fsConnection = nil,
    fsAnimConnection = nil,
    adrenalineOn = false,
    adrenalineConns = {},
    lastARTime = 0,
}

local FakePerks = _G.Ox.FakePerks

local function isSurvivor()
    local team = localPlayer.Team
    return team ~= nil and team.Name == "Survivors"
end

local function isPlayingVaultAnimation(character)
    if not character then return false end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return false end
    local animator = humanoid:FindFirstChildOfClass("Animator")
    if not animator then return false end

    for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
        if track.Animation and string.find(tostring(track.Animation.AnimationId), "126081405469607", 1, true) then
            return true
        end
    end
    return false
end

local function startQuickRecoveryBoost(character)
    if not FakePerks.QuickRecoveryEnabled or not isSurvivor() then return end
    if FakePerks.boostActive then return end
    if tick() - FakePerks.lastQRTime < FakePerks.PerkCooldown then return end

    FakePerks.boostActive = true
    FakePerks.lastQRTime = tick()
    local startedAt = tick()

    task.spawn(function()
        while FakePerks.QuickRecoveryEnabled and tick() - startedAt < 3 do
            if character and character.Parent then
                character:SetAttribute("speedboost", 1.4)
            end
            task.wait()
        end
        if character and character.Parent then
            character:SetAttribute("speedboost", 1)
        end
        FakePerks.boostActive = false
    end)
end

local function attachQuickRecovery(character)
    if FakePerks.qrConnection then
        FakePerks.qrConnection:Disconnect()
        FakePerks.qrConnection = nil
    end
    if not character then return end

    FakePerks.qrConnection = character:GetAttributeChangedSignal("isvaulting"):Connect(function()
        if character:GetAttribute("isvaulting") == true then
            task.spawn(function()
                task.wait(0.05)
                local playingVault = isPlayingVaultAnimation(character)
                if not playingVault then
                    task.wait(0.05)
                    playingVault = isPlayingVaultAnimation(character)
                end
                if not playingVault and character:GetAttribute("isvaulting") == true then
                    startQuickRecoveryBoost(character)
                end
            end)
        end
    end)
end

local function toggleQuickRecovery(enabled)
    FakePerks.QuickRecoveryEnabled = enabled
    if enabled and localPlayer.Character then
        attachQuickRecovery(localPlayer.Character)
    elseif not enabled and FakePerks.qrConnection then
        FakePerks.qrConnection:Disconnect()
        FakePerks.qrConnection = nil
    end
    VD_Notify("Fake Quick Recovery", enabled and "AKTIF" or "NONAKTIF", 2)
end

local function startPerfectLandingBoost(character)
    if not FakePerks.PerfectLandingEnabled or not isSurvivor() then return end
    if FakePerks.perfectLandingBoostActive then return end
    if tick() - FakePerks.lastPLTime < FakePerks.PerkCooldown then return end

    FakePerks.perfectLandingBoostActive = true
    FakePerks.lastPLTime = tick()
    local startedAt = tick()
    task.spawn(function()
        while FakePerks.perfectLandingBoostActive and tick() - startedAt < 3 do
            if character and character.Parent then
                character:SetAttribute("speedboost", 1.4)
            end
            task.wait()
        end
        if character and character.Parent then
            character:SetAttribute("speedboost", 1)
        end
        FakePerks.perfectLandingBoostActive = false
    end)
end

local function attachPerfectLanding(character)
    if FakePerks.plConnection then
        FakePerks.plConnection:Disconnect()
        FakePerks.plConnection = nil
    end
    if not character then return end

    FakePerks.plConnection = character:GetAttributeChangedSignal("speedboost"):Connect(function()
        if not isSurvivor() then return end
        if character:GetAttribute("speedboost") == 0.625 then
            startPerfectLandingBoost(character)
        end
    end)
end

local function togglePerfectLanding(enabled)
    FakePerks.PerfectLandingEnabled = enabled
    if enabled then
        if localPlayer.Character then attachPerfectLanding(localPlayer.Character) end
    else
        if FakePerks.plConnection then
            FakePerks.plConnection:Disconnect()
            FakePerks.plConnection = nil
        end
        if FakePerks.perfectLandingBoostActive and localPlayer.Character then
            localPlayer.Character:SetAttribute("speedboost", 1)
            FakePerks.perfectLandingBoostActive = false
        end
    end
    VD_Notify("Fake Perfect Landing", enabled and "AKTIF" or "NONAKTIF", 2)
end

local function attachFlowstate(character)
    if FakePerks.fsConnection then
        FakePerks.fsConnection:Disconnect()
        FakePerks.fsConnection = nil
    end
    if FakePerks.fsAnimConnection then
        FakePerks.fsAnimConnection:Disconnect()
        FakePerks.fsAnimConnection = nil
    end
    if not character then return end

    local humanoid = character:WaitForChild("Humanoid", 3)
    if not humanoid then return end
    local animator = humanoid:WaitForChild("Animator", 3)
    if not animator then return end

    FakePerks.fsAnimConnection = animator.AnimationPlayed:Connect(function(track)
        if not track.Animation or track.Animation.AnimationId ~= "rbxassetid://136962284480779" then return end
        local stoppedConnection
        stoppedConnection = track.Stopped:Connect(function()
            if stoppedConnection then stoppedConnection:Disconnect() end
            FakePerks.lastFSTime = tick()
            FakePerks.fsOnCooldown = true
            if character and character.Parent then
                character:SetAttribute("Flowstate", false)
            end
            task.delay(FakePerks.PerkCooldown, function()
                FakePerks.fsOnCooldown = false
                if FakePerks.FlowstateEnabled and character and character.Parent then
                    character:SetAttribute("Flowstate", true)
                end
            end)
        end)
    end)

    FakePerks.fsConnection = character:GetAttributeChangedSignal("Flowstate"):Connect(function()
        if not FakePerks.FlowstateEnabled or not isSurvivor() then return end
        local value = character:GetAttribute("Flowstate")
        if value == true then
            if FakePerks.fsOnCooldown or tick() - FakePerks.lastFSTime < FakePerks.PerkCooldown then
                character:SetAttribute("Flowstate", false)
            end
        elseif value == false and not FakePerks.fsOnCooldown then
            if FakePerks.PerkCooldown <= tick() - FakePerks.lastFSTime then
                character:SetAttribute("Flowstate", true)
            end
        end
    end)

    task.wait(0.5)
    if FakePerks.FlowstateEnabled and character and character.Parent then
        character:SetAttribute("Flowstate", true)
    end
end

local function toggleFlowstate(enabled)
    FakePerks.FlowstateEnabled = enabled
    if enabled then
        if localPlayer.Character then attachFlowstate(localPlayer.Character) end
    else
        if FakePerks.fsConnection then
            FakePerks.fsConnection:Disconnect()
            FakePerks.fsConnection = nil
        end
        if FakePerks.fsAnimConnection then
            FakePerks.fsAnimConnection:Disconnect()
            FakePerks.fsAnimConnection = nil
        end
        if localPlayer.Character then
            localPlayer.Character:SetAttribute("Flowstate", false)
        end
    end
    VD_Notify("Fake Flowstate", enabled and "AKTIF" or "NONAKTIF", 2)
end

local function clearAdrenalineConnections()
    for _, connection in ipairs(FakePerks.adrenalineConns or {}) do
        pcall(function() connection:Disconnect() end)
    end
    FakePerks.adrenalineConns = {}
end

local function startAdrenalineRush(character)
    if not FakePerks.FakeAdrenalineRush or not isSurvivor() then return end
    if not character or not character.Parent or FakePerks.boostActive then return end
    if tick() - (FakePerks.lastARTime or 0) < FakePerks.PerkCooldown then return end

    FakePerks.boostActive = true
    FakePerks.lastARTime = tick()
    local startedAt = tick()
    task.spawn(function()
        while FakePerks.FakeAdrenalineRush and tick() - startedAt < 5 do
            if character and character.Parent then
                character:SetAttribute("speedboost", 1.4)
            end
            task.wait()
        end
        if character and character.Parent then
            character:SetAttribute("speedboost", 1)
        end
        FakePerks.boostActive = false
    end)
end

local function attachAdrenalineRush(character)
    if not character then return end
    local humanoid = character:FindFirstChildOfClass("Humanoid") or character:WaitForChild("Humanoid", 5)
    if not humanoid then return end
    local previousHealth = humanoid.Health

    table.insert(FakePerks.adrenalineConns, humanoid.HealthChanged:Connect(function(newHealth)
        if not FakePerks.FakeAdrenalineRush then return end
        if newHealth < previousHealth and newHealth <= 50 and newHealth > 0 then
            startAdrenalineRush(character)
        end
        previousHealth = newHealth
    end))
end

local function toggleAdrenalineRush(enabled)
    FakePerks.FakeAdrenalineRush = enabled == true
    FakePerks.adrenalineOn = enabled == true
    clearAdrenalineConnections()

    if not enabled then
        VD_Notify("Fake Perks", "Adrenaline Rush OFF", 2)
        return
    end

    attachAdrenalineRush(localPlayer.Character)
    VD_Notify("Fake Perks", "Adrenaline Rush ON", 3)
end

-- Restore listeners after respawn while each related toggle remains enabled.
local respawnConnection = localPlayer.CharacterAdded:Connect(function(character)
    task.wait(0.5)
    if FakePerks.QuickRecoveryEnabled then attachQuickRecovery(character) end
    if FakePerks.PerfectLandingEnabled then attachPerfectLanding(character) end
    if FakePerks.FlowstateEnabled then attachFlowstate(character) end
    if FakePerks.FakeAdrenalineRush then attachAdrenalineRush(character) end
end)


            _G.N3K0P01_FakePerks = {
                SetQuickRecovery = toggleQuickRecovery,
                SetPerfectLanding = togglePerfectLanding,
                SetFlowstate = toggleFlowstate,
                SetAdrenalineRush = toggleAdrenalineRush,
                SetCooldown = function(value) FakePerks.PerkCooldown = math.max(0, tonumber(value) or 10) end,
            }
        end

        -- Integrated Fast Bandage backend (main hub UI owns the toggle).
        do
            local Players = game:GetService("Players")
            local RunService = game:GetService("RunService")
            local UserInputService = game:GetService("UserInputService")
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local GuiService = game:GetService("GuiService")
            local CollectionService = game:GetService("CollectionService")
            local LocalPlayer = Players.LocalPlayer
            local W = getgenv()
            local VD = W.VD or {}
            W.VD = VD
            VD.FB_Enabled = VD.FB_Enabled == true
            local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
            local VirtualInputManager = nil
            pcall(function() VirtualInputManager = game:GetService("VirtualInputManager") end)
            local G = {}
            local VD_Notify = function(title, content, duration)
                pcall(function() ShowNotify(title, content, duration) end)
            end
    local FB_Config = {
        AutoStopAtMaxHp = true,
        FastPreClickBugEnabled = true,
        PreClicksCount = 50,
        PreClickDelay = 0.0001,
        AnimationId = "rbxassetid://138299892867437",
        MinHp = 50,
        MaxHp = 80,
        AutoHealThreshold = 50,
        AutoHealDelay = 10,
    }

    local FB_ANIM_DIGITS = FB_Config.AnimationId:match("%d+") or ""

    local FB_State = {
        healing = false,
        healAnim = nil,
        activeTool = nil,
        heartbeatConn = nil,
        touchId = nil,
        touchHeld = false,
        touchThread = nil,
        gameAnimTrack = nil,
        watcherConn = nil,
        autoHealPending = false,
        autoHealStartTime = 0,
        lastNotifiedSecond = 0,
        monitorConn = nil,
    }

    G.FastBandage_Config = FB_Config
    G.FastBandage_State  = FB_State

    local function FB_getRemote()
        local remotes = ReplicatedStorage:FindFirstChild("Remotes")
        local items = remotes and remotes:FindFirstChild("Items")
        local bandage = items and items:FindFirstChild("Bandage")
        return bandage and bandage:FindFirstChild("Fire")
    end

    local function FB_getTool()
        local character = LocalPlayer.Character
        local bandage = character and character:FindFirstChild("Bandage")
        if not bandage then return nil end
        local hand = bandage:FindFirstChild("Right Arm") or bandage:FindFirstChild("RightHand")
        return hand and hand:FindFirstChild("Bandage")
    end

    local function FB_getMobileActionButton()
        local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
        local survivorMob = playerGui and playerGui:FindFirstChild("Survivor-mob")
        local controls = survivorMob and survivorMob:FindFirstChild("Controls")
        if not controls then return nil end
        return controls:FindFirstChild("action") or controls:FindFirstChild("Gui-mob")
    end

    local function FB_isBandagePromptVisible()
        local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
        if not playerGui then return false end
        local pcprompts = playerGui:FindFirstChild("pcprompts")
        local frame = pcprompts and pcprompts:FindFirstChild("Frame")
        local prompt = frame and frame:FindFirstChild("BandagePromptGui")
        if prompt and prompt.Visible then return true end
        local button = FB_getMobileActionButton()
        if button then
            for _, child in ipairs(button:GetChildren()) do
                if child:IsA("ImageLabel") or child:IsA("ImageButton") then
                    local name = string.lower(child.Name)
                    if (name:find("bandage") or name:find("heal")) and child.Visible then
                        return true
                    end
                end
            end
        end
        return false
    end

    local function FB_isBlocked(character)
        return CollectionService:HasTag(character, "Silenced") or CollectionService:HasTag(character, "Antiheal")
    end

    local function FB_touchCenter(button)
        local pos, size, inset = button.AbsolutePosition, button.AbsoluteSize, GuiService:GetGuiInset()
        return pos.X + size.X / 2 + inset.X, pos.Y + size.Y / 2 + inset.Y
    end

    local function FB_GetGameBandageTrack()
        local char = LocalPlayer.Character
        if not char then return nil end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum then return nil end
        local animator = hum:FindFirstChildOfClass("Animator")
        if not animator then return nil end
        for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
            local anim = track.Animation
            local id = (anim and anim.AnimationId) or ""
            if id ~= "" and id:find(FB_ANIM_DIGITS, 1, true) and track ~= FB_State.healAnim then
                return track
            end
        end
        return nil
    end

    local FB_stop
    local FB_start
    local FB_toggle

    local function FB_pressAction()
        if not isMobile then
            pcall(function()
                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
            end)
            return
        end
        if FB_State.touchHeld or not FB_isBandagePromptVisible() then return end
        local button = FB_getMobileActionButton()
        if not button then return end
        pcall(function()
            FB_State.touchId = math.random(1000, 9999)
            VirtualInputManager:SendTouchEvent(FB_State.touchId, 0, FB_touchCenter(button))
            FB_State.touchHeld = true
            if FB_State.touchThread then task.cancel(FB_State.touchThread) end
            FB_State.touchThread = task.spawn(function()
                while FB_State.touchHeld and FB_State.healing do
                    task.wait(0.05)
                    if FB_State.touchHeld and FB_State.healing then
                        VirtualInputManager:SendTouchEvent(FB_State.touchId, 0, FB_touchCenter(button))
                    end
                end
            end)
        end)
    end

    local function FB_releaseAction()
        if not isMobile then
            pcall(function()
                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
            end)
            return
        end
        if not FB_State.touchHeld then return end
        FB_State.touchHeld = false
        if FB_State.touchThread then
            task.cancel(FB_State.touchThread)
            FB_State.touchThread = nil
        end
        pcall(function()
            if FB_State.touchId then
                VirtualInputManager:SendTouchEvent(FB_State.touchId, 2, 0, 0)
                FB_State.touchId = nil
            end
        end)
    end

    local function FB_canHeal()
        local character = LocalPlayer.Character
        if not character then return false, "Tidak ada karakter" end
        local humanoid = character:FindFirstChild("Humanoid")
        if not humanoid or humanoid.Health <= 0 then return false, "Karakter mati" end
        local tool = FB_getTool()
        if not tool then return false, "Tidak ada Bandage" end
        local charge = tool:GetAttribute("charge") or 0
        if type(charge) == "number" and charge <= 0 then return false, "Charge habis" end
        if humanoid.Health >= FB_Config.MaxHp then return false, "HP sudah full" end
        if FB_isBlocked(character) then return false, "Kena Silenced/Antiheal" end
        if not FB_getRemote() then return false, "Remote tidak ditemukan" end
        return true, nil
    end

    local function FB_setHealState(character, on)
        character:SetAttribute("Aiming", on)
        character:SetAttribute("overridelookscript", on)
        character:SetAttribute("IsBeingHealed", on)
        local interactable = character:FindFirstChild("CheckInterractable")
        if interactable then interactable:SetAttribute("isHealing", on) end
        local root = character:FindFirstChild("HumanoidRootPart")
        if root then
            if on then root:AddTag("doing action")
            else root:RemoveTag("doing action") end
        end
    end

    FB_stop = function()
        if not FB_State.healing then return end
        FB_State.healing = false
        if FB_State.heartbeatConn then
            FB_State.heartbeatConn:Disconnect()
            FB_State.heartbeatConn = nil
        end
        FB_releaseAction()
        local character = LocalPlayer.Character
        local tool = FB_State.activeTool or FB_getTool()
        local remote = FB_getRemote()
        if remote and tool then
            pcall(function() remote:FireServer(false, tool) end)
        end
        if character then FB_setHealState(character, false) end
        if FB_State.healAnim then
            pcall(function()
                FB_State.healAnim:Stop()
                FB_State.healAnim:Destroy()
            end)
            FB_State.healAnim = nil
        end
        FB_State.activeTool = nil
        FB_State.gameAnimTrack = nil
        print("[Fast Bandage] OFF")
    end

    FB_start = function()
        if FB_State.healing then return false, "Sudah healing" end
        local ok, reason = FB_canHeal()
        if not ok then
            print("[Fast Bandage] Skip: " .. tostring(reason))
            return false, reason
        end
        local character = LocalPlayer.Character
        local tool = FB_getTool()
        local humanoid = character and character:FindFirstChild("Humanoid")
        if not (character and tool and humanoid and FB_getRemote()) then
            return false, "Komponen tidak lengkap"
        end
        FB_State.healing = true
        FB_State.activeTool = tool
        FB_setHealState(character, true)
        pcall(function()
            if not FB_State.healAnim then
                local animation = Instance.new("Animation")
                animation.AnimationId = FB_Config.AnimationId
                FB_State.healAnim = humanoid:LoadAnimation(animation)
            end
            FB_State.healAnim:Play(0.1)
        end)
        FB_pressAction()
        task.defer(function()
            if FB_Config.FastPreClickBugEnabled and FB_Config.PreClicksCount > 0 then
                for _ = 1, FB_Config.PreClicksCount do
                    if not FB_State.healing then return end
                    local t = FB_State.activeTool or FB_getTool()
                    local remote = FB_getRemote()
                    if not remote or not t then break end
                    pcall(function()
                        remote:FireServer(true, t)
                        remote:FireServer(false, t)
                    end)
                end
            end
            if FB_State.healing then
                local t = FB_State.activeTool or FB_getTool()
                local remote = FB_getRemote()
                if remote and t then
                    pcall(function() remote:FireServer(true, t) end)
                end
            end
        end)
        if FB_State.heartbeatConn then FB_State.heartbeatConn:Disconnect() end
        FB_State.heartbeatConn = RunService.Heartbeat:Connect(function()
            if not FB_State.healing then return end
            local char = LocalPlayer.Character
            local hum = char and char:FindFirstChild("Humanoid")
            if not hum or hum.Health <= 0 then FB_stop(); return end
            local t = FB_State.activeTool or FB_getTool()
            local charge = t and (t:GetAttribute("charge") or 0) or 0
            if type(charge) == "number" and charge <= 0 then
                FB_stop(); print("[Fast Bandage] Charge habis!"); return
            end
            if FB_Config.AutoStopAtMaxHp and hum.Health >= FB_Config.MaxHp then
                FB_stop(); print("[Fast Bandage] HP Full! Berhenti"); return
            end
            if FB_isBlocked(char) then
                FB_stop(); print("[Fast Bandage] Kena Silenced/Antiheal"); return
            end
            if isMobile and not FB_State.touchHeld then FB_pressAction() end
        end)
        print("[Fast Bandage] ON (Super Cepat)")
        return true, nil
    end

    FB_toggle = function()
        if FB_State.healing then
            FB_stop()
            return false
        end
        return FB_start() == true
    end

    local function FB_AutoHealMonitorStep()
        if not VD.FB_Enabled then
            if FB_State.autoHealPending then
                FB_State.autoHealPending = false
                FB_State.lastNotifiedSecond = 0
            end
            return
        end

        if FB_State.healing then
            if FB_State.autoHealPending then
                FB_State.autoHealPending = false
                FB_State.lastNotifiedSecond = 0
            end
            return
        end

        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChild("Humanoid")
        if not hum or hum.Health <= 0 then
            FB_State.autoHealPending = false
            FB_State.lastNotifiedSecond = 0
            return
        end

        local hp = hum.Health
        local canHeal = FB_canHeal()
        local needHeal = (hp < FB_Config.AutoHealThreshold) and canHeal

        if not needHeal then
            if FB_State.autoHealPending then
                FB_State.autoHealPending = false
                FB_State.lastNotifiedSecond = 0
            end
            return
        end

        if not FB_State.autoHealPending then
            FB_State.autoHealPending = true
            FB_State.autoHealStartTime = tick()
            FB_State.lastNotifiedSecond = FB_Config.AutoHealDelay
            VD_Notify(
                "Fast Bandage",
                "HP rendah! Auto Heal dalam " .. FB_Config.AutoHealDelay .. " detik...",
                3
            )
            return
        end

        local elapsed = tick() - FB_State.autoHealStartTime
        local remaining = math.ceil(FB_Config.AutoHealDelay - elapsed)

        if remaining > 0 and remaining ~= FB_State.lastNotifiedSecond then
            FB_State.lastNotifiedSecond = remaining
            if remaining <= 5 then
                VD_Notify("Fast Bandage", "Auto Heal dalam " .. remaining .. "s...", 1)
            end
        end

        if elapsed >= FB_Config.AutoHealDelay then
            FB_State.autoHealPending = false
            FB_State.lastNotifiedSecond = 0
            VD_Notify("Fast Bandage", "Auto Heal dimulai!", 2)
            FB_start()
        end
    end

    local function FB_StartAutoHealMonitor()
        if FB_State.monitorConn then return end
        FB_State.monitorConn = RunService.Heartbeat:Connect(function()
            pcall(FB_AutoHealMonitorStep)
        end)
    end

    local function FB_StartWatcher()
        if FB_State.watcherConn then return end
        FB_State.watcherConn = RunService.Heartbeat:Connect(function()
            if not VD.FB_Enabled then
                if FB_State.healing then FB_stop() end
                return
            end
            local gameTrack = FB_GetGameBandageTrack()
            if gameTrack and not FB_State.healing then
                FB_State.gameAnimTrack = gameTrack
                FB_start()
            elseif FB_State.healing then
                if not gameTrack then
                    if not FB_State._graceStop then
                        FB_State._graceStop = true
                        task.delay(0.2, function()
                            FB_State._graceStop = false
                            if FB_State.healing and not FB_GetGameBandageTrack() then
                                FB_stop()
                            end
                        end)
                    end
                end
            end
        end)
    end

    LocalPlayer.CharacterAdded:Connect(function()
        if FB_State.healing then FB_stop() end
        FB_State.gameAnimTrack = nil
        FB_State.autoHealPending = false
        FB_State.lastNotifiedSecond = 0
    end)

    task.spawn(function()
        task.wait(0.5)
        FB_StartWatcher()
        FB_StartAutoHealMonitor()
    end)

    function G.FB_Start() return FB_start() end
    function G.FB_Stop() FB_stop() end
    function G.FB_Toggle() return FB_toggle() end
    function G.FB_IsHealing() return FB_State.healing end
    function G.FB_CanHeal() return FB_canHeal() end

    function G.FB_SetEnabled(v)
        v = v and true or false
        VD.FB_Enabled = v
        if v then
            print("[Fast Bandage] Armed — Auto Heal dalam " .. FB_Config.AutoHealDelay .. "s saat HP rendah")
            return true
        else
            FB_stop()
            FB_State.autoHealPending = false
            FB_State.lastNotifiedSecond = 0
            print("[Fast Bandage] Disarmed")
            return true
        end
    end


            _G.N3K0P01_FastBandage = G
        end

        -- Integrated Survival features based on the uploaded source files.
        do
            -- Moonwalk: PC-held keys and touch buttons share the same orientation controller.
            local MW = {Enabled=false, Mode="Classic", SwayWidth=0.55, SwaySpeed=6, ForwardKey=Enum.KeyCode.W, BackwardKey=Enum.KeyCode.S,
                ForwardHeld=false, BackwardHeld=false, InputDirection=0, Gui=nil, AlignRoot=nil, Rotation=0, SwaySign=1, LastFlip=0}
            W.N3K0P01_Moonwalk = MW
            local function MW_RemoveAlign(root)
                if not root then return end
                local a = root:FindFirstChild("N3K0P01_MoonwalkAlign")
                local att = root:FindFirstChild("N3K0P01_MoonwalkAttachment")
                if a then pcall(function() a:Destroy() end) end
                if att then pcall(function() att:Destroy() end) end
                if MW.AlignRoot == root then MW.AlignRoot = nil end
            end
            local function MW_CreateAlign(root)
                local a = root:FindFirstChild("N3K0P01_MoonwalkAlign")
                if a and a:IsA("AlignOrientation") then MW.AlignRoot = root; return a end
                local att = Instance.new("Attachment"); att.Name = "N3K0P01_MoonwalkAttachment"; att.Parent = root
                a = Instance.new("AlignOrientation"); a.Name = "N3K0P01_MoonwalkAlign"
                a.Mode = Enum.OrientationAlignmentMode.OneAttachment; a.Attachment0 = att
                a.MaxTorque = 6000000; a.Responsiveness = 65; a.Parent = root
                MW.AlignRoot = root; return a
            end
            local function MW_BuildGui()
                local pg = LocalPlayer:FindFirstChildOfClass("PlayerGui")
                if not pg then return end
                if MW.Gui and MW.Gui.Parent then return end
                local old = pg:FindFirstChild("N3K0P01_MoonwalkControls")
                if old then pcall(function() old:Destroy() end) end
                local gui = Instance.new("ScreenGui"); gui.Name = "N3K0P01_MoonwalkControls"
                gui.ResetOnSpawn = false; gui.IgnoreGuiInset = true; gui.DisplayOrder = 999990; gui.Enabled = MW.Enabled; gui.Parent = pg
                local holder = Instance.new("Frame"); holder.Name = "Buttons"; holder.AnchorPoint = Vector2.new(1,1)
                holder.Position = UDim2.new(1,-18,1,-160); holder.Size = UDim2.fromOffset(104,43); holder.BackgroundTransparency = 1; holder.Parent = gui
                local function button(name, title, x, dir)
                    local b = Instance.new("TextButton"); b.Name = name; b.Position = UDim2.fromOffset(x,0); b.Size = UDim2.fromOffset(49,42)
                    b.BackgroundColor3 = Color3.fromRGB(30,45,65); b.BackgroundTransparency = 0.15; b.BorderSizePixel = 0
                    b.Text = title; b.Font = Enum.Font.GothamBold; b.TextSize = 10; b.TextColor3 = Color3.new(1,1,1); b.AutoButtonColor = false; b.Parent = holder
                    Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)
                    b.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then MW.InputDirection = dir; b.BackgroundColor3 = Color3.fromRGB(50,130,180) end end)
                    b.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then if MW.InputDirection == dir then MW.InputDirection = 0 end; b.BackgroundColor3 = Color3.fromRGB(30,45,65) end end)
                end
                button("Forward", "FORWARD", 0, 1); button("Backward", "BACK", 55, -1); MW.Gui = gui
            end
            function MW.SetEnabled(value)
                MW.Enabled = value == true
                if MW.Enabled then MW_BuildGui(); if MW.Gui then MW.Gui.Enabled = true end
                else
                    MW.ForwardHeld=false; MW.BackwardHeld=false; MW.InputDirection=0
                    if MW.Gui then MW.Gui.Enabled=false end
                    local char=LocalPlayer.Character; local hum=char and char:FindFirstChildOfClass("Humanoid"); local root=char and char:FindFirstChild("HumanoidRootPart")
                    if hum then hum.AutoRotate=true end; MW_RemoveAlign(root); MW.Rotation=0
                end
            end
            UserInputService.InputBegan:Connect(function(input, processed)
                if not MW.Enabled or processed then return end
                if input.KeyCode == MW.ForwardKey then MW.ForwardHeld=true end
                if input.KeyCode == MW.BackwardKey then MW.BackwardHeld=true end
            end)
            UserInputService.InputEnded:Connect(function(input)
                if input.KeyCode == MW.ForwardKey then MW.ForwardHeld=false end
                if input.KeyCode == MW.BackwardKey then MW.BackwardHeld=false end
            end)
            RunService.Heartbeat:Connect(function(dt)
                if not MW.Enabled then return end
                local char=LocalPlayer.Character; local hum=char and char:FindFirstChildOfClass("Humanoid"); local root=char and char:FindFirstChild("HumanoidRootPart"); local camera=Workspace.CurrentCamera
                if not hum or not root or not camera then return end
                local direction=MW.InputDirection
                if direction == 0 then if MW.ForwardHeld then direction=1 elseif MW.BackwardHeld then direction=-1 end end
                if direction == 0 then hum.AutoRotate=true; MW_RemoveAlign(root); MW.Rotation=0; return end
                hum.AutoRotate=false; local align=MW_CreateAlign(root)
                local look=camera.CFrame.LookVector; local flat=Vector3.new(look.X,0,look.Z)
                if flat.Magnitude < 0.001 then return end
                flat=flat.Unit*direction; local yaw=math.atan2(flat.X,flat.Z); local sway=0
                if MW.Mode == "Sway" and hum.MoveDirection.Magnitude > 0.01 then
                    local interval=1.2/math.max(1,MW.SwaySpeed)
                    if os.clock()-MW.LastFlip >= interval then MW.LastFlip=os.clock(); MW.SwaySign=-MW.SwaySign end
                    local target=MW.SwaySign*MW.SwayWidth; MW.Rotation=MW.Rotation+(target-MW.Rotation)*math.clamp((dt or 0.016)*14,0,1); sway=MW.Rotation
                else MW.Rotation=0 end
                align.CFrame=CFrame.Angles(0,yaw+sway,0)
            end)

        end


        -- ===== BYPASS GENERATOR (integrated from standalone v7) =====
        do
            if W.N3K0P01_GenBypass and W.N3K0P01_GenBypass.destroy then
                pcall(W.N3K0P01_GenBypass.destroy)
            end

            local rng = Random.new()
            local GB = {
                Enabled = false,
                Debug = false,
                Cache = {},
                CacheTimer = 0,
                Processed = {},
                TriggerRange = 8,
                SnapDist = 1.5,
                MoveCancelDist = 2.5,
                Teleport = true,
                DelayScale = 0.5,
                CancelWait = {0.12, 0.2},
                TeleSettle = {0.08, 0.15},
                StepDelay = {0.2, 0.35},
                ReturnWait = {0.15, 0.25},
                MaxRejects = 2,
                Busy = false,
                Running = true,
            }

            local function log(...) if GB.Debug then print("[GenBypass]", ...) end end
            local function jitter(r)
                task.wait(rng:NextNumber(r[1], r[2]) * GB.DelayScale)
            end

            local function myHRP()
                local c = LocalPlayer.Character
                return c and c:FindFirstChild("HumanoidRootPart")
            end

            local function getPoints(model)
                local pts = {}
                if model then
                    for _, o in ipairs(model:GetChildren()) do
                        if o:IsA("BasePart") and string.find(o.Name, "GeneratorPoint") then
                            table.insert(pts, o)
                        end
                    end
                end
                table.sort(pts, function(a, b) return a.Name < b.Name end)
                return pts
            end

            local function getGensCached()
                local now = tick()
                if now - GB.CacheTimer < 5 then return GB.Cache end
                GB.Cache = {}
                GB.CacheTimer = now
                local mf = Workspace:FindFirstChild("Map")
                if not mf then return GB.Cache end
                pcall(function()
                    for _, v in pairs(mf:GetDescendants()) do
                        if v:IsA("Model") and v.Name == "Generator" then
                            local real = v:GetAttribute("RepairProgress") ~= nil
                                or v:GetAttribute("kickcount") ~= nil
                                or v:GetAttribute("ProgressRepair") ~= nil
                            if real then table.insert(GB.Cache, v) end
                        end
                    end
                end)
                return GB.Cache
            end

            local function getRemote()
                local r = ReplicatedStorage:FindFirstChild("Remotes")
                r = r and r:FindFirstChild("Generator")
                return r and r:FindFirstChild("RepairEvent")
            end

            local function fire(re, p, state)
                if not re or not p then return end
                pcall(function() re:FireServer(p, state) end)
            end

            local function moveTo(hrp, cf)
                if hrp and hrp.Parent then
                    hrp.CFrame = cf
                    hrp.AssemblyLinearVelocity = Vector3.zero
                    hrp.AssemblyAngularVelocity = Vector3.zero
                end
            end

            local function repairCount(gm)
                return tonumber(gm:GetAttribute("PlayersRepairingCount")) or 0
            end

            local function genDone(gm)
                return (tonumber(gm:GetAttribute("RepairProgress")) or 0) >= 100
            end

            local function dumpAttrs(inst)
                local t = {}
                for k, v in pairs(inst:GetAttributes()) do t[#t + 1] = k .. "=" .. tostring(v) end
                return table.concat(t, ", ")
            end

            -- IsRepairing di game ini selalu false -> pakai count generator + jarak ke-snap
            local function isSelfRepairing(bp)
                if not bp or not bp.Parent then return false end
                if bp:GetAttribute("IsRepairing") == true then return true end
                local hrp = myHRP()
                if not hrp then return false end
                return repairCount(bp.Parent) >= 1
                    and (hrp.Position - bp.Position).Magnitude <= GB.SnapDist
            end

            local function doRepair(tp)
                local gm = tp.Parent
                if GB.Processed[gm] then return end
                GB.Processed[gm] = true

                local re = getRemote()
                local hrp = myHRP()
                if not re or not hrp then GB.Processed[gm] = nil; return end

                local og = hrp.CFrame
                local held, rejects = {}, 0

                -- 1) cancel repair asli dulu
                fire(re, tp, false)
                jitter(GB.CancelWait)

                -- 2) point lain
                for _, p in ipairs(getPoints(gm)) do
                    if not (GB.Running and GB.Enabled) then break end
                    if p ~= tp and p.Parent then
                        if GB.Teleport then
                            hrp = myHRP()
                            if not hrp then break end
                            moveTo(hrp, p.CFrame)
                            jitter(GB.TeleSettle)
                        end

                        local before = repairCount(gm)
                        fire(re, p, true)
                        jitter(GB.StepDelay)
                        local after = repairCount(gm)
                        log(("fire %s -> count %d -> %d"):format(p.Name, before, after))

                        if after > before or p:GetAttribute("IsRepairing") == true then
                            table.insert(held, p)
                        else
                            fire(re, p, false)
                            rejects += 1
                            if rejects >= GB.MaxRejects then
                                log("server nolak berulang, berhenti")
                                break
                            end
                        end
                    end
                end

                -- 3) balik ke posisi awal
                hrp = myHRP()
                if GB.Teleport and hrp then moveTo(hrp, og) end
                jitter(GB.ReturnWait)

                -- 4) restart repair asli dari posisi bener
                fire(re, tp, true)
                log("repair asli di-restart | titik tambahan:", #held)

                -- 5) watcher: gerak menjauh / gen selesai / pause / mati -> lepas semua
                task.wait(1.0)
                while GB.Running and GB.Enabled do
                    local h = myHRP()
                    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                    local moving = hum ~= nil and hum.MoveDirection.Magnitude > 0.1
                    local dist = h and (h.Position - tp.Position).Magnitude or math.huge
                    if GB.Debug then
                        print(("[GenBypass] watcher dist=%.2f moving=%s"):format(dist, tostring(moving)))
                    end
                    if not h or not tp.Parent or genDone(gm)
                        or gm:GetAttribute("ProgressPaused") == true
                        or dist > GB.MoveCancelDist
                        or moving then
                        log("watcher break | dist=" .. string.format("%.2f", dist) .. " moving=" .. tostring(moving))
                        break
                    end
                    task.wait(0.1)
                end

                for _, p in ipairs(held) do
                    fire(re, p, false)
                    task.wait(rng:NextNumber(0.04, 0.1))
                end
                fire(re, tp, false)
                log("release semua point")

                -- 7) re-arm: tunggu repair beneran berhenti, lalu buka lagi biar repair
                --    berikutnya di gen yang sama bisa kena bypass tanpa harus jalan jauh
                local t0 = tick()
                while GB.Running and tick() - t0 < 3 and isSelfRepairing(tp) do
                    task.wait(0.1)
                end
                GB.Processed[gm] = nil
                log("re-armed")
            end

            local function getNearestPoint()
                local hrp = myHRP()
                if not hrp then return nil end
                local best, bd = nil, math.huge
                for _, g in pairs(getGensCached()) do
                    for _, p in pairs(getPoints(g)) do
                        local d = (hrp.Position - p.Position).Magnitude
                        if d < bd then bd = d; best = p end
                    end
                end
                return best, bd
            end

            -- AUTO trigger
            task.spawn(function()
                local lastDbg = 0
                while GB.Running do
                    task.wait(0.1)
                    if GB.Enabled and not GB.Busy then
                        local bp, bd = getNearestPoint()

                        if GB.Debug and tick() - lastDbg > 2 then
                            lastDbg = tick()
                            if bp then
                                print(("[GenBypass] dekat: %s | jarak %.1f | point: {%s} | gen: {%s}")
                                    :format(bp.Name, bd, dumpAttrs(bp), dumpAttrs(bp.Parent)))
                                print("[GenBypass] processed=" .. tostring(GB.Processed[bp.Parent] == true)
                                    .. " selfRepairing=" .. tostring(isSelfRepairing(bp))
                                    .. " busy=" .. tostring(GB.Busy))
                            end
                        end

                        if bp and bd <= GB.TriggerRange
                            and not GB.Processed[bp.Parent]
                            and isSelfRepairing(bp) then
                            GB.Busy = true
                            log("TRIGGER")
                            pcall(doRepair, bp)
                            GB.Busy = false
                        end
                    end
                end
            end)

            -- reset Processed kalau udah jauh dari generator
            task.spawn(function()
                while GB.Running do
                    task.wait(2)
                    local hrp = myHRP()
                    if hrp then
                        for gm in pairs(GB.Processed) do
                            if not gm or not gm.Parent then
                                GB.Processed[gm] = nil
                            else
                                local near = false
                                for _, p in pairs(getPoints(gm)) do
                                    if p.Parent and (hrp.Position - p.Position).Magnitude <= 10 then
                                        near = true; break
                                    end
                                end
                                if not near then GB.Processed[gm] = nil end
                            end
                        end
                    end
                end
            end)

            local API = { Config = GB }
            function API.setEnabled(v)
                GB.Enabled = v == true
                if not GB.Enabled then GB.Busy = false end
            end
            function API.setRange(v)       GB.TriggerRange = math.clamp(tonumber(v) or 8, 3, 20) end
            function API.setTeleport(v)    GB.Teleport = v == true end
            function API.setMoveCancel(v)  GB.MoveCancelDist = math.clamp(tonumber(v) or 2.5, 1, 10) end
            function API.setMaxRejects(v)  GB.MaxRejects = math.clamp(math.floor(tonumber(v) or 2), 1, 6) end
            function API.setDelayScale(v)  GB.DelayScale = math.clamp(tonumber(v) or 1, 0.5, 3) end
            function API.setDebug(v)       GB.Debug = v == true end
            -- kalau stuck: lepas semua point generator terdekat
            function API.unstuck()
                local re = getRemote()
                local bp = getNearestPoint()
                if re and bp and bp.Parent then
                    for _, p in ipairs(getPoints(bp.Parent)) do fire(re, p, false) end
                end
                local hrp = myHRP()
                if hrp then hrp.Anchored = false end
                GB.Processed = {}
                GB.Busy = false
            end
            function API.destroy() GB.Running = false; GB.Enabled = false end

            W.N3K0P01_GenBypass = API
        end

        local allSections = {}
        local function MakeSection(tab, name)
            local s = tab:AddSection(name)
            table.insert(allSections, s)
            return s
        end

        local uiOK, uiErr = pcall(function()
            if not UILib then error("UILib tidak tersedia.") end
            local Window = UILib:Window({
                Title = "N3K0P01 HUB - Premium",
                LogoButtonSize = 52,
                Image = "80227588329123",
                Footer = "Violence District",
                Color = NotifyColor,
                ShowInfo = true,
                Version = 1,
                Search = true
            })
            Window:InfoTab({
                Name = "Information", Icon = "lightbulb",
                SectionTitle = "Information",
                Banner = "rbxassetid://117287925943202",
                Version = "v1.0.16",
                DiscordLink = "",
                DiscordName = "N3K0P01 HUB - Community",
                DiscordText = "Join Server Discord N3K0P01 HUB Untuk Informasi Update Dan Giveaway.",
                Cards = { { Title = "Credits", Description = "Owner = SEIZEE\nDev = SEIZEE\nVersion = v1.0.16\nBanner Code = 117287925943202" } }
            })

            local SurvivorTab = Window:AddTab({ Name = "Survivor", Icon = "user" })
            local VisualsTab  = Window:AddTab({ Name = "Visuals",  Icon = "eye" })
            local KillerTab   = Window:AddTab({ Name = "Killer",   Icon = "crosshair" })
            local MiscTab     = Window:AddTab({ Name = "Misc",     Icon = "settings-2" })
            local ConfigTab   = Window:AddTab({ Name = "Config",   Icon = "save" })



            -- ============================================================
            -- N3K0P01 HUB INTEGRATION: SILENT VEIL SPEAR AIM
            -- Controls are added directly to the existing Killer tab.
            -- ============================================================
            do
            -- ============================================================
            -- Silent Veil Spear Aim - Standalone
            -- Extracted from Violence District (VD v1.7.0)
            -- ============================================================

            local Players        = game:GetService("Players")
            local RunService     = game:GetService("RunService")
            local UserInputService = game:GetService("UserInputService")

            local localPlayer = Players.LocalPlayer
            local camera      = workspace.CurrentCamera

            -- ============================================================
            -- SETTINGS
            -- ============================================================
            local Settings = {
                Enabled                = false,
                FOVRadius              = 240,
                ShowFOV                = true,
                FOVColor               = "Yellow",
                Priority               = "Nearest",
                VerticalOffset         = -0.8,
                TargetHighlightEnabled = true,
                TargetHighlightColor   = "Red",
            }

            Settings.VerticalOffset = 0
            Settings.LeadMultiplier = 1
            Settings.Spread = 0

            local SpearParams = {
                MaxSpeed       = 180,
                Gravity        = Vector3.new(0, -98.099998474121, 0),
                SpawnOffset    = 3,
                MinChargeTime  = 0.3,
                FullChargeTime = 1,
            }

            local ColorMap = {
                Cyan   = Color3.fromRGB(0, 240, 255),
                Red    = Color3.fromRGB(255, 50, 50),
                Green  = Color3.fromRGB(50, 255, 50),
                Yellow = Color3.fromRGB(255, 255, 50),
                Purple = Color3.fromRGB(170, 80, 255),
                Orange = Color3.fromRGB(255, 125, 0),
                Pink   = Color3.fromRGB(255, 100, 200),
                White  = Color3.fromRGB(255, 255, 255),
                Blue   = Color3.fromRGB(0, 100, 255),
            }

            -- ============================================================
            -- HELPERS
            -- ============================================================
            local function getPing()
                local ok, ping = pcall(function() return localPlayer:GetNetworkPing() end)
                local value = (ok and type(ping) == "number" and ping > 0) and math.clamp(ping * 0.5, 0, 0.25) or 0.035
                return math.clamp(value, 0.015, 0.25)
            end

            local function sortPriority(list, priority, maxDist)
                maxDist = math.max(maxDist or 150, 1)
                if priority == "Furthest" then
                    table.sort(list, function(a, b)
                        if math.abs(a.dist - b.dist) > .01 then return a.dist > b.dist end
                        return a.health < b.health
                    end)
                elseif priority == "Injured" then
                    table.sort(list, function(a, b)
                        if math.abs(a.health - b.health) > .01 then return a.health < b.health end
                        return a.dist < b.dist
                    end)
                elseif priority == "Healed" then
                    table.sort(list, function(a, b)
                        if math.abs(a.health - b.health) > .01 then return a.health > b.health end
                        return a.dist < b.dist
                    end)
                else
                    table.sort(list, function(a, b)
                        if math.abs(a.dist - b.dist) > .01 then return a.dist < b.dist end
                        return a.health < b.health
                    end)
                end
                return list[1]
            end

            -- ============================================================
            -- SPEAR STATE DETECTION
            -- ============================================================
            local cachedEndAttack      = nil
            local cachedEndAttackTime  = 0

            local function findEndAttackFunc()
                local char = localPlayer.Character
                if not char then return false, 0 end

                local isVeil = char:GetAttribute("MorphedKiller") == "Veil"
                    or char:GetAttribute("Veil") == true
                    or char:FindFirstChild("Spear") ~= nil
                if not isVeil then return false, 0 end

                local anims = char:FindFirstChild("Animations")
                if not anims then return false, 0 end

                if not (cachedEndAttack and getfenv and getfenv(cachedEndAttack).script == anims) then
                    cachedEndAttack = nil
                    local now = os.clock()
                    if now - cachedEndAttackTime < 3 then
                        return false, 0
                    end
                    cachedEndAttackTime = now
                    if typeof(getgc) == "function" then
                        for _, fn in ipairs(getgc()) do
                            if type(fn) == "function" and (not islclosure or islclosure(fn)) then
                                if debug.info(fn, "n") == "endAttack" and getfenv(fn).script == anims then
                                    cachedEndAttack = fn
                                    break
                                end
                            end
                        end
                    end
                end

                if cachedEndAttack and typeof(getupvalues) == "function" then
                    local ok, ups = pcall(getupvalues, cachedEndAttack)
                    if ok and ups then
                        local isCharging = ups[2] == true
                        local startTime  = tonumber(ups[9]) or 0
                        return isCharging, startTime
                    end
                end
                return false, 0
            end

            local function isVeilWithSpear()
                local char = localPlayer.Character
                if not char then return false end

                local isVeil = char:GetAttribute("MorphedKiller") == "Veil"
                    or char:GetAttribute("Veil") == true
                    or char:FindFirstChild("spearmanager") ~= nil
                    or char:FindFirstChild("Spear") ~= nil
                if not isVeil then return false end

                local spear = char:FindFirstChild("Spear")
                if spear then
                    local sp = spear:FindFirstChild("Spear")
                    if sp and sp:IsA("BasePart") and sp.Transparency < 0.5 then
                        return true
                    end
                end
                if char:GetAttribute("VeilSpearEquipped") == true then return true end
                if char:GetAttribute("spearmode") == true then return true end

                return false
            end

            -- ========================================================
            -- TARGET PRIORITIZER (port dari Ic di script 2)
            -- ========================================================
            local function pickByPriority(list, priority, fov)
                if not list or #list == 0 then return nil end
                fov = math.max(fov or 150, 1)

                local function hpPct(c)
                    return math.clamp(c.health / math.max(c.maxHealth or 100, 1), 0, 1)
                end

                if priority == "Furthest" then
                    table.sort(list, function(a, b)
                        if math.abs(a.dist - b.dist) > 0.01 then return a.dist > b.dist end
                        return a.health < b.health
                    end)
                elseif priority == "Injured" then
                    table.sort(list, function(a, b)
                        if math.abs(a.health - b.health) > 0.01 then return a.health < b.health end
                        return a.dist < b.dist
                    end)
                elseif priority == "Healed" then
                    table.sort(list, function(a, b)
                        if math.abs(a.health - b.health) > 0.01 then return a.health > b.health end
                        return a.dist < b.dist
                    end)
                elseif priority == "NearestInjured" then
                    table.sort(list, function(a, b)
                        local sa = 0.5 * (a.dist / fov) + 0.5 * hpPct(a)
                        local sb = 0.5 * (b.dist / fov) + 0.5 * hpPct(b)
                        if math.abs(sa - sb) > 0.001 then return sa < sb end
                        return a.dist < b.dist
                    end)
                elseif priority == "NearestHealed" then
                    table.sort(list, function(a, b)
                        local sa = 0.5 * (a.dist / fov) + 0.5 * (1 - hpPct(a))
                        local sb = 0.5 * (b.dist / fov) + 0.5 * (1 - hpPct(b))
                        if math.abs(sa - sb) > 0.001 then return sa < sb end
                        return a.dist < b.dist
                    end)
                elseif priority == "FurthestInjured" then
                    table.sort(list, function(a, b)
                        local sa = 0.5 * (1 - a.dist / fov) + 0.5 * hpPct(a)
                        local sb = 0.5 * (1 - b.dist / fov) + 0.5 * hpPct(b)
                        if math.abs(sa - sb) > 0.001 then return sa < sb end
                        return a.dist > b.dist
                    end)
                elseif priority == "FurthestHealed" then
                    table.sort(list, function(a, b)
                        local sa = 0.5 * (1 - a.dist / fov) + 0.5 * (1 - hpPct(a))
                        local sb = 0.5 * (1 - b.dist / fov) + 0.5 * (1 - hpPct(b))
                        if math.abs(sa - sb) > 0.001 then return sa < sb end
                        return a.dist > b.dist
                    end)
                else -- Nearest
                    table.sort(list, function(a, b)
                        if math.abs(a.dist - b.dist) > 0.01 then return a.dist < b.dist end
                        return a.health < b.health
                    end)
                end
                return list[1]
            end

            local lockedChar = nil
            local SWITCH_BIAS = 40

            local function getSilentAimTarget()
                if not Settings.Enabled then lockedChar = nil return nil end
                local char = localPlayer.Character
                local cam = workspace.CurrentCamera
                if not cam or not char then return nil end

                local center = cam.ViewportSize / 2
                local list = {}

                for _, plr in ipairs(Players:GetPlayers()) do
                    local c = plr.Character
                    local isSurvivor = plr.Team and string.find(string.lower(plr.Team.Name), "survivor", 1, true)
                    if plr ~= localPlayer and c and isSurvivor then
                        local hum = c:FindFirstChildOfClass("Humanoid")
                        local root = c:FindFirstChild("HumanoidRootPart") or c.PrimaryPart
                        if hum and hum.Health > 0 and root and not c:GetAttribute("Immobile") then
                            local sp, onScreen = cam:WorldToViewportPoint(root.Position)
                            if onScreen and sp.Z > 0 then
                                local dist = (Vector2.new(sp.X, sp.Y) - center).Magnitude
                                if dist <= Settings.FOVRadius then
                                    table.insert(list, {
                                        character = c, part = root, dist = dist,
                                        health = hum.Health, maxHealth = hum.MaxHealth,
                                    })
                                end
                            end
                        end
                    end
                end

                local best = pickByPriority(list, Settings.Priority, Settings.FOVRadius)
                local kept
                for _, e in ipairs(list) do
                    if e.character == lockedChar then kept = e break end
                end
                if kept and best and best ~= kept and kept.dist <= best.dist + SWITCH_BIAS then
                    best = kept
                end

                lockedChar = best and best.character or nil
                return lockedChar
            end

            -- ============================================================
            -- 2D BOUNDING BOX (untuk highlight)
            -- ============================================================
            local function get2DBoundingBox(character)
                if not camera or not character then return nil end
                local head = character:FindFirstChild("Head")
                local root = character:FindFirstChild("HumanoidRootPart") or character.PrimaryPart
                if not root then return nil end

                local topPos = head and (head.Position + Vector3.new(0, 0.7, 0))
                    or (root.Position + Vector3.new(0, 2.2, 0))
                local botPos = root.Position - Vector3.new(0, 2.8, 0)

                local topScreen  = camera:WorldToViewportPoint(topPos)
                local botScreen  = camera:WorldToViewportPoint(botPos)
                local rootScreen, rootOn = camera:WorldToViewportPoint(root.Position)

                if not rootOn or rootScreen.Z <= 0 then return nil end

                local height = math.abs(botScreen.Y - topScreen.Y)
                local width  = math.clamp(height * 0.6, 12, 350)
                if height < 6 then return nil end

                return rootScreen.X - width / 2, topScreen.Y, width, height
            end

            -- ============================================================
            -- TARGET HIGHLIGHT GUI
            -- ============================================================
            local targetGui, targetFrame
            local targetCorners = {}

            local function setupTargetBoxGui()
                if targetGui and targetGui.Parent then return end
                local guiParent = localPlayer:FindFirstChildOfClass("PlayerGui")

                targetGui = Instance.new("ScreenGui")
                targetGui.Name            = "SilentSpearTargetGui"
                targetGui.ResetOnSpawn    = false
                targetGui.IgnoreGuiInset  = true
                targetGui.DisplayOrder    = 999
                targetGui.Parent          = guiParent

                targetFrame = Instance.new("Frame")
                targetFrame.Name                = "TargetBox"
                targetFrame.BackgroundTransparency = 1
                targetFrame.BorderSizePixel     = 0
                targetFrame.Visible             = false
                targetFrame.Parent              = targetGui

                local function mkCorner(name, anchor, pos, size)
                    local f = Instance.new("Frame")
                    f.Name              = name
                    f.AnchorPoint       = anchor
                    f.Position          = pos
                    f.Size              = size
                    f.BorderSizePixel   = 0
                    f.BackgroundColor3  = Color3.fromRGB(255, 50, 50)
                    f.Parent            = targetFrame
                    return f
                end

                local len, thick = 14, 2.5
                targetCorners = {
                    TL_H = mkCorner("TL_H", Vector2.new(0, 0), UDim2.new(0, -1, 0, -1), UDim2.new(0, len, 0, thick)),
                    TL_V = mkCorner("TL_V", Vector2.new(0, 0), UDim2.new(0, -1, 0, -1), UDim2.new(0, thick, 0, len)),
                    TR_H = mkCorner("TR_H", Vector2.new(1, 0), UDim2.new(1,  1, 0, -1), UDim2.new(0, len, 0, thick)),
                    TR_V = mkCorner("TR_V", Vector2.new(1, 0), UDim2.new(1,  1, 0, -1), UDim2.new(0, thick, 0, len)),
                    BL_H = mkCorner("BL_H", Vector2.new(0, 1), UDim2.new(0, -1, 1,  1), UDim2.new(0, len, 0, thick)),
                    BL_V = mkCorner("BL_V", Vector2.new(0, 1), UDim2.new(0, -1, 1,  1), UDim2.new(0, thick, 0, len)),
                    BR_H = mkCorner("BR_H", Vector2.new(1, 1), UDim2.new(1,  1, 1,  1), UDim2.new(0, len, 0, thick)),
                    BR_V = mkCorner("BR_V", Vector2.new(1, 1), UDim2.new(1,  1, 1,  1), UDim2.new(0, thick, 0, len)),
                }
            end

            local function updateTargetHighlight()
                if not Settings.Enabled or not Settings.TargetHighlightEnabled then
                    if targetFrame then targetFrame.Visible = false end
                    return
                end
                setupTargetBoxGui()

                local char
                pcall(function() char = getSilentAimTarget() end)

                if char then
                    local x, y, w, h = get2DBoundingBox(char)
                    if x and y and w and h then
                        targetFrame.Position = UDim2.new(0, x, 0, y)
                        targetFrame.Size     = UDim2.new(0, w, 0, h)

                        local color = ColorMap[Settings.TargetHighlightColor] or Color3.fromRGB(0, 240, 255)
                        local cl    = math.clamp(math.floor(w * 0.25), 6, 16)

                        for _, c in pairs(targetCorners) do
                            c.BackgroundColor3      = color
                            c.BackgroundTransparency = 0
                        end
                        targetCorners.TL_H.Size = UDim2.new(0, cl, 0, 2.5)
                        targetCorners.TR_H.Size = UDim2.new(0, cl, 0, 2.5)
                        targetCorners.BL_H.Size = UDim2.new(0, cl, 0, 2.5)
                        targetCorners.BR_H.Size = UDim2.new(0, cl, 0, 2.5)
                        targetCorners.TL_V.Size = UDim2.new(0, 2.5, 0, cl)
                        targetCorners.TR_V.Size = UDim2.new(0, 2.5, 0, cl)
                        targetCorners.BL_V.Size = UDim2.new(0, 2.5, 0, cl)
                        targetCorners.BR_V.Size = UDim2.new(0, 2.5, 0, cl)

                        targetFrame.Visible = true
                        return
                    end
                end
                if targetFrame then targetFrame.Visible = false end
            end

            -- ============================================================
            -- FOV CIRCLE
            -- ============================================================
            local function getGuiParent()
                local parent = nil
                if type(gethui) == "function" then
                    local ok, h = pcall(gethui)
                    if ok and h then parent = h end
                end
                return parent or localPlayer:FindFirstChildOfClass("PlayerGui")
            end

            local fovGui, fovFrame, fovStroke
            local function ensureFOV()
                if fovGui and fovGui.Parent then return end
                fovGui = Instance.new("ScreenGui")
                fovGui.Name = "SilentSpearFOVGui"
                fovGui.ResetOnSpawn = false
                fovGui.IgnoreGuiInset = true
                fovGui.DisplayOrder = 998
                fovGui.Parent = getGuiParent()

                fovFrame = Instance.new("Frame")
                fovFrame.Name = "FOVCircle"
                fovFrame.AnchorPoint = Vector2.new(0.5, 0.5)
                fovFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
                fovFrame.BackgroundTransparency = 1
                fovFrame.Visible = false
                fovFrame.Parent = fovGui

                fovStroke = Instance.new("UIStroke")
                fovStroke.Thickness = 1.5
                fovStroke.Transparency = 0.15
                fovStroke.Parent = fovFrame

                local corner = Instance.new("UICorner")
                corner.CornerRadius = UDim.new(1, 0)
                corner.Parent = fovFrame
            end

            local targetGui, targetFrame
            local targetCorners = {}
            local function ensureTargetBox()
                if targetGui and targetGui.Parent then return end
                targetGui = Instance.new("ScreenGui")
                targetGui.Name = "SilentSpearTargetGui"
                targetGui.ResetOnSpawn = false
                targetGui.IgnoreGuiInset = true
                targetGui.DisplayOrder = 999
                targetGui.Parent = getGuiParent()

                targetFrame = Instance.new("Frame")
                targetFrame.Name = "TargetBox"
                targetFrame.BackgroundTransparency = 1
                targetFrame.BorderSizePixel = 0
                targetFrame.Visible = false
                targetFrame.Parent = targetGui

                local function mk(name, anchor, pos, size)
                    local f = Instance.new("Frame")
                    f.Name = name
                    f.AnchorPoint = anchor
                    f.Position = pos
                    f.Size = size
                    f.BorderSizePixel = 0
                    f.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
                    f.Parent = targetFrame
                    return f
                end

                local len, thick = 14, 2.5
                targetCorners = {
                    TL_H = mk("TL_H", Vector2.new(0, 0), UDim2.new(0, -1, 0, -1), UDim2.new(0, len, 0, thick)),
                    TL_V = mk("TL_V", Vector2.new(0, 0), UDim2.new(0, -1, 0, -1), UDim2.new(0, thick, 0, len)),
                    TR_H = mk("TR_H", Vector2.new(1, 0), UDim2.new(1, 1, 0, -1), UDim2.new(0, len, 0, thick)),
                    TR_V = mk("TR_V", Vector2.new(1, 0), UDim2.new(1, 1, 0, -1), UDim2.new(0, thick, 0, len)),
                    BL_H = mk("BL_H", Vector2.new(0, 1), UDim2.new(0, -1, 1, 1), UDim2.new(0, len, 0, thick)),
                    BL_V = mk("BL_V", Vector2.new(0, 1), UDim2.new(0, -1, 1, 1), UDim2.new(0, thick, 0, len)),
                    BR_H = mk("BR_H", Vector2.new(1, 1), UDim2.new(1, 1, 1, 1), UDim2.new(0, len, 0, thick)),
                    BR_V = mk("BR_V", Vector2.new(1, 1), UDim2.new(1, 1, 1, 1), UDim2.new(0, thick, 0, len)),
                }
            end

            local function get2DBoundingBox(character)
                local cam = workspace.CurrentCamera
                if not cam or not character then return nil end
                local head = character:FindFirstChild("Head")
                local root = character:FindFirstChild("HumanoidRootPart") or character.PrimaryPart
                if not root then return nil end

                local topPos = head and (head.Position + Vector3.new(0, 0.7, 0)) or (root.Position + Vector3.new(0, 2.2, 0))
                local botPos = root.Position - Vector3.new(0, 2.8, 0)

                local top = cam:WorldToViewportPoint(topPos)
                local bot = cam:WorldToViewportPoint(botPos)
                local rootScreen, rootOn = cam:WorldToViewportPoint(root.Position)
                if not rootOn or rootScreen.Z <= 0 then return nil end

                local height = math.abs(bot.Y - top.Y)
                if height < 6 then return nil end
                local width = math.clamp(height * 0.6, 12, 350)
                return rootScreen.X - width / 2, top.Y, width, height
            end

            local function updateVisuals()
                -- FOV circle
                ensureFOV()
                local cam = workspace.CurrentCamera
                local showFov = Settings.Enabled and Settings.ShowFOV and cam ~= nil
                fovFrame.Visible = showFov
                if showFov then
                    fovFrame.Size = UDim2.new(0, Settings.FOVRadius * 2, 0, Settings.FOVRadius * 2)
                    fovStroke.Color = ColorMap[Settings.FOVColor] or ColorMap.Yellow
                end

                -- Target box
                if not Settings.Enabled or not Settings.TargetHighlightEnabled then
                    if targetFrame then targetFrame.Visible = false end
                    return
                end
                ensureTargetBox()

                local char = getSilentAimTarget()
                if char then
                    local x, y, w, h = get2DBoundingBox(char)
                    if x then
                        local color = ColorMap[Settings.TargetHighlightColor] or ColorMap.Red
                        local cl = math.clamp(math.floor(w * 0.25), 6, 16)
                        targetFrame.Position = UDim2.new(0, x, 0, y)
                        targetFrame.Size = UDim2.new(0, w, 0, h)
                        for name, c in pairs(targetCorners) do
                            c.BackgroundColor3 = color
                            c.BackgroundTransparency = 0
                            if name:sub(4) == "H" then
                                c.Size = UDim2.new(0, cl, 0, 2.5)
                            else
                                c.Size = UDim2.new(0, 2.5, 0, cl)
                            end
                        end
                        targetFrame.Visible = true
                        return
                    end
                end
                targetFrame.Visible = false
            end

            RunService.RenderStepped:Connect(function()
                pcall(updateVisuals)
            end)

            -- ========================================================
            -- DETEKSI VEIL + SPEAR + CHARGE
            -- ========================================================
            local cachedEndAttack, cachedEndAttackTime = nil, 0

            local function refreshEndAttack()
                local char = localPlayer.Character
                local anims = char and char:FindFirstChild("Animations")
                if not anims then cachedEndAttack = nil return end

                if cachedEndAttack then
                    local ok, env = pcall(getfenv, cachedEndAttack)
                    if ok and env.script == anims then return end
                end
                cachedEndAttack = nil
                if typeof(getgc) ~= "function" then return end
                for _, fn in ipairs(getgc()) do
                    if type(fn) == "function" and (not islclosure or islclosure(fn))
                        and debug.info(fn, "n") == "endAttack" then
                        local ok, env = pcall(getfenv, fn)
                        if ok and env.script == anims then cachedEndAttack = fn break end
                    end
                end
            end

            localPlayer.CharacterAdded:Connect(function()
                task.wait(2)
                pcall(refreshEndAttack)
            end)
            task.spawn(function()
                while task.wait(5) do pcall(refreshEndAttack) end
            end)

            local function getChargeState()
                local char = localPlayer.Character
                if not char then return false, 0 end

                local isVeil = char:GetAttribute("MorphedKiller") == "Veil"
                    or char:GetAttribute("Veil") == true
                    or char:FindFirstChild("Spear") ~= nil
                if not isVeil then return false, 0 end

                local anims = char:FindFirstChild("Animations")
                if not anims then return false, 0 end

                if not cachedEndAttack or (getfenv and getfenv(cachedEndAttack).script ~= anims) then
                    cachedEndAttack = nil
                    local now = os.clock()
                    if now - cachedEndAttackTime < 3 then return false, 0 end
                    cachedEndAttackTime = now
                    if typeof(getgc) == "function" then
                        for _, fn in ipairs(getgc()) do
                            if type(fn) == "function" and (not islclosure or islclosure(fn)) then
                                if debug.info(fn, "n") == "endAttack" and getfenv(fn).script == anims then
                                    cachedEndAttack = fn
                                    break
                                end
                            end
                        end
                    end
                end

                if cachedEndAttack and typeof(getupvalues) == "function" then
                    local ok, ups = pcall(getupvalues, cachedEndAttack)
                    if ok and ups then
                        return ups[2] == true, tonumber(ups[9]) or 0
                    end
                end
                return false, 0
            end

            local function spearEquipped(char)
                if not char then return false end
                local spear = char:FindFirstChild("Spear")
                if spear then
                    local part = spear:FindFirstChild("Spear")
                    if part and part:IsA("BasePart") then
                        return part.Transparency < 0.5
                    end
                end
                if char:GetAttribute("VeilSpearEquipped") == true then return true end
                if char:GetAttribute("spearmode") == true then return true end
                return false
            end

            local function isVeilWithSpear()
                local char = localPlayer.Character
                if not char then return false end
                local isVeil = char:GetAttribute("MorphedKiller") == "Veil"
                    or char:GetAttribute("Veil") == true
                    or char:FindFirstChild("spearmanager") ~= nil
                    or char:FindFirstChild("Spear") ~= nil
                if not isVeil then return false end
                return spearEquipped(char)
            end

            -- ============================================================
            -- PROYEKTIL BALLISTIC SOLVER
            -- ============================================================
            local statsService = game:GetService("Stats")

            local MAX_TARGET_SPEED = 60
            local TRACK_WINDOW = 0.2
            local trackedTargets = setmetatable({}, { __mode = "k" })
            local lastCharge = { duration = SpearParams.FullChargeTime, at = 0 }

            -- Round trip ping (detik) dari Stats, lebih akurat dari GetNetworkPing.
            local function getLatency()
                local rtt = 0.07
                pcall(function()
                    rtt = statsService.Network.ServerStatsItem["Data Ping"]:GetValue() / 1000
                end)
                return math.clamp(rtt, 0.01, 0.6)
            end

            -- Catat posisi survivor tiap frame untuk hitung velocity sendiri.
            local function sampleTargets()
                local now = os.clock()
                for _, plr in ipairs(Players:GetPlayers()) do
                    local char = plr.Character
                    local root = char and char:FindFirstChild("HumanoidRootPart")
                    if plr ~= localPlayer and root then
                        local data = trackedTargets[char]
                        if not data then
                            data = { samples = {}, groundY = root.Position.Y }
                            trackedTargets[char] = data
                        end
                        local samples = data.samples
                        samples[#samples + 1] = { t = now, p = root.Position }
                        while #samples > 0 and now - samples[1].t > TRACK_WINDOW do
                            table.remove(samples, 1)
                        end
                        local hum = char:FindFirstChildOfClass("Humanoid")
                        if hum and hum.FloorMaterial ~= Enum.Material.Air then
                            data.groundY = root.Position.Y
                        end
                    end
                end
            end

            local function getTargetVelocity(char, root)
                local data = trackedTargets[char]
                local samples = data and data.samples
                if samples and #samples >= 3 then
                    local first, last = samples[1], samples[#samples]
                    local dt = last.t - first.t
                    if dt > 0.05 then
                        return (last.p - first.p) / dt
                    end
                end
                return root.AssemblyLinearVelocity
            end

            -- Prediksi posisi target setelah horizon detik (horizontal + lompat/jatuh).
            local function predictPosition(char, root, horizon)
                local vel = getTargetVelocity(char, root)
                local flat = Vector3.new(vel.X, 0, vel.Z)
                if flat.Magnitude > MAX_TARGET_SPEED then
                    flat = flat.Unit * MAX_TARGET_SPEED
                end

                local pos = root.Position
                local y = pos.Y
                local hum = char:FindFirstChildOfClass("Humanoid")
                local grounded = hum and hum.FloorMaterial ~= Enum.Material.Air
                if not grounded then
                    local data = trackedTargets[char]
                    local floorY = data and data.groundY or (pos.Y - 50)
                    local vy = math.clamp(vel.Y, -60, 60)
                    y = math.max(pos.Y + vy * horizon - 0.5 * workspace.Gravity * horizon * horizon, floorY)
                end

                return Vector3.new(pos.X + flat.X * horizon, y, pos.Z + flat.Z * horizon)
            end

            -- Kecepatan lemparan asli: ambil dari argumen game dulu, baru dari charge.
            local function resolveThrowSpeed(arg1)
                if arg1 then
                    if typeof(arg1.Velocity) == "Vector3" and arg1.Velocity.Magnitude > 1 then
                        return arg1.Velocity.Magnitude
                    end
                    if type(arg1.Speed) == "number" and arg1.Speed > 1 then
                        return arg1.Speed
                    end
                end

                local charging, startTime = getChargeState()
                local duration
                if charging and startTime > 0 then
                    duration = workspace:GetServerTimeNow() - startTime
                elseif os.clock() - lastCharge.at < 0.6 then
                    duration = lastCharge.duration
                else
                    duration = SpearParams.FullChargeTime
                end

                duration = math.clamp(duration, SpearParams.MinChargeTime, SpearParams.FullChargeTime)
                return math.clamp(duration * SpearParams.MaxSpeed, 1, SpearParams.MaxSpeed)
            end

            local function computeSpearDirection(targetChar, origin, forcedSpeed)
                local cam = workspace.CurrentCamera
                local root = targetChar and (targetChar:FindFirstChild("HumanoidRootPart") or targetChar.PrimaryPart)
                if not cam or not root then return nil end

                local spawnPos = origin or (cam.CFrame.Position + cam.CFrame.LookVector * SpearParams.SpawnOffset)
                local speed = forcedSpeed or resolveThrowSpeed(nil)
                local gMag = math.abs(SpearParams.Gravity.Y)
                local extra = getLatency() + 0.05
                local mult = Settings.LeadMultiplier or 1
                local offset = Vector3.new(0, Settings.VerticalOffset or 0, 0)

                local t = (root.Position - spawnPos).Magnitude / speed
                local aimPoint = root.Position + offset
                local outOfRange = false

                -- Iterasi sampai waktu terbang konvergen (target bergerak).
                for _ = 1, 8 do
                    aimPoint = predictPosition(targetChar, root, (t + extra) * mult) + offset

                    local d = aimPoint - spawnPos
                    local xz2 = d.X * d.X + d.Z * d.Z
                    local a = 0.25 * gMag * gMag
                    local b = d.Y * gMag - speed * speed
                    local c = xz2 + d.Y * d.Y
                    local disc = b * b - 4 * a * c

                    local newT
                    if disc >= 0 then
                        local r = (-b - math.sqrt(disc)) / (2 * a)
                        newT = r > 0 and math.sqrt(r) or d.Magnitude / speed
                        outOfRange = false
                    else
                        newT = d.Magnitude / speed
                        outOfRange = true
                    end

                    newT = math.max(newT, 0.03)
                    local converged = math.abs(newT - t) < 0.002
                    t = newT
                    if converged then break end
                end

                local d = aimPoint - spawnPos
                local dir
                if outOfRange then
                    -- Di luar jangkauan: lob 45 derajat (jarak maksimal).
                    local flat = Vector3.new(d.X, 0, d.Z)
                    if flat.Magnitude < 0.001 then return nil end
                    local angle = math.rad(45)
                    dir = flat.Unit * math.cos(angle) + Vector3.new(0, math.sin(angle), 0)
                else
                    local gVec = Vector3.new(0, -gMag, 0)
                    dir = ((d - 0.5 * gVec * t * t) / t).Unit
                end

                -- Spread opsional biar lebih legit.
                local spread = math.rad(Settings.Spread or 0)
                if spread > 0 then
                    local jitter = Vector3.new(math.random() - 0.5, math.random() - 0.5, math.random() - 0.5) * 2 * math.tan(spread)
                    dir = (dir + jitter).Unit
                end

                return dir, spawnPos, speed, aimPoint
            end

            -- Sampler: posisi target + durasi charge terakhir.
            RunService.Heartbeat:Connect(function()
                pcall(sampleTargets)
                if Settings.Enabled then
                    local charging, startTime = getChargeState()
                    if charging and startTime > 0 then
                        lastCharge.duration = workspace:GetServerTimeNow() - startTime
                        lastCharge.at = os.clock()
                    end
                end
            end)


            -- ============================================================
            -- NAMECALL HOOK
            -- ============================================================
            local hookAvailable = type(hookmetamethod) == "function" and type(getnamecallmethod) == "function"
            local _newccl = newcclosure or function(f) return f end
            local _FireServer = Instance.new("RemoteEvent").FireServer

            local ProjectileVisuals = nil
            local function getProjectileVisuals()
                if ProjectileVisuals ~= nil then return ProjectileVisuals or nil end
                local ok, mod = pcall(function()
                    return require(ReplicatedStorage.Modules.World.ProjectileVisualsClient)
                end)
                ProjectileVisuals = (ok and mod) or false
                return ProjectileVisuals or nil
            end

            if hookAvailable then
                local oldNamecall
                local setnc = setnamecallmethod or function() end
                local myToken = {}
                _G.__SVA_Token = myToken

                oldNamecall = hookmetamethod(game, "__namecall", _newccl(function(self, ...)
                    local method = getnamecallmethod()

                    if _G.__SVA_Token ~= myToken
                        or (method ~= "FireServer" and method ~= "fireServer")
                        or typeof(self) ~= "Instance"
                        or self.Name:lower() ~= "spearthrow"
                        or not Settings.Enabled then
                        return oldNamecall(self, ...)
                    end

                    local n = select("#", ...)
                    local args = { ... }

                    pcall(function()
                        if not isVeilWithSpear() then return end
                        local target = (lockedChar and lockedChar.Parent) and lockedChar or getSilentAimTarget()
                        if not target then return end

                        local cam = workspace.CurrentCamera
                        local arg1 = type(args[1]) == "table" and args[1] or nil
                        local origin = (arg1 and typeof(arg1.Origin) == "Vector3" and arg1.Origin)
                            or (cam and (cam.CFrame.Position + cam.CFrame.LookVector * SpearParams.SpawnOffset))

                        local dir, newOrigin, speed = computeSpearDirection(target, origin, resolveThrowSpeed(arg1))
                        if not dir or dir.X ~= dir.X or dir.Y ~= dir.Y or dir.Z ~= dir.Z then return end

                        if arg1 then
                            arg1.Direction = dir
                            if arg1.Velocity ~= nil then arg1.Velocity = dir * speed end
                        elseif typeof(args[1]) == "Vector3" and typeof(args[2]) == "Vector3" then
                            args[1], args[2] = newOrigin, dir
                        elseif typeof(args[1]) == "Vector3" then
                            args[1] = dir
                        end
                    end)

                    setnc(method)
                    return oldNamecall(self, unpack(args, 1, n))
                end))
            else
                warn("[Silent Veil Spear] Executor tidak support hookmetamethod/getnamecallmethod.")
            end

            -- ============================================================
            -- RENDER LOOP
            -- ============================================================

            Settings.TracerEnabled = false
            Settings.TracerColor = "Red"
            Settings.TracerThickness = 1.5

            local tracerGui, tracerLine
            local function ensureTracer()
                if tracerGui and tracerGui.Parent and tracerLine then return end
                tracerGui = Instance.new("ScreenGui")
                tracerGui.Name = "N3K0P01_SpearTracer"
                tracerGui.ResetOnSpawn = false
                tracerGui.IgnoreGuiInset = true
                tracerGui.DisplayOrder = 997
                tracerGui.Parent = getGuiParent()

                tracerLine = Instance.new("Frame")
                tracerLine.AnchorPoint = Vector2.new(0.5, 0.5)
                tracerLine.BorderSizePixel = 0
                tracerLine.Visible = false
                tracerLine.Parent = tracerGui
            end

            RunService.RenderStepped:Connect(function()
                pcall(function()
                    if not (Settings.Enabled and Settings.TracerEnabled) then
                        if tracerLine then tracerLine.Visible = false end
                        return
                    end
                    ensureTracer()

                    local cam = workspace.CurrentCamera
                    local char = getSilentAimTarget()
                    local root = char and (char:FindFirstChild("HumanoidRootPart") or char.PrimaryPart)
                    if not (cam and root) then tracerLine.Visible = false return end

                    local sp = cam:WorldToViewportPoint(root.Position)
                    if sp.Z <= 0 then tracerLine.Visible = false return end

                    local from = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y)
                    local to = Vector2.new(sp.X, sp.Y)
                    local delta = to - from

                    tracerLine.Size = UDim2.fromOffset(delta.Magnitude, Settings.TracerThickness)
                    tracerLine.Position = UDim2.fromOffset((from.X + to.X) / 2, (from.Y + to.Y) / 2)
                    tracerLine.Rotation = math.deg(math.atan2(delta.Y, delta.X))
                    tracerLine.BackgroundColor3 = ColorMap[Settings.TracerColor] or ColorMap.Red
                    tracerLine.Visible = true
                end)
            end)

            -- ============================================================
            -- N3K0P01 HUB UI CONTROLS (Killer tab)
            -- ============================================================
            _G.SilentSpearAim = Settings
            _G.ToggleSilentSpearAim = function(on)
                Settings.Enabled = on and true or false
            end

            local priorityOptions = {
                "Nearest", "Furthest", "Injured", "Healed",
                "NearestInjured", "NearestHealed", "FurthestInjured", "FurthestHealed",
            }
            local colorOptions = {"Cyan", "Red", "Green", "Yellow", "Purple", "Orange", "Pink", "White", "Blue"}

            local veilSection = MakeSection(KillerTab, "Silent Veil Spear Aim")
            veilSection:AddToggle({
                Title = "Enable Silent Veil Aim",
                Content = "Arahkan lemparan spear Veil ke target dalam FOV (ballistic + prediksi).",
                Default = false,
                ConfigId = "N3K_VeilAimEnabled",
                Callback = function(v)
                    Settings.Enabled = v == true
                    VD_Notify("Silent Veil Aim", Settings.Enabled and "Enabled" or "Disabled", 2)
                end
            })
            veilSection:AddToggle({
                Title = "Show FOV Circle",
                Default = Settings.ShowFOV,
                ConfigId = "N3K_VeilShowFOV",
                Callback = function(v) Settings.ShowFOV = v == true end
            })
            veilSection:AddSlider({
                Title = "FOV Radius",
                Min = 30, Max = 600, Default = Settings.FOVRadius, Increment = 10,
                ConfigId = "N3K_VeilFOVRadius",
                Callback = function(v) Settings.FOVRadius = math.clamp(tonumber(v) or 240, 30, 600) end
            })
            veilSection:AddDropdown({
                Title = "Target Priority",
                Options = priorityOptions,
                Default = Settings.Priority,
                ConfigId = "N3K_VeilPriority",
                Callback = function(v) Settings.Priority = v or "Nearest" end
            })
            veilSection:AddDropdown({
                Title = "FOV Color",
                Options = colorOptions,
                Default = Settings.FOVColor,
                ConfigId = "N3K_VeilFOVColor",
                Callback = function(v) Settings.FOVColor = v or "Yellow" end
            })
            veilSection:AddToggle({
                Title = "Target Highlight",
                Default = Settings.TargetHighlightEnabled,
                ConfigId = "N3K_VeilHighlight",
                Callback = function(v) Settings.TargetHighlightEnabled = v == true end
            })
            veilSection:AddDropdown({
                Title = "Highlight Color",
                Options = colorOptions,
                Default = Settings.TargetHighlightColor,
                ConfigId = "N3K_VeilHighlightColor",
                Callback = function(v) Settings.TargetHighlightColor = v or "Red" end
            })
            veilSection:AddSlider({
                Title = "Vertical Aim Offset",
                Min = -3, Max = 3, Default = Settings.VerticalOffset, Increment = 0.1,
                ConfigId = "N3K_VeilVerticalOffset",
                Callback = function(v) Settings.VerticalOffset = math.clamp(tonumber(v) or -0.8, -3, 3) end
            })

            veilSection:AddToggle({
                Title = "Show Tracer Line",
                Content = "Garis dari bawah tengah layar ke target.",
                Default = false,
                ConfigId = "N3K_VeilTracer",
                Callback = function(v) Settings.TracerEnabled = v == true end
            })
            veilSection:AddDropdown({
                Title = "Tracer Color",
                Options = colorOptions,
                Default = Settings.TracerColor,
                ConfigId = "N3K_VeilTracerColor",
                Callback = function(v) Settings.TracerColor = v or "Red" end
            })
            veilSection:AddSlider({
                Title = "Tracer Thickness",
                Min = 1, Max = 6, Default = Settings.TracerThickness, Increment = 0.5,
                ConfigId = "N3K_VeilTracerThickness",
                Callback = function(v) Settings.TracerThickness = math.clamp(tonumber(v) or 1.5, 1, 6) end
            })

            veilSection:AddSlider({
                Title = "Lead Multiplier",
                Content = "Pengali prediksi gerakan. Naikin kalau tembakan ketinggalan di belakang target, turunin kalau kelewatan.",
                Min = 0, Max = 2, Default = 1, Increment = 0.05,
                ConfigId = "N3K_VeilLead",
                Callback = function(v) Settings.LeadMultiplier = math.clamp(tonumber(v) or 1, 0, 2) end
            })
            veilSection:AddSlider({
                Title = "Legit Spread (deg)",
                Content = "Sebaran acak kecil biar kelihatan lebih natural. 0 = 100% akurat.",
                Min = 0, Max = 5, Default = 0, Increment = 0.1,
                ConfigId = "N3K_VeilSpread",
                Callback = function(v) Settings.Spread = math.clamp(tonumber(v) or 0, 0, 5) end
            })

            print("[Silent Veil Spear] Loaded (script 2 logic).")
            end -- Silent Veil Spear Aim integration scope

            local autoParrySection = MakeSection(SurvivorTab, "Auto Parry")
            autoParrySection:AddToggle({
                Title = "Enable Auto Parry",
                Content = "Parry otomatis saat killer menyerang (LowerBodyStabilize nyala).",
                Default = false,
                ConfigId = "N3K_AutoParry",
                Callback = function(v)
                    if W.N3K0P01_AutoParry then W.N3K0P01_AutoParry.SetEnabled(v) end
                    VD_Notify("Auto Parry", v and "Enabled" or "Disabled", 2)
                end
            })
            autoParrySection:AddDropdown({
                Title = "Auto Parry Mode",
                Options = { "Killer Hit", "Range" },
                Default = "Killer Hit",
                ConfigId = "N3K_AutoParryMode",
                Callback = function(v)
                    local val = type(v) == "table" and v[1] or v
                    if W.N3K0P01_AutoParry then W.N3K0P01_AutoParry.SetMode(val) end
                end
            })
            autoParrySection:AddSlider({
                Title = "Range",
                Min = 3, Max = 60, Default = 11, Increment = 1, Suffix = " studs",
                ConfigId = "N3K_AutoParryRange",
                Callback = function(v)
                    if W.N3K0P01_AutoParry then W.N3K0P01_AutoParry.SetRange(v) end
                end
            })
            autoParrySection:AddToggle({
                Title = "Show Range",
                Content = "Tampilkan cincin range di sekitar karakter.",
                Default = false,
                ConfigId = "N3K_AutoParryShowRange",
                Callback = function(v)
                    if W.N3K0P01_AutoParry then W.N3K0P01_AutoParry.SetShowRange(v) end
                end
            })


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

            local skillSection = MakeSection(SurvivorTab, "Auto Skill Check")
            skillSection:AddToggle({ Title = "Auto Skill Check Generator", Default = false, Callback = function(v)
                W.SkillCheck_SetEnabled(v); if v then VD_Notify("Auto Skill Check Generator", "Enabled", 2) end end })
            skillSection:AddDropdown({ Title = "Generator Mode", Options = {"Legit", "Instant"}, Default = "Legit",
                Callback = function(v) W.SkillCheck.Mode = v end })
            skillSection:AddToggle({ Title = "Auto Skill Check Traps", Default = false, Callback = function(v)
                W.SkillCheckTrap_SetEnabled(v); if v then VD_Notify("Auto Skill Check Traps", "Enabled", 2) end end })
            skillSection:AddDropdown({ Title = "Trap Mode", Options = {"Legit", "Instant"}, Default = "Legit",
                Callback = function(v) W.SkillCheckTrap.Mode = v end })


            -- Always Fast Vault: source logic adapted from message (2).txt.
            -- Keep the original validation functions and only override their result while enabled.
            local AlwaysFastVaultEnabled = false
            local AlwaysFastVaultHooksInstalled = false
            local function InstallAlwaysFastVaultHooks()
                local rs = game:GetService("ReplicatedStorage")
                pcall(function()
                    local module = require(rs:WaitForChild("Modules"):WaitForChild("Survivors"):WaitForChild("SurvivorVault"))
                    if module and type(module.evaluate) == "function" and not module._n3k0p01FastVaultHooked then
                        module._n3k0p01OriginalEvaluate = module.evaluate
                        module.evaluate = function(self, ...)
                            if AlwaysFastVaultEnabled then
                                return true, "ready", 5
                            end
                            return module._n3k0p01OriginalEvaluate(self, ...)
                        end
                        module._n3k0p01FastVaultHooked = true
                    end
                end)
                pcall(function()
                    local module = require(rs:WaitForChild("Modules"):WaitForChild("Survivors"):WaitForChild("SurvivorAnimationsController"))
                    if module and type(module._validateFastVault) == "function" and not module._n3k0p01FastVaultHooked then
                        module._n3k0p01OriginalValidateFastVault = module._validateFastVault
                        module._validateFastVault = function(self, ...)
                            if AlwaysFastVaultEnabled then
                                return true, "ready", 5
                            end
                            return module._n3k0p01OriginalValidateFastVault(self, ...)
                        end
                        module._n3k0p01FastVaultHooked = true
                    end
                end)
                AlwaysFastVaultHooksInstalled = true
            end
            local function SetAlwaysFastVault(state)
                AlwaysFastVaultEnabled = state and true or false
                -- Retry while enabled in case the game's survivor modules load later.
                if AlwaysFastVaultEnabled then
                    task.spawn(function()
                        for _ = 1, 20 do
                            InstallAlwaysFastVaultHooks()
                            task.wait(0.25)
                        end
                    end)
                end
            end

            local AlwaysFastVaultSection = MakeSection(SurvivorTab, "Always Fast Vault")
            AlwaysFastVaultSection:AddToggle({
                Title = "Always Fast Vault",
                Content = "Mengaktifkan validasi fast vault selama fitur menyala",
                Default = false,
                Callback = function(state)
                    SetAlwaysFastVault(state)
                    VD_Notify("Always Fast Vault", state and "Enabled" or "Disabled", 2)
                end
            })

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

            -- Restored features migrated from N3K0P01 Hub, adapted to the N3K0P01 UI adapter.
            -- These implementations reuse the current script's existing player/parry/vault logic.

            VD.CrosshairEnabled = VD.CrosshairEnabled or false
            VD.CrosshairStyle = VD.CrosshairStyle or "Dot"
            VD.CrosshairSize = VD.CrosshairSize or 8
            VD.CrosshairThickness = VD.CrosshairThickness or 2
            VD.CrosshairColor = VD.CrosshairColor or Color3.fromRGB(255, 255, 255)
            VD.DashLockEnabled = VD.DashLockEnabled or false



            local crouchDodgeSection = MakeSection(SurvivorTab, "Auto Crouch Dodge")
            crouchDodgeSection:AddToggle({
                Title = "Auto Crouch Dodge",
                Content = "Crouch otomatis saat animasi dodge S1 terdeteksi dalam jarak 40 studs.",
                Default = VD.AutoCrouch == true,
                ConfigId = "AutoCrouchDodge",
                Callback = function(enabled)
                    VD.AutoCrouch = enabled == true
                    VD_Notify("Auto Crouch Dodge", VD.AutoCrouch and "Enabled" or "Disabled", 2)
                end
            })

            -- Custom crosshair overlay. Rebuilds only when the user changes a setting.
            local crosshairGui = nil
            local function DestroyCrosshair()
                if crosshairGui then pcall(function() crosshairGui:Destroy() end) end
                crosshairGui = nil
            end
            local function ApplyCrosshair()
                DestroyCrosshair()
                if not VD.CrosshairEnabled then return end
                local gui = Instance.new("ScreenGui")
                gui.Name = "N3K0P01_Crosshair"
                gui.IgnoreGuiInset = true
                gui.ResetOnSpawn = false
                gui.DisplayOrder = 998
                local parented = pcall(function() gui.Parent = CoreGui end)
                if not parented or not gui.Parent then
                    local playerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
                    if playerGui then gui.Parent = playerGui else gui:Destroy(); return end
                end
                crosshairGui = gui
                local color = VD.CrosshairColor
                local size = math.clamp(tonumber(VD.CrosshairSize) or 8, 2, 30)
                local thickness = math.clamp(tonumber(VD.CrosshairThickness) or 2, 1, 8)
                local offset = UDim2.new(0.5, 0, 0.5, 0)
                local function makePart(name, partSize, position)
                    local part = Instance.new("Frame")
                    part.Name = name
                    part.AnchorPoint = Vector2.new(0.5, 0.5)
                    part.Position = position or offset
                    part.Size = partSize
                    part.BackgroundColor3 = color
                    part.BorderSizePixel = 0
                    part.Parent = gui
                    return part
                end
                if VD.CrosshairStyle == "Plus" then
                    makePart("Horizontal", UDim2.fromOffset(size * 2, thickness), offset)
                    makePart("Vertical", UDim2.fromOffset(thickness, size * 2), offset)
                elseif VD.CrosshairStyle == "Circle" then
                    local ring = makePart("Ring", UDim2.fromOffset(size * 2, size * 2), offset)
                    ring.BackgroundTransparency = 1
                    local corner = Instance.new("UICorner")
                    corner.CornerRadius = UDim.new(1, 0)
                    corner.Parent = ring
                    local stroke = Instance.new("UIStroke")
                    stroke.Color = color
                    stroke.Thickness = thickness
                    stroke.Parent = ring
                else
                    local dot = makePart("Dot", UDim2.fromOffset(size, size), offset)
                    local corner = Instance.new("UICorner")
                    corner.CornerRadius = UDim.new(1, 0)
                    corner.Parent = dot
                end
            end
            local crosshairSection = MakeSection(VisualsTab, "Crosshair")
            crosshairSection:AddToggle({
                Title = "Enable Crosshair",
                Content = "Tampilkan crosshair sederhana di tengah layar.",
                Default = VD.CrosshairEnabled,
                ConfigId = "CrosshairEnabled",
                Callback = function(enabled)
                    VD.CrosshairEnabled = enabled == true
                    ApplyCrosshair()
                end
            })
            crosshairSection:AddDropdown({
                Title = "Style",
                Options = {"Dot", "Plus", "Circle"},
                Default = VD.CrosshairStyle,
                ConfigId = "CrosshairStyle",
                Callback = function(style)
                    VD.CrosshairStyle = tostring(style or "Dot")
                    ApplyCrosshair()
                end
            })
            crosshairSection:AddSlider({
                Title = "Size",
                Min = 2, Max = 30, Default = VD.CrosshairSize, Increment = 1,
                ConfigId = "CrosshairSize",
                Callback = function(value)
                    VD.CrosshairSize = value
                    ApplyCrosshair()
                end
            })
            crosshairSection:AddSlider({
                Title = "Thickness",
                Min = 1, Max = 8, Default = VD.CrosshairThickness, Increment = 1,
                ConfigId = "CrosshairThickness",
                Callback = function(value)
                    VD.CrosshairThickness = value
                    ApplyCrosshair()
                end
            })
            crosshairSection:AddColorPicker({
                Title = "Color",
                Default = VD.CrosshairColor,
                ConfigId = "CrosshairColor",
                Callback = function(color)
                    if typeof(color) == "Color3" then VD.CrosshairColor = color; ApplyCrosshair() end
                end
            })
            if VD.CrosshairEnabled then ApplyCrosshair() end

            local moonwalkSection = MakeSection(SurvivorTab, "Moonwalk")
            moonwalkSection:AddToggle({ Title = "Enable Moonwalk", Content = "PC key controls and mobile Forward/Back buttons.", Default = false, ConfigId = "N3K_Moonwalk", Callback = function(v) if W.N3K0P01_Moonwalk then W.N3K0P01_Moonwalk.SetEnabled(v == true) end; VD_Notify("Moonwalk", v and "Enabled" or "Disabled", 2) end })
            moonwalkSection:AddDropdown({ Title = "Moonwalk Mode", Options = {"Classic", "Sway"}, Default = "Classic", ConfigId = "N3K_MoonwalkMode", Callback = function(v) if W.N3K0P01_Moonwalk then W.N3K0P01_Moonwalk.Mode = v or "Classic" end end })
            moonwalkSection:AddDropdown({ Title = "PC Forward Key", Options = {"W", "Up", "E", "Q"}, Default = "W", ConfigId = "N3K_MoonwalkForwardKey", Callback = function(v) if W.N3K0P01_Moonwalk and Enum.KeyCode[tostring(v)] then W.N3K0P01_Moonwalk.ForwardKey = Enum.KeyCode[tostring(v)] end end })
            moonwalkSection:AddDropdown({ Title = "PC Backward Key", Options = {"S", "Down", "X", "Z"}, Default = "S", ConfigId = "N3K_MoonwalkBackwardKey", Callback = function(v) if W.N3K0P01_Moonwalk and Enum.KeyCode[tostring(v)] then W.N3K0P01_Moonwalk.BackwardKey = Enum.KeyCode[tostring(v)] end end })
            moonwalkSection:AddSlider({ Title = "Sway Width", Min = 0.1, Max = 1.5, Default = 0.55, Increment = 0.05, ConfigId = "N3K_MoonwalkSwayWidth", Callback = function(v) if W.N3K0P01_Moonwalk then W.N3K0P01_Moonwalk.SwayWidth = math.clamp(tonumber(v) or 0.55,0.1,1.5) end end })
            moonwalkSection:AddSlider({ Title = "Sway Speed", Min = 1, Max = 12, Default = 6, Increment = 0.5, ConfigId = "N3K_MoonwalkSwaySpeed", Callback = function(v) if W.N3K0P01_Moonwalk then W.N3K0P01_Moonwalk.SwaySpeed = math.clamp(tonumber(v) or 6,1,12) end end })


            -- Dash Lock module is also loaded only on demand; failures leave the toggle off.
            local dashLockModule = nil
            local function GetDashLockModule()
                if dashLockModule then return dashLockModule end
                if type(loadstring) ~= "function" then return nil, "loadstring tidak tersedia pada executor ini" end
                local ok, result = pcall(function()
                    local source = game:HttpGet("https://pastefy.app/Pu94U00g/raw")
                    local compile = loadstring(source)
                    assert(type(compile) == "function", "gagal compile Dash Lock")
                    return compile()
                end)
                if not ok or type(result) ~= "table" then
                    return nil, tostring(result or "module Dash Lock tidak valid")
                end
                dashLockModule = result
                return dashLockModule
            end
            local dashLockState = false
            local function SetDashLock(enabled)
                enabled = enabled == true
                if enabled == dashLockState then return end
                if enabled then
                    local module, err = GetDashLockModule()
                    if not module then
                        VD_Notify("Dash Lock", "Gagal memuat: " .. tostring(err), 4)
                        dashLockState = false
                        VD.DashLockEnabled = false
                        return
                    end
                    local ok = pcall(function()
                        assert(type(module.Enable) == "function", "module tidak memiliki Enable()")
                        module.Enable()
                    end)
                    if not ok then
                        VD_Notify("Dash Lock", "Module gagal diaktifkan.", 3)
                        VD.DashLockEnabled = false
                        dashLockState = false
                        return
                    end
                    dashLockState = true
                    VD.DashLockEnabled = true
                    VD_Notify("Dash Lock", "Enabled — klik kanan untuk lock", 3)
                else
                    if dashLockModule then
                        pcall(function() if type(dashLockModule.HideGUI) == "function" then dashLockModule.HideGUI() end end)
                        pcall(function() if type(dashLockModule.Disable) == "function" then dashLockModule.Disable() end end)
                    end
                    dashLockState = false
                    VD.DashLockEnabled = false
                    VD_Notify("Dash Lock", "Disabled", 2)
                end
            end
            local dashLockSection = MakeSection(KillerTab, "Dash Lock (Hidden)")
            dashLockSection:AddToggle({
                Title = "Dash Lock (Hidden)",
                Content = "Modul sumber memakai klik kanan untuk lock; hotkey toggle: V.",
                Default = VD.DashLockEnabled,
                ConfigId = "DashLockEnabled",
                Callback = SetDashLock
            })
            UserInputService.InputBegan:Connect(function(input, processed)
                if processed or UserInputService:GetFocusedTextBox() then return end
                if input.KeyCode == Enum.KeyCode.V then SetDashLock(not dashLockState) end
            end)

            -- Teleport Player dropdown refreshes when players join or leave.
            local selectedTeleportPlayer = nil
            local function GetTeleportPlayerNames()
                local names = {}
                for _, player in ipairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer then table.insert(names, player.Name) end
                end
                table.sort(names)
                if #names == 0 then names[1] = "None" end
                return names
            end
            local initialTeleportPlayerNames = GetTeleportPlayerNames()
            if initialTeleportPlayerNames[1] and initialTeleportPlayerNames[1] ~= "None" then
                selectedTeleportPlayer = initialTeleportPlayerNames[1]
            end
            local teleportPlayerSection = MakeSection(MiscTab, "Teleport Player")
            local teleportPlayerDropdown = teleportPlayerSection:AddDropdown({
                Title = "Select Player",
                Options = initialTeleportPlayerNames,
                Default = initialTeleportPlayerNames[1] or "None",
                ConfigId = "TeleportPlayerTarget",
                Callback = function(value)
                    selectedTeleportPlayer = (value and value ~= "None") and tostring(value) or nil
                end
            })
            local function RefreshTeleportPlayerList()
                local names = GetTeleportPlayerNames()
                local apiTable = getgenv().__N3K0P01_DropdownAPIs
                local api = apiTable and apiTable[teleportPlayerDropdown]
                if api and type(api.SetValues) == "function" then
                    local wanted = selectedTeleportPlayer
                    local found = false
                    for _, name in ipairs(names) do if name == wanted then found = true; break end end
                    local chosen = found and wanted or names[1]
                    api.SetValues(names, chosen, true)
                    selectedTeleportPlayer = (chosen and chosen ~= "None") and chosen or nil
                end
            end
            teleportPlayerSection:AddButton({
                Title = "Refresh Player List",
                Callback = function()
                    RefreshTeleportPlayerList()
                    VD_Notify("Teleport Player", "Player list refreshed", 2)
                end
            })
            teleportPlayerSection:AddButton({
                Title = "Teleport to Player",
                Callback = function()
                    local target = selectedTeleportPlayer and Players:FindFirstChild(selectedTeleportPlayer)
                    local myCharacter = LocalPlayer.Character
                    local myRoot = myCharacter and myCharacter:FindFirstChild("HumanoidRootPart")
                    local targetRoot = target and target.Character and target.Character:FindFirstChild("HumanoidRootPart")
                    if not myRoot or not targetRoot then
                        VD_Notify("Teleport Player", "Pilih player valid terlebih dahulu", 3)
                        return
                    end
                    local ok = pcall(function() myRoot.CFrame = targetRoot.CFrame + Vector3.new(0, 3, 0) end)
                    VD_Notify("Teleport Player", ok and ("Teleported to " .. target.Name) or "Teleport gagal", 2)
                end
            })
            Players.PlayerAdded:Connect(function() task.defer(RefreshTeleportPlayerList) end)
            Players.PlayerRemoving:Connect(function() task.defer(RefreshTeleportPlayerList) end)

            -- Teleport to Pumpkin (ported from the supplied source; only this feature's logic is included).
            local teleportPumpkinSection = MakeSection(MiscTab, "Teleport to Pumpkin")

            local function GetPumpkinTeleportTargets()
                local targets = {}
                local map = Workspace:FindFirstChild("Map")
                local pumpkinFolder = map and map:FindFirstChild("Pumpkins")

                if pumpkinFolder then
                    for _, obj in ipairs(pumpkinFolder:GetChildren()) do
                        if obj:IsA("BasePart") or obj:IsA("Model") then
                            table.insert(targets, obj)
                        end
                    end
                end

                -- Fallback for maps where pumpkin objects are not direct children of Map.Pumpkins.
                if #targets == 0 then
                    for _, obj in ipairs(Workspace:GetDescendants()) do
                        local lowerName = string.lower(obj.Name)
                        if lowerName ~= "pumpkins"
                            and string.find(lowerName, "pumpkin", 1, true)
                            and (obj:IsA("BasePart") or obj:IsA("Model")) then
                            table.insert(targets, obj)
                        end
                    end
                end

                return targets
            end

            local function TeleportToPumpkin(furthest)
                local character = LocalPlayer.Character
                local root = character and character:FindFirstChild("HumanoidRootPart")
                if not root then
                    VD_Notify("Teleport to Pumpkin", "Character root tidak ditemukan", 3)
                    return
                end

                local bestPart = nil
                local bestDistance = furthest and -1 or math.huge
                for _, target in ipairs(GetPumpkinTeleportTargets()) do
                    if target and target.Parent then
                        local part
                        if target:IsA("BasePart") then
                            part = target
                        elseif target:IsA("Model") then
                            part = target.PrimaryPart or target:FindFirstChildWhichIsA("BasePart", true)
                        end

                        if part then
                            local distance = (part.Position - root.Position).Magnitude
                            if (furthest and distance > bestDistance) or (not furthest and distance < bestDistance) then
                                bestDistance = distance
                                bestPart = part
                            end
                        end
                    end
                end

                if not bestPart then
                    VD_Notify("Teleport to Pumpkin", "Pumpkin tidak ditemukan di map", 3)
                    return
                end

                local ok = pcall(function()
                    root.CFrame = bestPart.CFrame + Vector3.new(0, 3, 0)
                end)
                if ok then
                    VD_Notify("Teleport to Pumpkin", furthest and "Berhasil teleport ke pumpkin terjauh" or "Berhasil teleport ke pumpkin terdekat", 2)
                else
                    VD_Notify("Teleport to Pumpkin", "Teleport gagal", 3)
                end
            end

            teleportPumpkinSection:AddButton({
                Title = "Teleport to Nearest Pumpkin",
                Callback = function() TeleportToPumpkin(false) end
            })
            teleportPumpkinSection:AddButton({
                Title = "Teleport to Furthest Pumpkin",
                Callback = function() TeleportToPumpkin(true) end
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

            local bypassGenSection = MakeSection(SurvivorTab, "Bypass Generator")
            bypassGenSection:AddToggle({
                Title = "Enable Bypass Generator",
                Content = "Otomatis repair di banyak point generator sekaligus saat kamu mulai repair.",
                Default = false,
                ConfigId = "N3K_GenBypass",
                Callback = function(v)
                    if W.N3K0P01_GenBypass then W.N3K0P01_GenBypass.setEnabled(v) end
                    VD_Notify("Bypass Generator", v and "Enabled" or "Disabled", 2)
                end
            })
            bypassGenSection:AddSlider({
                Title = "Delay Scale",
                Content = "Pengali semua jeda. Naikin kalau server sering nolak, turunin kalau mau lebih cepat.",
                Min = 0.5, Max = 3, Default = 1, Increment = 0.1,
                ConfigId = "N3K_GenBypassDelayScale",
                Callback = function(v) if W.N3K0P01_GenBypass then W.N3K0P01_GenBypass.setDelayScale(v) end end
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

            -- Requested additions, grouped under Survive.
            local fakePerksSection = MakeSection(SurvivorTab, "Fake Perks")
            fakePerksSection:AddToggle({ Title = "Quick Recovery", Content = "Fake perk recovery boost", Default = false, ConfigId = "N3KFakeQR", Callback = function(v)
                if _G.N3K0P01_FakePerks then _G.N3K0P01_FakePerks.SetQuickRecovery(v) end
            end })
            fakePerksSection:AddToggle({ Title = "Perfect Landing", Content = "Fake perk landing boost", Default = false, ConfigId = "N3KFakePL", Callback = function(v)
                if _G.N3K0P01_FakePerks then _G.N3K0P01_FakePerks.SetPerfectLanding(v) end
            end })
            fakePerksSection:AddToggle({ Title = "Flowstate", Content = "Fake Flowstate perk", Default = false, ConfigId = "N3KFakeFS", Callback = function(v)
                if _G.N3K0P01_FakePerks then _G.N3K0P01_FakePerks.SetFlowstate(v) end
            end })
            fakePerksSection:AddToggle({ Title = "Adrenaline Rush", Content = "Fake adrenaline speed boost", Default = false, ConfigId = "N3KFakeAR", Callback = function(v)
                if _G.N3K0P01_FakePerks then _G.N3K0P01_FakePerks.SetAdrenalineRush(v) end
            end })
            fakePerksSection:AddSlider({ Title = "Perk Cooldown", Min = 0, Max = 180, Default = 10, Increment = 1, Suffix = "s", Callback = function(v)
                if _G.N3K0P01_FakePerks then _G.N3K0P01_FakePerks.SetCooldown(v) end
            end })


            local fastBandageSection = MakeSection(SurvivorTab, "Fast Bandage")
            fastBandageSection:AddToggle({ Title = "Fast Bandage", Content = "Auto heal saat HP rendah dan percepat bandage manual", Default = false, ConfigId = "N3K_FB_Enabled", Callback = function(v)
                if _G.N3K0P01_FastBandage then
                    _G.N3K0P01_FastBandage.FB_SetEnabled(v)
                end
                VD_Notify("Fast Bandage", v and "Enabled" or "Disabled", 2)
            end })


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

            local tofSection = MakeSection(SurvivorTab, "Silent Aim TOF")
            tofSection:AddToggle({
                Title = "Enable Silent Aim TOF",
                Content = "Redirects Twist of Fate shots toward the killer.",
                Default = false, ConfigId = "TOF_Enabled",
                Callback = function(v)
                    if W.N3K0P01_TOF then W.N3K0P01_TOF.setEnabled(v) end
                    VD_Notify("Silent Aim TOF", v and "Enabled" or "Disabled", 2)
                end
            })
            tofSection:AddToggle({
                Title = "Show Laser",
                Content = "Laser from you to the killer. Hidden when blocked by a wall/part or when the killer is outside the radius.",
                Default = false, ConfigId = "TOF_ShowLaser",
                Callback = function(v) if W.N3K0P01_TOF then W.N3K0P01_TOF.setShowLaser(v) end end
            })
            tofSection:AddSlider({
                Title = "Silent Aim Radius", Min = 20, Max = 500, Default = 200, Increment = 5, Suffix = " studs",
                Content = "Silent aim and laser only work while the killer is inside this radius.",
                ConfigId = "TOF_Radius",
                Callback = function(v) if W.N3K0P01_TOF then W.N3K0P01_TOF.setRadius(v) end end
            })
            tofSection:AddToggle({
                Title = "Lead / Movement Prediction",
                Content = "Predicts where the killer will be when the shot lands.",
                Default = true, ConfigId = "TOF_Lead",
                Callback = function(v) if W.N3K0P01_TOF then W.N3K0P01_TOF.setLead(v) end end
            })

            tofSection:AddToggle({
                Title = "Debug Print",
                Content = "Print TOF remote arguments to the console. For troubleshooting only.",
                Default = false, Save = false,
                Callback = function(v) if W.N3K0P01_TOF then W.N3K0P01_TOF.setDebug(v) end end
            })

            local ESPBox = MakeSection(VisualsTab, "Full ESP System")
            ESPBox:AddToggle({ Title = "ESP Survivor", Default = false, Callback = function(v) FESP.Survivor = v end })
            ESPBox:AddColorPicker({ Title = "Survivor Color", Default = GetESPColor("Survivor"), Save = false, Callback = function(c) FESPC.Survivor = c end })
            ESPBox:AddToggle({ Title = "ESP Killer", Default = false, Callback = function(v) FESP.Killer = v end })
            ESPBox:AddColorPicker({ Title = "Killer Color", Default = FESPC.Killer, Save = false, Callback = function(c) FESPC.Killer = c end })
            ESPBox:AddToggle({ Title = "ESP Generator", Default = false, Callback = function(v) FESP.Generator = v end })
            ESPBox:AddColorPicker({ Title = "Generator Color", Default = FESPC.Generator, Save = false, Callback = function(c) FESPC.Generator = c end })
            ESPBox:AddToggle({ Title = "ESP Pumpkin", Default = false, Callback = function(v) FESP.Pumpkin = v end })
            ESPBox:AddColorPicker({ Title = "Pumpkin Color", Default = FESPC.Pumpkin, Save = false, Callback = function(c) FESPC.Pumpkin = c end })
            ESPBox:AddToggle({ Title = "ESP Pallet", Default = false, Callback = function(v) FESP.Pallet = v end })
            ESPBox:AddColorPicker({ Title = "Pallet Color", Default = FESPC.Pallet, Save = false, Callback = function(c) FESPC.Pallet = c end })
            ESPBox:AddToggle({ Title = "ESP Window", Default = false, Callback = function(v)
                FESP.Window = v
                if v then _G.GlutoWindowScanned = false
                else _G.GlutoWindowScanned = false end
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

            local counterParrySection = MakeSection(KillerTab, "Counter Auto Parry")
            local AntiAutoParryEnabled = false
            local CounterParryAnimList = {}
            for id, _ in pairs(KillerAttackAnimSet) do
                table.insert(CounterParryAnimList, id)
            end
            task.spawn(function()
                while true do
                    task.wait(0.5)
                    if not AntiAutoParryEnabled then continue end
                    local char = LocalPlayer.Character
                    if not char then continue end
                    local myRoot = char:FindFirstChild("HumanoidRootPart")
                    if not myRoot then continue end
                    local near = false
                    for _, p in pairs(Players:GetPlayers()) do
                        if p ~= LocalPlayer and p.Team and string.find(string.lower(p.Team.Name), "survivor", 1, true) then
                            local r = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
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
                            local track = animator:LoadAnimation(anim)
                            track:Play()
                            track:AdjustWeight(0)
                            task.wait(0.05)
                            track:Stop()
                            anim:Destroy()
                        end
                    end
                end
            end)
            counterParrySection:AddToggle({
                Title = "Counter Auto Parry",
                Content = "Spam animasi parry di dekat survivor — bikin mereka trigger auto parry sendiri",
                Default = false,
                Keybind = true,
                Callback = function(v)
                    AntiAutoParryEnabled = v
                    if v then VD_Notify("Counter Auto Parry", "Enabled", 2) end
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

            -- Removed by request: Killer Perks Display

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


            local settingsSection = MakeSection(MiscTab, "Settings")
            settingsSection:AddToggle({ Title = "Enable Notifications", Default = true, Callback = function(v)
                W.NotifyEnabled = v
                if v then ForceNotify("Settings", "Notifications Enabled") end
            end })

            settingsSection:AddButton({ Title = "Unload Script", Callback = function()
                if _G.N3K0P01_UI then _G.N3K0P01_UI:Unload() end
            end })

            local stunSection = MakeSection(MiscTab, "Stun Indicator")
            stunSection:AddToggle({ Title = "Enable Stun Indicator", Default = false, Callback = function(v)
                W.SInd_SetEnabled(v); if v then VD_Notify("Stun Indicator", "Enabled", 2) end end })
            stunSection:AddDropdown({ Title = "Stun Sound",
                Options = { "an anime", "Default", "Clash Royale", "Blash", "antek asing", "hidup Jokowi", "Kururin Kuru", "Spongebob", "Fahhhh", "Aughhh", "iPhone", "Siren" },
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


            local camDBDSection = MakeSection(MiscTab, "Camera DBD")
            camDBDSection:AddToggle({ Title = "DBD Camera", Default = false, Callback = function(v)
                W.CamDBD_SetSmooth(v); VD_Notify("Camera DBD", v and "ON" or "OFF", 2) end })
            camDBDSection:AddSlider({ Title = "Distance", Min = 1, Max = 60, Default = 25, Increment = 1, Callback = function(v) W.CamDBD_SetDistance(v) end })
            camDBDSection:AddSlider({ Title = "FOV", Min = 50, Max = 120, Default = 120, Increment = 1, Suffix = "°", Callback = function(v) W.CamDBD_SetFOV(v) end })
            camDBDSection:AddSlider({ Title = "Height", Min = -5, Max = 10, Default = 0, Increment = 0.5, Callback = function(v) W.CamDBD_SetHeight(v) end })
            camDBDSection:AddToggle({ Title = "Use Character Scale", Default = true, Callback = function(v) W.CamDBD_SetUseCharScale(v) end })
            camDBDSection:AddSlider({ Title = "Character Scale", Min = 0.01, Max = 1, Default = 0.05, Increment = 0.01, Callback = function(v) W.CamDBD_SetCharScale(v) end })

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
                Content = "Auto-apply WalkSpeed, disabled saat stun/parry/downed",
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

            local Fake8BitSection = MakeSection(MiscTab, "Fake 8-Bit")
            local Fake8BitAssets = {
                ["8-Bit Royal Crown"] = 10159600649,
                ["8-Bit HP Bar"] = 10159610478,
                ["8-Bit Extra Life"] = 10159606132,
                ["8-Bit Tabby Cat"] = 10159617728,
                ["8-Bit Roblox Coin"] = 10159622004,
                ["8-Bit Throwing Barrel"] = 31839260,
            }
            local Fake8BitEnabled = {}
            local Fake8BitObjects = {}

            local function Fake8Bit_Clear(name)
                local character = LocalPlayer.Character
                if character then
                    for _, obj in ipairs(character:GetChildren()) do
                        if obj:GetAttribute("N3K0P01_Fake8Bit") and obj:GetAttribute("N3K0P01_Fake8BitName") == name then
                            pcall(function() obj:Destroy() end)
                        end
                    end
                end
                local list = Fake8BitObjects[name]
                if list then
                    for _, obj in ipairs(list) do
                        pcall(function()
                            if obj and obj.Parent then obj:Destroy() end
                        end)
                    end
                end
                Fake8BitObjects[name] = nil
            end

            local function Fake8Bit_GetContainer(assetId)
                local ok, result = pcall(function()
                    return game:GetObjects("rbxassetid://" .. tostring(assetId))
                end)
                if ok and type(result) == "table" and #result > 0 then
                    return result
                end
                return nil
            end

            local function Fake8Bit_Apply(name)
                Fake8Bit_Clear(name)
                local assetId = Fake8BitAssets[name]
                local character = LocalPlayer.Character
                if not character or not assetId then return false end

                local loaded = Fake8Bit_GetContainer(assetId)
                if not loaded then
                    VD_Notify("Fake 8-Bit", name .. " gagal dimuat", 3)
                    return false
                end

                local attached = {}

                local function attachAccessory(accessory)
                    local handle = accessory:FindFirstChild("Handle")
                    if not handle or not handle:IsA("BasePart") then
                        return false
                    end

                    local clone = accessory:Clone()
                    local cloneHandle = clone:FindFirstChild("Handle")
                    if not cloneHandle or not cloneHandle:IsA("BasePart") then
                        pcall(function() clone:Destroy() end)
                        return false
                    end

                    clone:SetAttribute("N3K0P01_Fake8Bit", true)
                    clone:SetAttribute("N3K0P01_Fake8BitName", name)
                    cloneHandle.CanCollide = false
                    cloneHandle.CanTouch = false
                    cloneHandle.CanQuery = false
                    cloneHandle.Massless = true

                    local accAttachment = nil
                    for _, obj in ipairs(cloneHandle:GetChildren()) do
                        if obj:IsA("Attachment") then
                            accAttachment = obj
                            break
                        end
                    end

                    local targetAttachment = nil
                    if accAttachment then

                        for _, obj in ipairs(character:GetDescendants()) do
                            if obj:IsA("Attachment") and obj.Name == accAttachment.Name then
                                targetAttachment = obj
                                break
                            end
                        end
                    end

                    if not targetAttachment then
                        local fallbackPart
                        if name == "8-Bit Tabby Cat" then
                            fallbackPart = character:FindFirstChild("UpperTorso")
                                or character:FindFirstChild("Torso")
                        elseif name == "8-Bit Throwing Barrel" then
                            fallbackPart = character:FindFirstChild("LowerTorso")
                                or character:FindFirstChild("Torso")
                        else
                            fallbackPart = character:FindFirstChild("Head")
                        end
                        if fallbackPart then
                            targetAttachment = fallbackPart:FindFirstChildWhichIsA("Attachment")
                        end
                    end

                    clone.Parent = character

                    if targetAttachment and accAttachment then

                        cloneHandle.CFrame = targetAttachment.WorldCFrame * accAttachment.CFrame:Inverse()
                    else
                        local fallbackPart = character:FindFirstChild("Head")
                            or character:FindFirstChild("UpperTorso")
                            or character:FindFirstChild("Torso")
                        if not fallbackPart then
                            clone:Destroy()
                            return false
                        end
                        cloneHandle.CFrame = fallbackPart.CFrame
                    end

                    local weld = Instance.new("WeldConstraint")
                    weld.Name = "N3K0P01_Fake8BitWeld"
                    weld.Part0 = cloneHandle
                    weld.Part1 = (targetAttachment and targetAttachment.Parent and targetAttachment.Parent:IsA("BasePart"))
                        and targetAttachment.Parent
                        or (character:FindFirstChild("Head") or character:FindFirstChild("UpperTorso") or character:FindFirstChild("Torso"))
                    weld.Parent = cloneHandle

                    table.insert(attached, clone)
                    return true
                end

                for _, root in ipairs(loaded) do
                    local candidates = {}
                    if root:IsA("Accessory") then
                        table.insert(candidates, root)
                    else
                        for _, obj in ipairs(root:GetDescendants()) do
                            if obj:IsA("Accessory") then
                                table.insert(candidates, obj)
                            end
                        end
                    end

                    for _, accessory in ipairs(candidates) do
                        attachAccessory(accessory)
                    end
                    pcall(function() root:Destroy() end)
                end

                if #attached == 0 then
                    VD_Notify("Fake 8-Bit", name .. " gagal dipasang", 3)
                    return false
                end

                Fake8BitObjects[name] = attached
                return true
            end

            local function Fake8Bit_SetEnabled(name, enabled)
                Fake8BitEnabled[name] = enabled == true
                if Fake8BitEnabled[name] then
                    if Fake8Bit_Apply(name) then
                        VD_Notify("Fake 8-Bit", name .. " ON", 2)
                    else
                        Fake8BitEnabled[name] = false
                    end
                else
                    Fake8Bit_Clear(name)
                    VD_Notify("Fake 8-Bit", name .. " OFF", 2)
                end
            end

            LocalPlayer.CharacterAdded:Connect(function()
                task.wait(1)
                for name, enabled in pairs(Fake8BitEnabled) do
                    if enabled then
                        Fake8Bit_Apply(name)
                    end
                end
            end)

            for name, _ in pairs(Fake8BitAssets) do
                Fake8BitSection:AddToggle({
                    Title = name,
                    Content = "Fake accessory • Asset ID: " .. tostring(Fake8BitAssets[name]),
                    Default = false,
                    Callback = function(v)
                        Fake8Bit_SetEnabled(name, v)
                    end
                })
            end

            local FakeLimitedHornsSection = MakeSection(MiscTab, "Fake Limited Horns")
            local FakeLimitedHorns = {
                ["Poisoned Horns of the Toxic Wasteland"] = {
                    AssetId = 1744060292,
                    MeshId = "215680403",
                    TextureId = "1744057070",
                },
                ["Fiery Horns of the Netherworld"] = {
                    AssetId = 215718515,
                    MeshId = "215680403",
                    TextureId = "215676264",
                },
                ["Frozen Horns of the Frozen Tundra"] = {

                    MeshId = "215680403",
                    TextureId = "658646189",
                },
            }
            local FakeLimitedHornsEnabled = {}
            local FakeLimitedHornObjects = {}

            local function FakeLimitedHorns_Clear(name)
                local character = LocalPlayer.Character
                if character then
                    for _, obj in ipairs(character:GetChildren()) do
                        if obj:GetAttribute("N3K0P01_FakeLimitedHorn")
                            and obj:GetAttribute("N3K0P01_FakeLimitedHornName") == name then
                            pcall(function() obj:Destroy() end)
                        end
                    end
                end
                local list = FakeLimitedHornObjects[name]
                if list then
                    for _, obj in ipairs(list) do
                        pcall(function()
                            if obj and obj.Parent then obj:Destroy() end
                        end)
                    end
                end
                FakeLimitedHornObjects[name] = nil
            end

            local function FakeLimitedHorns_GetContainer(assetId)
                if not assetId then return nil end
                local ok, result = pcall(function()
                    return game:GetObjects("rbxassetid://" .. tostring(assetId))
                end)
                if ok and type(result) == "table" and #result > 0 then
                    return result
                end
                return nil
            end

            local function FakeLimitedHorns_Apply(name)
                FakeLimitedHorns_Clear(name)
                local data = FakeLimitedHorns[name]
                local character = LocalPlayer.Character
                if not data or not character then return false end

                local attached = {}

                local function attachAccessory(sourceAccessory)
                    local sourceHandle = sourceAccessory:FindFirstChild("Handle")
                    if not sourceHandle or not sourceHandle:IsA("BasePart") then
                        return false
                    end

                    local clone = sourceAccessory:Clone()
                    local handle = clone:FindFirstChild("Handle")
                    if not handle or not handle:IsA("BasePart") then
                        pcall(function() clone:Destroy() end)
                        return false
                    end

                    clone.Name = "N3K0P01_FakeLimitedHorn"
                    clone:SetAttribute("N3K0P01_FakeLimitedHorn", true)
                    clone:SetAttribute("N3K0P01_FakeLimitedHornName", name)
                    handle.CanCollide = false
                    handle.CanTouch = false
                    handle.CanQuery = false
                    handle.Massless = true

                    local accAttachment = nil
                    for _, obj in ipairs(handle:GetChildren()) do
                        if obj:IsA("Attachment") then
                            accAttachment = obj
                            break
                        end
                    end

                    local targetAttachment = nil
                    if accAttachment then
                        for _, obj in ipairs(character:GetDescendants()) do
                            if obj:IsA("Attachment") and obj.Name == accAttachment.Name then
                                targetAttachment = obj
                                break
                            end
                        end
                    end

                    clone.Parent = character

                    local head = character:FindFirstChild("Head")
                    if targetAttachment and accAttachment and targetAttachment.Parent:IsA("BasePart") then
                        handle.CFrame = targetAttachment.WorldCFrame * accAttachment.CFrame:Inverse()
                    elseif head then
                        handle.CFrame = head.CFrame * CFrame.new(0, 0.65, 0)
                    else
                        pcall(function() clone:Destroy() end)
                        return false
                    end

                    local weld = Instance.new("WeldConstraint")
                    weld.Name = "N3K0P01_FakeLimitedHornWeld"
                    weld.Part0 = handle
                    weld.Part1 = (targetAttachment and targetAttachment.Parent:IsA("BasePart"))
                        and targetAttachment.Parent
                        or head
                    weld.Parent = handle

                    table.insert(attached, clone)
                    return true
                end

                local loaded = FakeLimitedHorns_GetContainer(data.AssetId)
                if loaded then
                    for _, root in ipairs(loaded) do
                        local candidates = {}
                        if root:IsA("Accessory") then
                            table.insert(candidates, root)
                        else
                            for _, obj in ipairs(root:GetDescendants()) do
                                if obj:IsA("Accessory") then
                                    table.insert(candidates, obj)
                                end
                            end
                        end
                        for _, accessory in ipairs(candidates) do
                            attachAccessory(accessory)
                        end
                        pcall(function() root:Destroy() end)
                    end
                end

                if #attached == 0 and data.MeshId and data.TextureId then
                    local head = character:FindFirstChild("Head")
                    if head then
                        local accessory = Instance.new("Accessory")
                        accessory.Name = "N3K0P01_FakeLimitedHorn"
                        accessory:SetAttribute("N3K0P01_FakeLimitedHorn", true)
                        accessory:SetAttribute("N3K0P01_FakeLimitedHornName", name)

                        local handle = Instance.new("Part")
                        handle.Name = "Handle"
                        handle.Size = Vector3.new(1, 1, 1)
                        handle.Transparency = 1
                        handle.CanCollide = false
                        handle.CanTouch = false
                        handle.CanQuery = false
                        handle.Massless = true
                        handle.CastShadow = false
                        handle.Parent = accessory

                        local mesh = Instance.new("SpecialMesh")
                        mesh.MeshType = Enum.MeshType.FileMesh
                        mesh.MeshId = "rbxassetid://" .. data.MeshId
                        mesh.TextureId = "rbxassetid://" .. data.TextureId
                        mesh.Parent = handle

                        accessory.Parent = character
                        handle.CFrame = head.CFrame * CFrame.new(0, 0.65, 0)

                        local weld = Instance.new("WeldConstraint")
                        weld.Name = "N3K0P01_FakeLimitedHornWeld"
                        weld.Part0 = handle
                        weld.Part1 = head
                        weld.Parent = handle

                        table.insert(attached, accessory)
                    end
                end

                if #attached == 0 then
                    VD_Notify("Fake Limited Horns", name .. " gagal dimuat/dipasang", 3)
                    return false
                end

                FakeLimitedHornObjects[name] = attached
                return true
            end

            local function FakeLimitedHorns_SetEnabled(name, enabled)
                if enabled then

                    for otherName, otherEnabled in pairs(FakeLimitedHornsEnabled) do
                        if otherEnabled and otherName ~= name then
                            FakeLimitedHornsEnabled[otherName] = false
                            FakeLimitedHorns_Clear(otherName)
                        end
                    end

                    if FakeLimitedHorns_Apply(name) then
                        FakeLimitedHornsEnabled[name] = true
                        VD_Notify("Fake Limited Horns", name .. " ON", 2)
                    else
                        FakeLimitedHornsEnabled[name] = false
                    end
                else
                    FakeLimitedHornsEnabled[name] = false
                    FakeLimitedHorns_Clear(name)
                    VD_Notify("Fake Limited Horns", name .. " OFF", 2)
                end
            end

            LocalPlayer.CharacterAdded:Connect(function()
                task.wait(1)
                for name, enabled in pairs(FakeLimitedHornsEnabled) do
                    if enabled then
                        FakeLimitedHorns_Apply(name)
                    end
                end
            end)

            for name, data in pairs(FakeLimitedHorns) do
                local desc = data.AssetId
                    and ("Local visual • Asset ID: " .. tostring(data.AssetId))
                    or "Local visual • Mesh/Texture"
                FakeLimitedHornsSection:AddToggle({
                    Title = name,
                    Content = desc,
                    Default = false,
                    Callback = function(v)
                        FakeLimitedHorns_SetEnabled(name, v)
                    end
                })
            end

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
            local HeaderText = "N3K0P01 HUB"
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
                textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                textLabel.Text = HeaderText; textLabel.ZIndex = 1; textLabel.Parent = billboard
                HeaderState.TextLabel = textLabel
                local shineLabel = Instance.new("TextLabel")
                shineLabel.Name = "ShineText"; shineLabel.Size = UDim2.new(1, 0, 1, 0)
                shineLabel.BackgroundTransparency = 1; shineLabel.TextScaled = true
                shineLabel.Font = Enum.Font.GothamBold; shineLabel.TextStrokeTransparency = 1
                shineLabel.Text = HeaderText; shineLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
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
                HeaderText = text or "N3K0P01 HUB"
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
            HeaderSection:AddInput({ Title = "Header Text", Default = "N3K0P01 HUB", Placeholder = "Nama header lu...",
                Callback = function(input) Header_UpdateText(input) end })
            HeaderSection:AddToggle({ Title = "Enable Header Title", Default = false, Callback = function(v)
                HeaderEnabled = v; Header_Toggle(v) end })
            HeaderSection:AddColorPicker({ Title = "Header Color", Default = Color3.fromRGB(255, 255, 255), Save = false,
                Callback = function(c)
                    if HeaderState.TextLabel then HeaderState.TextLabel.TextColor3 = c end
                    if HeaderState.ShineLabel then HeaderState.ShineLabel.TextColor3 = Color3.fromRGB(255, 255, 255) end
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
                SpecGui = Instance.new("ScreenGui")
                SpecGui.Name = "GlutoSpectatorCounter"
                SpecGui.ResetOnSpawn = false; SpecGui.IgnoreGuiInset = true
                SpecGui.Parent = CoreGui
                local mainFrame = Instance.new("Frame", SpecGui)
                mainFrame.Name = "MainBox"
                mainFrame.AnchorPoint = Vector2.new(0.5, 0)
                mainFrame.Position = UDim2.new(0.5, 0, 0.42, 0)
                mainFrame.Size = UDim2.new(0, 145, 0, 52)
                mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
                mainFrame.BackgroundTransparency = 0.1
                mainFrame.BorderSizePixel = 0; mainFrame.Active = true
                Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 6)
                local topBar = Instance.new("Frame", mainFrame)
                topBar.Name = "TopBar"; topBar.Size = UDim2.new(1, 0, 0, 4)
                topBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255); topBar.BorderSizePixel = 0
                Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 6)
                local header = Instance.new("Frame", mainFrame)
                header.Name = "Header"; header.Size = UDim2.new(1, 0, 0, 18)
                header.Position = UDim2.new(0, 0, 0, 4)
                header.BackgroundTransparency = 1; header.Active = true
                local title = Instance.new("TextLabel", header)
                title.Name = "Title"; title.Size = UDim2.new(1, -20, 1, 0)
                title.BackgroundTransparency = 1; title.Font = Enum.Font.GothamBold
                title.Text = "Spectators"; title.TextColor3 = Color3.fromRGB(255, 255, 255)
                title.TextSize = 10; title.TextXAlignment = Enum.TextXAlignment.Center
                local minBtn = Instance.new("TextButton", header)
                minBtn.Name = "MinBtn"; minBtn.Size = UDim2.new(0, 18, 0, 18)
                minBtn.Position = UDim2.new(1, -19, 0, 0)
                minBtn.BackgroundTransparency = 1; minBtn.Text = "−"
                minBtn.TextColor3 = Color3.fromRGB(255, 255, 255); minBtn.Font = Enum.Font.GothamBold
                minBtn.TextSize = 13; minBtn.AutoButtonColor = false
                local divider = Instance.new("Frame", mainFrame)
                divider.Name = "Divider"; divider.Size = UDim2.new(1, -12, 0, 1)
                divider.Position = UDim2.new(0, 6, 0, 23)
                divider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
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
                eye.ImageColor3 = Color3.fromRGB(255, 255, 255); eye.LayoutOrder = 1
                SpecLabel = Instance.new("TextLabel", body)
                SpecLabel.Name = "CountLabel"; SpecLabel.BackgroundTransparency = 1
                SpecLabel.Font = Enum.Font.GothamMedium; SpecLabel.Text = "No spectators"
                SpecLabel.TextColor3 = Color3.fromRGB(220, 220, 220); SpecLabel.TextSize = 10
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
                    SpecLabel.Text = "No spectators"; SpecLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
                else
                    SpecLabel.Text = count .. " spectators"; SpecLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
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

            local cfgSection = MakeSection(ConfigTab, "Config Manager")
            local currentName = ""
            local selectedConfig = nil
            local configList = nil
            local function ConfigFolderPath() return "N3K0P01/Config" end
            local function EnsureConfigFolder()
                if isfolder and makefolder then
                    if not isfolder("N3K0P01") then makefolder("N3K0P01") end
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
                local dropdownApis = getgenv().__N3K0P01_DropdownAPIs
                local api = dropdownApis and configList and dropdownApis[configList]
                if api and api.SetValues then api.SetValues(list, selectedConfig, true) end
                return list
            end
            cfgSection:AddInput({ Title = "Config Name", Placeholder = "MyConfig", Save = false, Callback = function(text) currentName = text end })
            configList = cfgSection:AddDropdown({ Title = "Saved Configs", Multi = false, Options = {}, Save = false, Callback = function(v) selectedConfig = v end })

            local function FindConfigControl(key, meta)
                key = tostring(key or "")
                local registry = getgenv().__N3K0P01_ConfigElements or getgenv().Elements or Elements
                if type(registry) ~= "table" then return nil end

                if key ~= "" and registry[key] then return registry[key] end

                local stableId = type(meta) == "table" and tostring(meta.StableId or "") or ""
                local configId = type(meta) == "table" and tostring(meta.ConfigId or "") or ""
                local title = type(meta) == "table" and tostring(meta.Title or "") or ""
                local section = type(meta) == "table" and tostring(meta.Section or "") or ""
                local page = type(meta) == "table" and tostring(meta.Page or "") or ""

                local found, matches = nil, 0
                for ek, ec in pairs(registry) do
                    if type(ec) == "table" then
                        local hit = false
                        if stableId ~= "" and tostring(ec.StableId or "") == stableId then
                            hit = true
                        elseif configId ~= "" and tostring(ec.ConfigId or "") == configId then

                            hit = (section == "" or tostring(ec.Section or "") == section)
                                and (page == "" or tostring(ec.Page or "") == page)
                        elseif title ~= "" and tostring(ec.Title or "") == title then
                            hit = (section == "" or tostring(ec.Section or "") == section)
                                and (page == "" or tostring(ec.Page or "") == page)
                        end
                        if hit then
                            found = ec
                            matches = matches + 1
                        end
                    end
                end
                if matches == 1 then return found end

                if key ~= "" then
                    found, matches = nil, 0
                    local shortKey = key:match("::([^:]+)$") or key
                    for ek, ec in pairs(registry) do
                        local short = tostring(ek):match("::([^:]+)$")
                        if short == shortKey then
                            found = ec
                            matches = matches + 1
                        end
                    end
                    if matches == 1 then return found end
                end

                if title == "" then title = key end
                found, matches = nil, 0
                for _, ec in pairs(registry) do
                    if type(ec) == "table" and tostring(ec.Title or "") == title then
                        found = ec
                        matches = matches + 1
                        if matches > 1 then return nil end
                    end
                end
                return matches == 1 and found or nil
            end

            local function UnpackConfigValue(value)
                if ConfigData and type(ConfigData.__UnpackConfigValue) == "function" then
                    local ok, unpacked = pcall(ConfigData.__UnpackConfigValue, value)
                    if ok and unpacked ~= nil then return unpacked end
                end
                return value
            end

            local function ApplyOneConfigValue(key, rawValue, meta)
                local control = FindConfigControl(key, meta)
                if not control or type(control.Set) ~= "function" then
                    return false
                end

                local value = UnpackConfigValue(rawValue)
                local lastErr

                for attempt = 1, 3 do
                    local okSet, err = pcall(function()

                        control.Set(value, false)
                    end)
                    if okSet then
                        local verified = true
                        if type(control.Get) == "function" then
                            local okGet, current = pcall(control.Get)
                            if okGet then
                                if type(value) == "boolean" then
                                    verified = current == value
                                elseif type(value) == "number" then
                                    verified = tonumber(current) ~= nil and math.abs(tonumber(current) - value) < 0.000001
                                elseif type(value) == "string" then
                                    verified = tostring(current) == value
                                elseif typeof(value) == "Color3" then
                                    verified = typeof(current) == "Color3"
                                        and math.abs(current.R - value.R) < 0.001
                                        and math.abs(current.G - value.G) < 0.001
                                        and math.abs(current.B - value.B) < 0.001
                                elseif typeof(value) == "EnumItem" then
                                    verified = tostring(current) == tostring(value)
                                end
                            end
                        end
                        if verified then
                            if ConfigData then ConfigData[key] = value end
                            return true
                        end
                    else
                        lastErr = err
                    end
                    task.wait(0.03)
                end

                if lastErr then
                    warn("[N3K0P01 Config] Apply failed:", tostring(key), tostring(lastErr))
                else
                    warn("[N3K0P01 Config] Apply could not verify:", tostring(key))
                end
                return false
            end

            local function ApplyConfigSnapshot(snapshot)
                if type(snapshot) ~= "table" then return false, 0, 0 end

                local entries = {}
                local metaByKey = {}
                if type(snapshot.__n3k_controls) == "table" then
                    for _, meta in ipairs(snapshot.__n3k_controls) do
                        if type(meta) == "table" and meta.Key then
                            metaByKey[tostring(meta.Key)] = meta
                        end
                    end
                end

                for k, v in pairs(snapshot) do
                    if k ~= "_version" and k ~= "_timestamp" and k ~= "_name"
                        and k ~= "__n3k_controls" then
                        entries[#entries + 1] = {
                            key = tostring(k),
                            value = v,
                            meta = metaByKey[tostring(k)],
                        }
                    end
                end

                table.sort(entries, function(a, b)
                    local av = type(a.value) == "boolean" and 0 or 1
                    local bv = type(b.value) == "boolean" and 0 or 1
                    if av ~= bv then return av < bv end
                    return tostring(a.key) < tostring(b.key)
                end)

                local applied, failed = 0, 0
                for _, entry in ipairs(entries) do
                    if ApplyOneConfigValue(entry.key, entry.value, entry.meta) then
                        applied = applied + 1
                    else
                        failed = failed + 1
                    end
                end

                for pass = 1, 8 do
                    task.wait(0.15)
                    for _, entry in ipairs(entries) do
                        if type(entry.value) == "boolean" then
                            ApplyOneConfigValue(entry.key, entry.value, entry.meta)
                        end
                    end
                end

                return true, applied, failed
            end

            local function SaveConfigByName(name)
                name = tostring(name or "")
                name = name:gsub("[\\/:*?\"<>|]", "_")
                name = name:gsub("^%s+", ""):gsub("%s+$", "")
                if name == "" then
                    return false, "Isi nama config dulu!"
                end
                if not writefile or not HttpService then
                    return false, "Executor gak support file config"
                end

                EnsureConfigFolder()
                local snapshot = GetConfigSnapshot and GetConfigSnapshot() or (ConfigData or {})
                snapshot._version = 5
                snapshot._timestamp = os.time()
                snapshot._name = name
                local okEnc, encoded = pcall(function() return HttpService:JSONEncode(snapshot) end)
                if not okEnc or not encoded then
                    return false, "Gagal encode config"
                end

                local path = ConfigFolderPath() .. "/" .. name .. ".json"
                local okW, errW = pcall(writefile, path, encoded)
                if not okW then
                    return false, "Gagal save config"
                end

                currentName = name
                selectedConfig = name
                return true, path
            end

            local function LoadConfigByName(name, notify)
                name = tostring(name or "")
                if name == "" then
                    return false, "Pilih config dulu!", 0
                end
                if not readfile or not isfile or not HttpService then
                    return false, "Executor gak support file config", 0
                end

                EnsureConfigFolder()
                local path = ConfigFolderPath() .. "/" .. name .. ".json"
                if not isfile(path) then
                    return false, "Config gak ketemu: " .. name, 0
                end

                local okR, raw = pcall(readfile, path)
                if not okR or type(raw) ~= "string" or raw == "" then
                    return false, "Gagal baca config", 0
                end

                local okD, snapshot = pcall(function() return HttpService:JSONDecode(raw) end)
                if not okD or type(snapshot) ~= "table" then
                    return false, "File config corrupt", 0
                end

                local okApply, applied, failed = ApplyConfigSnapshot(snapshot)
                if not okApply then
                    return false, "Gagal menerapkan config", 0
                end

                currentName = name
                selectedConfig = name
                if SetActiveConfig then
                    pcall(SetActiveConfig, name, path, AutoSaveEnabled ~= false, "file")
                end

                if notify ~= false then
                    local msg = "Loaded: " .. name .. " (" .. tostring(applied) .. " setting"
                    if failed and failed > 0 then msg = msg .. ", " .. tostring(failed) .. " gagal" end
                    msg = msg .. ")"
                    ForceNotify("Config", msg, failed and failed > 0 and 4 or 3)
                end
                return true, path, applied, failed
            end

            local AutoLoadEnabled = true
            local AutoLoadName = nil
            local function ReadAutoLoadSettings()
                if not readfile or not isfile or not HttpService then return end
                local path = ConfigFolderPath() .. "/_autoload.json"
                if not isfile(path) then return end
                local okR, raw = pcall(readfile, path)
                if not okR or type(raw) ~= "string" or raw == "" then return end
                local okD, data = pcall(function() return HttpService:JSONDecode(raw) end)
                if not okD or type(data) ~= "table" then return end
                AutoLoadName = tostring(data.Name or "")
                if data.Enabled ~= nil then AutoLoadEnabled = data.Enabled == true end
            end
            ReadAutoLoadSettings()

            RefreshConfigList()

            cfgSection:AddButton({
                Title = "Save",
                Callback = function()
                    local okS, result = SaveConfigByName(currentName)
                    if not okS then
                        ForceNotify("Config", result, 2)
                        return
                    end

                    if AutoLoadEnabled ~= false and writefile and HttpService then
                        AutoLoadName = selectedConfig
                        AutoLoadEnabled = true
                        pcall(writefile, ConfigFolderPath() .. "/_autoload.json", HttpService:JSONEncode({
                            Name = selectedConfig,
                            Enabled = true,
                        }))
                    end
                    ForceNotify("Config", "Saved: " .. selectedConfig, 3)
                    RefreshConfigList()
                end
            })

            cfgSection:AddButton({
                Title = "Load",
                Callback = function()
                    local name = selectedConfig or currentName
                    local okL, result = LoadConfigByName(name, true)
                    if not okL then
                        ForceNotify("Config", result, 2)
                    end
                end
            })

            cfgSection:AddButton({ Title = "Delete", SubTitle = "Refresh List",
                Callback = function()
                    if not selectedConfig or selectedConfig == "" then ForceNotify("Config", "Pilih config dulu!", 2); return end
                    local path = ConfigFolderPath() .. "/" .. selectedConfig .. ".json"
                    if isfile and delfile and isfile(path) then
                        pcall(delfile, path)
                        ForceNotify("Config", "Deleted: " .. selectedConfig, 2)
                        selectedConfig = nil; RefreshConfigList()
                    end
                end,
                SubCallback = function()
                    RefreshConfigList(); ForceNotify("Config", "List refreshed", 2)
                end
            })
            cfgSection:AddToggle({ Title = "Auto Save", Default = AutoSaveEnabled ~= false, Save = false,
                Callback = function(v)
                    AutoSaveEnabled = v
                    if SetActiveConfig and ActiveConfigName ~= nil then
                        pcall(SetActiveConfig, ActiveConfigName, ActiveConfigPath, v, ActiveConfigMode)
                    end
                    ForceNotify("Config", "Auto Save: " .. (v and "ON" or "OFF"), 2)
                end })
            local initAutoLoad = true
            cfgSection:AddToggle({ Title = "Auto Load", Default = AutoLoadEnabled == true, Save = false,
                Callback = function(v)
                    AutoLoadEnabled = v == true
                    if writefile and HttpService then
                        local name = selectedConfig or AutoLoadName or currentName or ""
                        pcall(writefile, ConfigFolderPath() .. "/_autoload.json", HttpService:JSONEncode({
                            Name = name,
                            Enabled = AutoLoadEnabled,
                        }))
                    end
                    if not initAutoLoad then
                        if AutoLoadEnabled and (selectedConfig or AutoLoadName) then
                            ForceNotify("Config", "Auto Load ON: " .. tostring(selectedConfig or AutoLoadName), 2)
                        else
                            ForceNotify("Config", "Auto Load: OFF", 2)
                        end
                    end
                end })
            initAutoLoad = false

            task.defer(function()
                if AutoLoadEnabled ~= true or not AutoLoadName or AutoLoadName == "" then return end
                task.wait(0.15)
                local okL, result, applied = LoadConfigByName(AutoLoadName, false)
                if okL then
                    ForceNotify("Config", "Auto Loaded: " .. AutoLoadName .. " (" .. tostring(applied or 0) .. " setting)", 3)
                else
                    warn("[N3K0P01 Config] Auto Load failed: " .. tostring(result))
                end
            end)
            local importJsonStr = ""
            cfgSection:AddInput({ Title = "Import JSON", Placeholder = "{...}", Save = false, Callback = function(text) importJsonStr = text end })
            cfgSection:AddButton({ Title = "Import", SubTitle = "From Clipboard",
                Callback = function()
                    if importJsonStr == "" then ForceNotify("Config", "Paste JSON dulu", 2); return end
                    local okD, dec = pcall(function() return HttpService:JSONDecode(importJsonStr) end)
                    if not okD or type(dec) ~= "table" then ForceNotify("Config", "JSON invalid", 2); return end
                    for k, v in pairs(dec) do
                        if k ~= "_version" then
                            local value = v
                            if ConfigData and type(ConfigData.__UnpackConfigValue) == "function" then
                                local okU, unpacked = pcall(ConfigData.__UnpackConfigValue, v)
                                if okU then value = unpacked end
                            end
                            if ConfigData then ConfigData[k] = value end
                            local control = Elements and Elements[k]
                            if not control and Elements then
                                for ek, ec in pairs(Elements) do
                                    local short = tostring(ek):match("::([^:]+)$")
                                    if short == tostring(k) then control = ec; break end
                                end
                            end
                            if control and type(control.Set) == "function" then pcall(function() control.Set(value, false) end) end
                        end
                    end
                    ForceNotify("Config", "Imported!", 2)
                end,
                SubCallback = function()
                    if not getclipboard then ForceNotify("Config", "Clipboard gak support", 2); return end
                    local clip = getclipboard()
                    if not clip or clip == "" then ForceNotify("Config", "Clipboard kosong", 2); return end
                    local okD, dec = pcall(function() return HttpService:JSONDecode(clip) end)
                    if not okD or type(dec) ~= "table" then ForceNotify("Config", "JSON invalid", 2); return end
                    for k, v in pairs(dec) do
                        if k ~= "_version" then
                            local value = v
                            if ConfigData and type(ConfigData.__UnpackConfigValue) == "function" then
                                local okU, unpacked = pcall(ConfigData.__UnpackConfigValue, v)
                                if okU then value = unpacked end
                            end
                            if ConfigData then ConfigData[k] = value end
                            local control = Elements and Elements[k]
                            if not control and Elements then
                                for ek, ec in pairs(Elements) do
                                    local short = tostring(ek):match("::([^:]+)$")
                                    if short == tostring(k) then control = ec; break end
                                end
                            end
                            if control and type(control.Set) == "function" then pcall(function() control.Set(value, false) end) end
                        end
                    end
                    ForceNotify("Config", "Imported from clipboard!", 2)
                end
            })
            cfgSection:AddButton({ Title = "Export to Clipboard", Callback = function()
                if not setclipboard then ForceNotify("Config", "Clipboard gak support", 2); return end
                local snapshot = GetConfigSnapshot and GetConfigSnapshot() or (ConfigData or {})
                snapshot._version = 2
                local okE, encoded = pcall(function() return HttpService:JSONEncode(snapshot) end)
                if okE and encoded then
                    setclipboard(encoded)
                    ForceNotify("Config", "Copied to clipboard!", 2)
                end
            end })
            local cfgInfoSection = MakeSection(ConfigTab, "Config Info")
            cfgInfoSection:AddParagraph({ Title = "Cara Pakai Config",
                Content = "• Save: tulis nama config, klik Save\n• Load: pilih Saved Configs, klik Load\n• Load akan menjalankan callback fitur sehingga setting aktif kembali\n• Auto Load: config terakhir dapat dipulihkan saat script start\n• Import/Export: backup JSON" })
        end)

        if not uiOK then warn("[Gluto] Gagal membuat UI:", uiErr) end

        print("[N3K0P01 HUB v1.0.16] Loaded!")
        print("  - NEW: Auto Hook + Speed Boost")
        ForceNotify("N3K0P01 HUB v1.0.16 Loaded", "AutoHook + PerksDisplay + SpeedBoost added", 6)

    end

    __Gluto_Init_Main__()

end


    local HostUI = VertexUI
    local featureAdapter = {}
    local function registerSearchObject(object, titleText, contentText)
        if not object then return object end
        pcall(function()
            object:SetAttribute("N3K0P01_SearchChild", true)
            object:SetAttribute("N3K0P01_FeatureTitle", tostring(titleText or ""))
            object:SetAttribute("N3K0P01_FeatureContent", tostring(contentText or ""))
        end)
        return object
    end
    local categoryIcons = {
        Survivor = ICO.PLAYER,
        Visuals = ICO.VISUAL,
        Killer = ICO.ESP,
        Misc = ICO.MISC,
        Config = ICO.SETTINGS,
    }

    local function getEnvironment()
        local ok, env = pcall(function() return getgenv() end)
        if ok and type(env) == "table" then return env end
        return _G
    end

    local function makeConfigControl(section, opts, controlObject, getter, setter)
        opts = opts or {}
        local env = getEnvironment()
        local entry = {
            Control = controlObject,
            Get = getter,
            Set = function(value, silent)
                if type(setter) == "function" then
                    return setter(value, silent == true)
                end
            end,
            Title = tostring(opts.Title or "Control"),
            ConfigId = tostring(opts.ConfigId or opts.Title or "Control"),
            Section = tostring(section.__title or "Section"),
            Page = tostring(section.__pageName or "Page"),
            StableId = "N3K0P01::" .. tostring(opts.ConfigId or opts.Title or "Control"),
        }
        if opts.Save ~= false then
            env.__N3K0P01_ConfigElements = env.__N3K0P01_ConfigElements or {}
            env.Elements = env.__N3K0P01_ConfigElements
            local key = tostring(section.__configPrefix or "Page::Section") .. "::" .. entry.ConfigId
            env.__N3K0P01_ConfigElements[key] = entry
        end
        return entry
    end

    function featureAdapter:Window(_)
        local window = {}
        function window:InfoTab(_)
            -- The Premium Script UI already has the HUB/profile card in its sidebar.
            return nil
        end
        function window:AddTab(tabOptions)
            tabOptions = tabOptions or {}
            local name = tostring(tabOptions.Name or "Tab")
            local page = HostUI:CreateTab(name, categoryIcons[name])
            local tab = { Name = name, Page = page }
            function tab:AddSection(title)
                local sectionPageName = tostring(page.Name or name)
                local box = HostUI:CreateSection(page, tostring(title or "Section"))
                pcall(function()
                    box:SetAttribute("N3K0P01_SearchSection", true)
                    box:SetAttribute("N3K0P01_SearchSectionTitle", tostring(title or "Section"))
                    box:SetAttribute("N3K0P01_SearchPage", name)
                end)
                local section = {
                    __box = box,
                    __title = tostring(title or "Section"),
                    __pageName = sectionPageName,
                    __configPrefix = sectionPageName .. "::" .. tostring(title or "Section"),
                }

                function section:AddToggle(opts)
                    opts = opts or {}
                    local row, setVisual, getValue = HostUI:AddToggle(
                        box, opts.Title or "Toggle", opts.Default == true,
                        function(value)
                            if type(opts.Callback) == "function" then pcall(opts.Callback, value) end
                        end,
                        opts.Content
                    )
                    registerSearchObject(row, opts.Title or "Toggle", opts.Content)
                    return makeConfigControl(section, opts, row,
                        getValue or function() return opts.Default == true end,
                        function(value, silent) setVisual(value == true, not silent) end)
                end

                function section:AddButton(opts)
                    opts = opts or {}
                    local titleText = opts.Title or "Button"
                    local primary = HostUI:AddButton(box, titleText, function()
                        if type(opts.Callback) == "function" then pcall(opts.Callback) end
                    end)
                    registerSearchObject(primary, titleText, opts.Content)
                    if type(opts.SubCallback) == "function" then
                        local secondary = HostUI:AddButton(box, opts.SubTitle or "Secondary Action", function()
                            opts.SubCallback()
                        end)
                        registerSearchObject(secondary, opts.SubTitle or "Secondary Action", opts.SubContent or opts.Content)
                    end
                    return primary
                end

                function section:AddSlider(opts)
                    opts = opts or {}
                    local row, setValue, getValue = HostUI:AddSlider(
                        box, opts.Title or "Slider", opts.Min or 0, opts.Max or 100,
                        opts.Default or opts.Min or 0, opts.Suffix or "",
                        function(value)
                            if type(opts.Callback) == "function" then pcall(opts.Callback, value) end
                        end,
                        opts.Increment or 1
                    )
                    registerSearchObject(row, opts.Title or "Slider", opts.Content)
                    return makeConfigControl(section, opts, row,
                        getValue or function() return tonumber(opts.Default) or tonumber(opts.Min) or 0 end,
                        function(value, silent) setValue(value, not silent) end)
                end

                function section:AddDropdown(opts)
                    opts = opts or {}
                    local liveOptions = type(opts.Options) == "table" and opts.Options or {}
                    local row, setOption, setValues, getValue = HostUI:AddDropdown(
                        box, opts.Title or "Dropdown", liveOptions, opts.Default,
                        function(value)
                            if type(opts.Callback) == "function" then pcall(opts.Callback, value) end
                        end
                    )
                    registerSearchObject(row, opts.Title or "Dropdown", opts.Content)
                    local control = makeConfigControl(section, opts, row,
                        getValue or function() return nil end,
                        function(value, silent) setOption(value, not silent) end)
                    local env = getEnvironment()
                    env.__N3K0P01_DropdownAPIs = env.__N3K0P01_DropdownAPIs or {}
                    env.__N3K0P01_DropdownAPIs[control] = {
                        SetValues = function(newOptions, selected, silent)
                            liveOptions = type(newOptions) == "table" and newOptions or {}
                            opts.Options = liveOptions
                            setValues(liveOptions, selected, not silent)
                        end,
                        GetValues = function()
                            return liveOptions
                        end,
                    }
                    return control
                end

                function section:AddInput(opts)
                    opts = opts or {}
                    local row = FT(UDim2.new(1, 0, 0, 34), nil, box)
                    TL(opts.Title or "Input", 12, C.TXT, false, row,
                        UDim2.new(0, 0, 0, 0), UDim2.new(0.48, -5, 1, 0))
                    local input = Instance.new("TextBox")
                    input.Name = "FeatureInput"
                    input.Size = UDim2.new(0.52, 0, 0, 28)
                    input.Position = UDim2.new(0.48, 5, 0.5, -14)
                    input.BackgroundColor3 = C.BTN_BG
                    input.BorderSizePixel = 0
                    input.ClearTextOnFocus = false
                    input.Font = Enum.Font.Gotham
                    input.TextSize = 10
                    input.TextColor3 = C.TXT
                    input.PlaceholderText = tostring(opts.Placeholder or "")
                    input.Text = tostring(opts.Default or "")
                    input.TextXAlignment = Enum.TextXAlignment.Left
                    input.Parent = row
                    R(7, input)
                    Stroke(C.BOX_STROKE, 1, input)
                    local function setInput(value, fireCallback)
                        input.Text = tostring(value or "")
                        if fireCallback and type(opts.Callback) == "function" then
                            opts.Callback(input.Text)
                        end
                    end
                    input.FocusLost:Connect(function()
                        if type(opts.Callback) == "function" then pcall(opts.Callback, input.Text) end
                    end)
                    registerSearchObject(row, opts.Title or "Input", opts.Content)
                    return makeConfigControl(section, opts, input,
                        function() return input.Text end,
                        function(value, silent) setInput(value, not silent) end)
                end

                function section:AddColorPicker(opts)
                    opts = opts or {}
                    local row = FT(UDim2.new(1, 0, 0, 32), nil, box)
                    TL(opts.Title or "Color", 12, C.TXT, false, row,
                        UDim2.new(0, 0, 0, 0), UDim2.new(1, -48, 1, 0))
                    local currentColor = (typeof(opts.Default) == "Color3") and opts.Default or Color3.fromRGB(255, 255, 255)
                    local colorButton = Instance.new("TextButton")
                    colorButton.Name = "ColorPickerButton"
                    colorButton.Size = UDim2.fromOffset(36, 24)
                    colorButton.Position = UDim2.new(1, -36, 0.5, -12)
                    colorButton.BackgroundColor3 = currentColor
                    colorButton.BorderSizePixel = 0
                    colorButton.Text = ""
                    colorButton.AutoButtonColor = false
                    colorButton.Parent = row
                    R(6, colorButton)
                    Stroke(C.BOX_STROKE, 1, colorButton)
                    local function setColor(value, fireCallback)
                        if typeof(value) ~= "Color3" then return end
                        currentColor = value
                        colorButton.BackgroundColor3 = value
                        if fireCallback and type(opts.Callback) == "function" then opts.Callback(value) end
                    end
                    colorButton.Activated:Connect(function()
                        EnsureColorPickerModal()
                        OpenColorPicker(opts.Title or "Color", currentColor, function(newColor)
                            setColor(newColor, true)
                        end)
                    end)
                    registerSearchObject(row, opts.Title or "Color", opts.Content)
                    return makeConfigControl(section, opts, row,
                        function() return currentColor end,
                        function(value, silent) setColor(value, not silent) end)
                end

                function section:AddKeybind(opts)
                    opts = opts or {}
                    local defaultKey = opts.Default
                    if typeof(defaultKey) ~= "EnumItem" then
                        local keyName = tostring(defaultKey or "Unknown")
                        defaultKey = Enum.KeyCode[keyName] or Enum.KeyCode.Unknown
                    end
                    local row, setKey, getKey = HostUI:AddKeybind(box, opts.Title or "Keybind", defaultKey,
                        function(value)
                            if type(opts.Callback) == "function" then pcall(opts.Callback, value) end
                        end)
                    registerSearchObject(row, opts.Title or "Keybind", opts.Content)
                    return makeConfigControl(section, opts, row,
                        getKey or function() return defaultKey end,
                        function(value, silent)
                            if typeof(value) == "EnumItem" then setKey(value, not silent) end
                        end)
                end

                function section:AddParagraph(opts)
                    opts = opts or {}
                    local wrap = FT(UDim2.new(1, 0, 0, 0), nil, box)
                    wrap.AutomaticSize = Enum.AutomaticSize.Y
                    local layout = Instance.new("UIListLayout")
                    layout.FillDirection = Enum.FillDirection.Vertical
                    layout.SortOrder = Enum.SortOrder.LayoutOrder
                    layout.Padding = UDim.new(0, 3)
                    layout.Parent = wrap
                    if opts.Title and tostring(opts.Title) ~= "" then
                        local titleLabel = TL(tostring(opts.Title), 12, C.TXT, true, wrap,
                            UDim2.new(0, 0, 0, 0), UDim2.new(1, 0, 0, 18))
                        titleLabel.LayoutOrder = 1
                        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
                    end
                    local body = Instance.new("TextLabel")
                    body.BackgroundTransparency = 1
                    body.Size = UDim2.new(1, 0, 0, 0)
                    body.AutomaticSize = Enum.AutomaticSize.Y
                    body.Font = Enum.Font.Gotham
                    body.Text = tostring(opts.Content or opts.Description or "")
                    body.TextColor3 = C.TXT_DIM
                    body.TextSize = 10
                    body.TextWrapped = true
                    body.TextXAlignment = Enum.TextXAlignment.Left
                    body.TextYAlignment = Enum.TextYAlignment.Top
                    body.LayoutOrder = 2
                    body.Parent = wrap
                    registerSearchObject(wrap, opts.Title or "Information", opts.Content or opts.Description)
                    return wrap
                end

                return section
            end
            return tab
        end
        return window
    end

    function featureAdapter:MakeNotify(opts)
        opts = opts or {}
        HostUI:Notify(opts.Title or "N3K0P01 HUB", opts.Content or opts.Description or "", opts.Delay or 2)
    end

    __N3K0P01_UI_ADAPTER = featureAdapter
    if __N3K0P01_FEATURE_RUNTIME_STARTED then
        warn("[N3K0P01] Feature runtime already started; skipping duplicate init.")
    else
        __N3K0P01_FEATURE_RUNTIME_STARTED = true
        __N3K0P01_FEATURE_RUNTIME_RUNNING = true
        _G.__N3K0P01_FEATURE_RUNTIME_RUNNING = true
        task.spawn(function()
            local ok, err = pcall(function()
                __N3K0P01_START()
            end)
            __N3K0P01_FEATURE_RUNTIME_RUNNING = false
            _G.__N3K0P01_FEATURE_RUNTIME_RUNNING = false
            if not ok then
                warn("[N3K0P01] Feature runtime error:", err)
                HostUI:Notify("Feature Runtime", "Runtime stopped safely. Check executor/game compatibility.", 4)
            end
        end)
    end
end


-- Category pages use the same organization as the feature source.
local SurvivorPage = VertexUI:CreateTab("Survivor", ICO.PLAYER)
local VisualsPage  = VertexUI:CreateTab("Visuals", ICO.VISUAL)
local KillerPage   = VertexUI:CreateTab("Killer", ICO.ESP)
local MiscPage     = VertexUI:CreateTab("Misc", ICO.MISC)
local ConfigPage   = VertexUI:CreateTab("Config", ICO.SETTINGS)

-- ============================================================
-- FEATURE SEARCH (ported from COLOR PARY VEIL FOV source)
-- Search section names, feature labels and descriptions; selecting
-- a result opens its category and scrolls directly to the section.
-- ============================================================
local SearchWrap = Instance.new("Frame")
SearchWrap.Name = "FeatureSearchWrap"
SearchWrap.Size = UDim2.fromOffset(178, 28)
SearchWrap.Position = UDim2.new(1, -252, 0, 6)
SearchWrap.BackgroundColor3 = C.BOX_BG
SearchWrap.BackgroundTransparency = 0.04
SearchWrap.BorderSizePixel = 0
SearchWrap.ZIndex = 120
SearchWrap.Parent = Win
R(8, SearchWrap)
local searchWrapStroke = Stroke(C.BOX_STROKE, 1, SearchWrap)
RegisterThemed(SearchWrap, "BackgroundColor3", "BOX_BG")
RegisterThemed(searchWrapStroke, "Color", "BOX_STROKE")

local featureSearch = Instance.new("TextBox")
featureSearch.Name = "FeatureSearch"
featureSearch.Size = UDim2.new(1, -16, 1, 0)
featureSearch.Position = UDim2.fromOffset(8, 0)
featureSearch.BackgroundTransparency = 1
featureSearch.BorderSizePixel = 0
featureSearch.ClearTextOnFocus = false
featureSearch.Font = Enum.Font.Gotham
featureSearch.Text = ""
featureSearch.PlaceholderText = "Search feature..."
featureSearch.PlaceholderColor3 = C.TXT_DIM
featureSearch.TextColor3 = C.TXT
featureSearch.TextSize = 10
featureSearch.TextXAlignment = Enum.TextXAlignment.Left
featureSearch.ZIndex = 122
featureSearch.Parent = SearchWrap

local searchResults = Instance.new("Frame")
searchResults.Name = "FeatureSearchResults"
searchResults.Size = UDim2.fromOffset(190, 0)
searchResults.Position = UDim2.new(1, -252, 0, 39)
searchResults.BackgroundColor3 = C.BOX_BG
searchResults.BackgroundTransparency = 0.03
searchResults.BorderSizePixel = 0
searchResults.Visible = false
searchResults.ClipsDescendants = true
searchResults.ZIndex = 130
searchResults.Parent = Win
R(9, searchResults)
local searchResultsStroke = Stroke(C.BOX_STROKE, 1, searchResults)
RegisterThemed(searchResults, "BackgroundColor3", "BOX_BG")
RegisterThemed(searchResultsStroke, "Color", "BOX_STROKE")
local searchResultsPadding = Instance.new("UIPadding")
searchResultsPadding.PaddingTop = UDim.new(0, 6)
searchResultsPadding.PaddingBottom = UDim.new(0, 6)
searchResultsPadding.PaddingLeft = UDim.new(0, 6)
searchResultsPadding.PaddingRight = UDim.new(0, 6)
searchResultsPadding.Parent = searchResults
local searchResultsLayout = Instance.new("UIListLayout")
searchResultsLayout.FillDirection = Enum.FillDirection.Vertical
searchResultsLayout.SortOrder = Enum.SortOrder.LayoutOrder
searchResultsLayout.Padding = UDim.new(0, 4)
searchResultsLayout.Parent = searchResults

local function MarkSearchItem(object, titleText, contentText)
    if not object then return object end
    pcall(function()
        object:SetAttribute("N3K0P01_SearchChild", true)
        object:SetAttribute("N3K0P01_FeatureTitle", tostring(titleText or ""))
        object:SetAttribute("N3K0P01_FeatureContent", tostring(contentText or ""))
    end)
    return object
end

local function clearSearchResults()
    for _, child in ipairs(searchResults:GetChildren()) do
        if child:IsA("TextButton") or child:IsA("TextLabel") then
            child:Destroy()
        end
    end
    searchResults.Visible = false
    searchResults.Size = UDim2.fromOffset(190, 0)
end

local function scrollToFeature(pageObject, holder)
    if not pageObject or not holder then return end
    task.spawn(function()
        for _ = 1, 30 do
            task.wait(0.04)
            if holder.Parent == pageObject and holder.AbsoluteSize.Y > 1 then break end
        end
        if holder.Parent ~= pageObject or not pageObject.Visible then return end
        task.wait(0.08)
        local targetY = holder.AbsolutePosition.Y - Sc.AbsolutePosition.Y + Sc.CanvasPosition.Y - 10
        local maxY = math.max(0, Sc.AbsoluteCanvasSize.Y - Sc.AbsoluteWindowSize.Y)
        Sc.CanvasPosition = Vector2.new(0, math.clamp(targetY, 0, maxY))
    end)
end

local function collectSearchResults(query)
    local results = {}
    local q = string.lower(tostring(query or "")):gsub("^%s+", ""):gsub("%s+$", "")
    if q == "" then return results end

    for pageName, pageObject in pairs(Pages) do
        if pageName ~= "Main" and pageName ~= "Information" and pageObject then
            for _, sectionBox in ipairs(pageObject:GetChildren()) do
                if sectionBox:IsA("Frame") and sectionBox:GetAttribute("N3K0P01_SearchSection") == true then
                    local sectionTitle = tostring(sectionBox:GetAttribute("N3K0P01_SearchSectionTitle") or sectionBox.Name)
                    local searchableParts = { sectionTitle }
                    for _, child in ipairs(sectionBox:GetDescendants()) do
                        if child.GetAttribute and child:GetAttribute("N3K0P01_SearchChild") == true then
                            table.insert(searchableParts, tostring(child:GetAttribute("N3K0P01_FeatureTitle") or ""))
                            table.insert(searchableParts, tostring(child:GetAttribute("N3K0P01_FeatureContent") or ""))
                        end
                    end
                    local haystack = string.lower(table.concat(searchableParts, " "))
                    local matchPos = string.find(haystack, q, 1, true)
                    if matchPos then
                        table.insert(results, { holder = sectionBox, page = pageObject, pageName = pageName, title = sectionTitle, matchPos = matchPos })
                    end
                end
            end
        end
    end

    table.sort(results, function(a, b)
        local at, bt = string.lower(a.title), string.lower(b.title)
        local aq = string.find(at, q, 1, true) or 9999
        local bq = string.find(bt, q, 1, true) or 9999
        if aq ~= bq then return aq < bq end
        if at ~= bt then return at < bt end
        return a.pageName < b.pageName
    end)
    return results
end

local function renderSearchResults(query)
    clearSearchResults()
    local results = collectSearchResults(query)
    if #results == 0 then
        if tostring(query or "") ~= "" then
            local empty = Instance.new("TextLabel")
            empty.Name = "SearchEmpty"
            empty.BackgroundTransparency = 1
            empty.Size = UDim2.new(1, 0, 0, 30)
            empty.LayoutOrder = 1
            empty.Font = Enum.Font.Gotham
            empty.Text = "No feature found"
            empty.TextColor3 = C.TXT_DIM
            empty.TextSize = 10
            empty.ZIndex = 132
            empty.Parent = searchResults
            searchResults.Size = UDim2.fromOffset(190, 44)
            searchResults.Visible = true
        end
        return
    end

    local maxResults = math.min(#results, 7)
    for i = 1, maxResults do
        local result = results[i]
        local row = Instance.new("TextButton")
        row.Name = "SearchResult_" .. tostring(i)
        row.Size = UDim2.new(1, 0, 0, 34)
        row.LayoutOrder = i
        row.BackgroundColor3 = C.BTN_BG
        row.BackgroundTransparency = 0.05
        row.BorderSizePixel = 0
        row.Text = ""
        row.AutoButtonColor = false
        row.ZIndex = 132
        row.Parent = searchResults
        R(7, row)

        local title = TL(result.title, 9, C.TXT, true, row, UDim2.fromOffset(9, 3), UDim2.new(1, -18, 0, 16))
        title.ZIndex = 133
        local categoryLabel = ({ Survivor = "SURVIVE", Visuals = "VISUAL", Killer = "KILLER", Misc = "MISC", Config = "SAVE" })[result.pageName] or string.upper(result.pageName)
        local subtitle = TL(categoryLabel .. " • Main Feature", 8, C.TXT_DIM, false, row,
            UDim2.fromOffset(9, 18), UDim2.new(1, -18, 0, 12))
        subtitle.ZIndex = 133

        row.MouseEnter:Connect(function() row.BackgroundColor3 = C.TAB_ACT end)
        row.MouseLeave:Connect(function() row.BackgroundColor3 = C.BTN_BG end)
        row.Activated:Connect(function()
            VertexUI:SelectTab(result.pageName)
            task.defer(function() scrollToFeature(result.page, result.holder) end)
            featureSearch.Text = ""
            clearSearchResults()
            pcall(function() featureSearch:ReleaseFocus() end)
        end)
    end
    local rowHeight = 34
    local totalHeight = 12 + (maxResults * rowHeight) + ((maxResults - 1) * 4)
    searchResults.Size = UDim2.fromOffset(190, math.min(totalHeight, 286))
    searchResults.Visible = true
end

featureSearch:GetPropertyChangedSignal("Text"):Connect(function() renderSearchResults(featureSearch.Text) end)
featureSearch.Focused:Connect(function()
    if featureSearch.Text ~= "" then renderSearchResults(featureSearch.Text) end
end)
featureSearch.FocusLost:Connect(function()
    task.delay(0.12, function()
        if featureSearch.Text == "" then clearSearchResults() end
    end)
end)

-- The music utility is added after the game-feature controls so it stays at the end of Misc.
task.spawn(function()
    local waitDeadline = os.clock() + 15
    while _G.__N3K0P01_FEATURE_RUNTIME_RUNNING == true and os.clock() < waitDeadline do
        task.wait(0.1)
    end
    do
        local MUSIC_SOUND_SERVICE = game:GetService("SoundService")
        local MUSIC_CONTENT_PROVIDER = game:GetService("ContentProvider")
    
        local MUSIC_SONGS = {
            {id="rbxassetid://71026986293665", name="MILLION STARS STADIUM", artist="LZEN"},
            {id="rbxassetid://118946667355787", name="I CLOSE MY EYES", artist="LZEN"},
            {id="rbxassetid://113593609443956", name="RED EYES V1", artist="LZEN"},
            {id="rbxassetid://113593609443956", name="CHINESE R&B MIX", artist="LZEN"},
            {id="rbxassetid://95902344232769", name="HIPHOP V2", artist="LZEN"},
            {id="rbxassetid://123022794586021", name="BOPEX", artist="LZEN"},
            {id="rbxassetid://71525240256488", name="THE AWAKENING LIGHTS", artist="LZEN"},
            {id="rbxassetid://117020806574845", name="LUPA NAMA LAGU", artist=""},
            {id="rbxassetid://117574079633196", name="DJ BLACK HOLE", artist=""},
            {id="rbxassetid://85936017588280", name="BBHC HARDCORE", artist=""},
            {id="rbxassetid://124582101215124110337096446518", name="ONIA", artist=""},
            {id="rbxassetid://110839312239968", name="Jealousy setuyilu", artist=""},
            {id="rbxassetid://133179214676469", name="Dj piki2x bom pa", artist=""},
            {id="rbxassetid://108878711230593", name="Levan polka", artist=""},
            {id="rbxassetid://124949400580961", name="Neng ayo neng", artist=""},
            {id="rbxassetid://132789860983151", name="Tangkis Tangkis dong", artist=""},
            {id="rbxassetid://76033817753386", name="Wek Wek", artist=""},
            {id="rbxassetid://122495237452168", name="Penyangkalan", artist=""},
            {id="rbxassetid://125652823164812", name="Afgan Tell U Cinta", artist=""},
            {id="rbxassetid://118182203343782", name="Slurhnfsini", artist=""},
            {id="rbxassetid://135357032110162", name="Armada", artist=""},
            {id="rbxassetid://129700548831112", name="Tenxi HTS", artist=""},
            {id="rbxassetid://122283659725483", name="Wali Yank", artist=""},
            {id="rbxassetid://132054631309472", name="Wali Emng Dsar", artist=""},
            {id="rbxassetid://89561884967226", name="Beauty Girls", artist=""},
            {id="rbxassetid://93267966777242", name="DJ Minang Leng Jedag Jedug", artist=""},
            {id="rbxassetid://91597768703052", name="Mulai Merindumu", artist=""},
            {id="rbxassetid://87543116048841", name="Let You Go With a Smile", artist=""},
            {id="rbxassetid://128996141516362", name="Afterlife", artist=""},
            {id="rbxassetid://139475031066050", name="NIGHT MODE SUBWOOFER TEST", artist=""},
            {id="rbxassetid://138551890276730", name="Adrenaline Arcade Synthwave", artist=""},
            {id="rbxassetid://104847492515442", name="Late Night Drive", artist=""},
            {id="rbxassetid://115408466589902", name="KPOP ROMANCE", artist=""},
            {id="rbxassetid://123860629119609", name="너는 내 romance tune", artist=""},
            {id="rbxassetid://142376088", name="Parry Gripp Raining Tacos", artist=""},
            {id="rbxassetid://120812539198119", name="Memories", artist=""},
            {id="rbxassetid://1839444520", name="Cat Chase", artist=""},
            {id="rbxassetid://100048144167699", name="i love you so jumpstyle", artist=""},
            {id="rbxassetid://87384540137807", name="DJ Tarak Tak Dung", artist=""},
            {id="rbxassetid://115408466589902", name="KPOP ROMANCE", artist=""},
            {id="rbxassetid://115995823971154", name="Chinese Remix", artist=""},
            {id="rbxassetid://138111805607934", name="One Dance", artist=""},
            {id="rbxassetid://124859793063355", name="Space Song", artist=""},
            {id="rbxassetid://73342752988586", name="DJ Ambatukam", artist=""},
            {id="rbxassetid://130796457790083", name="Wasted", artist="Juice WRLD"},
            {id="rbxassetid://133435792119877", name="You Already Too Late", artist=""},
            {id="rbxassetid://76638211528783", name="Slow Dancing in the Dark", artist="Joji"},
            {id="rbxassetid://138544195832654", name="Brazil Funk", artist=""},
            {id="rbxassetid://111391042544257", name="Babydoll", artist="Dominic Fike"},
            {id="rbxassetid://86791468764167", name="As It Was", artist=""},
            {id="rbxassetid://92848271744405", name="Black Beatles", artist="Swae Lee"},
            {id="rbxassetid://87570666848900", name="Fashion Center", artist=""},
            {id="rbxassetid://79624526160824", name="Hate Me", artist="Ellie Goulding"},
            {id="rbxassetid://123956105101233", name="Queenst", artist=""},
            {id="rbxassetid://134302801244622", name="Goosebumps", artist="Travis Scott"},
            {id="rbxassetid://90233200492479", name="Im Closing My Eyes", artist=""},
            {id="rbxassetid://135609653444873", name="No One Noticed", artist="The Marías"},
            {id="rbxassetid://81737389581810", name="Selamanya Bersamamu", artist=""},        {id="rbxassetid://97357680045096", name="Kembalilah Padaku", artist=""},        {id="rbxassetid://122785132595824", name="Senja Tak Pernah Usai", artist=""},        {id="rbxassetid://84834036587777", name="Terakhir Kali", artist=""},        {id="rbxassetid://89836791839135", name="Jatuh Cinta Lagi", artist=""},        {id="rbxassetid://96159173961268", name="Abadi Bersamamu", artist=""},        {id="rbxassetid://113319167795491", name="Jangan Pergi", artist=""},        {id="rbxassetid://90168245064471", name="Langit Biru", artist=""},        {id="rbxassetid://93596344950405", name="Kau Di Hatiku", artist=""},        {id="rbxassetid://85137592663322", name="Hanya Kamu", artist=""},        {id="rbxassetid://83844141761369", name="Kerinduan Dalam Diam", artist=""},        {id="rbxassetid://80389306943751", name="Melody Cinta", artist=""},        {id="rbxassetid://80223079206027", name="Kecewa", artist=""},        {id="rbxassetid://105563365661048", name="Cinta Pertama", artist=""},        {id="rbxassetid://118521946985301", name="1 bulan", artist=""},        {id="rbxassetid://79902843921518", name="di tempat ini", artist=""},        {id="rbxassetid://73768619545835", name="cinta istimewa", artist=""},        {id="rbxassetid://7779094440506", name="coba mengerti", artist=""},        {id="rbxassetid://81973481116917", name="Mata yang berbicara", artist=""},        {id="rbxassetid://81211527812792", name="Hujan cinta", artist=""},        {id="rbxassetid://111862546703577", name="Janji di bawah bintang", artist=""},        {id="rbxassetid://125024246145900", name="Haruskah aku pergi", artist=""},        {id="rbxassetid://124994794838360", name="Padamu sepi", artist=""},        {id="rbxassetid://119782974075632", name="Aku bisa", artist=""},        {id="rbxassetid://89185650940118", name="Selamanya aku ingin denganmu", artist=""},        {id="rbxassetid://83250836631471", name="Rumah di hatimu", artist=""},        {id="rbxassetid://10559566237", name="Asmara Semalam", artist=""},        {id="rbxassetid://110651286181267", name="Emang Gue Pikirin", artist=""},        {id="rbxassetid://121366562667104", name="Tergoda", artist=""},        {id="rbxassetid://90593758589409", name="Pacarku Tetanggaku", artist=""},        {id="rbxassetid://16662832435", name="Wahra Paca", artist=""},        {id="rbxassetid://106291412410472", name="Kangen Banget", artist=""},        {id="rbxassetid://83817418053316", name="Aku Bete sama Kamu", artist=""},        {id="rbxassetid://138399521757966", name="Aku Tetap Cinta", artist=""},        {id="rbxassetid://126398962163813", name="Jangan Pernah Berubah", artist=""},        {id="rbxassetid://77545154026611", name="Orang Yang Salah", artist=""},        {id="rbxassetid://91195881581393", name="Rasa Yang Tertinggal", artist=""},        {id="rbxassetid://132867463657917", name="Aku Bisa", artist=""},        {id="rbxassetid://93671745663611", name="Jangan Bertengkar Lagi", artist=""},        {id="rbxassetid://107155526014683", name="Sahur mimi peri", artist=""},        {id="rbxassetid://135613441856864", name="Kenangan Terindah", artist=""},        {id="rbxassetid://118453909244421", name="Jak sel lep", artist=""},        {id="rbxassetid://128423732057141", name="Tak Sanggup Lagi", artist=""},        {id="rbxassetid://12933736403549", name="Penjaga Hati", artist=""},        {id="rbxassetid://70583524630795", name="Secepat kilat", artist=""},        {id="rbxassetid://137760399276127", name="JKT48 Rapsodi", artist=""},        {id="rbxassetid://121604689787053", name="Jangan menyerah", artist=""},        {id="rbxassetid://79590300003240", name="JANGAN PAKSA RINDU", artist=""},        {id="rbxassetid://117487670431781", name="PHOTOGRAPH", artist=""},        {id="rbxassetid://108785172684673", name="HINDIA CINCIN", artist=""},        {id="rbxassetid://89048742100707", name="MARDUA HOLONG", artist=""},        {id="rbxassetid://120983443791226", name="RASA BALI", artist=""},        {id="rbxassetid://77790944405065", name="COBALAH MENGERTI", artist=""},        {id="rbxassetid://109985727947617", name="Kangen band kembali", artist=""},        {id="rbxassetid://111429453705075", name="Di bukit berbunga", artist=""},        {id="rbxassetid://79158835442971", name="pacar impian", artist=""},        {id="rbxassetid://140544795409401", name="Kehadiran cinta", artist=""},        {id="rbxassetid://116986630959929", name="Sakit tapi rindu", artist=""},        {id="rbxassetid://131215162188982", name="Jika nanti", artist=""},        {id="rbxassetid://128259754377999", name="Tetap kusayang", artist=""},        {id="rbxassetid://133511571620797", name="hancur hatiku", artist=""},        {id="rbxassetid://75156127215458", name="bisikan angin", artist=""},        {id="rbxassetid://123283873688952", name="masih mencintaimu", artist=""},        {id="rbxassetid://135473913594559", name="ibu kaulah cahaya", artist=""},        {id="rbxassetid://106698218030422", name="hatiku tersiksa karena melupakanmu", artist=""},        {id="rbxassetid://100216914755202", name="rapuh di sajadah", artist=""},        {id="rbxassetid://75312813261125", name="manisnya cinta ini", artist=""},        {id="rbxassetid://108891709611668", name="pura pura kuat", artist=""},        {id="rbxassetid://115131247077030", name="pelukan hangat", artist=""},        {id="rbxassetid://137192349740602", name="pergi tanpa ragu", artist=""},        {id="rbxassetid://135825408597541", name="tenggelam dalam kecewa", artist=""},        {id="rbxassetid://102243069137065", name="di bawah bintang", artist=""},        {id="rbxassetid://127301830644577", name="di ujung senja", artist=""},        {id="rbxassetid://88442580814345", name="di hatimu", artist=""},        {id="rbxassetid://122827602727670", name="setiap tantangan", artist=""},        {id="rbxassetid://100776947967575", name="Pergi lah", artist=""},        {id="rbxassetid://77556082453137", name="Mengejar waktu", artist=""},        {id="rbxassetid://12825975437799", name="Ku Tetap Sayang", artist=""},        {id="rbxassetid://112021392466036", name="Ilusi Tak Bertepi", artist=""},        {id="rbxassetid://111869264914484", name="Gerimis Di Pelantaran", artist=""},        {id="rbxassetid://113639353301886", name="Sesuatu Yang Sempurna", artist=""},        {id="rbxassetid://76769189002980", name="Kau Nyawaku", artist=""},        {id="rbxassetid://127815872735971", name="Cinta Dalam Ilusi", artist=""},        {id="rbxassetid://70965504859488", name="di bukit berbunga", artist=""},        {id="rbxassetid://104928443006967", name="Di bawah kuasa", artist=""},        {id="rbxassetid://134139943975072", name="pagi yang cerah", artist=""},        {id="rbxassetid://88099261246808", name="separuh cintaku", artist=""},        {id="rbxassetid://83783872130461", name="pergi tanpa penjelasan", artist=""},        {id="rbxassetid://113426585652241", name="di kota asing", artist=""},        {id="rbxassetid://134080487231612", name="dingin yang menyapa", artist=""},        {id="rbxassetid://1653188644608", name="jangan malu malu boy", artist=""},        {id="rbxassetid://107198551105205", name="mentari pagi", artist=""},        {id="rbxassetid://78859797813378", name="senggol dong", artist=""},        {id="rbxassetid://79358926243534", name="rasa sayang sayang e", artist=""},        {id="rbxassetid://139810085372815", name="dumes", artist=""},        {id="rbxassetid://139246144993743", name="Dekat Selalu", artist=""},        {id="rbxassetid://93487584604663", name="Rindu Tak Bertepi", artist=""},        {id="rbxassetid://135718271696932", name="Jangan Pergi", artist=""},        {id="rbxassetid://105264732403812", name="Ada Harapan Lagi", artist=""},        {id="rbxassetid://84795128040964", name="Oazayakan YOUNG LEX", artist=""},        {id="rbxassetid://96755117635802", name="dangdut bara² bere", artist=""},        {id="rbxassetid://115764116614755", name="TipeX MAWAR HITAM", artist=""},        {id="rbxassetid://72371077169699", name="WARKOP DKI", artist=""},        {id="rbxassetid://98788374971904", name="lunasi angsuran", artist=""},        {id="rbxassetid://90953411416049", name="rindunya hatiku", artist=""},        {id="rbxassetid://128423732058141", name="tak sanggup lagi", artist=""},        {id="rbxassetid://129008330358425", name="galau n sepi", artist=""},        {id="rbxassetid://84563717173214", name="nangis sedih", artist=""},        {id="rbxassetid://101580869706585", name="sedih", artist=""},        {id="rbxassetid://120740631549367", name="gelora asmara", artist=""},        {id="rbxassetid://108585280704650", name="Sayang sampai mati", artist=""},        {id="rbxassetid://135357032110162", name="Asalkan kau bahagia", artist=""},        {id="rbxassetid://82992470212894", name="Tanpamu", artist=""},        {id="rbxassetid://70614011662651", name="pura pura tak tahu", artist=""},        {id="rbxassetid://139694597836683", name="Rahasia hati", artist=""},        {id="rbxassetid://97698430446092", name="sesakit sakitnya", artist=""},        {id="rbxassetid://73296126598485", name="Cinta sempurna", artist=""},        {id="rbxassetid://129584498396171", name="ku tak bersuara", artist=""},        {id="rbxassetid://97999529277098", name="Aku rindu padamu", artist=""},        {id="rbxassetid://137224054872014", name="Rindu serindu-rindunya", artist=""},        {id="rbxassetid://87754370424091", name="Ku sapu airmata perpisahan", artist=""},        {id="rbxassetid://83631534046210", name="SESI POTRET ARI LESMANA", artist=""},        {id="rbxassetid://139610754639017", name="TAK AKAN HILANG", artist=""},        {id="rbxassetid://139298110131403", name="SERANA", artist=""},        {id="rbxassetid://82269526324787", name="UTOPIA HUJAN", artist=""},        {id="rbxassetid://75686649986453", name="JAKARTA HARI INI", artist=""},        {id="rbxassetid://98257780312256", name="AL Ghazali KESAYANGANKU", artist=""},        {id="rbxassetid://118182203343782", name="SELURUH NAFAS INI AL GHAZALI", artist=""},        {id="rbxassetid://95080754270253", name="PUDAR ROSSA", artist=""},        {id="rbxassetid://111417042398302", name="BRING ME TO LIFE", artist=""},        {id="rbxassetid://97574638837693", name="CUP OF JOE MULTO", artist=""},        {id="rbxassetid://93374686543252", name="ok with out you", artist=""},        {id="rbxassetid://111094481733044", name="risk it all", artist=""},        {id="rbxassetid://82162714102729", name="Timeless-The Weeknd", artist=""},        {id="rbxassetid://132497938577328", name="Yo Bunny", artist=""},        {id="rbxassetid://118315804375467", name="White Tee", artist=""},        {id="rbxassetid://112748273890049", name="DIAMOND MQT", artist=""},        {id="rbxassetid://89831490305285", name="NO ERA AMOR", artist=""},        {id="rbxassetid://113568851878579", name="Rock That Body", artist=""},        {id="rbxassetid://88117000154040", name="MANGO", artist=""},        {id="rbxassetid://114191942698668", name="i love you so", artist=""},        {id="rbxassetid://105663768150465", name="confess your lover", artist=""},        {id="rbxassetid://114339730158889", name="notion", artist=""},        {id="rbxassetid://100991657598498", name="batte forte", artist=""},        {id="rbxassetid://95554192381753", name="boys a liar", artist=""},        {id="rbxassetid://109149632133821", name="alone alan walker", artist=""},        {id="rbxassetid://107887768910692", name="summertime", artist=""},        {id="rbxassetid://129689476828113", name="7 rings", artist=""},        {id="rbxassetid://98337901681441", name="dia delicia", artist=""},        {id="rbxassetid://131094825741877", name="mambo jambo", artist=""},        {id="rbxassetid://111351357978027", name="let the world burn", artist=""},        {id="rbxassetid://72678301552319", name="rock that body", artist=""},        {id="rbxassetid://74388399461660", name="on & on", artist=""},        {id="rbxassetid://114470764795648", name="happier marshmello", artist=""},        {id="rbxassetid://108092699453319", name="alone marshmello", artist=""},        {id="rbxassetid://125902207303673", name="y que fue", artist=""},        {id="rbxassetid://84570363516667", name="Yami Yami", artist=""},        {id="rbxassetid://109813107078767", name="fly me to the moon", artist=""},        {id="rbxassetid://100993094479665", name="it was you", artist=""},        {id="rbxassetid://99061601759308", name="marry an a cross", artist=""},        {id="rbxassetid://89610760702249", name="streo love", artist=""},        {id="rbxassetid://71939423568679", name="Kiss it better", artist=""},        {id="rbxassetid://82486078058691", name="Doubt Twenty One Pilots", artist=""},        {id="rbxassetid://122525489670033", name="Cook Pardon", artist=""},        {id="rbxassetid://70879716541062", name="No 1 Party Anthem", artist=""},        {id="rbxassetid://110919391228823", name="Low Cortisol", artist=""},        {id="rbxassetid://135213147622965", name="Into you", artist=""},        {id="rbxassetid://107378935108211", name="Die for u the weekend", artist=""},        {id="rbxassetid://104000508729120", name="TAKE ME BCK", artist=""},        {id="rbxassetid://115996264941094", name="DRUNK TEXT COVER WOMAN", artist=""},        {id="rbxassetid://104745955172001", name="finding a catholic man to love the love of my life - reality club", artist=""},        {id="rbxassetid://140030657581747", name="JOJI LIKE U DO", artist=""},        {id="rbxassetid://115286761390891", name="RADIOHED CREEPY", artist=""},        {id="rbxassetid://133999545543086", name="MULTO CUP OF JOE", artist=""},        {id="rbxassetid://104415337487177", name="DISA HOLIC PAMBASILET", artist=""},        {id="rbxassetid://79972660352710", name="DRIVER LICENSE", artist=""},        {id="rbxassetid://82544116533013", name="MY LOVE", artist=""},        {id="rbxassetid://98193982795910", name="Still yours tonight", artist=""},        {id="rbxassetid://119603387493082", name="Slow light rising", artist=""},        {id="rbxassetid://121888323869383", name="Not here", artist=""},        {id="rbxassetid://102021410631118", name="Your always there", artist=""},        {id="rbxassetid://104126242604436", name="Hearts out of line", artist=""},        {id="rbxassetid://83424082312174", name="Forever in my mind", artist=""},        {id="rbxassetid://87543116048841", name="Let you go with a smile", artist=""},        {id="rbxassetid://121031750977586", name="You are my everything", artist=""},        {id="rbxassetid://134761795685588", name="Gone without goodbye", artist=""},        {id="rbxassetid://122663255354685", name="Until we meet again", artist=""},        {id="rbxassetid://135584977404939", name="Soft goodbye", artist=""},        {id="rbxassetid://83943063538795", name="A THOUSAND YEARS", artist=""},        {id="rbxassetid://132417947544523", name="MY HEART WILL GO ON", artist=""},        {id="rbxassetid://86316862829978", name="DEAR GOD", artist=""},        {id="rbxassetid://107082200998987", name="LILY", artist=""},        {id="rbxassetid://133193396302237", name="THAT SHOULD BE ME", artist=""},        {id="rbxassetid://89433429094554", name="Inggris", artist=""},        {id="rbxassetid://124692889945283", name="im yours", artist=""},        {id="rbxassetid://132245999482129", name="numb", artist=""},        {id="rbxassetid://70621522505799", name="Stay With Me", artist=""},        {id="rbxassetid://132697275131753", name="ONE MORE LIGHT", artist=""},        {id="rbxassetid://80146405023122", name="VISITING HOURS", artist=""},        {id="rbxassetid://107640209448951", name="BENSONE BOONE IN THE STARS", artist=""},        {id="rbxassetid://106476385308153", name="ONE IN A MILLION", artist=""},        {id="rbxassetid://74703047909199", name="MULTO X ABOUT YOU", artist=""},        {id="rbxassetid://109623463614511", name="BEAUTY AND A BEAT", artist=""},        {id="rbxassetid://138056089016273", name="WE RIDE ON", artist=""},        {id="rbxassetid://137293338992309", name="ALL I ASK", artist=""},        {id="rbxassetid://86351999812492", name="BAD OMENS JUST PRETEND", artist=""},        {id="rbxassetid://92138971240477", name="THE ONE THAT GOT AWAY", artist=""},        {id="rbxassetid://107989251655963", name="WE ON FIRE N TEAM", artist=""},        {id="rbxassetid://74299516242980", name="BROKEN ANGLE", artist=""},        {id="rbxassetid://131390866165882", name="BOUNCE &PA BKB", artist=""},        {id="rbxassetid://121645674019611", name="LOVE ME NOT", artist=""},        {id="rbxassetid://122894183909858", name="DROP DEAD OLIVIA RODRIGO", artist=""},        {id="rbxassetid://86981717742783", name="Lotus", artist=""},        {id="rbxassetid://99471948694270", name="CRAZYFROG BY CRSTN", artist=""},        {id="rbxassetid://138413902400298", name="PRECENT BY CRSTN", artist=""},        {id="rbxassetid://120313972450310", name="golden brown", artist=""},        {id="rbxassetid://81858790822731", name="the best part", artist=""},        {id="rbxassetid://107936871198253", name="xxxtenations", artist=""},        {id="rbxassetid://105001706788234", name="hope", artist=""},        {id="rbxassetid://77867143295334", name="Moonlight", artist=""},        {id="rbxassetid://15689451063", name="metamorfosis", artist=""},        {id="rbxassetid://82097579442332", name="lotus", artist=""},        {id="rbxassetid://97212310868241", name="DJ Drop No Lie", artist=""},
            {id="rbxassetid://139049085515888", name="DJ Boxing on the Star", artist=""},
            {id="rbxassetid://109749726405984", name="DJ Drop the Bass", artist=""},
            {id="rbxassetid://135356574120184", name="DJ Propaganda", artist=""},
            {id="rbxassetid://83777453179914", name="DJ Party People", artist=""},
            {id="rbxassetid://109184193897016", name="DJ Shake That", artist=""},
            {id="rbxassetid://116358628732093", name="DJ Wake Up", artist=""},
            {id="rbxassetid://109207664651325", name="DJ Boomerang", artist=""},
            {id="rbxassetid://95158960995959", name="DJ Party Song", artist=""},
            {id="rbxassetid://94197925697408", name="DJ Low Track", artist=""},
            {id="rbxassetid://110936152657534", name="DJ Crazy Dope", artist=""},
            {id="rbxassetid://85427648559465", name="DJ Phut Hon", artist=""},
            {id="rbxassetid://71524249419499", name="DJ Baile Funk 10", artist=""},
            {id="rbxassetid://74810971700392", name="DJ Madu dan Garam", artist=""},
            {id="rbxassetid://108298274142964", name="DJ Sound Horeg Prindavan", artist=""},
            {id="rbxassetid://75732729256441", name="DJ India", artist=""},
            {id="rbxassetid://127620210026197", name="DJ Sayang Culik Aku Dong", artist=""},
            {id="rbxassetid://85857435480264", name="DJ Khalayan Tingkat Tinggi", artist=""},
            {id="rbxassetid://116255319981650", name="DJ Jamilah Aisyah", artist=""},
            {id="rbxassetid://104207837699519", name="DJ Tabole Bale", artist=""},
            {id="rbxassetid://77533933904801", name="DJ Coba Coba", artist=""},
            {id="rbxassetid://84272432192031", name="DJ Mejikuhibinui", artist=""},
            {id="rbxassetid://118390472006859", name="DJ Party Shaker", artist=""},
            {id="rbxassetid://90145710334449", name="DJ Lu Mampu Ga Bos", artist=""},
            {id="rbxassetid://96077163288111", name="DJ Jika Tidak Hari Ini", artist=""},
            {id="rbxassetid://109025172796477", name="DJ Galaxy", artist=""},
            {id="rbxassetid://112443233864493", name="DJ Wale Babu", artist=""},
            {id="rbxassetid://99275097706406", name="DJ Mati Aku Dikejar Cinta", artist=""},
            {id="rbxassetid://111530724718992", name="DJ Pargoy Cenat Cenut", artist=""},
            {id="rbxassetid://105935548669522", name="DJ Funkot Stesu Stesu", artist=""},
            {id="rbxassetid://127548536837903", name="DJ Funkot Velocity", artist=""},
            {id="rbxassetid://76319653516761", name="DJ Mantap Mantap", artist=""},
            {id="rbxassetid://104291477079374", name="DJ Lupa Ingat", artist=""},
            {id="rbxassetid://1844008189", name="DJ Turn the Music", artist=""},
            {id="rbxassetid://73257575772632", name="DJ Fiesta", artist=""},
            {id="rbxassetid://101608805472261", name="DJ Mexico King", artist=""},
            {id="rbxassetid://101419525809543", name="DJ Ee Ee Kenceng Banget", artist=""},
            {id="rbxassetid://90471492509215", name="DJ Pong Pong Enak", artist=""},
            {id="rbxassetid://1842658587", name="Megamix", artist=""},
            {id="rbxassetid://91089804280618", name="Suka Suka Bahagia", artist=""},
            {id="rbxassetid://136842585273816", name="Nanana Menissu", artist=""},
            {id="rbxassetid://70860648654984", name="Funkot Tung Tung Sahur", artist=""},
            {id="rbxassetid://79073283903510", name="Joget Lalala", artist=""},
            {id="rbxassetid://109109569895008", name="Capybara Song", artist=""},
            {id="rbxassetid://137067689748748", name="Pargoy Bass", artist=""},
            {id="rbxassetid://12662884943103", name="Dangdut Oh Dangdut", artist=""},
            {id="rbxassetid://134435445558993", name="Bintang 5", artist=""},
            {id="rbxassetid://133574412216668", name="Tokyo Drift", artist=""},
            {id="rbxassetid://90851490275942", name="That or That", artist=""},
            {id="rbxassetid://83276780295701", name="Fck Queen Elizabeth", artist=""},
            {id="rbxassetid://138383691590612", name="Tisakorean - iPhone", artist=""},
            {id="rbxassetid://115832485029273", name="DJ SonAsu", artist=""},
            {id="rbxassetid://89759938634210", name="Singkong dan Keju", artist=""},
            {id="rbxassetid://100790333280969", name="Jangan Tunggu Lama-lama", artist=""},
            {id="rbxassetid://119822943881590", name="Yali Yali", artist=""},
            {id="rbxassetid://110949419969810", name="Lambada", artist=""},
            {id="rbxassetid://113479403085978", name="DJ Maydonoz", artist=""},
            {id="rbxassetid://76851950494391", name="DJ Bunga Hati", artist=""},
            {id="rbxassetid://85411032344879", name="Ayy", artist=""},
            {id="rbxassetid://96966974660960", name="New Hearts", artist=""},
            {id="rbxassetid://135018311294635", name="Cinamon Girl", artist=""},
            {id="rbxassetid://75966793604872", name="DJ Dedrick", artist=""},
            {id="rbxassetid://123668967867004", name="Nurlela", artist=""},
            {id="rbxassetid://121662262869987", name="Injit Semut", artist=""},
            {id="rbxassetid://129988226070628", name="Nasty Girl", artist=""},
            {id="rbxassetid://139825186779265", name="ABG Tua", artist=""},
            {id="rbxassetid://130721206402716", name="Kamnh", artist=""},
            {id="rbxassetid://119254319180287", name="Ayo Sayang Culik Aku Dong", artist=""},
            {id="rbxassetid://139590201617508", name="Dola", artist=""},
            {id="rbxassetid://111278874582591", name="Gk Tau Judulnya", artist=""},
            {id="rbxassetid://136681353220472", name="Regge Sedia Aku Sebelum Hujan", artist=""},
            {id="rbxassetid://135473905127296", name="DJ Thailand", artist=""},
            {id="rbxassetid://117052993794241", name="Kopi Dangdut", artist=""},
        }
    
        local musicSound = MUSIC_SOUND_SERVICE:FindFirstChild("N3K0P01_MusicPlayer")
        if musicSound and not musicSound:IsA("Sound") then
            pcall(function() musicSound:Destroy() end)
            musicSound = nil
        end
        if not musicSound then
            musicSound = Instance.new("Sound")
            musicSound.Name = "N3K0P01_MusicPlayer"
            musicSound.Parent = MUSIC_SOUND_SERVICE
        end
        musicSound.Volume = 0.5
        musicSound.Looped = false
        pcall(function() musicSound:Stop() end)
    
        local musicCurrent = 1
        local musicShuffle = false
        local musicRepeat = false
        local musicLoading = false
        local musicToken = 0
        local musicVolume = 0.5
        local musicFloatVisible = false
    
        local musicSection = VertexUI:CreateSection(MiscPage, "Music Player", ICO.MISC)
        pcall(function()
            musicSection:SetAttribute("N3K0P01_SearchSection", true)
            musicSection:SetAttribute("N3K0P01_SearchSectionTitle", "Music Player")
            musicSection:SetAttribute("N3K0P01_SearchPage", "Misc")
        end)
        local musicStatus = "Ready"
        local musicRows = {}
        local musicStatusRow = FT(UDim2.new(1, 0, 0, 25), nil, musicSection)
        local musicStatusLabel = TL("STATUS  •  " .. musicStatus, 10, C.TXT_DIM, false,
            musicStatusRow, UDim2.new(0, 0, 0, 0), UDim2.new(1, 0, 1, 0))
        local function setMusicStatus(message)
            musicStatus = tostring(message or "")
            if musicStatusLabel and musicStatusLabel.Parent then
                musicStatusLabel.Text = "STATUS  •  " .. musicStatus
            end
        end
    
        local function musicNextIndex()
            if musicShuffle and #MUSIC_SONGS > 1 then
                local nextIndex = musicCurrent
                for _ = 1, 10 do
                    nextIndex = math.random(1, #MUSIC_SONGS)
                    if nextIndex ~= musicCurrent then break end
                end
                return nextIndex
            end
            return (musicCurrent % #MUSIC_SONGS) + 1
        end
    
        local function musicLoadSong(index, autoplay)
            index = math.floor(tonumber(index) or 1)
            if not MUSIC_SONGS[index] then return end
            musicToken = musicToken + 1
            local myToken = musicToken
            musicCurrent = index
            local song = MUSIC_SONGS[index]
            if musicRows then
                for rowIndex, row in ipairs(musicRows) do
                    row.BackgroundColor3 = (rowIndex == musicCurrent) and C.T_ON or C.BTN_BG
                end
            end
            musicLoading = true
            setMusicStatus("Loading: " .. tostring(song.name))
            pcall(function()
                musicSound:Stop()
                musicSound.TimePosition = 0
                musicSound.SoundId = ""
            end)
    
            task.spawn(function()
                local loadedOK = pcall(function()
                    musicSound.SoundId = song.id
                    MUSIC_CONTENT_PROVIDER:PreloadAsync({ musicSound })
                end)
                if myToken ~= musicToken then return end
    
                local deadline = os.clock() + 8
                while loadedOK and musicSound.TimeLength <= 0 and os.clock() < deadline do
                    if myToken ~= musicToken then return end
                    task.wait(0.1)
                end
                if myToken ~= musicToken then return end
    
                musicLoading = false
                if not loadedOK or musicSound.TimeLength <= 0 then
                    setMusicStatus("Audio gagal dimuat: " .. tostring(song.name))
                    return
                end
    
                musicSound.Volume = musicVolume
                if autoplay then
                    local playOK = pcall(function() musicSound:Play() end)
                    setMusicStatus(playOK and ("Playing: " .. tostring(song.name)) or "Playback gagal")
                else
                    setMusicStatus("Loaded: " .. tostring(song.name))
                end
            end)
        end
    
        local playlistHeader = FT(UDim2.new(1, 0, 0, 18), nil, musicSection)
        TL("PLAYLIST  •  " .. tostring(#MUSIC_SONGS) .. " TRACKS", 10, C.TXT_DIM, true,
            playlistHeader, UDim2.new(0, 0, 0, 0), UDim2.new(1, 0, 1, 0))
        local musicList = Instance.new("ScrollingFrame")
        musicList.Name = "MusicPlaylist"
        musicList.Size = UDim2.new(1, 0, 0, 168)
        musicList.BackgroundColor3 = C.BOX_BG
        musicList.BackgroundTransparency = 0.08
        musicList.BorderSizePixel = 0
        musicList.ScrollBarThickness = 4
        musicList.ScrollBarImageColor3 = C.TXT_DIM
        musicList.AutomaticCanvasSize = Enum.AutomaticSize.Y
        musicList.CanvasSize = UDim2.new(0, 0, 0, 0)
        musicList.Parent = musicSection
        R(8, musicList)
        Stroke(C.BOX_STROKE, 1, musicList)
        local musicListLayout = Instance.new("UIListLayout")
        musicListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        musicListLayout.Padding = UDim.new(0, 3)
        musicListLayout.Parent = musicList
        local musicListPadding = Instance.new("UIPadding")
        musicListPadding.PaddingTop = UDim.new(0, 5)
        musicListPadding.PaddingBottom = UDim.new(0, 5)
        musicListPadding.PaddingLeft = UDim.new(0, 5)
        musicListPadding.PaddingRight = UDim.new(0, 5)
        musicListPadding.Parent = musicList
        local function highlightMusicRow()
            for index, row in ipairs(musicRows) do
                row.BackgroundColor3 = (index == musicCurrent) and C.T_ON or C.BTN_BG
            end
        end
        for index, song in ipairs(MUSIC_SONGS) do
            local row = Instance.new("TextButton")
            row.Name = "Track_" .. tostring(index)
            row.Size = UDim2.new(1, -2, 0, 27)
            row.BackgroundColor3 = C.BTN_BG
            row.BorderSizePixel = 0
            row.AutoButtonColor = false
            row.Text = string.format("%03d  •  %s", index, tostring(song.name or "Unknown Track"))
            row.TextColor3 = C.TXT
            row.TextSize = 9
            row.Font = Enum.Font.Gotham
            row.TextXAlignment = Enum.TextXAlignment.Left
            row.LayoutOrder = index
            row.Parent = musicList
            R(6, row)
            local rowPadding = Instance.new("UIPadding")
            rowPadding.PaddingLeft = UDim.new(0, 8)
            rowPadding.Parent = row
            table.insert(musicRows, row)
            MarkSearchItem(row, tostring(song.name or ("Track " .. index)), "Music playlist track")
            row.Activated:Connect(function()
                musicCurrent = index
                highlightMusicRow()
                musicLoadSong(index, true)
            end)
        end
        highlightMusicRow()
    
        local function musicPlayPause()
            if musicLoading then return end
            if musicSound.SoundId == "" then
                musicLoadSong(musicCurrent, true)
                return
            end
            if musicSound.IsPlaying then
                pcall(function() musicSound:Pause() end)
                setMusicStatus("Paused")
            else
                local ok = pcall(function() musicSound:Play() end)
                setMusicStatus(ok and ("Playing: " .. tostring(MUSIC_SONGS[musicCurrent].name)) or "Playback gagal")
            end
        end
    
        local function musicPrevious()
            local index = musicCurrent - 1
            if index < 1 then index = #MUSIC_SONGS end
            musicLoadSong(index, true)
        end
    
        local function musicNext()
            musicLoadSong(musicNextIndex(), true)
        end
    
        MarkSearchItem(VertexUI:AddButton(musicSection, "Play / Pause", musicPlayPause), "Play / Pause", "Play or pause the selected music track")
        MarkSearchItem(VertexUI:AddButton(musicSection, "Previous Track", musicPrevious), "Previous Track", "Play the previous music track")
        MarkSearchItem(VertexUI:AddButton(musicSection, "Next Track", musicNext), "Next Track", "Play the next music track")
        MarkSearchItem(VertexUI:AddButton(musicSection, "Stop Playback", function()
            musicToken = musicToken + 1
            musicLoading = false
            pcall(function() musicSound:Stop(); musicSound.TimePosition = 0 end)
            setMusicStatus("Stopped")
        end), "Stop Playback", "Stop music playback")
        MarkSearchItem(VertexUI:AddToggle(musicSection, "Shuffle", false, function(value)
            musicShuffle = value == true
            setMusicStatus(musicShuffle and "Shuffle enabled" or "Shuffle disabled")
        end, "Play a random track after the current song."), "Shuffle", "Play a random track after the current song")
        MarkSearchItem(VertexUI:AddToggle(musicSection, "Repeat Current Track", false, function(value)
            musicRepeat = value == true
            setMusicStatus(musicRepeat and "Repeat enabled" or "Repeat disabled")
        end, "Repeat the current track when it ends."), "Repeat Current Track", "Repeat the current track when it ends")
        MarkSearchItem(VertexUI:AddSlider(musicSection, "Volume", 0, 100, 50, "%", function(value)
            musicVolume = math.clamp((tonumber(value) or 50) / 100, 0, 1)
            musicSound.Volume = musicVolume
        end, 1), "Volume", "Music playback volume")
    
        -- Compact floating player, optionally shown over the game.
        local mini = Instance.new("Frame")
        mini.Name = "N3K0P01_MusicMiniPlayer"
        mini.Size = UDim2.fromOffset(238, 88)
        mini.AnchorPoint = Vector2.new(1, 1)
        mini.Position = UDim2.new(1, -14, 1, -112)
        mini.BackgroundColor3 = C.BOX_BG
        mini.BackgroundTransparency = 1
        mini.BorderSizePixel = 0
        mini.Visible = false
        mini.Active = true
        mini.ClipsDescendants = true
        mini.ZIndex = 800
        mini.Parent = Gui
        R(12, mini)
        local miniBackground = Instance.new("ImageLabel")
        miniBackground.Name = "MusicBackgroundImage"
        miniBackground.Size = UDim2.fromScale(1, 1)
        miniBackground.Position = UDim2.fromScale(0, 0)
        miniBackground.BackgroundTransparency = 1
        miniBackground.BorderSizePixel = 0
        miniBackground.Image = N3K0P01_FLOATING_BG_ASSET
        miniBackground.ImageTransparency = 0.12
        miniBackground.ScaleType = Enum.ScaleType.Crop
        miniBackground.Active = false
        miniBackground.ZIndex = 800
        miniBackground.Parent = mini
        R(12, miniBackground)
        local miniShade = Instance.new("Frame")
        miniShade.Name = "MusicBackgroundShade"
        miniShade.Size = UDim2.fromScale(1, 1)
        miniShade.BackgroundColor3 = C.BOX_BG
        miniShade.BackgroundTransparency = 0.38
        miniShade.BorderSizePixel = 0
        miniShade.ZIndex = 800
        miniShade.Parent = mini
        R(12, miniShade)
        Stroke(C.STROKE, 1.2, mini)
    
        local miniHeader = Instance.new("Frame")
        miniHeader.Size = UDim2.new(1, -12, 0, 22)
        miniHeader.Position = UDim2.fromOffset(6, 5)
        miniHeader.BackgroundTransparency = 1
        miniHeader.Active = true
        miniHeader.ZIndex = 801
        miniHeader.Parent = mini
        local miniTitle = TL("N3K0P01 MUSIC", 10, C.TXT, true, miniHeader,
            UDim2.new(0, 0, 0, 0), UDim2.new(1, -24, 1, 0))
        miniTitle.ZIndex = 802
        local miniClose = Instance.new("TextButton")
        miniClose.Size = UDim2.fromOffset(20, 20)
        miniClose.Position = UDim2.new(1, -20, 0, 0)
        miniClose.BackgroundTransparency = 1
        miniClose.Text = "×"
        miniClose.TextColor3 = C.TXT
        miniClose.TextSize = 17
        miniClose.Font = Enum.Font.GothamBold
        miniClose.ZIndex = 803
        miniClose.Parent = miniHeader
        local setMiniToggle
        miniClose.Activated:Connect(function()
            if setMiniToggle then
                setMiniToggle(false, true)
            else
                musicFloatVisible = false
                mini.Visible = false
            end
        end)
        pcall(function() Drag(mini, miniHeader) end)
    
        local miniTrack = TL("Ready", 9, C.TXT_DIM, false, mini,
            UDim2.fromOffset(8, 29), UDim2.new(1, -16, 0, 16))
        miniTrack.ZIndex = 802
        local miniProgressBG = Instance.new("Frame")
        miniProgressBG.Size = UDim2.new(1, -16, 0, 3)
        miniProgressBG.Position = UDim2.fromOffset(8, 50)
        miniProgressBG.BackgroundColor3 = C.SLIDER_BG
        miniProgressBG.BorderSizePixel = 0
        miniProgressBG.ZIndex = 802
        miniProgressBG.Parent = mini
        R(2, miniProgressBG)
        local miniProgress = Instance.new("Frame")
        miniProgress.Size = UDim2.new(0, 0, 1, 0)
        miniProgress.BackgroundColor3 = C.SLIDER_FILL
        miniProgress.BorderSizePixel = 0
        miniProgress.ZIndex = 803
        miniProgress.Parent = miniProgressBG
        R(2, miniProgress)
    
        local function miniButton(text, x, width, callback)
            local button = Instance.new("TextButton")
            button.Size = UDim2.fromOffset(width, 25)
            button.Position = UDim2.fromOffset(x, 57)
            button.BackgroundColor3 = C.BTN_BG
            button.BorderSizePixel = 0
            button.Text = text
            button.TextColor3 = C.TXT
            button.Font = Enum.Font.GothamBold
            button.TextSize = 10
            button.AutoButtonColor = false
            button.ZIndex = 803
            button.Parent = mini
            R(7, button)
            button.Activated:Connect(callback)
            return button
        end
        miniButton("PREV", 8, 54, musicPrevious)
        miniButton("PLAY / PAUSE", 67, 104, musicPlayPause)
        miniButton("NEXT", 176, 54, musicNext)
    
        local _, miniToggleSetter = VertexUI:AddToggle(musicSection, "Floating Mini Player", false, function(value)
            musicFloatVisible = value == true
            mini.Visible = musicFloatVisible
        end, "Show compact playback controls over the game.")
        setMiniToggle = miniToggleSetter
    
        musicSound.Ended:Connect(function()
            if musicRepeat then
                musicLoadSong(musicCurrent, true)
            else
                musicNext()
            end
        end)
    
        local musicRenderConnection
        musicRenderConnection = RunService.RenderStepped:Connect(function()
            if not Gui or not Gui.Parent then
                if musicRenderConnection then musicRenderConnection:Disconnect() end
                return
            end
            if musicSound.TimeLength > 0 then
                miniProgress.Size = UDim2.new(math.clamp(musicSound.TimePosition / musicSound.TimeLength, 0, 1), 0, 1, 0)
            else
                miniProgress.Size = UDim2.new(0, 0, 1, 0)
            end
            local song = MUSIC_SONGS[musicCurrent]
            local name = song and song.name or "Ready"
            miniTrack.Text = string.format("%s  •  %d/%d", tostring(name), musicCurrent, #MUSIC_SONGS)
        end)
    end
end)

VertexUI.MainPage = SurvivorPage
VertexUI:SelectTab("Survivor")

-- Logo/border animasi pada window dan navbar.
AddGlowBorder(Win, 2, 3)
AddGlowBorder(Nav, 1.5, 2.5)

_G.N3K0P01_UI = VertexUI
return VertexUI
