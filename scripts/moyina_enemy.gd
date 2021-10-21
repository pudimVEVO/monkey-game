extends KinematicBody2D

var motion = Vector2()
export(int) var speed = 135
export(String) var type
export(bool) var dir

func _ready():
	if type == "ud":
		$U.enabled = true
		$D.enabled = true
		$R.enabled = false
		$L.enabled = false
	
	if type == "lr":
		$U.enabled = false
		$D.enabled = false
		$R.enabled = true
		$L.enabled = true

func _physics_process(delta):
	if type == "ud":
		if dir == true:
			motion.y = -speed
		if dir == false:
			motion.y = speed
		if $U.is_colliding() == true && $U.get_collider().get("TYPE") == null && dir == true:
			dir = false
	
		if $D.is_colliding() == true && $D.get_collider().get("TYPE") == null && dir == false:
			dir = true
	
	if type == "lr":
		if dir == true:
			motion.x = speed
		if dir == false:
			motion.x = -speed
		if $R.is_colliding() == true && $R.get_collider().get("TYPE") == null && dir == true:
			dir = false
	
		if $L.is_colliding() == true && $L.get_collider().get("TYPE") == null && dir == false:
			dir = true
	motion = move_and_slide(motion)
	


func _on_Area2D_body_entered(body):
	if body.get("TYPE") == 'player':
		print("AH")
