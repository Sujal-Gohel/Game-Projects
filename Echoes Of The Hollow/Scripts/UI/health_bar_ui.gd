extends TextureProgressBar

@onready var damage_bar: TextureProgressBar = $DamageBar
@onready var timer: Timer = $Timer

var health : float = 0.0 : set = set_health

#func _ready() -> void:
	#if  damage_bar.is_node_ready():
		#print(damage_bar)
	#if  timer.is_node_ready():
		#print(timer)

func set_health(new_health):
#if damage_bar and timer:
	var prev_health = health
	health = min(max_value,new_health)
	value = health
	#print("After Setting The Health Value Is:",value)
	#print("After Setting The Health Max Value Is :",max_value)
	
	if health < prev_health:
		timer.start()
	else :
		damage_bar.value = health
#else:
	#print("Damage Bar Not Loaded")

func init_health(p_health) :
#if damage_bar or timer:
	health = p_health
	#health = health * (health/100)
	max_value = health
	value = health
	#print("At Init Value Is :",value)
	#print("At Init Max Value Is :",max_value)
	damage_bar.max_value = health
	damage_bar.value = health
	#print(value)
#else:
	#print("Damage Bar Not Loaded")

func _on_timer_timeout() -> void:
	damage_bar.value = health
