# Design Document

## Overview

This design describes a VLC Skins2 XML theme file that implements a functional media player interface with intentional visual corruption elements. The theme, named "Spectre", will be a valid XML document conforming to VLC's Skins2 DTD while incorporating subtle misalignments and hidden elements for testing purposes.

The design focuses on creating a single XML file that references pre-existing bitmap assets and defines a complete UI layout with standard media controls (play, pause, stop, next, previous, fullscreen), time slider, and volume slider.

## Architecture

### Component Structure

```
theme.xml
├── Theme (root element)
│   ├── ThemeInfo (metadata)
│   ├── Bitmap definitions (resource declarations)
│   ├── Window (main_window)
│   │   ├── Layout
│   │   │   ├── Button controls (6 buttons)
│   │   │   ├── Slider (time)
│   │   │   ├── Slider (volume)
│   │   │   └── Panel (hidden overlay)
```

### File Location

The theme.xml file will be placed at: `vlc-3.0.21/share/skins2/default/theme.xml`

### Asset References

All bitmap assets will be referenced using relative paths from the skins2 directory:
- `default/main_bg.png` - Window background (800x600)
- `default/buttons_strip.png` - Button states strip (192x32, 6 buttons @ 32x32 each)
- `default/buttons_hover.png` - Button hover states (same dimensions)
- `default/cone_icon.png` - Optional icon/logo

## Components and Interfaces

### XML Structure Components

#### 1. Theme Root Element
- **Attributes**: `name="Spectre"`, `version="1.0"`
- **Purpose**: Container for all theme elements
- **Children**: ThemeInfo, Bitmap elements, Window elements

#### 2. Bitmap Resources
Each bitmap must declare:
- `id`: Unique identifier for referencing
- `file`: Relative path to image file
- `alphacolor`: Transparency color (typically "#FF00FF" for magenta)

Required bitmaps:
- `bg_main`: Main window background
- `buttons_normal`: Button strip for normal state
- `buttons_hover`: Button strip for hover state
- `cone_icon`: VLC cone logo

#### 3. Window Element
- **id**: "main_window"
- **Attributes**: `x="0"`, `y="0"`, `width="800"`, `height="600"`, `visible="true"`
- **Contains**: One or more Layout elements

#### 4. Layout Element
- **Attributes**: `width="800"`, `height="600"`
- **Contains**: All interactive controls and visual elements

#### 5. Button Controls
Each button requires:
- `id`: Unique identifier
- `x`, `y`: Position coordinates
- `lefttop`, `rightbottom`: Sprite coordinates from button strip
- `up`: Normal state bitmap reference
- `over`: Hover state bitmap reference
- `action`: VLC command to execute
- `tooltiptext`: Hover tooltip

Button specifications:
- **Play**: coords (0,0,32,32), action "vlc.play()", position (100, 500) - **CORRUPTED: y+5**
- **Pause**: coords (32,0,64,32), action "vlc.pause()", position (140, 500)
- **Stop**: coords (64,0,96,32), action "vlc.stop()", position (180, 500)
- **Previous**: coords (96,0,128,32), action "vlc.playlist.previous()", position (220, 500)
- **Next**: coords (128,0,160,32), action "vlc.playlist.next()", position (260, 500)
- **Fullscreen**: coords (160,0,192,32), action "vlc.fullscreen()", position (300, 500)

#### 6. Slider Controls

