extends VBoxContainer

@export var mesh:MeshInstance3D
@onready var mesh_material:Material = mesh.material_override

var lightPosition:Vector3 = Vector3(0, 0.5, 1)

# Called when the node enters the scene tree for the first time.
func _ready():
	mesh_material.set_shader_parameter("light_position", lightPosition)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_x_slider_value_changed(value:float):
	lightPosition.x = value
	mesh_material.set_shader_parameter("light_position", lightPosition)

func _one_y_slider_value_changed(value:float):
	lightPosition.y = value
	mesh_material.set_shader_parameter("light_position", lightPosition)

func _on_z_slider_value_changed(value:float):
	lightPosition.z = value
	mesh_material.set_shader_parameter("light_position", lightPosition)
