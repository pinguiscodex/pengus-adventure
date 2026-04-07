# Pengus Adventure

## Project Overview

**Pengus Adventure** is a 2D platformer game built with **Godot Engine 4.6** using the **GL Compatibility** renderer. The game follows a penguin character on an adventure in Antarctica. It's currently at version **0.3** and is developed by **Penguin Games**.

### Key Features
- 2D platformer gameplay with a penguin protagonist
- Running, jumping, and sliding mechanics
- Enemy seals that move toward the player
- Main menu with settings (VSync, FPS counter)
- Save/Load system for game settings
- Cross-platform support (Windows & Linux)

### Project Structure

```
pengus-adventure/
├── addons/             # Godot addons (currently empty/git-ignored)
├── assets/             # Game assets (images, sounds, etc.)
├── characters/         # Character scenes and scripts
│   ├── penguin/        # Player character (penguin.gd, penguin.tscn)
│   └── seal/           # Enemy character (seal.gd, seal.tscn)
├── scenes/             # Game scenes
│   ├── main_menu/      # Main menu scene with settings
│   └── world/          # Main game world scene
├── global.gd           # Global autoload (currently minimal)
├── SaveLoad.gd         # Settings save/load system (autoload)
├── project.godot       # Godot project configuration
└── export_presets.cfg  # Export configurations for Windows/Linux
```

### Architecture

- **Global Autoload** (`global.gd`): Currently a placeholder for global variables and state management.
- **SaveLoad Autoload** (`SaveLoad.gd`): Handles persistent settings (VSync, FPS display) via JSON serialization to `user://settingsjson`.
- **Penguin** (`characters/penguin/penguin.gd`): Player character with physics-based movement, including running, jumping, sliding, and falling animations. Uses `CharacterBody2D` with animation state machine.
- **Seal** (`characters/seal/seal.gd`): Enemy that moves toward the penguin using simple AI.
- **World** (`scenes/world/world.tscn`): Main game level scene.
- **Main Menu** (`scenes/main_menu/main_menu.tscn`): Entry point with Play and Quit buttons.

### Color Palette
- Primary: `#53a8ce`
- Secondary: `#f4f4f4`
- Accent: `#197097`
- Highlight: `#80c8e9`

## Building and Running

### Prerequisites
- **Godot Engine 4.6** (or compatible 4.x version)
- GL Compatibility renderer support

### Running the Game
1. Open the project in Godot Engine
2. Press `F5` to run the main scene
3. Or open `scenes/main_menu/main_menu.tscn` and run from there

### Exporting
Export presets are configured for:
- **Windows Desktop**: `./Pengus Adventure.exe`
- **Linux**: `./Pengus Adventure.x86_64`

To export:
1. Open Godot Editor
2. Go to `Project > Export`
3. Select the target platform (Windows or Linux)
4. Click `Export Project`

### Controls
| Action | Keyboard | Gamepad |
|--------|----------|---------|
| Move Left | `A` / `Left Arrow` | Left Stick / D-Pad |
| Move Right | `D` / `Right Arrow` | Left Stick / D-Pad |
| Jump | `W` / `Space` / `Up Arrow` | Button 11 / Up |
| Slide | `Shift` | - |

## Development Conventions

### GDScript Style
- Use typed variables (`var x: int = 0`)
- Use `@onready` for node references
- Follow Godot's naming conventions: `snake_case` for variables/functions, `PascalCase` for classes/nodes
- Constants in `UPPER_CASE`

### Autoload Pattern
Global systems are registered as autoloads in `project.godot`:
- `Global` - for global state/variables
- `SaveLoad` - for persistent settings

### Scene Organization
- Each character has its own directory with `.gd` script, `.uid` file, and `.tscn` scene
- Scenes are organized under `scenes/` by game area (main_menu, world)
- Characters are under `characters/` by entity type

### Temporary Files
- `.godot/` directory contains editor-generated files (gitignored)
- Temporary `.tscn*` files may appear during development (safe to ignore)
