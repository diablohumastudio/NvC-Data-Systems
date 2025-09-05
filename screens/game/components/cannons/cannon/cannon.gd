class_name Cannon extends GameCharacter

var damage_per_hit : int = 100
var _is_already_shooting : bool

@export var cannon_number : int

func _on_physical_contact_area_2d_body_entered(body: Node2D) -> void:
	shoot()
	
func shoot():
	if not _is_already_shooting:
		
		_is_already_shooting = true
		%AnimationPlayer.play("_prepare_to_shoot")
		
		await get_tree().create_timer(.4).timeout
		
		AudioSystem.post_event(AK.EVENTS.PLAY_CANNON_SHOOTING)
		_create_and_send_bullet()
		GSS.cannon_shooted.emit(self)

func _create_and_send_bullet():
	var bullet : CannonBullet = load("uid://oq6aen6b7qdb").instantiate()
	bullet.position = %BulletPosition.position
	bullet.bullet_sender = self
	self.add_child(bullet)
