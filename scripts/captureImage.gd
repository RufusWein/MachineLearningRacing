extends Camera2D

var cochito : CharacterBody2D;
var areaCapture: Rect2 = Rect2(10,-20,40,40);

	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cochito = get_parent().get_parent().get_node("CharacterBody2D");

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta : float) -> void:
	pass
	
func _draw() -> void:
	draw_rect(areaCapture, Color.GREEN, false, 1.0);
