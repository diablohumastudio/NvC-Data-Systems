class_name EnemyScene extends GameCharacter

var type: TYPES
enum TYPES {HandGunGerman}

func receive_damage(damage_points: float, _damage_type: GameCharacter.DAMAGE_TYPES):
	super.receive_damage(damage_points, _damage_type)

func check_dying_conditions() -> void:
	super()
