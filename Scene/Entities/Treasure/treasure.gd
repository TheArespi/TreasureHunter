extends Area2D

func _ready():
    position = position.snapped(Vector2.ONE * 16)
    position += Vector2.ONE * 16 / 2

    GlobalStuff.add_entity($EntityInformation.entity_name, self)

func _on_acquirable_interaction_acquired():
    GlobalStuff.toggle_treasure_acquired()
    GlobalStuff.delete_entity($EntityInformation.entity_name)
    queue_free()
