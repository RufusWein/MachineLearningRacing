extends Sprite2D

const UI_UP = -1
const UI_DOWN = 1
const NO_FORWARD = 0

var speed = 0.0

func _physics_process(delta):
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var forward = Input.get_axis("ui_up", "ui_down")
	if (forward == UI_UP): speed += 3.0
	if (forward == UI_DOWN): speed -= 1.5
	var direction = Input.get_axis("ui_right", "ui_left")
		
	speed -= 0.5;
	if (speed > 0): 
		forward = UI_UP
		rotation += direction * -(0.001 + (speed * 0.0002))
	else: 
		speed = 0;
		forward = NO_FORWARD;

	if (speed > 200): speed = 200;

	position.x = cos(rotation) * speed * -1
	position.y = sin(rotation) * speed * -1
	
#	for item in get_collision_exceptions():
#		print(item) 
#		pass

	var areaCochito = (get_node("areaCochito") as Area2D)
	
	print("En la pista: ", areaCochito.get_collision_layer_value(1) );
	print("Rotacion :", rotation)
	print("Velocidad :", speed)
	print("Direccion :", direction)
	print("Relacion Velocidad/Giro :", (0.001 + (speed * 0.0002)));
