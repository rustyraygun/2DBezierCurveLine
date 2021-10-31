extends Node2D
var mos_line = preload("res://components/line_creator/mos_line.tscn")
var is_pressed = false
var current_line
var t = 0.0
var last_point

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var line_box = get_node("..").get_node("LINES")
		var _line 
		if event.pressed:
			is_pressed = true
			_line = mos_line.instance()
			line_box.add_child(_line)
			current_line = _line
			var pt_0 = get_global_mouse_position()
			_line.add_point(pt_0)
			
			var pt_2 = pt_0 - Vector2(-100, -100)
			current_line.add_point(pt_2)
			
			var pt_3 = pt_0 - Vector2(-200, -200)
			current_line.add_point(pt_3)

		else:
			# We released the mouse -> release()
			var pt_1 = get_global_mouse_position()
			current_line.add_point(pt_1)
			current_line.set_active(current_line)
			is_pressed = false



func _process(delta):
	var temp_line = get_node("..").get_node("LINES").get_node("temp_line")
	if is_pressed:
		var mos_pos = get_global_mouse_position()
		temp_line.add_point(mos_pos)
		t += delta
	else:
		temp_line.clear_points()
		
		
	

	
