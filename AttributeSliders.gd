extends VBoxContainer

@export var mesh:MeshInstance3D
@onready var mesh_material:Material = mesh.material_override

# Connect the signals in the _ready function
func _ready():
	$Label/AmbienceColorPicker.connect("color_changed", Callable(_on_AmbienceColorPicker_changed))
	$Label3/ShininessColorPicker.connect("color_changed", Callable(_on_ShininessColorPicker_changed))
	$Label4/SpecularColorPicker.connect("color_changed", Callable(_on_SpecularColorPicker_changed))
	$Label5/DiffuseColorPicker.connect("color_changed", Callable(_on_DiffuseColorPicker_changed))

	$Label/CheckButton.connect("toggled", Callable(_on_AmbienceCheckButton_toggled))
	$Label3/CheckButton.connect("toggled", Callable(_on_ShininessCheckButton_toggled))
	$Label4/CheckButton.connect("toggled", Callable(_on_SpecularCheckButton_toggled))
	$Label5/CheckButton.connect("toggled", Callable(_on_DiffuseCheckButton_toggled))

# Define the callback functions for the color_changed signals
func _on_AmbienceColorPicker_changed(color):
	mesh_material.set_shader_parameter("ao_color", color)

func _on_ShininessColorPicker_changed(color):
	mesh_material.set_shader_parameter("shininess_amount", color)

func _on_SpecularColorPicker_changed(color):
	mesh_material.set_shader_parameter("specular_color", color)

func _on_DiffuseColorPicker_changed(color):
	mesh_material.set_shader_parameter("diffuse_color", color)

# Define the callback functions for the CheckButton toggled signals
func _on_AmbienceCheckButton_toggled(button_pressed):
	$Label/AmbienceColorPicker.visible = button_pressed
	if button_pressed:
		mesh_material.set_shader_parameter("ao_strength", 1)
	else:
		mesh_material.set_shader_parameter("ao_strength", 0)

func _on_ShininessCheckButton_toggled(button_pressed):
	$Label3/ShininessColorPicker.visible = button_pressed

func _on_SpecularCheckButton_toggled(button_pressed):
	$Label4/SpecularColorPicker.visible = button_pressed
	if button_pressed:
		mesh_material.set_shader_parameter("specular_strength", 1)
	else:
		mesh_material.set_shader_parameter("specular_strength", 0)

func _on_DiffuseCheckButton_toggled(button_pressed):
	$Label5/DiffuseColorPicker.visible = button_pressed
	if button_pressed:
		mesh_material.set_shader_parameter("diffuse_strength", 1)
	else:
		mesh_material.set_shader_parameter("diffuse_strength", 0)


func _on_color_picker_color_changed(color):
	mesh_material.set_shader_parameter("model_color", color)
