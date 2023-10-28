extends Node

@export var mob_count: int = 5
@export var tilemap: TileMap
@export var mob_obj: PackedScene

var mobs = {}

signal mob_spawning_done

func _ready():
	var tilemap_rect = tilemap.get_used_rect()
	var map_cellsize = tilemap.tile_set.tile_size
	var entity_position = map_cellsize / 2
	
	for x in mob_count: 
		var found_free_tile = false
		var random_area = Vector2.ZERO
		
		while !found_free_tile: 
			var rand_x = (tilemap_rect.position.x + get_random_int(tilemap_rect.end.x, tilemap_rect.position.x)) * map_cellsize.x
			var rand_y = (tilemap_rect.position.y + get_random_int(tilemap_rect.end.y, tilemap_rect.position.y)) * map_cellsize.y
			random_area = Vector2(rand_x + entity_position.x, rand_y + entity_position.y)
			
			found_free_tile = true
			
			for static_body in tilemap.get_children():
				var in_polygon: bool = Geometry2D.is_point_in_polygon(random_area, static_body.get_node("CollisionPolygon2D").polygon)
				if in_polygon:
					found_free_tile = false
					break
					
		var new_mob = mob_obj.instantiate()
		new_mob.position = random_area
		add_child(new_mob)
		
	for mob in get_children():
		mobs[mob.get_node("EntityInformation").entity_name] = mob
		
	mob_spawning_done.emit()
	
func get_random_int(min_val: int, max_val: int):
	return randi() % (min_val - max_val)
