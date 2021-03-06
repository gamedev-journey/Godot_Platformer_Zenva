extends Area2D

export var speed : int = 100
export var moveDistance : int = 100

onready var startX : int = position.x
onready var targetX : int = position.x + moveDistance

var enemyRotation : float = 360.0


func _process(delta):
	rotation_degrees += enemyRotation * delta
	position.x = move_to(position.x, targetX, speed * delta)
	
	if position.x == targetX:
		if targetX == startX:
			targetX = position.x + moveDistance
			
		else:
			targetX = startX


func move_to(current, to, step):
	var new = current
	
	if new < to:
		new += step
		if new > to:
			new = to
	else:
		new -= step
		if new < to:
			new = to
	return new


func _on_Enemy_body_entered(body):
	if body.name == "Player":
		body.die()
		

	
