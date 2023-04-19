extends Sprite2D

signal cancel_racing;

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

	if (isCloserTo(self.global_position, cochito.global_position, 100)): 
		i+= 1;
		restTime +=1;

	if (isCloserTo(cochito.global_position, redCross.global_position, 100)):
		i = 0; 
		emit_signal("cancel_racing");

	if (restTime > 0.5):
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
		var posCross : int = i - positionBack;
		if (i-positionBack<=0): posCross = (totalPoints - 1) - (positionBack-i) ;
		redCross.position = curve.get_baked_points()[posCross];
	
func isCloserTo(posSource: Vector2, posTarget: Vector2, distMin: int) -> bool:
	var distBetweenPoints : int = posSource.distance_to(posTarget) as int;
	return distBetweenPoints < distMin;	

