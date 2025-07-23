extends GutTest

func test_create_ud_level():
	var new_ud_level : UDLevel = UDLevel.new()
	assert_not_null(new_ud_level, "UDLevel wont create by code.")

func test_load_ud_level_resource_file():
	var loaded_ud_level: UDLevel = load("res://data/levels/user_data/data/ud_lv_2.tres")
	assert_not_null(loaded_ud_level, "UDLevel notloaded by code.")

func test_complete_condition_on_ud_level():
	var new_ud_level: UDLevel = UDLevel.new()
	var new_condition: CondTest = CondTest.new()	
	new_ud_level.unlocked_conditionis = {
		new_condition: false
		}
	new_condition.type = Action.TYPES.TEST
	#new_condition.fullfilled.emit(new_condition)
	ACS.conditions.append(new_condition)
	ACS.set_action(Action.new(Action.TYPES.TEST, Action.Payload.new()))
	assert_eq(new_ud_level.unlocked_conditionis, {new_condition: true})
	assert_eq(new_ud_level.locked, false, "Condition doesn't activate ud_level")
