extends Node2D

@export var max_health: int = 100
@export var entity_information: Node

var current_health: int

signal health_reached_zero(entity_name: String)

func _ready(): 
	$HealthBar.max_value = max_health
	set_current_health(max_health)
	
func set_current_health(value: int):
	current_health = value
	$HealthBar.value = value

func damage(amount: int):
	if amount > current_health:
		current_health = 0
		
	set_current_health(current_health - amount)
	
	if current_health == 0:
		health_reached_zero.emit(entity_information.entity_name)
