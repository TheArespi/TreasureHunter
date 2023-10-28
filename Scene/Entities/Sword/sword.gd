extends Area2D

@export var weapon_resource: Weapon
@export var entity_information: Node

func _ready():
	position = position.snapped(Vector2.ONE * 16)
	position += Vector2.ONE * 16 / 2

func _on_acquirable_interaction_acquired():
	GlobalStuff.equip.emit("Player", weapon_resource)
	GlobalStuff.delete_entity(entity_information.entity_name)
	queue_free()
