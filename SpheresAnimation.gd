extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func run_split_anim(rot):
	rotation_degrees.y=rot
	#in two spheres
	if self.get_child_count()==4:
		$Tween.interpolate_property($MeshInstance,"translation",Vector3(0,0,0),Vector3(1,0,0),0.5,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		$Tween2.interpolate_property($MeshInstance2,"translation",Vector3(0,0,0),Vector3(0,0,1),0.5,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)	
		$Tween.start()
		$Tween2.start()	
	elif self.get_child_count()==6:
		$Tween.interpolate_property($MeshInstance,"translation",Vector3(0,0,0),Vector3(1,0,0),0.5,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		$Tween2.interpolate_property($MeshInstance2,"translation",Vector3(0,0,0),Vector3(0,0,1),0.5,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		$Tween3.interpolate_property($MeshInstance3,"translation",Vector3(0,0,0),Vector3(-1,0,0),0.5,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)	
		$Tween.start()
		$Tween2.start()	
		$Tween3.start()
	elif self.get_child_count()==8:
		$Tween.interpolate_property($MeshInstance,"translation",Vector3(0,0,0),Vector3(1,0,0),0.5,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		$Tween2.interpolate_property($MeshInstance2,"translation",Vector3(0,0,0),Vector3(0,0,1),0.5,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		$Tween3.interpolate_property($MeshInstance3,"translation",Vector3(0,0,0),Vector3(-1,0,0),0.5,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		$Tween4.interpolate_property($MeshInstance4,"translation",Vector3(0,0,0),Vector3(0,0,-1),0.5,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)	
		$Tween.start()
		$Tween2.start()	
		$Tween3.start()
		$Tween4.start()
	pass


func _on_Tween_tween_completed(object, key):
	queue_free()
	pass # Replace with function body.
