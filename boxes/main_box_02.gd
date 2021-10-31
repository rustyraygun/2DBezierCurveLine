extends Node2D
var points: Array
onready var line = get_node("line")
onready var d_line = get_node("draw_line")
var t: float = 0.0
var last_point: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	d_line.position = $Sprite.position


func get_line_points(_line):
	var pts = _line.get_points()
	
	
	array_to_curve(pts, 2.2)
#	return pts


func array_to_curve(input : Array, dist : float):
	#dist determines length of controls, set dist = 0 for no smoothing
	var curve = Curve2D.new()

	#calculate first point
	var start_dir = input[0].direction_to(input[1])
	curve.add_point(input[0], - start_dir * dist, start_dir * dist)

	#calculate middle points
	for i in range(1, input.size() - 1):
		var dir = input[i-1].direction_to(input[i+1])
		curve.add_point(input[i], -dir * dist, dir * dist)

	#calculate last point
	var end_dir = input[-1].direction_to(input[-2])
	curve.add_point(input[-1], - end_dir * dist, end_dir * dist)
#	print(curve.get_baked_points())
	
	#create new line from first line and curve points array
	var curve_points = curve.get_baked_points()
#		d_line.set_points(curve_points)
	for i in range(1, curve_points.size() -1):
		d_line.add_point(curve_points[i])
		
#	print("drawline_points: " + str(d_line.get_points()))
	return curve
	
	
func create_curve(_line, t: float):
		var pt0 = _line.get_point_position(0)
		var pt1 = _line.get_point_position(1)
		var pt2 = _line.get_point_position(2)
		var pt3 = _line.get_point_position(3)
#		print(pt0,pt1,pt2,pt3)
		last_point = pt3
		
		
		var q0 = pt0.linear_interpolate(pt1, t)
		var q1 = pt1.linear_interpolate(pt2, t)
		var q2 = pt2.linear_interpolate(pt3, t)
		var r0 = q0.linear_interpolate(q1, t)
		var r1 = q1.linear_interpolate(q2, t)

		var s = r0.linear_interpolate(r1, t)
		return s
	
func _process(delta):
	var pin = $Sprite
	if pin.position.distance_to(last_point) <= 10.5:
		t = 0.0
		$Sprite/Particles2D.emitting = true
		set_process(false)
	else:
		t += delta
		$Sprite.position = create_curve(line, t/5)
		d_line.add_point(pin.position)
	
#func _draw():
##    var from = _origin_pos - get_global_position()
#	var to = Vector2(0, 0)
#	var from = create_curve(line, 0.3).s
#	from = from.normalized() * 100
#	to = to.normalized() * 100
#
#	# blue
#	draw_line(from, to , Color(0, 0, 1), 5)
#	# white
#	draw_line(from, to, Color(1, 1, 1), 1)


