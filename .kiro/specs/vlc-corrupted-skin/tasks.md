# Implementation Plan

- [x] 1. Create theme.xml file structure with root elements


  - Create the file at `vlc-3.0.21/share/skins2/default/theme.xml`
  - Write the XML declaration and root `<Theme>` element with name="Spectre" and version="1.0"
  - Add `<ThemeInfo>` element with metadata (name, author, email, webpage)
  - Ensure proper XML formatting and indentation
  - _Requirements: 1.1, 1.2_

- [x] 2. Define bitmap resource declarations


  - Create `<Bitmap>` element for main_bg.png with id="bg_main", file="default/main_bg.png", alphacolor="#FF00FF"
  - Create `<Bitmap>` element for buttons_strip.png with id="buttons_normal"
  - Create `<Bitmap>` element for buttons_hover.png with id="buttons_hover"
  - Create `<Bitmap>` element for cone_icon.png with id="cone_icon"
  - Ensure all bitmap elements include required attributes (id, file, alphacolor)
  - _Requirements: 1.4, 3.1, 3.2, 3.3_

- [x] 3. Create main window and layout structure


  - Define `<Window>` element with id="main_window", x="0", y="0", width="800", height="600", visible="true"
  - Add `<Layout>` child element with width="800" and height="600"
  - Reference bg_main bitmap as the window background
  - _Requirements: 2.1, 2.2, 2.3_

- [x] 4. Implement media control buttons


  - [x] 4.1 Create Play button with intentional Y-offset corruption


    - Define `<Button>` with id="btn_play", x="100", y="505" (corrupted: +5px offset)
    - Set lefttop="0 0" rightbottom="32 32" for sprite coordinates
    - Set up="#buttons_normal" and over="#buttons_hover"
    - Set action="vlc.play()" and tooltiptext="Play"
    - _Requirements: 4.1, 6.1_
  
  - [x] 4.2 Create Pause button


    - Define `<Button>` with id="btn_pause", x="140", y="500"
    - Set lefttop="32 0" rightbottom="64 32"
    - Set up="#buttons_normal" and over="#buttons_hover"
    - Set action="vlc.pause()" and tooltiptext="Pause"
    - _Requirements: 4.2_
  
  - [x] 4.3 Create Stop button


    - Define `<Button>` with id="btn_stop", x="180", y="500"
    - Set lefttop="64 0" rightbottom="96 32"
    - Set up="#buttons_normal" and over="#buttons_hover"
    - Set action="vlc.stop()" and tooltiptext="Stop"
    - _Requirements: 4.3_
  
  - [x] 4.4 Create Previous button


    - Define `<Button>` with id="btn_prev", x="220", y="500"
    - Set lefttop="96 0" rightbottom="128 32"
    - Set up="#buttons_normal" and over="#buttons_hover"
    - Set action="vlc.playlist.previous()" and tooltiptext="Previous"
    - _Requirements: 4.4_
  
  - [x] 4.5 Create Next button


    - Define `<Button>` with id="btn_next", x="260", y="500"
    - Set lefttop="128 0" rightbottom="160 32"
    - Set up="#buttons_normal" and over="#buttons_hover"
    - Set action="vlc.playlist.next()" and tooltiptext="Next"
    - _Requirements: 4.5_


  
  - [ ] 4.6 Create Fullscreen button
    - Define `<Button>` with id="btn_fullscreen", x="300", y="500"
    - Set lefttop="160 0" rightbottom="192 32"




    - Set up="#buttons_normal" and over="#buttons_hover"
    - Set action="vlc.fullscreen()" and tooltiptext="Fullscreen"
    - _Requirements: 4.6_



- [ ] 5. Implement slider controls
  - [ ] 5.1 Create time slider
    - Define `<Slider>` with id="time_slider", x="100", y="450", width="600", height="20"



    - Set value="time" for playback position binding
    - Set thickness="10" and tooltiptext="$T"
    - _Requirements: 5.1, 7.2_
  
  - [ ] 5.2 Create volume slider with width corruption
    - Define `<Slider>` with id="volume_slider", x="650", y="500", width="120", height="20" (corrupted: 3px narrower)
    - Set value="volume" for volume binding
    - Set thickness="10" and tooltiptext="$V"
    - _Requirements: 5.2, 6.2, 7.3_

- [ ] 6. Add hidden panel corruption element
  - Define `<Panel>` with id="jumpscare_overlay", x="0", y="0", width="800", height="600", visible="false"
  - Ensure the panel is hidden by default but can be programmatically revealed
  - _Requirements: 6.3_

