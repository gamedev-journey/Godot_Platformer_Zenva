extends KinematicBody2D

var score : int = 0
var speed : int = 200
var jumpForce : int = 600
var gravity : int = 800
var velocity : Vector2 = Vector2()
onready var sprite : Sprite = get_node("Sprite")
onready var ui : Node = get_node("/root/MainScene/CanvasLayer/UI")
onready var audioPlayer : Node = get_node("/root/MainScene/Camera2D/AudioPlayer")
 
func _physics_process(delta):
	velocity.x = 0
	
	#movement input
	if Input.is_action_pressed("move_left"):
		velocity.x -= speed
	if Input.is_action_pressed("move_right"):
		velocity.x += speed
	
	#apply movvement
	velocity = move_and_slide(velocity, Vector2.UP)
	
	#gravity
	velocity.y += gravity * delta
	
	#jump input
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y -= jumpForce
	
	#sprite direction
	if velocity.x < 0:
		sprite.flip_h = true
	elif velocity.x > 0:
		sprite.flip_h = false

func die():
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()
	
func collect_coin(value):
	score += value
	ui.set_score_text(score)
	audioPlayer.play_coin_sfx()
