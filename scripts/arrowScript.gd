extends Sprite2D

var cochito : CharacterBody2D;
var earlySeconds : float;
var redCross : Sprite2D;
var pathOk : Path2D;
var curve: Curve2D;
var i : int = 0;
var positionBack: int = 50; 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pathOk = get_parent().get_parent().get_node("pathOK");
	cochito = get_parent().get_parent().get_parent().get_node("CharacterBody2D");
	redCross = get_parent().get_parent().get_node("pathOK/RedCross");
	
	earlySeconds = Time.get_unix_time_from_system();
	curve = pathOk.curve;
	#i = curve.get_baked_points().size() - 100;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta : float) -> void:
	var forwardPosition : Vector2;
	var restTime: float = Time.get_unix_time_from_system() - earlySeconds;
	
	if (restTime > 0.10):
		var totalPoints : int = curve.get_baked_points().size();
		earlySeconds = Time.get_unix_time_from_system();
		i+=1;
		if (i>=totalPoints): i = 0;
		self.position = curve.get_baked_points()[i];
		if (i+1<totalPoints): 
			forwardPosition = curve.get_baked_points()[i+1];
			self.rotation = self.position.angle_to_point(forwardPosition);
			self.rotation_degrees = self.rotation_degrees + 180;			
		else: 
			forwardPosition = curve.get_baked_points()[0];		
			self.rotation = self.position.angle_to_point(forwardPosition);
		
		if (i-positionBack<=0):
			var posCross : int = (totalPoints - 1) - (positionBack-i) ;
			redCross.position = curve.get_baked_points()[posCross];
		else:
			var posCross : int = i - positionBack;
			redCross.position = curve.get_baked_points()[posCross];
		
		print("Pos. Cross (Vector2):", redCross.position );
	
