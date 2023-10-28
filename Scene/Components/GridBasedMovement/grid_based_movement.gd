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
				if facing_raycast.get_collider().get_node("Interactable") != null:
					var interactor = get_owner().get_node("EntityInformation").entity_name
					var interacted = facing_raycast.get_collider().get_node("EntityInformation").entity_name
					GlobalStuff.interaction.emit(interactor, interacted)
					
				target_position = get_owner().position
				stopped_moving.emit()
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

# will return an array of entity name or "" [ NORTH, EAST, SOUTH, WEST ]
func check_interactable():
	var north_interactable = ""
	var raycast_colliding = north_raycast.is_colliding()
	var collider_has_interactable = north_raycast.get_collider().get_node("Interactable") != null
	if raycast_colliding && collider_has_interactable:
		north_interactable = north_raycast.get_collider().get_node("EntityInformation").entity_name
		
	var east_interactable = ""
	raycast_colliding = east_raycast.is_colliding()
	collider_has_interactable = east_raycast.get_collider().get_node("Interactable") != null
	if raycast_colliding && collider_has_interactable:
		east_interactable = east_raycast.get_collider().get_node("EntityInformation").entity_name
		
	var south_interactable = ""
	raycast_colliding = south_raycast.is_colliding()
	collider_has_interactable = south_raycast.get_collider().get_node("Interactable") != null
	if raycast_colliding && collider_has_interactable:
		south_interactable = south_raycast.get_collider().get_node("EntityInformation").entity_name
		
	var west_interactable = ""
	raycast_colliding = west_raycast.is_colliding()
	collider_has_interactable = west_raycast.get_collider().get_node("Interactable") != null
	if raycast_colliding && collider_has_interactable:
		west_interactable = west_raycast.get_collider().get_node("EntityInformation").entity_name
		
	return [north_interactable, east_interactable, south_interactable, west_interactable]
	
func can_interact(direction: String):
	var raycast_colliding: bool
	var collider_has_interactable: bool
	
	if direction == "north":
		raycast_colliding = north_raycast.is_colliding()
		collider_has_interactable = north_raycast.get_collider().get_node("Interactable") != null
		if raycast_colliding && collider_has_interactable:
			return true
	elif direction == "east":
		raycast_colliding = east_raycast.is_colliding()
		collider_has_interactable = east_raycast.get_collider().get_node("Interactable") != null
		if raycast_colliding && collider_has_interactable:
			return true
	elif direction == "south":
		raycast_colliding = south_raycast.is_colliding()
		collider_has_interactable = south_raycast.get_collider().get_node("Interactable") != null
		if raycast_colliding && collider_has_interactable:
			return true
	elif direction == "west":
		raycast_colliding = west_raycast.is_colliding()
		collider_has_interactable = west_raycast.get_collider().get_node("Interactable") != null
		if raycast_colliding && collider_has_interactable:
			return true
	
	return false
