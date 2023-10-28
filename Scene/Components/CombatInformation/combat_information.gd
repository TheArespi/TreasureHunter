extends Node

@export var base_damage: int = 10
@export var weapon: Weapon = null

func calculate_damage():
	if weapon != null:
		return weapon.base_damage
	return base_damage
