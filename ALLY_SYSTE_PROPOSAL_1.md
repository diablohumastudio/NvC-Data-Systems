# Allies System Proposal 1 - Detailed Implementation Plan

## Overview
This proposal outlines a comprehensive allies system with money management, branching upgrade paths, and integration between market and in-game mechanics.

## System Architecture

### 1. Money System

#### 1.1 Two-Currency System
- **In-Game Money**: Earned during gameplay, used for temporary upgrades
- **In-Menu Money**: Earned upon level completion, used for permanent purchases

#### 1.2 Money Management Classes
```gdscript
# New class: MoneyManager
class_name MoneyManager extends Resource
@export var in_game_money: int = 0
@export var in_menu_money: int = 0

# Integration with existing UserData
# Add to user_data system:
@export var money_manager: MoneyManager
```

[[No need for money manager. in_game money is not persistent. is only while playing the game in gamescreen. So maybe a property in UserProgress]]

### 2. Ally Data Structure (Renamed from Ally)

#### 2.1 AllyData Class (formerly Ally)
**File: `data/game_characters/allies/res_data/model/ally_data.gd`**
```gdscript
class_name AllyData extends Resource

enum IDs { BAYONETE_SOLDIER, CHEST }

@export var id: IDs
@export var ally_name: String
@export var description: String
@export var thumbnail: Texture2D
@export var base_price: int
@export var upgrade_tree: AllyUpgradeTree
@export var ud_ally: UDAlly : set = _set_ud_ally
@export var scene: PackedScene

func _set_ud_ally(new_value:UDAlly) -> void:
	ud_ally = new_value
	for saved_ud_ally in UDS.current_user_data.allies_inventory.ud_allies:
		if saved_ud_ally.id == ud_ally.id:
			ud_ally = saved_ud_ally
```
[[If we have a base_level and it have a property price, maybe we shouldnt need a base_price in AllyData. Also maybe no need for action of type unlock, because we can validate with base_level unlocked property]]

#### 2.2 AllyUpgradeTree Class
**File: `data/game_characters/allies/upgrade_trees/model/ally_upgrade_tree.gd`**
```gdscript
class_name AllyUpgradeTree extends Resource

@export var base_level: AllyLevel
@export var upgrade_branches: Array[AllyUpgradeBranch]

func get_available_upgrades(current_level: AllyLevel) -> Array[AllyLevel]:
	# Returns next available upgrade levels from current position
	pass

func get_max_unlocked_level(unlocked_levels: Array[AllyLevel]) -> AllyLevel:
	# Returns highest level available based on unlocked progression
	pass
```
[[i dont know what are the uses for this functions. explain]]

#### 2.3 AllyUpgradeBranch Class
**File: `data/game_characters/allies/upgrade_trees/model/ally_upgrade_branch.gd`**
```gdscript
class_name AllyUpgradeBranch extends Resource

@export var branch_id: String
@export var branch_name: String
@export var levels: Array[AllyLevel]
@export var prerequisites: Array[AllyLevel] # Levels that must be unlocked first
@export var branch_color: Color # For UI visualization

func is_accessible(unlocked_levels: Array[AllyLevel]) -> bool:
	# Check if this branch can be accessed based on unlocked levels
	pass
```
[[i dont know what are the uses for this function. explain]]

### 3. Enhanced UDAlly (User Data Ally)

#### 3.1 Updated UDAlly Class
**File: `data/game_characters/allies/user_data/model/ud_ally.gd`**
```gdscript
class_name UDAlly extends Resource

@export var id : AllyData.IDs
@export var locked: bool = true
@export var current_level: AllyLevel
@export var unlocked_levels: Array[AllyLevel]
@export var in_game_level: AllyLevel # Current level in active game session

func can_upgrade_to(target_level: AllyLevel) -> bool:
	# Check if upgrade is possible based on unlocked levels
	pass

func get_next_available_upgrades() -> Array[AllyLevel]:
	# Get all possible next upgrades from current position
	pass

func unlock_level(level: AllyLevel) -> void:
	# Add level to unlocked_levels array
	pass

func upgrade_in_game(level: AllyLevel) -> void:
	# Upgrade current in-game level (temporary)
	pass
```
[[in_game_level shouldn exists. This is a property of ally_scene and as games sessions are not persistent it shoulnt be here. also dont understand what is the uses to this functions except to unlock_level()]]

### 4. Level Progression System

