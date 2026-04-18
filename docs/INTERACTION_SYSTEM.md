# Universal Interaction System

## Overview
The interaction system allows players to interact with objects in the game world using the **E key** (or gamepad button). It's designed to be universal and reusable for any interactive element (doors, NPCs, chests, switches, etc.).

## Architecture

### Components

1. **InteractionZone** (`res://scripts/interaction_zone.gd`)
   - A reusable script that attaches to an `Area2D` node
   - Detects when the player enters/exits the zone
   - Handles input detection for the "interact" action
   - Emits signals for other systems to respond to
   - Optionally manages a visual indicator (E key sprite)

2. **Visual Indicator** (`res://scenes/world/interaction_keys/e.gd`)
   - Displays the E key icon when player is in an interaction zone
   - Plays a wiggle animation to draw attention
   - Automatically shows/hides based on interaction zone signals

3. **Input Action** ("interact")
   - Defined in `project.godot`
   - Mapped to E key (physical keycode 69) and gamepad button 0
   - Can be reconfigured in Project Settings > Input Map

## How to Create a New Interactive Element

### Step-by-Step Guide

1. **Create an Area2D node** in your scene where you want the interaction to happen

2. **Add a CollisionShape2D** as a child of the Area2D to define the interaction zone

3. **Attach the InteractionZone script**:
   ```gdscript
   # Click "Attach Script" and select: res://scripts/interaction_zone.gd
   ```

4. **Configure the InteractionZone properties**:
   - `Target Body Name`: Set to "penguin" (or leave empty for any body)
   - `Enabled`: Whether the zone is active (default: true)
   - `Visual Indicator Path`: NodePath to the E key Sprite2D (e.g., `"../interaction_keys/E"`)

5. **Connect to the `interacted` signal**:
   - Select the Area2D node
   - Go to Node tab > Signals
   - Double-click `interacted` signal
   - Connect to the appropriate receiver (e.g., world script)
   - Implement the handler function

### Understanding the Activator Pattern

The **activator** is the Area2D collision zone that triggers the interaction. When the player enters this area:
1. The visual indicator (E key icon) appears and wiggles
2. The player can press E to interact
3. The `interacted` signal fires

You can have multiple activators in a scene, each with their own:
- Collision shape size
- Target body filter
- Visual indicator
- Interaction behavior

### Example Scene Structure

```
World (Node2D)
├── Penguin (CharacterBody2D)
├── InteractiveChest (StaticBody2D)
│   └── interaction_zone (Area2D) ← InteractionZone script
│       ├── CollisionShape2D
│       └── (signals connected to world.gd)
└── interaction_keys (Node2D)
    └── E (Sprite2D) ← Visual indicator
```

### Example Code

**In your scene script (e.g., world.gd):**
```gdscript
extends Node2D

func _on_chest_interacted() -> void:
    print("Opening chest...")
    # Add your chest opening logic here

func _on_npc_interacted() -> void:
    print("Talking to NPC...")
    # Add your dialogue logic here
```

## Signals

The InteractionZone script emits three signals:

- `player_entered()` - Called when the target body enters the zone
- `player_exited()` - Called when the target body exits the zone
- `interacted()` - Called when player presses the interact key while in the zone

## Customization

### Change the Interaction Key
1. Open Godot Editor
2. Go to Project > Project Settings > Input Map
3. Find the "interact" action
4. Add/remove key bindings as needed

### Multiple Interaction Zones
You can have multiple interaction zones in the same scene. Each zone operates independently and can have its own:
- Target body name
- Visual indicator
- Signal handlers
- Enabled/disabled state

### Dynamic Enable/Disable
You can enable or disable interaction zones at runtime:
```gdscript
$interaction_zone.enabled = false  # Disable interaction
$interaction_zone.enabled = true   # Re-enable interaction
```

## Current Usage in the Game

### Door Interaction (Iglu)
- **Location**: `scenes/world/world.tscn` → `Iglu/door`
- **Handler**: `world.gd._on_door_interacted()`
- **Visual**: `interaction_keys/E`
- **Current Behavior**: Prints "Door interacted!" to console (placeholder for actual door logic)

## Best Practices

1. **Keep interaction zones appropriately sized** - Large enough to be forgiving, small enough to be precise
2. **Use visual indicators** - Helps players know what's interactive
3. **Provide feedback** - When player interacts, give visual/audio feedback
4. **Disable zones when not needed** - Use the `enabled` property to control when interactions are available
5. **Use descriptive signal handler names** - e.g., `_on_chest_interacted()` instead of generic names
