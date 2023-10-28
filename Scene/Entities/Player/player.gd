extends Area2D

@export var tilemap: TileMap

func _ready():
	var map_limit = tilemap.get_used_rect()
	var map_cellsize = tilemap.tile_set.tile_size
	
	$Camera2D.limit_left = map_limit.position.x * map_cellsize.x
	$Camera2D.limit_right = map_limit.end.x * map_cellsize.x
	$Camera2D.limit_top = map_limit.position.y * map_cellsize.y
	$Camera2D.limit_bottom = map_limit.end.y * map_cellsize.y
	
	GlobalStuff.equip.connect(equip)
	GlobalStuff.addEntity($EntityInformation.entity_name, self)

func _process(_delta):
	if !$TurnBasedEntity.current_turn:
		return
		
	if !$GridBasedMovement.moving: 
		if Input.is_action_pressed("Right"):
			$GridBasedMovement.move("Right")
		elif Input.is_action_pressed("Left"):
			$GridBasedMovement.move("Left")
		elif Input.is_action_pressed("Up"):
			$GridBasedMovement.move("Up")
		elif Input.is_action_pressed("Down"):
			$GridBasedMovement.move("Down")

func _on_grid_based_movement_stopped_moving():
	GlobalStuff.update_player_position.emit(position)
	GlobalStuff.end_turn.emit($EntityInformation.entity_name)
	
func equip(_equipper: String, weapon: Weapon):
	$CombatInformation.weapon = weapon
