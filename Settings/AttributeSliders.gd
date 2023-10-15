extends VBoxContainer

@export var mesh:MeshInstance3D
@onready var mesh_material:Material = mesh.material_override

var prev_ao_color:Color = Color(255,255,255)
var prev_diffuse_color:Color
var prev_specular_color:Color

# Connect the signals in the _ready function
func _ready():
	$Label/AmbienceColorPicker.connect("color_changed", Callable(_on_AmbienceColorPicker_changed))
	$Label4/SpecularColorPicker.connect("color_changed", Callable(_on_SpecularColorPicker_changed))
	$Label5/DiffuseColorPicker.connect("color_changed", Callable(_on_DiffuseColorPicker_changed))

	$Label/CheckButton.connect("toggled", Callable(_on_AmbienceCheckButton_toggled))
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
	$Label/AmbienceColorPicker.disabled = !button_pressed
	if button_pressed:
		mesh_material.set_shader_parameter("ao_strength", 1)
		$Label/AmbienceColorPicker.color = prev_ao_color
	else:
		mesh_material.set_shader_parameter("ao_strength", 0)
		prev_ao_color = $Label/AmbienceColorPicker.color
		$Label/AmbienceColorPicker.color = Color(0,0,0)

func _on_SpecularCheckButton_toggled(button_pressed):
	$Label4/SpecularColorPicker.disabled = !button_pressed
	if button_pressed:
		mesh_material.set_shader_parameter("specular_strength", 1)
		$Label4/SpecularColorPicker.color = prev_specular_color
	else:
		mesh_material.set_shader_parameter("specular_strength", 0)
		prev_specular_color = $Label4/SpecularColorPicker.color
		$Label4/SpecularColorPicker.color = Color(0,0,0)

func _on_DiffuseCheckButton_toggled(button_pressed):
	$Label5/DiffuseColorPicker.disabled = !button_pressed
	if button_pressed:
		mesh_material.set_shader_parameter("diffuse_strength", 1)
		$Label5/DiffuseColorPicker.color = prev_diffuse_color
	else:
		mesh_material.set_shader_parameter("diffuse_strength", 0)
		prev_diffuse_color = $Label5/DiffuseColorPicker.color
		$Label5/DiffuseColorPicker.color = Color(0,0,0)

func _on_color_picker_color_changed(color):
	mesh_material.set_shader_parameter("model_color", color)


func _on_shiny_slider_value_changed(value):
	mesh_material.set_shader_parameter("shininess_amount", value)


func _on_wave_amplitude_value_changed(value):
	mesh_material.set_shader_parameter("wave_amplitude", value)
