extends Button

var buttonPlayRacing : Button;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	buttonPlayRacing = get_parent().get_node("PlayRacing");
	self.grab_focus();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta : float) -> void:
	pass

func _toggled(_button_pressed : bool) -> void:
	buttonPlayRacing.set_pressed_no_signal(false);
	print("Boton Training Pushed");
