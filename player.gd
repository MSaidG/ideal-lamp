extends CharacterBody2D


var is_moving : bool = false
var hasKey : bool = false
const TILE_SIZE = 16

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

	if !check_is_moving():
		get_movement_input(event)

	update_animation(move_direction)
		

func _physics_process(_delta):
	
	can_move_b = !raycast_b.is_colliding()
	can_move_f = !raycast_f.is_colliding()
	can_move_l = !raycast_l.is_colliding()
	can_move_r = !raycast_r.is_colliding()

	# if !can_move_r:
		# print(raycast_r.get_collider().name)



func get_movement_input(event):

	x_position = int(position.x)
	y_position = int(position.y)

	if event.is_action_pressed("move_forward") and can_move_f:
		move_direction = Vector2(0, -1)
		target_position = Vector2(x_position, y_position - distance_to_move)

	elif event.is_action_pressed("move_backward") and can_move_b:
		move_direction = Vector2(0, 1)
		target_position = Vector2(x_position, y_position + distance_to_move)

	elif event.is_action_pressed("move_left") and can_move_l:
		move_direction = Vector2(-1, 0)
		target_position = Vector2(x_position - distance_to_move, y_position)

	elif event.is_action_pressed("move_right") and can_move_r:
		move_direction = Vector2(1, 0)
		target_position = Vector2(x_position + distance_to_move, y_position)


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
		
		# print(self.position)
	

func check_is_moving() -> bool:

	is_moving = (velocity != Vector2.ZERO)
	return is_moving


func convert_position_to_int():
	position.x = int(position.x)
	position.y = int(position.y)


func get_key():
	hasKey = true
	print(hasKey)