- [ ]* 7. Create property-based test suite
  - [ ]* 7.1 Set up Python testing environment
    - Create test file `test_theme_properties.py`
    - Import lxml for XML parsing
    - Import hypothesis for property-based testing
    - Create helper function to parse theme.xml
    - _Requirements: All_
  
  - [ ]* 7.2 Write property test for theme root element structure
    - **Property 1: Theme root element structure**
    - Parse theme.xml and verify root element is `<Theme>`
    - Verify attributes name="Spectre" and version="1.0" exist
    - Verify document is well-formed XML
    - Configure to run 100 iterations
    - **Validates: Requirements 1.2, 1.3**
  
  - [ ]* 7.3 Write property test for bitmap path format consistency
    - **Property 2: Bitmap path format consistency**
    - Extract all `<Bitmap>` elements using XPath
    - For each bitmap, verify file attribute starts with "default/"
    - Verify no absolute paths (no leading "/")
    - Configure to run 100 iterations
    - **Validates: Requirements 1.4, 3.3**
  
  - [ ]* 7.4 Write property test for bitmap required attributes
    - **Property 3: Bitmap required attributes**
    - Extract all `<Bitmap>` elements
    - For each bitmap, verify presence of id, file, and alphacolor attributes
    - Configure to run 100 iterations
    - **Validates: Requirements 3.1**
  
  - [ ]* 7.5 Write property test for button hover state completeness
    - **Property 4: Button hover state completeness**
    - Extract all `<Button>` elements
    - For each button, verify both up and over attributes exist
    - Verify both reference valid bitmap IDs
    - Configure to run 100 iterations
    - **Validates: Requirements 4.7**
  
  - [ ]* 7.6 Write property test for slider required attributes
    - **Property 5: Slider required attributes**
    - Extract all `<Slider>` elements
    - For each slider, verify value, width, height, x, and y attributes exist
    - Configure to run 100 iterations
    - **Validates: Requirements 5.3**
  
  - [ ]* 7.7 Write property test for button action bindings
    - **Property 6: Button action bindings**
    - Extract all `<Button>` elements
    - For each button, verify action attribute exists
    - Verify action contains "vlc." prefix (valid VLC command)
    - Configure to run 100 iterations
    - **Validates: Requirements 7.1**
  
  - [ ]* 7.8 Write property test for valid XML structure
    - **Property 7: Valid XML structure**
    - Parse theme.xml and verify no XML syntax errors
    - Verify parsing succeeds despite corruption elements
    - Configure to run 100 iterations
    - **Validates: Requirements 6.4**

- [ ]* 8. Create unit tests for specific elements
  - [ ]* 8.1 Write test for file existence at correct path
    - Verify theme.xml exists at `vlc-3.0.21/share/skins2/default/theme.xml`
    - _Requirements: 1.1_
  
  - [ ]* 8.2 Write test for main window element
    - Verify `<Window>` element with id="main_window" exists
    - Verify width="800" and height="600" attributes
    - _Requirements: 2.1, 2.2_
  
  - [ ]* 8.3 Write test for Play button Y-offset corruption
    - Extract Play button element
    - Verify y="505" (5 pixels offset from standard 500)
    - Compare with other button Y-coordinates to confirm offset
    - _Requirements: 6.1_
  
  - [ ]* 8.4 Write test for volume slider width corruption
    - Extract volume slider element
    - Verify width="120" (3 pixels narrower than expected 123)
    - _Requirements: 6.2_
  
  - [ ]* 8.5 Write test for hidden panel element
    - Verify `<Panel>` with id="jumpscare_overlay" exists
    - Verify x="0", y="0", width="800", height="600", visible="false"
    - _Requirements: 6.3_
  
  - [ ]* 8.6 Write tests for all button coordinates
    - Verify Play button: lefttop="0 0" rightbottom="32 32"
    - Verify Pause button: lefttop="32 0" rightbottom="64 32"
    - Verify Stop button: lefttop="64 0" rightbottom="96 32"
    - Verify Previous button: lefttop="96 0" rightbottom="128 32"
    - Verify Next button: lefttop="128 0" rightbottom="160 32"
    - Verify Fullscreen button: lefttop="160 0" rightbottom="192 32"
    - _Requirements: 4.1, 4.2, 4.3, 4.4, 4.5, 4.6_

- [ ] 9. Checkpoint - Ensure all tests pass
  - Ensure all tests pass, ask the user if questions arise.