**Time Slider**:
- **id**: "time_slider"
- **Position**: (100, 450)
- **Dimensions**: width="600", height="20"
- **Binding**: `value="time"` (VLC's playback position variable)
- **Attributes**: `thickness="10"`, `tooltiptext="$T"`

**Volume Slider**:
- **id**: "volume_slider"
- **Position**: (650, 500)
- **Dimensions**: width="120", height="20" - **CORRUPTED: 3px narrower than background**
- **Binding**: `value="volume"` (VLC's volume variable)
- **Attributes**: `thickness="10"`, `tooltiptext="$V"`

#### 7. Hidden Panel (Corruption Element)
- **id**: "jumpscare_overlay"
- **Position**: (0, 0)
- **Dimensions**: (800, 600)
- **Attributes**: `visible="false"`
- **Purpose**: Hidden element that can be programmatically revealed

## Data Models

### XML Schema Compliance

The theme.xml must conform to VLC Skins2 DTD. Key element structures:

```xml
<Theme version="1.0" name="Spectre">
  <ThemeInfo name="Spectre" author="..." email="..." webpage="..." />
  
  <Bitmap id="..." file="..." alphacolor="..." />
  
  <Window id="..." x="..." y="..." width="..." height="..." visible="...">
    <Layout width="..." height="...">
      <Button id="..." x="..." y="..." lefttop="..." rightbottom="..." 
              up="..." over="..." action="..." tooltiptext="..." />
      <Slider id="..." x="..." y="..." width="..." height="..." 
              value="..." thickness="..." tooltiptext="..." />
      <Panel id="..." x="..." y="..." width="..." height="..." visible="..." />
    </Layout>
  </Window>
</Theme>
```

### Coordinate System

- Origin (0,0) is top-left corner
- X increases rightward
- Y increases downward
- Button strip uses (left, top, right, bottom) format
- All measurements in pixels

### Asset Assumptions

Based on the requirements, we assume:
- `buttons_strip.png`: 192x32 pixels (6 buttons × 32px width)
- `main_bg.png`: 800x600 pixels
- `buttons_hover.png`: 192x32 pixels (matching button strip)
- All assets use magenta (#FF00FF) as alpha channel

## Correctness Properties

*A property is a characteristic or behavior that should hold true across all valid executions of a system-essentially, a formal statement about what the system should do. Properties serve as the bridge between human-readable specifications and machine-verifiable correctness guarantees.*


### Property Reflection

After reviewing the prework analysis, several properties can be consolidated:

- Properties 4.1-4.6 are all checking specific button coordinates - these are better tested as individual examples rather than a single property
- Property 1.4 and 3.3 both relate to path format validation - these can be combined
- Properties about specific element existence (2.1, 2.2, 3.2, 6.3) are examples, not properties

The following properties provide unique validation value:

Property 1: XML structure validation (1.2, 1.3)
Property 2: Bitmap path format consistency (1.4, 3.3)
Property 3: Required bitmap attributes (3.1)
Property 4: Button hover states (4.7)
Property 5: Slider required attributes (5.3)
Property 6: Button action attributes (7.1)
Property 7: Valid XML without parse errors (6.4)

### Correctness Properties

Property 1: Theme root element structure
*For any* generated theme.xml file, the root element should be `<Theme>` with attributes name="Spectre" and version="1.0", and the document should be well-formed XML
**Validates: Requirements 1.2, 1.3**

Property 2: Bitmap path format consistency
*For any* `<Bitmap>` element in the theme, the file attribute should use the format "default/[filename]" without absolute paths
**Validates: Requirements 1.4, 3.3**

Property 3: Bitmap required attributes
*For any* `<Bitmap>` element in the theme, it should include all three required attributes: id, file, and alphacolor
**Validates: Requirements 3.1**

Property 4: Button hover state completeness
*For any* `<Button>` element in the theme, it should include both a normal state bitmap reference (up attribute) and a hover state bitmap reference (over attribute)
**Validates: Requirements 4.7**

Property 5: Slider required attributes
*For any* `<Slider>` element in the theme, it should specify value binding, dimensions (width, height), and position (x, y) attributes
**Validates: Requirements 5.3**

Property 6: Button action bindings
*For any* `<Button>` element in the theme, it should include an action attribute that contains a valid VLC command
**Validates: Requirements 7.1**

Property 7: Valid XML structure
*For any* generated theme.xml file, it should be parseable as valid XML without syntax errors, even with intentional visual corruption elements
**Validates: Requirements 6.4**

## Error Handling

### XML Validation Errors

If the generated XML does not conform to the Skins2 DTD:
- VLC will fail to load the skin
- Error messages will appear in VLC's message log
- The default skin will be used instead

**Mitigation**: Validate XML structure against DTD before deployment

### Missing Asset Files

If referenced bitmap files don't exist:
- VLC will log warnings about missing resources
- Controls may appear as blank rectangles
- The skin may partially render or fail to load

**Mitigation**: Ensure all referenced assets are copied to the correct directory

### Invalid Coordinate Values

If button coordinates exceed bitmap dimensions:
- Buttons may appear blank or corrupted
- VLC may clip the sprite incorrectly

**Mitigation**: Verify sprite coordinates match actual bitmap dimensions

### Corruption Element Risks

The intentional design flaws may cause:
- **Play button misalignment**: Visual inconsistency but functional
- **Volume slider width mismatch**: Potential rendering artifacts
- **Hidden panel**: No immediate impact unless programmatically revealed

**Expected behavior**: All corruption elements should render without causing XML parse errors

## Testing Strategy

### Unit Testing Approach

Since this is a declarative XML file rather than executable code, traditional unit tests will focus on XML structure validation:

1. **File existence test**: Verify theme.xml is created at the correct path
2. **XML well-formedness test**: Parse the XML and verify no syntax errors
3. **DTD validation test**: Validate against VLC Skins2 DTD schema
4. **Specific element tests**: Verify presence of required elements (Window, Buttons, Sliders, Panel)
5. **Attribute value tests**: Check specific attributes match requirements (window dimensions, button coordinates, corruption offsets)

### Property-Based Testing Approach

**Testing Framework**: We will use Python with `lxml` library for XML parsing and validation, combined with `hypothesis` for property-based testing.

**Test Configuration**: Each property test should run a minimum of 100 iterations.

**Property Test Implementations**:

Each property-based test will:
1. Parse the generated theme.xml file
2. Extract relevant elements using XPath
3. Verify the property holds for all matching elements
4. Tag each test with the format: `**Feature: vlc-corrupted-skin, Property {number}: {property_text}**`

**Test Data Generation**:
Since we're testing a single static XML file rather than generated variations, property tests will:
- Parse the actual theme.xml file once
- Verify properties hold across all elements of a given type (all Buttons, all Bitmaps, etc.)
- Use XPath queries to select element sets for validation

**Example Test Structure**:
```python
def test_property_bitmap_paths():
    """
    Feature: vlc-corrupted-skin, Property 2: Bitmap path format consistency
    Validates: Requirements 1.4, 3.3
    """
    tree = parse_theme_xml()
    bitmaps = tree.xpath('//Bitmap')
    for bitmap in bitmaps:
        file_path = bitmap.get('file')
        assert file_path.startswith('default/')
        assert not file_path.startswith('/')
```

### Integration Testing

Integration tests will verify the theme works with VLC:
1. Copy theme.xml and assets to VLC skins directory
2. Launch VLC with the custom skin
3. Verify VLC loads without errors
4. Test button functionality (play, pause, stop, etc.)
5. Test slider functionality (seek, volume adjustment)
6. Verify corruption elements render as intended

### Manual Verification

Visual inspection required for:
- Play button Y-offset (+5px) is visually noticeable
- Volume slider width mismatch creates visible artifact
- Hidden panel is not visible by default
- Overall theme aesthetic matches "Spectre" design intent

## Implementation Notes

### XML Generation Approach

The theme.xml will be hand-crafted as a static file rather than programmatically generated, ensuring:
- Precise control over corruption elements
- Human-readable structure
- Easy modification for testing variations

### Asset Path Resolution

VLC resolves bitmap paths relative to the skin's directory:
- Skin location: `vlc-3.0.21/share/skins2/default/`
- Asset references: `default/filename.png`
- Actual asset location: `vlc-3.0.21/share/skins2/default/filename.png`

### VLC Skins2 DTD Compliance

Key DTD requirements:
- All elements must have required attributes
- Attribute values must match expected types (integers for coordinates, strings for IDs)
- Element nesting must follow schema (Window > Layout > Controls)
- Boolean attributes use "true"/"false" strings

### Corruption Implementation Details

**Play Button Offset**:
- Standard button Y-position: 500
- Play button Y-position: 505 (500 + 5)
- Creates subtle vertical misalignment

**Volume Slider Width**:
- Assume slider background bitmap width: 123px
- Volume slider width attribute: 120px (123 - 3)
- Creates edge clipping or gap

**Hidden Panel**:
- Full-screen overlay (800x600)
- visible="false" prevents initial display
- Can be revealed via VLC scripting or events

## Dependencies

### External Dependencies

- **VLC Media Player 3.0.21**: Required to load and render the skin
- **Bitmap Assets**: Pre-existing PNG files in assets/ directory
  - main_bg.png
  - buttons_strip.png
  - buttons_hover.png
  - cone_icon.png

### Testing Dependencies

- **Python 3.x**: For property-based tests
- **lxml**: XML parsing and validation library
- **hypothesis**: Property-based testing framework
- **VLC Skins2 DTD**: Schema definition for validation

## Future Enhancements

Potential extensions to this design:
1. Additional corruption elements (text misalignment, color shifts)
2. Animated corruption effects using VLC's animation features
3. Multiple theme variations with different corruption patterns
4. Programmatic theme generator for testing various corruption scenarios
5. Integration with VLC's scripting API to trigger hidden panel visibility
