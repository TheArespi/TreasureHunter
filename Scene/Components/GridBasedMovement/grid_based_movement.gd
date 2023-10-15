extends Node

@export var north_raycast = RayCast2D
@export var east_raycast = RayCast2D
@export var west_raycast = RayCast2D
@export var south_raycast = RayCast2D

@export var sprite_2d = Sprite2D

# remove this after creating the tilemap
@export var tile_size: int = 16
@export var minimum_distance: float = 0.1
@export var speed: float = 1

var moving: bool = false
var target_position: Vector2

var facing_raycast: RayCast2D

signal started_moving
signal stopped_moving

func _ready():
	#snap properly to tile
	get_owner().position = get_owner().position.snapped(Vector2.ONE * tile_size)
	get_owner().position += Vector2.ONE * tile_size / 2
	target_position = get_owner().position
	facing_raycast = south_raycast

func _process(_delta): 
	if !moving:
		if get_owner().position.distance_to(target_position) > minimum_distance:
			if facing_raycast.is_colliding():
				target_position = get_owner().position
				stopped_moving.emit()
				#if there is an interactable, interact
			else:
				moving = true
				started_moving.emit()
	else:
		get_owner().position = get_owner().position.move_toward(target_position, speed)
		
		if get_owner().position.distance_to(target_position) < minimum_distance:
			moving = false
			get_owner().position = target_position
			stopped_moving.emit()

func move(dir: String):
	if !moving:
		if dir == "Right":
			sprite_2d.flip_h = false
			target_position.x += tile_size
			facing_raycast = east_raycast
		elif dir == "Left":
			sprite_2d.flip_h = true
			target_position.x -= tile_size
			facing_raycast = west_raycast
		elif dir == "Up":
			target_position.y -= tile_size
			facing_raycast = north_raycast
		elif dir == "Down":
			target_position.y += tile_size
			facing_raycast = south_raycast

# will return an array of interactable or null [ NORTH, EAST, SOUTH, WEST ]
func check_interactable():
	var north_interactable = null
	#TODO: make interactable component
	
