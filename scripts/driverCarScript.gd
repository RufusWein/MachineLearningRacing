extends CharacterBody2D

const UI_UP: int = -1;
const UI_DOWN: int = 1;
const NO_FORWARD: int = 0;

var speed: float = 0.0;

var negativeFeeback : bool = false;
var UI;

func _ready() -> void:
	var arrow: Node2D = get_parent().get_node("Circuit/pathOK/Arrow");
	arrow.connect("cancel_racing", self._cancel_racing);
	

func _physics_process(_delta: float) -> void:
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var forward: int = Input.get_axis("ui_up", "ui_down") as int;
	if (forward == UI_UP): speed += 3.0;
	if (forward == UI_DOWN): speed -= 1.5;
	var direction: int = Input.get_axis("ui_right", "ui_left") as int;
		
	speed -= 0.5;
	if (speed > 0):
		forward = UI_UP;
		rotation += direction * -(0.001 + (speed * 0.0002));
	else: 
		speed = 0;
		forward = NO_FORWARD;

	if (speed > 200): speed = 200;

	velocity.x = cos(rotation) * speed * -1
	velocity.y = sin(rotation) * speed * -1
	
#	print("En la pista: ", !negativeFeeback );
#	print("Rotacion :", rotation)
#	print("Velocidad :", speed)
#	print("Direccion :", direction)
#	print("Relacion Velocidad/Giro :", (0.001 + (speed * 0.0002)));
	#print("Posicion X coche: ",position.x)
	#print("Posicion Y coche: ",position.y)	
	
	move_and_slide();

func _on_area_track_body_exited(_body: Node2D) ->void:
	_cancel_racing();

func _cancel_racing() -> void:
	position.x = 480;
	position.y = 301;
	rotation = 0;
	speed = 0;
	negativeFeeback = false;
