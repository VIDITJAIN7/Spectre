--[[
 Spectre - Horror-themed VLC Extension
 Triggers random scary events during playback with downloaded assets
 
 Author: VLC Horror Extension
 Version: 1.0
 Compatible with: VLC 3.0.x
--]]

--------------------------------------------------------------------------------
-- CONFIGURATION
--------------------------------------------------------------------------------

-- API Keys from appsettings.json
local UNSPLASH_KEY = "85X1wfGGaP0xnKVBGQx6xv49fOE4-4xELwZBfruitXQ"
local FREESOUND_KEY = "HMTnCSkqCBzRXCZO3ZNQM6GvIQmU48YG0PazHrUq"

-- Search terms for horror content
local SEARCH_TERMS = {"scary face", "skull", "ghost", "horror", "zombie", "clown"}

-- Trigger settings
local CHECK_INTERVAL = 30000000  -- 30 seconds in microseconds
local TRIGGER_CHANCE = 5         -- 5% chance per check

-- Cache directory for downloaded assets
local CACHE_DIR = nil  -- Will be set in activate()

-- State tracking
local is_running = false

--------------------------------------------------------------------------------
-- VLC EXTENSION DESCRIPTOR
--------------------------------------------------------------------------------

function descriptor()
    return {
        title = "Spectre",
        version = "1.0",
        author = "VLC Horror Extension",
        url = "http://www.videolan.org/vlc/",
        shortdesc = "Horror-themed random events",
        description = "Triggers random scary images and sounds during playback",
        capabilities = {"input-listener"}
    }
end

--------------------------------------------------------------------------------
-- ACTIVATION / DEACTIVATION
--------------------------------------------------------------------------------

function activate()
    vlc.msg.info("[Spectre] ========================================")
    vlc.msg.info("[Spectre] Extension activated")
    vlc.msg.info("[Spectre] Horror events enabled...")
    vlc.msg.info("[Spectre] ========================================")
    
    -- Initialize cache directory
    local home = vlc.config.userdatadir() or vlc.config.homedir()
    CACHE_DIR = home .. "/spectre_cache"
    
    -- Create cache directory
    create_directory(CACHE_DIR)
    
    -- Set running flag
    is_running = true
    
    -- Start the main trigger loop
    trigger_loop()
end

function deactivate()
    vlc.msg.info("[Spectre] Extension deactivated")
    vlc.msg.info("[Spectre] Horror events disabled")
    is_running = false
end

--------------------------------------------------------------------------------
-- MAIN TRIGGER LOOP
--------------------------------------------------------------------------------

function trigger_loop()
    vlc.msg.info("[Spectre] Starting trigger loop (checking every 30 seconds)")
    
    while is_running do
        -- Wait for 30 seconds
        vlc.misc.mwait(vlc.misc.mdate() + CHECK_INTERVAL)
        
        -- Check if we should trigger a scare (5% chance)
        local roll = math.random(100)
        vlc.msg.info("[Spectre] Scare check: rolled " .. roll .. "/100")
        
        if roll <= TRIGGER_CHANCE then
            vlc.msg.warn("[Spectre] ⚠️  TRIGGERING SCARE EVENT! ⚠️")
            trigger_scare_event()
        else
            vlc.msg.info("[Spectre] Safe... for now")
        end
    end
    
    vlc.msg.info("[Spectre] Trigger loop ended")
end

--------------------------------------------------------------------------------
-- SCARE EVENT TRIGGER
--------------------------------------------------------------------------------

function trigger_scare_event()
    -- Randomly choose between image or sound scare
    local scare_type = math.random(1, 2)
    
    if scare_type == 1 then
        vlc.msg.warn("[Spectre] 👻 Triggering IMAGE scare...")
        trigger_image_scare()
    else
        vlc.msg.warn("[Spectre] 🔊 Triggering SOUND scare...")
        trigger_sound_scare()
    end
    
    -- Log error message as requested
    vlc.msg.err("HELP ME")
end

--------------------------------------------------------------------------------
-- IMAGE SCARE
--------------------------------------------------------------------------------

function trigger_image_scare()
    -- Fetch scary image
    local image_path = fetch_scare_image()
    
    if image_path and file_exists(image_path) then
        vlc.msg.info("[Spectre] Image downloaded: " .. image_path)
        
        -- Display the image using OSD message
        vlc.osd.message("👻 SPECTRE 👻", vlc.osd.channel_create(), "top-right", 3000000)
        
        -- Try to show image via logo filter
        show_image_overlay(image_path)
        
        vlc.msg.err("[Spectre] 🖼️  SCARY IMAGE DISPLAYED!")
    else
        vlc.msg.err("[Spectre] Failed to fetch image, using fallback")
        vlc.osd.message("👻 SPECTRE WATCHES 👻", vlc.osd.channel_create(), "center", 5000000)
    end
