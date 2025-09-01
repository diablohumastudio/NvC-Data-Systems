class_name Enemy extends GameCharacter

# Enemy-specific properties (inherits hp, current_hp, accuracy_points, DAMAGE_TYPES from GameCharacter)

# Override the damage and death interface for enemy-specific behavior
func receive_damage(damage_points: float, _damage_type: GameCharacter.DAMAGE_TYPES):
	super.receive_damage(damage_points, _damage_type)

func check_dying_conditions() -> void:
	super()
