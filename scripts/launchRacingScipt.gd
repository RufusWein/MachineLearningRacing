extends Button

var buttonTraining : Button;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	buttonTraining = get_parent().get_node("Training");

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta : float) -> void:
	pass
	
func _toggled(_button_pressed : bool) -> void:
	buttonTraining.set_pressed_no_signal(false);
	print("Boton Racing Pushed");
	