#### 4.1 Enhanced AllyLevel Class
**File: `data/game_characters/allies/upgrade_levels/model/ally_level.gd`**
```gdscript
class_name AllyLevel extends GameCharacterLevel

@export var level_id: String
@export var price: int
@export var branch_id: String
@export var level_position: Vector2 # For UI graph positioning
@export var level_icon: Texture2D
@export var prerequisites: Array[String] # level_ids that must be unlocked first

enum LevelState {
	LOCKED,      # Cannot be unlocked yet
	AVAILABLE,   # Can be unlocked (prerequisites met)
	UNLOCKED     # Already unlocked
}

func get_state(unlocked_levels: Array[AllyLevel]) -> LevelState:
	# Determine current state based on unlocked levels
	pass
```

### 5. Market System Enhancements

#### 5.1 Market UI Components
**Files to modify:**
- `screens/allies_market/ally_details_popup/ally_details_popup.gd`
- `screens/allies_market/ally_details_popup/ally_details_popup.tscn`

#### 5.2 Upgrade Tree Visualization
**New Component: `screens/allies_market/ally_details_popup/upgrade_tree_graph.gd`**
```gdscript
class_name UpgradeTreeGraph extends Control

@export var ally_data: AllyData
@export var ud_ally: UDAlly

@onready var tree_container = $TreeContainer
@onready var level_button_scene = preload("res://screens/allies_market/ally_details_popup/level_button.tscn")

func setup_tree(ally: AllyData, user_ally: UDAlly):
	# Create visual representation of upgrade tree
	# Show levels with different states (locked/available/unlocked)
	pass

func _on_level_button_pressed(level: AllyLevel):
	# Handle level selection for upgrade
	pass
```

#### 5.3 Market Operations
**New Service: `global_systems/market_system/market_service.gd`**
```gdscript
class_name MarketService extends Node

signal ally_unlocked(ally_id: AllyData.IDs)
signal ally_upgraded(ally_id: AllyData.IDs, level: AllyLevel)
signal insufficient_funds()

func unlock_ally(ally_id: AllyData.IDs) -> bool:
	# Unlock ally if player has enough money
	pass

func upgrade_ally(ally_id: AllyData.IDs, target_level: AllyLevel) -> bool:
	# Upgrade ally level if prerequisites are met and player has money
	pass

func get_ally_unlock_cost(ally_id: AllyData.IDs) -> int:
	# Return cost to unlock ally
	pass

func get_level_upgrade_cost(level: AllyLevel) -> int:
	# Return cost to upgrade to specific level
	pass
```

### 6. In-Game System Integration

#### 6.1 Game Screen Ally Management
**New Component: `screens/game_screen/ally_placement_system.gd`**
```gdscript
class_name AllyPlacementSystem extends Node

@export var ally_scenes: Array[PackedScene]
var placed_allies: Array[Node] = []

func place_ally(ally_data: AllyData, position: Vector2) -> Node:
	# Place ally at base level on game field
	pass

func upgrade_ally_in_game(ally_node: Node, target_level: AllyLevel) -> bool:
	# Upgrade specific ally instance during gameplay
	pass

func get_placeable_allies() -> Array[AllyData]:
	# Return allies that can be placed (unlocked and available)
	pass
```

#### 6.2 In-Game Ally Popup
**New Component: `screens/game_screen/ally_upgrade_popup.gd`**
```gdscript
class_name AllyUpgradePopup extends Control

@export var ally_node: Node
@export var ally_data: AllyData
@export var ud_ally: UDAlly

@onready var upgrade_tree_graph = $UpgradeTreeGraph
@onready var upgrade_button = $UpgradeButton
@onready var cost_label = $CostLabel

func setup_popup(ally: Node):
	# Configure popup for specific ally instance
	pass

func _on_upgrade_button_pressed():
	# Handle in-game upgrade
	pass
```

### 7. ACS System Integration

#### 7.1 Money Reward Actions
**New Action Payloads in `data/acs_system/actions/model/action.gd`:**
```gdscript
class PayMoneyReward extends Payload:
	var amount: int
	var money_type: String # "in_game" or "in_menu"
	
	func _init(_amount: int, _money_type: String) -> void:
		amount = _amount
		money_type = _money_type
```

#### 7.2 Level Completion Money Rewards
**New State Changer: `data/acs_system/state_changers/model/sc_award_money.gd`**
```gdscript
class_name SCAwardMoney extends StateChanger

func execute(payload: Action.PayMoneyReward) -> void:
	if payload.money_type == "in_menu":
		UDS.current_user_data.money_manager.in_menu_money += payload.amount
	elif payload.money_type == "in_game":
		UDS.current_user_data.money_manager.in_game_money += payload.amount
	
	UDS.save_user_data()
```

