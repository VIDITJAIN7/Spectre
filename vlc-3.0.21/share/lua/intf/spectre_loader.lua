--[[
 Spectre Auto-Loader Interface
 Automatically loads and activates the Spectre horror extension on VLC startup
 
 Usage: vlc --lua-intf spectre_loader
 Or add to vlcrc: lua-intf=spectre_loader
--]]

vlc.msg.info("========================================")
vlc.msg.info("[Spectre Loader] Starting auto-loader...")
vlc.msg.info("========================================")

-- Function to load the Spectre extension
local function load_spectre_extension()
    vlc.msg.info("[Spectre Loader] Attempting to load Spectre extension...")
    
    -- Get the extensions directory path
    local datadir = vlc.config.datadir()
    local ext_path = datadir .. "/lua/extensions/spectre.lua"
    
    vlc.msg.info("[Spectre Loader] Extension path: " .. ext_path)
    
    -- Check if the extension file exists
    local file = io.open(ext_path, "r")
    if not file then
        vlc.msg.err("[Spectre Loader] ERROR: spectre.lua not found at: " .. ext_path)
        vlc.msg.err("[Spectre Loader] Please ensure the extension is installed correctly")
        return false
    end
    file:close()
    
    vlc.msg.info("[Spectre Loader] Extension file found!")
    
    -- Try to load the extension using dofile
    -- This executes the extension script in the current Lua environment
    local success, err = pcall(function()
        dofile(ext_path)
    end)
    
    if not success then
        vlc.msg.err("[Spectre Loader] Failed to load extension: " .. tostring(err))
        return false
    end
    
    vlc.msg.info("[Spectre Loader] Extension loaded successfully!")
    
    -- Try to activate the extension
    -- Check if the activate function exists (defined in spectre.lua)
    if type(activate) == "function" then
        vlc.msg.info("[Spectre Loader] Activating Spectre extension...")
        
        local success, err = pcall(activate)
        
        if success then
            vlc.msg.info("[Spectre Loader] ✓ Spectre extension activated!")
            vlc.msg.info("[Spectre Loader] Horror events are now enabled")
            return true
        else
            vlc.msg.err("[Spectre Loader] Failed to activate extension: " .. tostring(err))
            return false
        end
    else
        vlc.msg.warn("[Spectre Loader] Extension loaded but activate() function not found")
        vlc.msg.warn("[Spectre Loader] Extension may not be properly initialized")
        return false
    end
end

-- Main execution
vlc.msg.info("[Spectre Loader] Initializing...")

-- Wait a moment for VLC to fully initialize
vlc.misc.mwait(vlc.misc.mdate() + 2000000) -- Wait 2 seconds

-- Load the extension
local result = load_spectre_extension()

if result then
    vlc.msg.info("========================================")
    vlc.msg.info("[Spectre Loader] SUCCESS!")
    vlc.msg.info("[Spectre Loader] Spectre is now haunting your VLC")
    vlc.msg.info("========================================")
else
    vlc.msg.err("========================================")
    vlc.msg.err("[Spectre Loader] FAILED to load Spectre")
    vlc.msg.err("[Spectre Loader] Check the error messages above")
    vlc.msg.err("========================================")
end

-- Keep the interface alive (required for VLC interfaces)
-- This prevents the interface from immediately exiting
vlc.msg.info("[Spectre Loader] Loader interface staying active...")

-- Simple keep-alive loop
while true do
    vlc.misc.mwait(vlc.misc.mdate() + 60000000) -- Check every 60 seconds
    
    -- Optional: Check if extension is still running
    if type(is_running) ~= "nil" and not is_running then
        vlc.msg.warn("[Spectre Loader] Spectre extension has stopped")
        break
    end
end

vlc.msg.info("[Spectre Loader] Loader interface shutting down")
