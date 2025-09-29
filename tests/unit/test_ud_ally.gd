extends GutTest

# Test for the UDAlly class

var ally_level_mock: AllyLevelData

func before_each():
	# Create a mock AllyLevelData for testing
	ally_level_mock = AllyLevelData.new()
	ally_level_mock.level_id = "test_level_1"

func after_each():
	ally_level_mock = null

# Basic Creation and Properties Tests
func test_ud_ally_creation():
	# Test that we can create a UDAlly
	var ud_ally = UDAlly.new()
	assert_not_null(ud_ally, "UDAlly should be created successfully")

func test_ud_ally_id_property():
	# Test the id property
	var ud_ally = UDAlly.new()
	ud_ally.id = AllyData.IDs.IRC
	assert_eq(ud_ally.id, AllyData.IDs.IRC, "UDAlly id should be settable and gettable")

func test_ud_ally_has_unlocked_levels_array():
	# Test that unlocked_levels is initialized as array
	var ud_ally = UDAlly.new()
	assert_not_null(ud_ally.unlocked_levels, "Unlocked levels should not be null")
	assert_true(ud_ally.unlocked_levels is Array, "Unlocked levels should be an Array")

func test_ud_ally_has_buyed_levels_array():
	# Test that buyed_levels is initialized as array
	var ud_ally = UDAlly.new()
	assert_not_null(ud_ally.buyed_levels, "Buyed levels should not be null")
	assert_true(ud_ally.buyed_levels is Array, "Buyed levels should be an Array")

func test_ud_ally_has_levels_conditions_dictionary():
	# Test that levels_conditions is initialized as dictionary
	var ud_ally = UDAlly.new()
	assert_not_null(ud_ally.levels_conditions, "Levels conditions should not be null")
	assert_true(ud_ally.levels_conditions is Dictionary, "Levels conditions should be a Dictionary")

# Base LevelData Tests
func test_set_base_level():
	# Test setting base level
	var ud_ally = UDAlly.new()
	ud_ally.base_level = ally_level_mock
	
	assert_eq(ud_ally.base_level, ally_level_mock, "Base level should be set correctly")
	assert_true(ud_ally.levels_conditions.has(ally_level_mock), "Base level should be added to conditions")
	assert_true(ud_ally.unlocked_levels.has("test_level_1"), "Base level should be unlocked")

# LevelData Status Tests
func test_is_level_unlocked_true():
	# Test checking if a level is unlocked when it is
	var ud_ally = UDAlly.new()
	ud_ally.unlocked_levels.append("test_level_1")
	
	assert_true(ud_ally.is_level_unlocked("test_level_1"), "Should return true for unlocked level")

func test_is_level_unlocked_false():
	# Test checking if a level is unlocked when it isn't
	var ud_ally = UDAlly.new()
	
	assert_false(ud_ally.is_level_unlocked("test_level_1"), "Should return false for locked level")

func test_is_level_buyed_true():
	# Test checking if a level is buyed when it is
	var ud_ally = UDAlly.new()
	ud_ally.buyed_levels.append("test_level_1")
	
	assert_true(ud_ally.is_level_buyed("test_level_1"), "Should return true for buyed level")

func test_is_level_buyed_false():
	# Test checking if a level is buyed when it isn't
	var ud_ally = UDAlly.new()
	
	assert_false(ud_ally.is_level_buyed("test_level_1"), "Should return false for non-buyed level")

# Array Manipulation Tests
func test_unlocked_levels_can_be_modified():
	# Test that we can add levels to unlocked array
	var ud_ally = UDAlly.new()
	ud_ally.unlocked_levels.append("level_2")
	ud_ally.unlocked_levels.append("level_3")
	
	assert_eq(ud_ally.unlocked_levels.size(), 2, "Should have 2 unlocked levels")
	assert_true(ud_ally.unlocked_levels.has("level_2"), "Should contain level_2")
	assert_true(ud_ally.unlocked_levels.has("level_3"), "Should contain level_3")

func test_buyed_levels_can_be_modified():
	# Test that we can add levels to buyed array
	var ud_ally = UDAlly.new()
	ud_ally.buyed_levels.append("level_2")
	ud_ally.buyed_levels.append("level_3")
	
	assert_eq(ud_ally.buyed_levels.size(), 2, "Should have 2 buyed levels")
	assert_true(ud_ally.buyed_levels.has("level_2"), "Should contain level_2")
	assert_true(ud_ally.buyed_levels.has("level_3"), "Should contain level_3")

# Integration Test
func test_base_level_automatically_unlocked():
	# Test that setting base level automatically unlocks it
	var ud_ally = UDAlly.new()
	ally_level_mock.level_id = "base_level"
	
	ud_ally.base_level = ally_level_mock
	
	assert_true(ud_ally.is_level_unlocked("base_level"), "Base level should be automatically unlocked")
	assert_false(ud_ally.is_level_buyed("base_level"), "Base level should not be automatically buyed")
