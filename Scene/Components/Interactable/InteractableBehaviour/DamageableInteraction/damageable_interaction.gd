extends Node

@export var health = Node
@export var combat_information = Node

func interact(interactor: String, interacted: String):
	if interactor == "Player":
		health.damage(GlobalStuff.entities[interactor].get_node("CombatInformation").calculate_damage())
	if interactor != "Player" and interacted == "Player":
		health.damage(GlobalStuff.entities[interactor].get_node("CombatInformation").calculate_damage())
		
	var weapon_used = "fist"
	var interactor_weapon = GlobalStuff.entities[interactor].get_node("CombatInformation").weapon
	if interactor_weapon != null:
		weapon_used = interactor_weapon.title
	print(interactor, " attacked ", interacted, " using ", weapon_used, " inflicting ", combat_information.calculate_damage(), " damage")
