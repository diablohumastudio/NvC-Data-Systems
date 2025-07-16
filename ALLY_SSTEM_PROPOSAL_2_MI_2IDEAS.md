# Allies System Proposal 2 - Two Implementation Options

## Overview
Two technical approaches for implementing the allies system, leveraging the existing condition/state changer architecture versus a simpler ID-based approach.

---

## Option 1: Full Condition System Integration

### Philosophy
Leverage the existing level system architecture with conditions and state changers for maximum flexibility and consistency.

### Core Architecture

#### 1.1 AllyLevel with Built-in State Management
**File: `data/game_characters/allies/upgrade_levels/model/ally_level.gd`**
```gdscript
class_name AllyLevel extends GameCharacterLevel

enum IDs { 
    BASE_CHEST, FAST_CHEST_1, FAST_CHEST_2, RICH_CHEST_1, RICH_CHEST_2,
    BASE_SHOOTER, FAST_SHOOTER_1, DAMAGE_SHOOTER_1, RANGE_SHOOTER_1
}

@export var level_id: IDs
@export var price: int
@export var locked: bool = true
@export var buyed: bool = false
@export var conditions: Array[Condition] # For unlocking
# Note: buyed property uses state changer system
```

#### 1.2 Enhanced AllyData (formerly Ally)
**File: `data/game_characters/allies/res_data/model/ally_data.gd`**
```gdscript
class_name AllyData extends Resource

enum IDs { BAYONETE_SOLDIER, CHEST }

@export var id: IDs
@export var ally_name: String
@export var description: String
@export var thumbnail: Texture2D
@export var levels: Array[AllyLevel]
@export var scene: PackedScene

# Similar to Level._set_ud_level()
func _set_ally_levels() -> void:
    # Load saved ally levels from user_data at startup
    # Match by level_id and replace with saved versions
    for level in levels:
        for saved_level in UDS.current_user_data.allies_inventory.ally_levels:
            if saved_level.level_id == level.level_id:
                # Replace with saved version that has unlocked/buyed state
                var index = levels.find(level)
                levels[index] = saved_level
```

#### 1.3 User Data Structure Changes
**File: `global_systems/data_systems/user_data_system/user_data.gd`**
```gdscript
# In AlliesInventory class:
@export var ally_levels: Array[AllyLevel] # Instead of ud_allies
# This saves ALL ally levels with their unlocked/buyed states

# In UserDataSystem loading:
func load_ally_levels():
    # Load all saved ally levels at startup
    # Call _set_ally_levels() on all AllyData instances
```

#### 1.4 Condition-Dictionary System for Saving
**Since Array[Condition] doesn't save properly:**
```gdscript
# In AllyLevel or UDAllyLevel class:
@export var conditions_state: Dictionary[Condition, bool]

func setup_conditions():
    # Convert conditions array to dictionary for saving
    for condition in conditions:
        conditions_state[condition] = false
        condition.fulfilled.connect(_on_condition_fulfilled)

func _on_condition_fulfilled(condition: Condition):
    conditions_state[condition] = true
    if all_conditions_met():
        locked = false
```

### Pros of Option 1:
- **Maximum Flexibility**: Can unlock levels based on ANY condition (enemies killed, achievements, consecutive days, etc.)
- **Consistent Architecture**: Uses same pattern as existing level system
- **Powerful Conditions**: Complex unlock requirements possible
- **ACS Integration**: Full integration with Action-Condition-StateChanger system

### Cons of Option 1:
- **Higher Complexity**: More classes and systems to manage
- **Memory Usage**: Saves entire AllyLevel resources with conditions
- **Development Time**: More complex implementation
- **Potential Performance**: Dictionary[Condition, bool] might be slower

---

## Option 2: Simplified ID-Based System

### Philosophy
Streamlined approach using ID references and state changers for purchases, with simpler prerequisite chains.

### Core Architecture

#### 2.1 AllyLevel with ID System
**File: `data/game_characters/allies/upgrade_levels/model/ally_level.gd`**
```gdscript
class_name AllyLevel extends GameCharacterLevel

enum IDs { 
    BASE_CHEST, FAST_CHEST_1, FAST_CHEST_2, RICH_CHEST_1, RICH_CHEST_2,
    BASE_SHOOTER, FAST_SHOOTER_1, DAMAGE_SHOOTER_1, RANGE_SHOOTER_1
}

@export var level_id: IDs
@export var price: int
@export var prerequisites: Array[IDs] # Simple ID references
@export var level_position: Vector2 # For UI graph positioning
@export var level_icon: Texture2D
```

#### 2.2 Enhanced UDAlly for State Management
**File: `data/game_characters/allies/user_data/model/ud_ally.gd`**
```gdscript
class_name UDAlly extends Resource

@export var id: AllyData.IDs
@export var unlocked_levels_ids: Array[AllyLevel.IDs]
@export var buyed_levels_ids: Array[AllyLevel.IDs]

func is_level_unlocked(level_id: AllyLevel.IDs) -> bool:
    return unlocked_levels_ids.has(level_id)

func is_level_buyed(level_id: AllyLevel.IDs) -> bool:
    return buyed_levels_ids.has(level_id)

func can_unlock_level(level_id: AllyLevel.IDs, ally_data: AllyData) -> bool:
    var level = ally_data.get_level_by_id(level_id)
    # Check if all prerequisites are met
    for prereq_id in level.prerequisites:
        if !buyed_levels_ids.has(prereq_id):
            return false
    return true

func unlock_level(level_id: AllyLevel.IDs) -> void:
    if !unlocked_levels_ids.has(level_id):
        unlocked_levels_ids.append(level_id)

func buy_level(level_id: AllyLevel.IDs) -> void:
    if !buyed_levels_ids.has(level_id):
        buyed_levels_ids.append(level_id)
```

