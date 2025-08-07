extends Node2D

func _on_test_btn_pressed() -> void:
	printt("-------on btn pressed",%Label.get_property_list())
	%Label.my_member_2
	#%Label.set("my_member",3)
	#%Label.text = "mundo"
	#%Label.mouse_default_cursor_shape = Control.CursorShape.CURSOR_WAIT
	#printt("-------btnpressed end",%Label.my_member)
	pass
