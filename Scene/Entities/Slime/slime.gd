extends Area2D

var current_target_position: Vector2 = Vector2.ZERO
var picked_where_to_move: bool = false

func _ready():
	GlobalStuff.update_player_position.connect(player_position_updated)
	GlobalStuff.addEntity($EntityInformation.entity_name, self)

func _process(_delta):
	if $TurnBasedEntity.current_turn:
		var x_diff: float = position.x - current_target_position.x
		var y_diff: float = position.y - current_target_position.y
		
		if !picked_where_to_move:
			if abs(x_diff) > abs(y_diff):
				if x_diff < 0:
					print($EntityInformation.entity_name, " is going right")
					$GridBasedMovement.move("Right")
				else:
					print($EntityInformation.entity_name, " is going left")
					$GridBasedMovement.move("Left")
			else:
				if y_diff < 0:
					print($EntityInformation.entity_name, " is going down")
					$GridBasedMovement.move("Down")
				else:
					print($EntityInformation.entity_name, " is going up")
					$GridBasedMovement.move("Up")
			picked_where_to_move = true
		
func player_position_updated(current_position: Vector2):
	current_target_position = current_position

func _on_grid_based_movement_stopped_moving():
	GlobalStuff.end_turn.emit($EntityInformation.entity_name)
	picked_where_to_move = false
