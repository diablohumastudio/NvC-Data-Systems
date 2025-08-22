extends GutTest

# Test for the Action class and its payload classes

func before_each():
	pass

func after_each():
	pass

# Basic Action Tests
func test_action_creation_with_basic_payload():
	# Test creating an action with basic payload
	var payload = ActionPayload.new()
	var action = Action.new(Action.TYPES.LV_COMPLTD, payload)

	assert_not_null(action, "Action should be created successfully")
	assert_eq(action.type, Action.TYPES.LV_COMPLTD, "Action type should be set correctly")
	assert_not_null(action.payload, "Action payload should not be null")

func test_action_types_enum():
	# Test that all enum values exist
	assert_true(Action.TYPES.has("LV_COMPLTD"), "Should have LV_COMPLTD type")
	assert_true(Action.TYPES.has("ENEMY_KILLED"), "Should have ENEMY_KILLED type")
	assert_true(Action.TYPES.has("LV_COMPLTD_ALL_CANONS"), "Should have LV_COMPLTD_ALL_CANONS type")
	assert_true(Action.TYPES.has("BUYED_ALLY_LEVEL"), "Should have BUYED_ALLY_LEVEL type")

# Payload Tests
func test_basic_payload():
	# Test basic payload creation
	var payload = ActionPayload.new()
	assert_not_null(payload, "Basic payload should be created")
	assert_true(payload is ActionPayload, "Should be instance of Action.Payload")

func test_pay_lv_compl_payload():
	# Test PayLvCompl payload
	var payload = PayLvCompl.new(LevelData.IDs.Level1)
	
	assert_not_null(payload, "PayLvCompl payload should be created")
	assert_true(payload is ActionPayload, "Should inherit from Payload")
	assert_eq(payload.level_id, LevelData.IDs.Level1, "LevelData ID should be set correctly")

func test_pay_enem_killed_payload():
	# Test PayEnemKilled payload
	var killed_count = 5
	var payload = PayEnemKilled.new(killed_count)
	
	assert_not_null(payload, "PayEnemKilled payload should be created")
	assert_true(payload is ActionPayload, "Should inherit from Payload")
	assert_eq(payload.killed_enemies, killed_count, "Killed enemies count should be set correctly")

func test_pay_lvl_compl_all_canons_payload():
	# Test PayLvlComplAllCanons payload
	var canons_alive = 3
	var payload = PayLvlComplAllCanons.new(LevelData.IDs.Level2, canons_alive)
	
	assert_not_null(payload, "PayLvlComplAllCanons payload should be created")
	assert_true(payload is ActionPayload, "Should inherit from Payload")
	assert_eq(payload.level_id, LevelData.IDs.Level2, "LevelData ID should be set correctly")
	assert_eq(payload.canons_alive, canons_alive, "Canons alive should be set correctly")

func test_pay_buyed_ally_level_payload():
	# Test PayBuyedAllyLevel payload
	var ally_level_id = "fast_chest_lvl_1"
	var payload = PayBuyedAllyLevel.new(ally_level_id, Ally.IDs.CHEST)
	
	assert_not_null(payload, "PayBuyedAllyLevel payload should be created")
	assert_true(payload is ActionPayload, "Should inherit from Payload")
	assert_eq(payload.ally_level_id, ally_level_id, "Ally level ID should be set correctly")
	assert_eq(payload.ally_id, Ally.IDs.CHEST, "Ally ID should be set correctly")

# Integration Tests
func test_action_with_level_completion_payload():
	# Test full action with level completion
	var payload = PayLvCompl.new(LevelData.IDs.Level2)
	var action = Action.new(Action.TYPES.LV_COMPLTD, payload)
	
	assert_eq(action.type, Action.TYPES.LV_COMPLTD, "Action type should match")
	assert_true(action.payload is PayLvCompl, "Payload should be correct type")
	assert_eq(action.payload.level_id, LevelData.IDs.Level2, "Payload should contain correct level ID")

func test_action_with_enemy_killed_payload():
	# Test full action with enemy killed
	var enemies_killed = 10
	var payload = PayEnemKilled.new(enemies_killed)
	var action = Action.new(Action.TYPES.ENEMY_KILLED, payload)
	
	assert_eq(action.type, Action.TYPES.ENEMY_KILLED, "Action type should match")
	assert_true(action.payload is PayEnemKilled, "Payload should be correct type")
	assert_eq(action.payload.killed_enemies, enemies_killed, "Payload should contain correct count")
