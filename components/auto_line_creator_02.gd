extends Node2D
var mos_line = preload("res://components/line_creator/mos_line.tscn")
var current_line

func _on_timer_0_timeout():
		var line_box = get_node("..").get_node("LINES")
		var _line 
		
		_line = mos_line.instance()
		line_box.add_child(_line)
		current_line = _line
		var pt_0 = Vector2(rand_range(0.5,100), rand_range(0.5,100))
		_line.add_point(pt_0)
			
		var pt_2 = pt_0 - Vector2(-100, -100)
		current_line.add_point(pt_2)
			
		var pt_3 = pt_0 - Vector2(-200, -200)
#		var pt_3 = pt_0 +  Vector2(rand_range(-0.5,-100), rand_range(-0.5,-100))
		current_line.add_point(pt_3)
#		else:
#			# We released the mouse -> release()
		var pt_1 = current_line.get_point_position(0) * Vector2(rand_range(0.5,100), rand_range(-0.5,100))
		current_line.add_point(pt_1)
		current_line.set_active(current_line)
#		current_line.curve_line
#		current_line.default_color = Color(rand_range(0,0.9), rand_range(), 1)
	
