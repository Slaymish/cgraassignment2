extends VBoxContainer

@export var mesh:MeshInstance3D
@onready var mesh_material:Material = mesh.material_override


# Called when the node enters the scene tree for the first time.
func _ready():
	mesh_material.set_shader_parameter("ao_slider", 0.5)
	mesh_material.set_shader_parameter("light_slider", 0.5)
	mesh_material.set_shader_parameter("shininess_slider", 0.5)
	mesh_material.set_shader_parameter("specular_slider", 0.5)
	mesh_material.set_shader_parameter("diffuse_slider", 0.5)
	mesh_material.set_shader_parameter("light_color", Color(1, 1, 1, 1))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_ambience_slider_value_changed(value:float):
	mesh_material.set_shader_parameter("ao_slider", value)


func _on_light_color_slider_value_changed(value):
	mesh_material.set_shader_parameter("light_slider", value)


func _on_shininess_slider_value_changed(value):
	mesh_material.set_shader_parameter("shininess_slider", value)


func _on_specular_slider_value_changed(value):
	mesh_material.set_shader_parameter("specular_slider", value)


func _on_diffuse_slider_value_changed(value):
	mesh_material.set_shader_parameter("diffuse_slider", value)


func _on_color_picker_color_changed(color):
	mesh_material.set_shader_parameter("light_color", color)


func _on_wave_amplitude_value_changed(value):
	mesh_material.set_shader_parameter("wave_amplitude", value)
