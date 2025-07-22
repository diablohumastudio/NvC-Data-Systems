extends GutTest

# Test for the AllyLevel class

func before_each():
	pass

func after_each():
	pass

# Basic Creation Tests
func test_ally_level_creation():
	# Test that we can create an AllyLevel
	var ally_level = AllyLevel.new()
	assert_not_null(ally_level, "AllyLevel should be created successfully")

func test_ally_level_extends_game_character_level():
	# Test that AllyLevel extends GameCharacterLevel
	var ally_level = AllyLevel.new()
	assert_true(ally_level is GameCharacterLevel, "AllyLevel should extend GameCharacterLevel")
	assert_true(ally_level is Resource, "AllyLevel should inherit from Resource")

# Property Tests
func test_ally_level_has_ally_id_property():
	# Test the ally_id property
	var ally_level = AllyLevel.new()
	ally_level.ally_id = Ally.IDs.CHEST
	assert_eq(ally_level.ally_id, Ally.IDs.CHEST, "AllyLevel ally_id should be settable and gettable")

func test_ally_level_has_level_id_property():
	# Test the level_id property
	var ally_level = AllyLevel.new()
	ally_level.level_id = "fast_chest_lvl_1"
	assert_eq(ally_level.level_id, "fast_chest_lvl_1", "AllyLevel level_id should be settable and gettable")

func test_ally_level_has_price_property():
	# Test the price property
	var ally_level = AllyLevel.new()
	ally_level.price = 100
	assert_eq(ally_level.price, 100, "AllyLevel price should be settable and gettable")

# Inherited Property Tests
func test_ally_level_inherits_initial_hp():
	# Test that AllyLevel inherits initial_HP from GameCharacterLevel
	var ally_level = AllyLevel.new()
	ally_level.initial_HP = 50
	assert_eq(ally_level.initial_HP, 50, "AllyLevel should inherit initial_HP property")

# Property Types Tests
func test_ally_level_level_id_is_string():
	# Test that level_id accepts string values
	var ally_level = AllyLevel.new()
	ally_level.level_id = ""
	assert_typeof(ally_level.level_id, TYPE_STRING, "level_id should be a String")

func test_ally_level_price_is_int():
	# Test that price accepts integer values
	var ally_level = AllyLevel.new()
	ally_level.price = 0
	assert_typeof(ally_level.price, TYPE_INT, "price should be an integer")

func test_ally_level_initial_hp_is_int():
	# Test that initial_HP accepts integer values
	var ally_level = AllyLevel.new()
	ally_level.initial_HP = 0
	assert_typeof(ally_level.initial_HP, TYPE_INT, "initial_HP should be an integer")

# Integration Tests
func test_ally_level_full_setup():
	# Test setting up a complete AllyLevel
	var ally_level = AllyLevel.new()
	
	ally_level.ally_id = Ally.IDs.BAYONETE_SOLDIER
	ally_level.level_id = "fast_shot_lvl_1"
	ally_level.price = 150
	ally_level.initial_HP = 75
	
	assert_eq(ally_level.ally_id, Ally.IDs.BAYONETE_SOLDIER, "Ally ID should be set correctly")
	assert_eq(ally_level.level_id, "fast_shot_lvl_1", "Level ID should be set correctly")
	assert_eq(ally_level.price, 150, "Price should be set correctly")
	assert_eq(ally_level.initial_HP, 75, "Initial HP should be set correctly")

func test_ally_level_negative_price():
	# Test that negative prices can be set (might be valid for some game mechanics)
	var ally_level = AllyLevel.new()
	ally_level.price = -10
	assert_eq(ally_level.price, -10, "Should allow negative prices")

func test_ally_level_zero_values():
	# Test that zero values work correctly
	var ally_level = AllyLevel.new()
	ally_level.price = 0
	ally_level.initial_HP = 0
	
	assert_eq(ally_level.price, 0, "Should allow zero price")
	assert_eq(ally_level.initial_HP, 0, "Should allow zero HP")

func test_ally_level_empty_level_id():
	# Test that empty level_id works
	var ally_level = AllyLevel.new()
	ally_level.level_id = ""
	assert_eq(ally_level.level_id, "", "Should allow empty level_id")
