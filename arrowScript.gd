extends Sprite2D

var earlySeconds : float;
var cochito : CharacterBody2D;
var pathOk : Path2D;
var curve: Curve2D;
var i : int = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pathOk = get_parent().get_parent().get_node("pathOK");
	cochito = get_parent().get_parent().get_parent().get_node("CharacterBody2D");
	earlySeconds = Time.get_unix_time_from_system();
	curve = pathOk.curve;
	#i = curve.get_baked_points().size() - 100;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta : float) -> void:
	var forwardPosition : Vector2;
	var restTime: float = Time.get_unix_time_from_system() - earlySeconds;
	
	if (restTime > 0.05):
		earlySeconds = Time.get_unix_time_from_system();
		i+=1;
		if (i>=curve.get_baked_points().size()): i = 0;
		self.position = curve.get_baked_points()[i];
		if (i+1<curve.get_baked_points().size()): 
			forwardPosition = curve.get_baked_points()[i+1];
			self.rotation = self.position.angle_to_point(forwardPosition);
			self.rotation_degrees = self.rotation_degrees + 180;			
		else: 
			forwardPosition = curve.get_baked_points()[0];		
			self.rotation = self.position.angle_to_point(forwardPosition);
		
		print("Angulo (grados):", self.rotation_degrees );
	
