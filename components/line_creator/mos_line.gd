extends Line2D
var last_point
var first_point
onready var pin = get_node("pin")
var active: bool = false
var path
var t = 0.0
onready var curve_line = get_node("curve_line")

func _ready():

	$curve_line.global_position = pin.global_position
	$curve_line.width = rand_range(10.5,30.6)
	
	
func create_curve(_line, t: float):
		var pt0 = _line.get_point_position(0)
		var pt1 = _line.get_point_position(1)
		var pt2 = _line.get_point_position(2)
		var pt3 = _line.get_point_position(3)
#		print(pt0,pt1,pt2,pt3)
		last_point = pt3
		first_point = pt0
		
		
		var q0 = pt0.linear_interpolate(pt1, t)
		var q1 = pt1.linear_interpolate(pt2, t)
		var q2 = pt2.linear_interpolate(pt3, t)
		var r0 = q0.linear_interpolate(q1, t)
		var r1 = q1.linear_interpolate(q2, t)
		
		var s = r0.linear_interpolate(r1, t)
		return s
		
		
func set_active(_current_line):
	path = _current_line
	active = true
	
func _process(delta):
	if active:
		t += delta
		pin.position = create_curve(path, t/2)
		
		if pin.position.distance_to(last_point) <= 10.5:
			$curve_line.default_color = Color(round(rand_range(0,0.6)), round(rand_range(0,1)), 0)
			self.set_process(false)
			t = 0.0
		else: 
			$curve_line.add_point(pin.position * 10)
			$curve_line.set_point_position(0, first_point)
			
			
	else: pass

