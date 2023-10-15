extends Area2D

var current_target_position: Vector2 = Vector2.ZERO

func _ready():
	GlobalStuff.update_player_position.connect(player_position_updated)

func _process(_delta):
	if $TurnBasedEntity.current_turn:
		var x_diff: float = position.x - current_target_position.x
		var y_diff: float = position.y - current_target_position.y
		
		if abs(x_diff) > abs(y_diff):
			if x_diff < 0:
				$GridBasedMovement.move("Right")
			else:
				$GridBasedMovement.move("Left")
		else:
			if y_diff < 0:
				$GridBasedMovement.move("Down")
			else:
				$GridBasedMovement.move("Up")
		
func player_position_updated(current_position: Vector2):
	current_target_position = current_position

func _on_grid_based_movement_stopped_moving():
	GlobalStuff.end_turn.emit($EntityInformation.entity_name)
