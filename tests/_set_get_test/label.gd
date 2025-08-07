extends Label

#var my_member: int = 5
var my_member_2

func _set(property: StringName, value: Variant) -> bool:
	printt("Label _set ",property, value)
	return false

func _get(property: StringName) -> Variant:
	printt("Label _get",property)
	#{ "name": "my_member", "class_name": &"", "type": 2, "hint": 0, "hint_string": "", "usage": 4096 }
	#{ "name": "my_member_2", "class_name": &"", "type": 0, "hint": 0, "hint_string": "", "usage": 135168 }
	#{ "name": "my_member", "class_name": &"", "type": 2, "hint": 0, "hint_string": "", "usage": 6 }
	#{ "name": "my_member_3", "class_name": &"", "type": 2, "hint": 0, "hint_string": "", "usage": 6 }
	return (property)

func _get_property_list() -> Array[Dictionary]:
	var properties: Array[Dictionary] = []
	properties.append({
			name = "my_member",
			type = TYPE_INT,
		})
	properties.append({
			name = "my_member_3",
			type = TYPE_INT
		})
	return properties
