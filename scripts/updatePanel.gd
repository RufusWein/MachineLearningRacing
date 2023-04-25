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

func _update_panel(_texture: Texture2D) -> void:
	newTexture = _texture;
	updatePanel = true;
	queue_redraw();

func _draw() -> void:
	if (updatePanel):
		var posCar : Vector2 = cochito.global_position
		posCar.x = posCar.x / 5.13;
		posCar.y = posCar.y / 5.22;
		posCar.x += 63; #sin( cochito.global_rotation ) + 63;
		posCar.y += 153; #cos( cochito.global_rotation ) + 155;
		var image : Image =  texture.get_image().get_region( Rect2(posCar, Vector2(100,100)) );
		newTexture = ImageTexture.create_from_image( image );
		newTexture.set_size_override( Vector2(50,50) );
		draw_texture(newTexture, Vector2(2.5,2.5) );
		self.get_material().set_shader_parameter("_radians", cochito.global_rotation );
		var posLook : Vector2 = Vector2(25,25);
		posLook.x = sin( cochito.global_rotation );
		posLook.y = cos( cochito.global_rotation );
		draw_line(posLook, posLook, Color.RED, 1.0);
		self.draw_set_transform( Vector2.ZERO, 6.283185 - cochito.global_rotation , Vector2(1,1) )
		var angleFix : float = cochito.global_rotation * 2;
		posLook.x = sin( angleFix - 1.5707 ) * 25 + 25;
		posLook.y = 25 ;
		draw_line( Vector2(25,25), posLook, Color.RED, 1.0);
		posLook.x = 25;
		posLook.y = cos( angleFix + 1.5707 ) * 25 + 25;
		draw_line( Vector2(25,25), posLook, Color.BLUE, 1.0);		
		var rect: Rect2 = Rect2( sin( angleFix - 1.5707 ) * 10 + 15 , cos( angleFix + 1.5707 ) * 10 + 15, 20,19 );
		draw_rect( rect, Color.VIOLET, false, 1.0);
		draw_circle( Vector2(25,25), 2.0, Color.GREEN);
		#updatePanel = false;
