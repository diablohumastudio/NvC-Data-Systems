extends GutTest

# Test for the CondLvCompl (LevelData Completion Condition) class

var condition: CondLvCompl
var action_correct: Action
var action_wrong: Action

func before_each():
	# Setup condition and actions for testing
	condition = CondLvCompl.new()
	condition.level_id = LevelData.IDs.Level1
	condition.id = "test_cond_lv_1"
	
	# Correct action that should trigger the condition
	var payload_correct = PayLvCompl.new(LevelData.IDs.Level1)
	action_correct = Action.new(Action.TYPES.LV_COMPLTD, payload_correct)
	
	# Wrong action that should not trigger the condition
	var payload_wrong = PayLvCompl.new(LevelData.IDs.Level2)
	action_wrong = Action.new(Action.TYPES.LV_COMPLTD, payload_wrong)

func after_each():
	condition = null
	action_correct = null
	action_wrong = null

# Basic Creation Tests
func test_cond_lv_compl_creation():
	# Test that we can create a CondLvCompl
	var cond = CondLvCompl.new()
	assert_not_null(cond, "CondLvCompl should be created successfully")

func test_cond_lv_compl_extends_condition():
	# Test that CondLvCompl extends Condition
	var cond = CondLvCompl.new()
	assert_true(cond is Condition, "CondLvCompl should extend Condition")

func test_cond_lv_compl_sets_type_automatically():
	# Test that type is set automatically in _init
	var cond = CondLvCompl.new()
	assert_eq(cond.type, Action.TYPES.LV_COMPLTD, "Type should be set to LV_COMPLTD automatically")

# Property Tests
func test_cond_lv_compl_has_level_id_property():
	# Test the level_id property
	var cond = CondLvCompl.new()
	cond.level_id = LevelData.IDs.Level3
	assert_eq(cond.level_id, LevelData.IDs.Level3, "CondLvCompl level_id should be settable and gettable")

# Signal Tests
func test_condition_emits_fullfilled_signal_on_correct_level():
	# Test that signal is emitted when correct level is completed
	var signal_emitted = [false]
	var emitted_condition = [null]
	printt(signal_emitted, emitted_condition)
	# Connect to the signal
	condition.fullfilled.connect(func(cond): 
		signal_emitted[0] = true
		emitted_condition[0] = cond
	)
	# Evaluate with correct action
	condition.evaluate(action_correct)
	
	await get_tree().process_frame  # Wait for signal processing
	printt(signal_emitted, emitted_condition)
	
	assert_true(signal_emitted[0], "Signal should be emitted for correct level")
	assert_eq(emitted_condition[0], condition, "Emitted condition should be self")

func test_condition_does_not_emit_signal_on_wrong_level():
	# Test that signal is not emitted when wrong level is completed
	var signal_emitted = [false]
	
	# Connect to the signal
	condition.fullfilled.connect(func(_cond): signal_emitted[0] = true)
	
	# Evaluate with wrong action
	condition.evaluate(action_wrong)
	
	await get_tree().process_frame  # Wait for signal processing
	
	assert_false(signal_emitted[0], "Signal should not be emitted for wrong level")

# Evaluation Logic Tests
func test_evaluate_with_matching_level_id():
	# Test evaluation logic with matching level ID
	condition.level_id = LevelData.IDs.Level2
	var payload = PayLvCompl.new(LevelData.IDs.Level2)
	var action = Action.new(Action.TYPES.LV_COMPLTD, payload)
	
	var signal_received = [false]
	condition.fullfilled.connect(func(_cond): signal_received[0] = true)
	
	condition.evaluate(action)
	await get_tree().process_frame
	
	assert_true(signal_received[0], "Should emit signal for matching level ID")

func test_evaluate_with_non_matching_level_id():
	# Test evaluation logic with non-matching level ID
	condition.level_id = LevelData.IDs.Level1
	var payload = PayLvCompl.new(LevelData.IDs.Level3)
	var action = Action.new(Action.TYPES.LV_COMPLTD, payload)
	
	var signal_received = [false]
	condition.fullfilled.connect(func(_cond): signal_received[0] = true)
	
	condition.evaluate(action)
	await get_tree().process_frame
	
	assert_false(signal_received[0], "Should not emit signal for non-matching level ID")

# Edge Cases
func test_evaluate_with_wrong_action_type():
	# Test evaluation with wrong action type (should not crash)
	var payload = PayEnemKilled.new(5)
	var wrong_type_action = Action.new(Action.TYPES.ENEMY_KILLED, payload)
	
	# This should not crash even though payload is wrong type
	condition.evaluate(wrong_type_action)
	pass_test("Should handle wrong action type without crashing")

# Integration Test
func test_full_condition_workflow():
	# Test the complete workflow of condition creation and evaluation
	var cond = CondLvCompl.new()
	cond.level_id = LevelData.IDs.LevelEx
	cond.id = "complete_extra_level"
	
	var signal_data = []
	cond.fullfilled.connect(func(condition_instance): 
		signal_data.append(condition_instance)
	)
	
	# Test with correct level
	var payload = PayLvCompl.new(LevelData.IDs.LevelEx)
	var action = Action.new(Action.TYPES.LV_COMPLTD, payload)
	
	cond.evaluate(action)
	await get_tree().process_frame
	
	assert_eq(signal_data.size(), 1, "Should have received one signal")
	assert_eq(signal_data[0], cond, "Signal should contain the condition instance")
	assert_eq(signal_data[0].level_id, LevelData.IDs.LevelEx, "Condition should have correct level_id")
