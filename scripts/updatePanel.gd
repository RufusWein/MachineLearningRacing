extends Panel

var updatePanel : bool = false;
var newTexture : ImageTexture;
var texture : CompressedTexture2D = load("res://graphics/circuit.jpg");
var cochito : Node2D; # = get_parent().get_parent().get_node(".").get_node("CharacterBody2D/Cochito");

# Called when the node enters the scene tree for the first time.
func _ready() -> void :
	cochito = get_parent().get_parent().get_node(".").get_node("CharacterBody2D/Cochito");
	#var texture : CompressedTexture2D = load("res://graphics/circuit.jpg");
	var posCar : Vector2 = cochito.position;
	posCar = posCar / 5.16;
	var image : Image =  texture.get_image().get_region( Rect2(posCar, Vector2(80,80) ) );
	newTexture = ImageTexture.create_from_image( image );
	#newTexture.set_size_override( Vector2(40,40) );
	self.clip_contents = true;
	#camera.connect("update_panel", self._update_panel );

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta :  float) -> void:
	_update_panel(newTexture);

func _update_panel(texture: Texture2D) -> void:
	newTexture = texture;
	updatePanel = true;
	queue_redraw();

func _draw() -> void:
	if (updatePanel):
		var posCar : Vector2 = cochito.global_position
		posCar.x = posCar.x / 5.13;
		posCar.y = posCar.y / 5.22;
		posCar.x += 60;
		posCar.y += (251 - 93);
		var image : Image =  texture.get_image().get_region( Rect2(posCar, Vector2(100,100)) );
		#image.flip_y();
		#image.flip_x();
		
		newTexture = ImageTexture.create_from_image( image );
		newTexture.set_size_override( Vector2(50,50) );
		draw_texture(newTexture, Vector2(2.5,2.5) );
		#self.get_material().set_shader_parameter("_radians", cochito.global_rotation + 3.141516);
		self.get_material().set_shader_parameter("_radians", cochito.global_rotation );
		#updatePanel = false;
