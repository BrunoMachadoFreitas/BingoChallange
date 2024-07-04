extends RigidBody2D

@onready var BallSpawnedSound = get_node("BallSpawned")

# Sound Node
@onready var BallRollSound = get_node("BallRoll")

func _ready():
	BallSpawnedSound.play(35.48)

func _physics_process(_delta):
	apply_central_impulse(Vector2(0, 150))
	

func setNumber(number):
	$BallInfo.setNumber(number)

func _on_Ball_body_entered(_body):
	if !BallRollSound.playing:
		BallRollSound.play(2.70)

func _on_Ball_child_exiting_tree(_node):
	BallRollSound.stop()
	
func getNumber():
	return $BallInfo.number	
