extends Node

static func get_num(num: String) -> int:
	return num.to_int() if num.is_valid_int() else 0

static func load_json_from_path(path: String) -> Dictionary:
	var file = FileAccess.open(path, FileAccess.READ)
	
	if file == null:
		print("Erreur : Impossible d'ouvrir le fichier à ", path)
		return {}
	
	var json_string = file.get_as_text()
	file.close()
	
	var json = JSON.new()
	var parse_result = json.parse(json_string)
	if not parse_result == OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
		return {}
	
	return json.get_data()
