extends CharacterBody2D


var moving : bool = false
const TILE_SIZE = 64

var move_direction := Vector2.ZERO
var player_postiion := self.get_position_delta()
var speed : int = 30
var target_position : Vector2
var distance_to_move = 10 

# parameters/Idle/blend_position

@export var starting_direction := Vector2(0, 1)

@onready var animation_tree = $AnimationTree
@onready var animation_state_machine = animation_tree.get("parameters/playback")


var test := Vector2.ZERO

func _ready() -> void:
	update_animation(starting_direction)

func _process(_delta: float) -> void: 

	calculate_velocity()
	move_and_slide()
	check_position()

		

func _input(event: InputEvent) -> void:

	if !moving:
		var x_position = int(position.x)
		var y_position = int(position.y)
		if event.is_action_pressed("move_forward"):
			move_direction = Vector2(0, -1);
			target_position = Vector2(int(x_position) , y_position - distance_to_move);
		elif event.is_action_pressed("move_backward"):
			move_direction = Vector2(0, 1);
			target_position = Vector2(int(x_position) , y_position + distance_to_move);
		elif event.is_action_pressed("move_left"):
			move_direction = Vector2(-1, 0);
			target_position = Vector2(x_position - distance_to_move, int(y_position));
		elif event.is_action_pressed("move_right"):
			move_direction = Vector2(1, 0);
			target_position = Vector2(x_position + distance_to_move, int(y_position));

	update_animation(move_direction)
		
		

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
		move_direction = Vector2.ZERO

