extends Node

var entities= {}

signal interaction(interactor: String, interacted: String)

signal start_turn(name: String)
signal end_turn(name: String)

signal update_player_position(current_position: Vector2)

signal death(name: String)

signal equip(equiper: String, weapon: Weapon)

func addEntity(entity_name: String, entity: Node):
	entities[entity_name] = entity
	print("Entities updated: ", entities)