end

--------------------------------------------------------------------------------
-- SOUND SCARE
--------------------------------------------------------------------------------

function trigger_sound_scare()
    -- Fetch scary sound
    local audio_path = fetch_scare_sound()
    
    if audio_path and file_exists(audio_path) then
        vlc.msg.info("[Spectre] Sound downloaded: " .. audio_path)
        
        -- Play the scary sound
        play_audio(audio_path)
        
        -- Show OSD notification
        vlc.osd.message("🔊 SPECTRE SCREAMS 🔊", vlc.osd.channel_create(), "center", 3000000)
        
        vlc.msg.err("[Spectre] 🔊 SCARY SOUND PLAYING!")
    else
        vlc.msg.err("[Spectre] Failed to fetch sound, using fallback")
        vlc.osd.message("🔊 LISTEN... 🔊", vlc.osd.channel_create(), "center", 5000000)
    end
end

--------------------------------------------------------------------------------
-- ASSET DOWNLOADER - FETCH SCARY IMAGE
--------------------------------------------------------------------------------

function fetch_scare_image()
    vlc.msg.info("[Spectre] Fetching scary image from Unsplash...")
    
    -- Choose random search term
    local search_term = SEARCH_TERMS[math.random(#SEARCH_TERMS)]
    local encoded_term = url_encode(search_term)
    
    -- Build API URL
    local api_url = "https://api.unsplash.com/photos/random?query=" .. 
                    encoded_term .. "&client_id=" .. UNSPLASH_KEY
    
    vlc.msg.info("[Spectre] API URL: " .. api_url)
    
    -- Fetch JSON response with error handling
    local success, json_data = pcall(function()
        return fetch_url(api_url)
    end)
    
    if not success or not json_data then
        vlc.msg.err("[Spectre] Failed to fetch from Unsplash API")
        return nil
    end
    
    -- Parse JSON to extract image URL
    local image_url = extract_json_url(json_data, "regular")
    
    if not image_url then
        vlc.msg.err("[Spectre] Failed to parse image URL from JSON")
        return nil
    end
    
    vlc.msg.info("[Spectre] Image URL: " .. image_url)
    
    -- Download the image
    local filename = CACHE_DIR .. "/scare_img_" .. os.time() .. ".jpg"
    local success, result = pcall(function()
        return download_file(image_url, filename)
    end)
    
    if success and result then
        return filename
    else
        vlc.msg.err("[Spectre] Failed to download image")
        return nil
    end
end

--------------------------------------------------------------------------------
-- ASSET DOWNLOADER - FETCH SCARY SOUND
--------------------------------------------------------------------------------

function fetch_scare_sound()
    vlc.msg.info("[Spectre] Fetching scary sound from Freesound...")
    
    -- Build API URL
    local api_url = "https://freesound.org/apiv2/search/text/?query=scream&token=" .. 
                    FREESOUND_KEY .. "&fields=id,name,previews&page_size=1"
    
    vlc.msg.info("[Spectre] API URL: " .. api_url)
    
    -- Fetch JSON response with error handling
    local success, json_data = pcall(function()
        return fetch_url(api_url)
    end)
    
    if not success or not json_data then
        vlc.msg.err("[Spectre] Failed to fetch from Freesound API")
        return nil
    end
    
    -- Parse JSON to extract audio URL
    local audio_url = extract_json_url(json_data, "preview-hq-mp3")
    
    if not audio_url then
        -- Try alternative preview format
        audio_url = extract_json_url(json_data, "preview-lq-mp3")
    end
    
    if not audio_url then
        vlc.msg.err("[Spectre] Failed to parse audio URL from JSON")
        return nil
    end
    
    vlc.msg.info("[Spectre] Audio URL: " .. audio_url)
    
    -- Download the audio
    local filename = CACHE_DIR .. "/scare_sound_" .. os.time() .. ".mp3"
    local success, result = pcall(function()
        return download_file(audio_url, filename)
    end)
    
    if success and result then
        return filename
    else
        vlc.msg.err("[Spectre] Failed to download audio")
        return nil
    end
end

--------------------------------------------------------------------------------
-- HTTP UTILITIES
--------------------------------------------------------------------------------

-- Fetch URL content using vlc.stream()
function fetch_url(url)
    vlc.msg.info("[Spectre] Fetching URL: " .. url)
    
    local stream = vlc.stream(url)
    if not stream then
        vlc.msg.err("[Spectre] Failed to open stream")
        return nil
    end
    
    local data = ""
    local chunk_size = 65536
    
    while true do
        local chunk = stream:read(chunk_size)
        if not chunk or #chunk == 0 then
            break
        end
        data = data .. chunk
    end
    
    vlc.msg.info("[Spectre] Fetched " .. #data .. " bytes")
    return data
end

-- Download file from URL to local path
function download_file(url, filepath)
    vlc.msg.info("[Spectre] Downloading: " .. url)
    vlc.msg.info("[Spectre] To: " .. filepath)
    
    local stream = vlc.stream(url)
    if not stream then
        vlc.msg.err("[Spectre] Failed to open download stream")
        return false
    end
    
    local file = io.open(filepath, "wb")
    if not file then
        vlc.msg.err("[Spectre] Failed to create file: " .. filepath)
        return false
    end
    
    local chunk_size = 65536
    local total_bytes = 0
    
    while true do
        local chunk = stream:read(chunk_size)
        if not chunk or #chunk == 0 then
            break
        end
        file:write(chunk)
        total_bytes = total_bytes + #chunk
    end
    
    file:close()
    
    vlc.msg.info("[Spectre] Downloaded " .. total_bytes .. " bytes")
    return total_bytes > 0
end

--------------------------------------------------------------------------------
-- JSON PARSING (Simple pattern matching for Lua 5.1)
--------------------------------------------------------------------------------

function extract_json_url(json_str, field_name)
    if not json_str then
        return nil
    end
    
    -- Try pattern: "field_name":"url"
    local pattern1 = '"' .. field_name .. '"%s*:%s*"([^"]+)"'
    local url = string.match(json_str, pattern1)
    
    if url then
        return url
    end
    
    -- Try pattern for nested objects: "field_name":{"url":"value"}
    local pattern2 = '"' .. field_name .. '"%s*:%s*{[^}]*"url"%s*:%s*"([^"]+)"'
    url = string.match(json_str, pattern2)
    
    if url then
        return url
    end
    
    -- Try pattern for urls object: "urls":{"regular":"value"}
    if field_name == "regular" then
        local pattern3 = '"urls"%s*:%s*{[^}]*"regular"%s*:%s*"([^"]+)"'
        url = string.match(json_str, pattern3)
    end
    
    return url
end

--------------------------------------------------------------------------------
-- MEDIA PLAYBACK
--------------------------------------------------------------------------------

function play_audio(audio_path)
    vlc.msg.info("[Spectre] Playing audio: " .. audio_path)
    
    -- Convert to file:// URL
    local file_url = "file:///" .. audio_path:gsub("\\", "/")
    
    -- Add to playlist and play
    vlc.playlist.add({{path=file_url, name="Spectre Scare Sound"}})
    
    vlc.msg.info("[Spectre] Audio added to playlist")
end

function show_image_overlay(image_path)
    vlc.msg.info("[Spectre] Attempting to show image overlay: " .. image_path)
    
    -- Try to enable logo filter to show image
    -- Note: This may not work in all VLC configurations
    local input = vlc.object.input()
    if input then
        vlc.var.set(input, "logo-file", image_path)
        vlc.var.set(input, "logo-opacity", 255)
        vlc.var.set(input, "logo-position", 5) -- Center
        
        vlc.msg.info("[Spectre] Logo filter configured")
    else
        vlc.msg.warn("[Spectre] No active input for logo filter")
    end
end

--------------------------------------------------------------------------------
-- FILE SYSTEM UTILITIES
--------------------------------------------------------------------------------

function create_directory(path)
    vlc.msg.info("[Spectre] Creating directory: " .. path)
    
    -- Windows-compatible directory creation
    local cmd = 'mkdir "' .. path .. '" 2>nul'
    os.execute(cmd)
    
    vlc.msg.info("[Spectre] Directory created/verified")
end

function file_exists(filepath)
    local file = io.open(filepath, "r")
    if file then
        file:close()
        return true
    end
    return false
end

--------------------------------------------------------------------------------
-- STRING UTILITIES
--------------------------------------------------------------------------------

function url_encode(str)
    if not str then
        return ""
    end
    
    str = string.gsub(str, "\n", "\r\n")
    str = string.gsub(str, "([^%w %-%_%.%~])",
        function(c)
            return string.format("%%%02X", string.byte(c))
        end)
    str = string.gsub(str, " ", "+")
    
    return str
end

--------------------------------------------------------------------------------
-- INITIALIZATION
--------------------------------------------------------------------------------

-- Seed random number generator
math.randomseed(os.time())

vlc.msg.info("[Spectre] ========================================")
vlc.msg.info("[Spectre] Extension loaded successfully")
vlc.msg.info("[Spectre] Ready to haunt your playback...")
vlc.msg.info("[Spectre] ========================================")