### 8. Data Files Structure

#### 8.1 Directory Organization
```
data/
├── game_characters/
│   ├── allies/
│   │   ├── res_data/
│   │   │   ├── model/
│   │   │   │   └── ally_data.gd (renamed from ally.gd)
│   │   │   └── data/
│   │   │       ├── chest.tres
│   │   │       └── shoter_ally.tres
│   │   ├── upgrade_levels/
│   │   │   ├── model/
│   │   │   │   ├── ally_level.gd (enhanced)
│   │   │   │   └── money_provider_level.gd
│   │   │   └── data/
│   │   │       ├── chest_levels/
│   │   │       └── shooter_ally_levels/
│   │   ├── upgrade_trees/
│   │   │   ├── model/
│   │   │   │   ├── ally_upgrade_tree.gd (new)
│   │   │   │   └── ally_upgrade_branch.gd (new)
│   │   │   └── data/
│   │   │       ├── chest_upgrade_tree.tres (new)
│   │   │       └── shooter_upgrade_tree.tres (new)
│   │   └── user_data/
│   │       ├── model/
│   │       │   └── ud_ally.gd (enhanced)
│   │       └── data/
│   │           ├── ud_chest.tres
│   │           └── ud_shoter_ally.tres
```

#### 8.2 Example Upgrade Tree Data
**File: `data/game_characters/allies/upgrade_trees/data/chest_upgrade_tree.tres`**
```gdscript
[gd_resource type="AllyUpgradeTree" format=3]

[resource]
base_level = preload("res://data/game_characters/allies/upgrade_levels/data/chest_levels/base_chest_lvl.tres")
upgrade_branches = Array[AllyUpgradeBranch]([
	preload("res://data/game_characters/allies/upgrade_trees/data/chest_speed_branch.tres"),
	preload("res://data/game_characters/allies/upgrade_trees/data/chest_wealth_branch.tres")
])
```

### 9. UI/UX Specifications

#### 9.1 Market Popup Upgrade Tree Graph
- **Visual Elements:**
  - Nodes represent upgrade levels
  - Lines connect prerequisite relationships
  - Color coding:
    - Gray: Locked levels
    - Gold/Shining: Available for unlock
    - Green: Unlocked levels
    - Blue: Currently equipped level
  - Level icons with progression indicators

#### 9.2 In-Game Ally Popup
- **Similar to market popup but shows:**
  - Current in-game level vs max available
  - Temporary upgrade options
  - Cost in in-game currency
  - Upgrade tree limited to unlocked levels

#### 9.3 Money Display
- **Dual currency display:**
  - In-game money (temporary)
  - In-menu money (permanent)
  - Clear visual distinction between currencies

### 10. Implementation Priority

#### Phase 1: Core Systems
1. Rename Ally to AllyData
2. Implement MoneyManager system
3. Create AllyUpgradeTree classes
4. Enhance UDAlly with level progression

#### Phase 2: Market Integration
1. Create upgrade tree visualization
2. Implement market service
3. Update market popup UI
4. Add money reward system

#### Phase 3: In-Game Integration
1. Create ally placement system
2. Implement in-game upgrade popup
3. Add temporary upgrade mechanics
4. Integrate with ACS system

#### Phase 4: Polish & Testing
1. Create example upgrade trees
2. Balance pricing and progression
3. Test all user flows
4. Optimize performance

### 11. Technical Considerations

#### 11.1 Performance
- Cache upgrade tree calculations
- Lazy load upgrade tree visualizations
- Efficient state management for multiple allies

#### 11.2 Data Integrity
- Validate upgrade prerequisites
- Prevent invalid state transitions
- Backup user data before major changes

#### 11.3 Extensibility
- Support for new ally types
- Flexible upgrade tree structures
- Modular branch system

### 12. Testing Strategy

#### 12.1 Unit Tests
- AllyUpgradeTree logic
- Money management operations
- Level progression validation

#### 12.2 Integration Tests
- Market to game flow
- Save/load functionality
- ACS system integration

#### 12.3 User Experience Tests
- Upgrade tree navigation
- Visual feedback clarity
- Purchase flow validation

## Conclusion

This proposal provides a comprehensive framework for implementing a rich allies system with branching upgrades, dual currency economy, and seamless integration between market and gameplay mechanics. The system is designed to be extensible and maintainable while providing engaging progression mechanics for players.