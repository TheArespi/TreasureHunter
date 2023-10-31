extends Area2D

func _ready():
	position = position.snapped(Vector2.ONE * 16)
	position += Vector2(8, 0)
	GlobalStuff.treasure_has_been_acquired.connect(open_door)

func open_door():
	$Sprite2D.set_region_rect(Rect2(16, 0, 16, 32))
