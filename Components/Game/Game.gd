extends Node2D

# Nodes ball
var ballScene = preload("res://Components/Ball/Ball.tscn")

# get the timer
@onready var timer = $Timer

# sounds to manipulate
@onready var StartGameSound = $StartGame

# Stats from current play
@onready var BallNumberInfo = $GameStats/TextBallCurrent
@onready var LinesInfo = $GameStats/TextLinesCount
@onready var UsedBallNumberInfo = $GameStats/TextBallExtracted

@onready var BallsGenerator = $BallRandomNmr
@onready var Card = $Card

@onready var pause_button =$Pause2  
# Sound Node
@onready var SoundOnBingo = get_node("BingoSound")

var IsBingo = false
var ball = null
var is_paused = false

func _ready():
	StartGameSound.play()
	spawnBall()


func spawnBall():
	Card.isCardComplete()
	
	ball = ballScene.instantiate()
	ball.position = Vector2(20, 0)
	ball.setNumber(BallsGenerator.getNextBallNumber())
	add_child(ball)
	
	updateBallInfo()

func updateBallInfo():
	if ball:
		BallNumberInfo.text = str(ball.getNumber())
	
	LinesInfo.text = str(Card.getLinesCompleted())
	UsedBallNumberInfo.text = str(BallsGenerator.getExtractedBalls())

func _on_Area2D_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	if timer.time_left <= 0:
		ball = body
		var ballNumber = body.getNumber()

		Card.checkNumber(ballNumber)
		
		updateBallInfo()

		timer.start(3.0)

func _on_Timer_timeout():
	remove_child(ball)
	spawnBall()

func _on_Card_bingo():
	get_tree().reload_current_scene()
	

func _on_BallNumberGenerator_extraction_complete():
	get_tree().reload_current_scene()

