# Interaction Activator - Quick Reference

## What is an Activator?

An **activator** is an Area2D node with the `interaction_zone.gd` script attached. It defines a collision zone where:
- Player enters → E key icon appears and wiggles
- Player presses E → `interacted` signal fires
- Player exits → E key icon disappears

## Setup Checklist

```
☐ Add Area2D node
☐ Add CollisionShape2D as child
☐ Attach interaction_zone.gd script
☐ Set target_body_name = "penguin"
☐ Set visual_indicator_path = NodePath to E sprite
☐ Connect interacted signal to handler
☐ Implement your interaction logic
```

## NodePath Examples

From different locations in the scene tree:

```
# From Iglu/door to world/interaction_keys/E
visual_indicator_path = NodePath("../../interaction_keys/E")

# From chest (at root level) to world/interaction_keys/E  
visual_indicator_path = NodePath("interaction_keys/E")

# From NPC/interaction_zone to world/interaction_keys/E
visual_indicator_path = NodePath("../interaction_keys/E")
```

## Multiple Activators Example

```
world (Node2D)
├── penguin
├── interaction_keys
│   └── E (Sprite2D)
├── Iglu
│   └── door (Area2D) ← InteractionZone
│       └── CollisionShape2D
├── chest (StaticBody2D)
│   └── interaction_zone (Area2D) ← InteractionZone
│       └── CollisionShape2D
└── npc (CharacterBody2D)
    └── talk_zone (Area2D) ← InteractionZone
        └── CollisionShape2D

All three zones can share the same E key indicator!
```

## Common Patterns

### Door/Entrance Activator
```gdscript
# In world.gd
func _on_door_interacted() -> void:
    # Open door animation, change scene, etc.
    print("Door opened!")
```

### Chest/Item Activator
```gdscript
func _on_chest_interacted() -> void:
    # Give item to player, play animation
    chest_open_anim.play()
    player.add_item("sword")
    $chest_interaction_zone.enabled = false  # One-time use
```

### NPC Dialogue Activator
```gdscript
func _on_npc_talk_interacted() -> void:
    # Start dialogue system
    dialogue_manager.start_conversation(npc_dialogue)
```

### Switch/Puzzle Activator
```gdscript
func _on_switch_interacted() -> void:
    is_activated = !is_activated
    $lever_anim.play(is_activated ? "on" : "off")
    # Trigger connected mechanisms
```

## Advanced Usage

### Enable/Disable Dynamically
```gdscript
# Disable interaction during cutscene
$door_interaction_zone.enabled = false

# Re-enable after cutscene
$door_interaction_zone.enabled = true
```

### Multiple Indicators
```gdscript
# Each activator can have its own indicator
$door_zone.visual_indicator_path = NodePath("../keys/E")
$chest_zone.visual_indicator_path = NodePath("../keys/E")
# Or different indicators for different contexts!
```

### Conditional Interaction
```gdscript
func _on_body_entered(body: Node2D) -> void:
    if not has_required_key:
        show_message("Locked - need key!")
        return
    super._on_body_entered(body)
```

## Troubleshooting

**E icon doesn't show:**
- Check NodePath is correct (use relative paths)
- Verify CollisionShape2D has a valid shape
- Check target_body_name matches player node name

**Interaction doesn't trigger:**
- Verify `interacted` signal is connected
- Check E key is mapped to "interact" action
- Ensure player is actually in the zone

**Wiggle animation doesn't play:**
- E sprite script must have `_on_player_entered()` method
- InteractionZone calls this method automatically
