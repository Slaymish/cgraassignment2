extends Node3D

@onready var mesh = $Mesh
var rotation_degree:float = 0.0

var is_animated:bool = true


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_animated:
		rotation_degree += 1.0
		if rotation_degree >= 360.0:
			rotation_degree = 0.0
		mesh.rotation_degrees = Vector3(0.0, rotation_degree, 0.0)



func _on_check_button_toggled(button_pressed):
	is_animated = button_pressed

