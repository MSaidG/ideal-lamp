extends CharacterBody2D

signal change_dimension()
signal changed_location()

const TILE_SIZE = 16
var is_moving : bool = false
var is_changed_location : bool = true
var hasKey : bool = false

var move_direction := Vector2.ZERO
var player_position := self.get_position_delta()
var speed : int = 30
var target_position : Vector2 
var distance_to_move = TILE_SIZE
var can_move_f : bool = true
var can_move_b : bool = true
var can_move_l : bool = true
var can_move_r : bool = true
var x_position : int
var y_position : int

var is_in_dialogue : bool = false:
	set (value):
		is_in_dialogue = value
	get:
		return is_in_dialogue



# parameters/Idle/blend_position

@export var starting_direction := Vector2(0, 1)

@onready var animation_tree = $AnimationTree
@onready var animation_state_machine = animation_tree.get("parameters/playback")
@onready var raycast_f = $RayCast2DF
@onready var raycast_b = $RayCast2DB
@onready var raycast_r = $RayCast2DR
@onready var raycast_l = $RayCast2DL

var test := Vector2.ZERO

func _ready() -> void:
	update_animation(starting_direction)

func _process(_delta: float) -> void: 

	calculate_velocity()
	move_and_slide()
	check_position()

		

func _input(event: InputEvent) -> void:

	if !check_is_moving() and !is_in_dialogue:
		get_movement_input(event)
		get_dimension_input(event)

	update_animation(move_direction)
		

func _physics_process(_delta):

	# print(raycast_f.is_colliding())
	if raycast_b.is_colliding() and (raycast_b.get_collider() != null):
		if "TileMap" in raycast_b.get_collider().name:
			can_move_b = false
	else:
		can_move_b = true

	if raycast_f.is_colliding() and (raycast_f.get_collider() != null):
		if "TileMap" in raycast_f.get_collider().name:
			can_move_f = false

	else:
		can_move_f = true
	
	if raycast_r.is_colliding() and (raycast_r.get_collider() != null):
		if "TileMap" in raycast_r.get_collider().name:
			can_move_r = false
	else:
		can_move_r = true
			
	if raycast_l.is_colliding() and (raycast_l.get_collider() != null):
		if "TileMap" in raycast_l.get_collider().name:
			can_move_l = false

	else:
		can_move_l = true


func get_movement_input(event):

	x_position = int(position.x)
	y_position = int(position.y)

	if event.is_action_pressed("move_forward") and can_move_f:
		move_direction = Vector2(0, -1)
		target_position = Vector2(x_position, y_position - distance_to_move)
		is_changed_location = true

	elif event.is_action_pressed("move_backward") and can_move_b:
		move_direction = Vector2(0, 1)
		target_position = Vector2(x_position, y_position + distance_to_move)
		is_changed_location = true


	elif event.is_action_pressed("move_left") and can_move_l:
		move_direction = Vector2(-1, 0)
		target_position = Vector2(x_position - distance_to_move, y_position)
		is_changed_location = true


	elif event.is_action_pressed("move_right") and can_move_r:
		move_direction = Vector2(1, 0)
		target_position = Vector2(x_position + distance_to_move, y_position)
		is_changed_location = true


func get_dimension_input(event):

	if event.is_action_pressed("change_dimension"):
		emit_signal("change_dimension") 


func update_animation(move_input: Vector2) -> void:

	if move_input != Vector2.ZERO:
		animation_tree.set("parameters/Walk/blend_position", move_input)
		animation_tree.set("parameters/Idle/blend_position", move_input)


func change_animation_state():

	if (velocity != Vector2.ZERO):
		animation_state_machine.travel("Walk")
	else:
		animation_state_machine.travel("Idle")
		
func calculate_velocity() -> void:

	velocity = move_direction * speed 


func check_position() -> void:

	var current_position := Vector2(int(position.x), int(position.y)) 
	change_animation_state()		

	if target_position == current_position:
		convert_position_to_int()
		move_direction = Vector2.ZERO
		if is_changed_location:
			emit_signal("changed_location")
			is_changed_location = false
		# print(self.position)
	

func check_is_moving() -> bool:

	is_moving = (velocity != Vector2.ZERO)
	return is_moving


func convert_position_to_int():
	position.x = int(position.x)
	position.y = int(position.y)


func get_key(): # Connected from key
	hasKey = true
	# print(hasKey)


func check_key() -> bool:

	return hasKey


func enter_dialogue_mode():
	is_in_dialogue = true


func exit_dialogue_mode():
	is_in_dialogue = false
