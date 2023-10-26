-- Reference: https://wezfurlong.org/wezterm/config/files.html

-- Pull in the wezterm API
local wezterm = require("wezterm")

-- maximize on startup
-- local mux = wezterm.mux
-- wezterm.on("gui-attached", function(domain)
--     -- maximize all displayed windows on startup
--     local workspace = mux.get_active_workspace()
--     for _, window in ipairs(mux.all_windows()) do
--         if window:get_workspace() == workspace then
--             window:gui_window():maximize()
--         end
--     end
-- end)

-- This table will hold the configuration.
local config = wezterm.config_builder()

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- color scheme
config.color_scheme = "Catppuccin Frappe" -- Catppuccin themes: Latte / Frappe / Macchiato / Mocha

-- font
config.font = wezterm.font("JetBrainsMono Nerd Font Mono")

-- startup default domain
-- for example, launch WSL:Arch instead of default CMD in Windows
-- config.default_domain = 'WSL:Arch'

-- startup arguments
-- config.default_gui_startup_args = {
--     'ssh', '<SSH_USER>@<SSH_HOST>',
-- }

-- which render front-end to use
config.front_end = "WebGpu" -- OpenGL (GPU) / Software (CPU) / WebGpu (GPU); default is WebGpu

config.keys = {
    {
        key = "Insert",
        mods = "CTRL",
        -- action = wezterm.action.CopyTo("PrimarySelection"),  -- default
        action = wezterm.action.CopyTo("Clipboard"),
    },
    {
        key = "Insert",
        mods = "SHIFT",
        -- action = wezterm.action.PasteFrom("PrimarySelection"),  -- default
        action = wezterm.action.PasteFrom("Clipboard"),
    },
}

-- and finally, return the configuration to wezterm
return config
