-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local LibStub = _G.LibStub
local Self = LibStub("AceAddon-3.0"):NewAddon("JustTalent", "AceConsole-3.0")

local ADDON_NAME, private = ...

local JTGUI = private.ImportLib("JTGUI")
local JTUtils = private.ImportLib("JTUtils")

local frame = CreateFrame

-- char, realm, class, race, faction, factionrealm, profile, global
local default = {
    profile = {
        settings = true,
        isFrameOpen = false
    }
}

function Self:GetSpecInfo(key)
    local id, name, desc, icon, role = GetSpecializationInfo(GetSpecialization())
    return JTUtils.case(key) {
        id=id,
        name=name,
        desc=desc,
        icon=icon,
        role=role
    }
end

-----------------------------------------------------------------------
-- Addon Lifecycle
-----------------------------------------------------------------------

function Self:OnInitialize()
    private.db = LibStub("AceDB-3.0"):New("JustTalentDB", default, true)
    private.db.profile.name = UnitName("player")
    private.db.profile.faction = UnitFactionGroup("player")
    private.db.profile.className = UnitClass("player")
    Self:Print("[Event] Lifecycle: Initialized " .. private.db.profile.name .. " !")
end

function Self:OnEnable()
    Self:Print("[Event] Lifecycle: Enabled ".. private.db.profile.name .. " !")
end

function Self:OnDisable()
    Self:Print("[Event] Lifecycle: Disabled")
end

-----------------------------------------------------------------------
-- Register Slash command Main Frame
-----------------------------------------------------------------------
Self:RegisterChatCommand("jt", "SlashCommandOpenMainFrame")

function Self:SlashCommandOpenMainFrame()
    -- if !private.db.profile.isFrameOpen then
        -- private.db.profile.isFrameOpen = !private.db.profile.isFrameOpen
        frame = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
        frame:SetMovable(JTGUI.config.frame.isMovable)
        frame:SetResizable(JTGUI.config.frame.isResizable)
        frame:EnableMouse(JTGUI.config.frame.isMouseEnabled)
        frame:SetSize(JTGUI.config.frame.size.width, JTGUI.config.frame.size.height)
        frame:SetFrameLevel(JTGUI.config.frame.level)
        frame:SetToplevel(JTGUI.config.frame.isTopLevel)
        frame:SetBackdrop(JTGUI.config.frame.backdrop)
        frame:SetPoint("CENTER")
        frame:RegisterForDrag("LeftButton")
        frame:SetScript("OnDragStart", function(self, button)
            self:StartMoving()
        end)
        frame:SetScript("OnDragStop", function(self)
            self:StopMovingOrSizing()
        end)

        local icon = CreateFrame("Frame", nil, frame)
        icon:SetPoint("CENTER", 10)
        icon:SetSize(32, 32)
        icon.tex = icon:CreateTexture()
        icon.tex:SetAllPoints(icon)
        icon.tex:SetTexture(self:GetSpecInfo('icon'))

        local btnClose = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
        btnClose:SetSize(96, 22)
        btnClose:SetPoint("BOTTOMRIGHT", -16, 14)
        btnClose:SetText(CLOSE)
        btnClose:SetScript("OnClick", function()
            private.db.profile.isFrameOpen = false
            frame:Hide()
        end)
    -- else
    --     frame:Hide()
    -- end
end

-----------------------------------------------------------------------
-- GUI
-----------------------------------------------------------------------