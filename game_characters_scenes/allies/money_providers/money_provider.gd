class_name MoneyProvider extends ScAlly

@export var coin_value : int
@export var minimum_value: int
@export var maximum_value: int

@onready var _timer : Timer = $Timer 
@warning_ignore("unused_private_class_variable")
@onready var _animation_player = $AnimationPlayer

func _ready():
	super()
	_start_coin_dropping_process()

func _start_coin_dropping_process():
	var starting_wait_time : float = float(_get_coin_drop_wait_time()) / float(2)
	
	_timer.wait_time = starting_wait_time
	_timer.start()
	
func _get_coin_drop_wait_time() -> int:
	var random_number_generator := RandomNumberGenerator.new()
	
	var random_int =  random_number_generator.randi_range(minimum_value, maximum_value)
	return random_int