#### 2.3 AllyData with Level Management
**File: `data/game_characters/allies/res_data/model/ally_data.gd`**
```gdscript
class_name AllyData extends Resource

enum IDs { BAYONETE_SOLDIER, CHEST }

@export var id: IDs
@export var ally_name: String
@export var description: String
@export var thumbnail: Texture2D
@export var levels: Array[AllyLevel]
@export var ud_ally: UDAlly : set = _set_ud_ally
@export var scene: PackedScene

func get_level_by_id(level_id: AllyLevel.IDs) -> AllyLevel:
    for level in levels:
        if level.level_id == level_id:
            return level
    return null

func get_unlocked_levels() -> Array[AllyLevel]:
    var unlocked = []
    for level in levels:
        if ud_ally.is_level_unlocked(level.level_id):
            unlocked.append(level)
    return unlocked

func get_next_available_levels() -> Array[AllyLevel]:
    var available = []
    for level in levels:
        if !ud_ally.is_level_unlocked(level.level_id) and ud_ally.can_unlock_level(level.level_id, self):
            available.append(level)
    return available
```

#### 2.4 State Changer for Level Purchase
**File: `data/acs_system/state_changers/model/sc_buy_ally_level.gd`**
```gdscript
class_name SCBuyAllyLevel extends StateChanger

func execute(payload: Action.PayBuyAllyLevel) -> void:
    var ally_data = get_ally_by_id(payload.ally_id)
    var level = ally_data.get_level_by_id(payload.level_id)
    
    # Check money and prerequisites
    if UDS.current_user_data.in_menu_money >= level.price:
        if ally_data.ud_ally.can_unlock_level(payload.level_id, ally_data):
            # Deduct money
            UDS.current_user_data.in_menu_money -= level.price
            # Buy level
            ally_data.ud_ally.buy_level(payload.level_id)
            # Auto-unlock next levels if no conditions
            ally_data.ud_ally.unlock_level(payload.level_id)
            
            UDS.save_user_data()
```

### Pros of Option 2:
- **Simplicity**: Easier to understand and implement
- **Performance**: Lightweight ID-based system
- **Memory Efficient**: Only saves ID arrays, not full resources
- **Quick Development**: Faster to implement and test

### Cons of Option 2:
- **Limited Flexibility**: Only prerequisite-based unlocking
- **Less Versatile**: Can't unlock based on achievements, enemies killed, etc.
- **Simpler Conditions**: Only "buy previous level" type conditions

---

## Detailed Comparison

### Data Storage Comparison

#### Option 1 (Condition System):
```
user_data/
├── allies_inventory/
│   └── ally_levels: Array[AllyLevel] (saves full resources)
│       ├── conditions_state: Dictionary[Condition, bool]
│       ├── locked: bool
│       └── buyed: bool
```

#### Option 2 (ID System):
```
user_data/
├── allies_inventory/
│   └── ud_allies: Array[UDAlly]
│       ├── unlocked_levels_ids: Array[AllyLevel.IDs]
│       └── buyed_levels_ids: Array[AllyLevel.IDs]
```

### Flexibility Comparison

#### Option 1 Examples:
- Unlock Rich Chest Level 2 when: "Kill 100 enemies AND complete 5 levels"
- Unlock Sniper Level 3 when: "Complete achievement 'Marksman' OR play 7 consecutive days"
- Unlock Tank Level 2 when: "Have 1000 in-menu money AND unlock 3 other allies"

#### Option 2 Examples:
- Unlock Rich Chest Level 2 when: "Buy Rich Chest Level 1"
- Unlock Sniper Level 3 when: "Buy Sniper Level 2 AND Buy Sniper Level 1"
- Unlock Tank Level 2 when: "Buy Tank Level 1"

### UI Implementation Differences

#### Option 1:
- Graph shows complex condition tooltips
- Multiple unlock paths possible
- Conditions can be checked independently

#### Option 2:
- Clean linear/branching progression
- Simple prerequisite chains
- Clear upgrade paths

---

## Recommendation

### For Maximum Game Design Flexibility: **Choose Option 1**
- If you want rich, complex unlock conditions
- If you plan to add achievements-based unlocks
- If you want the system to grow with creative unlock mechanics

### For Fast Implementation and Simplicity: **Choose Option 2**
- If you want to get the system working quickly
- If prerequisite-based unlocking is sufficient
- If you prefer maintainable, straightforward code

### Hybrid Approach Possibility:
Start with **Option 2** for core functionality, then add **Option 1's** condition system later for special/advanced levels. This gives you both quick implementation and future expansion capability.

---

## Implementation Priority

### Option 1 Timeline:
1. Week 1: Enhanced AllyLevel with conditions
2. Week 2: Dictionary[Condition, bool] system
3. Week 3: ACS integration and state changers
4. Week 4: UI implementation and testing

### Option 2 Timeline:
1. Week 1: ID-based AllyLevel and UDAlly
2. Week 2: State changers for purchases
3. Week 3: UI implementation
4. Week 4: Polish and testing

**Option 2 delivers working system ~1 week faster**

---

## Technical Decision Points

### Memory vs Flexibility:
- **Option 1**: Higher memory usage, maximum flexibility
- **Option 2**: Lower memory usage, adequate flexibility

### Maintainability vs Features:
- **Option 1**: More complex but more features
- **Option 2**: Simpler to maintain, fewer features

### Development Speed vs Future Expansion:
- **Option 1**: Slower initial development, easier to expand
- **Option 2**: Faster initial development, harder to expand later