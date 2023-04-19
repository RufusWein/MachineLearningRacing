extends Camera2D

signal update_panel(texture : Texture2D);

var cochito : Node2D;
var earlySeconds : float;
var image : Image;
var panel: Panel;
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cochito = get_parent().get_parent().get_node("CharacterBody2D/Cochito/prueba");
	panel = get_parent().get_parent().get_node("CanvasLayer/Panel");
	image = load("res://graphics/circuit.jpg").get_image();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta : float) -> void:
	var restTime: float = Time.get_unix_time_from_system() - earlySeconds;
	if (restTime > 1.0):
		await RenderingServer.frame_post_draw
		var areaCapture: Rect2 = Rect2(0,0,200,200);
		var newPos : Vector2 = cochito.get_global_transform_with_canvas().origin
		areaCapture.position += newPos;# * 0.19;
		image = cochito.get_viewport().get_texture().get_image().get_region(areaCapture);
		var texture: ImageTexture = ImageTexture.create_from_image(image);#.get_region(areaCapture));
		texture.set_size_override(Vector2(40,40));
		var item: RID = self.get_canvas_item();
		var textureRID: RID = texture.get_rid();
		RenderingServer.canvas_item_add_texture_rect(item, Rect2(0,0,100,100), textureRID, false, Color(0,0,0,0), false  );
		#emit_signal("update_panel", texture);
	
func _draw() -> void:
	draw_rect(Rect2(10,-20,40,40), Color.GREEN, false, 1.0);
