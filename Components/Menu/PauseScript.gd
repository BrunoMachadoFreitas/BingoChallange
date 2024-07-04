extends Button

# Icons for paused and unpaused states
@export var paused_icon: Texture2D
@export var playing_icon: Texture2D

# Called when the node enters the scene tree for the first time.
func _ready():
	update_button_icon()

# Function to toggle between game pause and play
func toggle_pause():
	get_tree().paused = not get_tree().paused

# Function called when the pause button is pressed
func _on_pause_button_pressed() -> void:
	toggle_pause()
	update_button_icon()

# Function to update the button icon according to the game state
func update_button_icon():
	if get_tree().paused:
		icon = paused_icon
	else:
		icon = playing_icon
