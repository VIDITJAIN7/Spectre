# Requirements Document

## Introduction

This feature involves creating a custom VLC Skins2 XML theme file with intentional design flaws for testing or demonstration purposes. The theme, named "Spectre", will include standard media player controls (play, pause, stop, etc.) with subtle visual misalignments and hidden elements that create an unsettling user experience.

## Glossary

- **VLC Skins2**: VLC's theming system that uses XML files to define custom user interfaces
- **Theme XML**: The primary XML file (theme.xml) that defines the skin's structure, layout, and controls
- **Bitmap**: An image resource referenced in the skin XML
- **Button Strip**: A single image containing multiple button states arranged horizontally
- **Slider**: A UI control for adjusting values like volume or playback position
- **DTD**: Document Type Definition - the schema that defines valid VLC Skins2 XML structure
- **Control**: An interactive UI element (button, slider, etc.)
- **Panel**: A container element that can hold other controls

## Requirements

### Requirement 1

**User Story:** As a VLC skin developer, I want to create a valid Skins2 XML file, so that VLC can load and render the custom theme.

#### Acceptance Criteria

1. WHEN the theme.xml file is created THEN the system SHALL place it at the path `vlc-3.0.21/share/skins2/default/theme.xml`
2. WHEN the XML is parsed THEN the system SHALL include a root `<Theme>` element with attributes name="Spectre" and version="1.0"
3. WHEN the XML structure is validated THEN the system SHALL comply with the VLC Skins2 DTD specification
4. WHEN bitmap resources are referenced THEN the system SHALL use the path format "default/[filename]"
5. WHEN VLC loads the skin THEN the system SHALL successfully parse the XML without errors

### Requirement 2

**User Story:** As a theme designer, I want to define the main window structure, so that the player has a visible interface.

#### Acceptance Criteria

1. WHEN the main window is defined THEN the system SHALL create a `<Window>` element with id="main_window"
2. WHEN the window dimensions are set THEN the system SHALL specify width="800" and height="600"
3. WHEN the window background is configured THEN the system SHALL reference main_bg.png as the background bitmap
4. WHEN the window is rendered THEN the system SHALL display all child controls within the window boundaries

### Requirement 3

**User Story:** As a theme designer, I want to define bitmap resources, so that controls can reference visual assets.

#### Acceptance Criteria

1. WHEN bitmap elements are created THEN the system SHALL include all required attributes (id, file, alphacolor)
2. WHEN the button strip bitmap is defined THEN the system SHALL reference buttons_strip.png
3. WHEN bitmap paths are specified THEN the system SHALL use relative paths from the skins2 directory
4. WHEN bitmaps are loaded THEN the system SHALL handle missing files gracefully

### Requirement 4

**User Story:** As a theme designer, I want to create standard media control buttons, so that users can control playback.

#### Acceptance Criteria

1. WHEN the Play button is defined THEN the system SHALL map to image coordinates position="0,0,32,32" from buttons_strip.png
2. WHEN the Pause button is defined THEN the system SHALL map to image coordinates position="32,0,64,32" from buttons_strip.png
3. WHEN the Stop button is defined THEN the system SHALL map to image coordinates position="64,0,96,32" from buttons_strip.png
4. WHEN the Previous button is defined THEN the system SHALL map to image coordinates position="96,0,128,32" from buttons_strip.png
5. WHEN the Next button is defined THEN the system SHALL map to image coordinates position="128,0,160,32" from buttons_strip.png
6. WHEN the Fullscreen button is defined THEN the system SHALL map to image coordinates position="160,0,192,32" from buttons_strip.png
7. WHEN buttons have hover states THEN the system SHALL reference image2="buttons_hover.png" with matching coordinates
8. WHEN buttons are clicked THEN the system SHALL trigger the corresponding VLC action

### Requirement 5

**User Story:** As a theme designer, I want to add time and volume sliders, so that users can seek through media and adjust volume.

#### Acceptance Criteria

1. WHEN the time slider is created THEN the system SHALL include a draggable thumb control
2. WHEN the volume slider is created THEN the system SHALL include a draggable thumb control
3. WHEN sliders are defined THEN the system SHALL specify background bitmap, thumb bitmap, and value ranges
4. WHEN the user drags a slider THEN the system SHALL update the corresponding VLC parameter

### Requirement 6

**User Story:** As a developer testing UI robustness, I want to introduce intentional design flaws, so that I can observe how subtle misalignments affect user experience.

#### Acceptance Criteria

1. WHEN the Play button Y-position is set THEN the system SHALL offset it by +5 pixels relative to other buttons in the same row
2. WHEN the volume slider width is defined THEN the system SHALL make it 3 pixels narrower than the slider background bitmap
3. WHEN the hidden panel is created THEN the system SHALL define a `<Panel>` element with id="jumpscare_overlay" at position x="0" y="0" with dimensions width="800" height="600" and visible="false"
4. WHEN the theme is rendered THEN the system SHALL display the misalignments without causing XML parsing errors
5. WHEN the hidden panel exists THEN the system SHALL not display it by default but allow programmatic visibility changes

### Requirement 7

**User Story:** As a theme designer, I want all controls to have proper action bindings, so that the interface is functional despite visual flaws.

#### Acceptance Criteria

1. WHEN buttons are defined THEN the system SHALL include action attributes that map to VLC commands (vlc.play(), vlc.pause(), etc.)
2. WHEN the time slider is defined THEN the system SHALL bind to the playback position variable
3. WHEN the volume slider is defined THEN the system SHALL bind to the volume variable
4. WHEN controls are interacted with THEN the system SHALL execute the bound actions correctly
