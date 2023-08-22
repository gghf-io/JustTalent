-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local LibStub = _G.LibStub
local ADDON_NAME, private = ...

local JTGUI = private.NewLib("JTGUI")

JTGUI.config = {
    frame = {
        size = {
            width = 400,
            height = 200
        },
        isResizable = false,
        isMovable = true,
        isMouseEnabled = true,
        isTopLevel = true,
        position = "CENTER",
        level = 100,
        backdrop = BACKDROP_TUTORIAL_16_16
    }
}