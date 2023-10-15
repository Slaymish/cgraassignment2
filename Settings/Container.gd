extends Node3D

@onready var teapot = $Mesh
var imported_mesh: MeshInstance3D = null
var rotation_degree: float = 0.0

var is_animated: bool = true
var has_imported: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_animated:
		rotation_degree += 1.0
		if rotation_degree >= 360.0:
			rotation_degree = 0.0

		if not has_imported:
			teapot.rotation_degrees = Vector3(0.0, rotation_degree, 0.0)
		elif imported_mesh:
			imported_mesh.rotation_degrees = Vector3(0.0, rotation_degree, 0.0)

func _on_check_button_toggled(button_pressed):
	is_animated = button_pressed

func _on_load_obj_button_pressed():
	$Control/DisplacementPanel/FileDialog.popup_centered()

func _on_file_dialog_file_selected(path):
	print(path)
	load_obj(path)

# This function will calculate the bounding size of a mesh
func get_mesh_size(mesh: Mesh) -> Vector3:
	return mesh.get_aabb().size

# This function will load an OBJ given a path and scale it to match the teapot's size.
func load_obj(path: String) -> void:
	# Clear the previous imported mesh if any
	if imported_mesh:
		imported_mesh.queue_free()
		imported_mesh = null

	if ResourceLoader.exists(path):
		var mesh_data = ResourceLoader.load(path)
		if mesh_data:
			imported_mesh = MeshInstance3D.new()
			imported_mesh.mesh = mesh_data

			# Calculate size difference
			var bounding_box = imported_mesh.get_aabb()
			var max_dimension = max(bounding_box.size.x, bounding_box.size.y, bounding_box.size.z)
			var desired_size = 5.0  # Example size you want
			var scale_factor = desired_size / max_dimension
			imported_mesh.scale = Vector3(scale_factor, scale_factor, scale_factor)
			
			# Add phong material to new obj
			imported_mesh.material_override = teapot.get_active_material(0)

			# Add new object and remove/replace the teapot
			self.add_child(imported_mesh)
			teapot.hide()
			has_imported = true
			$Control/DisplacementPanel/ResetModelButton.disabled = false
		else:
			print("Failed to load the mesh data from:", path)
	else:
		print("The specified path does not exist:", path)

func _on_reset_model_button_pressed():
	# Reset back to the teapot
	if imported_mesh:
		imported_mesh.queue_free()
		imported_mesh = null
		has_imported = false
		teapot.show()
		$Control/DisplacementPanel/ResetModelButton.disabled = true
