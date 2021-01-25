extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var upb=0
var downb=6
var leftb=0
var rightb=9
var curr_button=null
signal splitter_complete

class Space:
	var n=0 
	var color=-1 # 0 for p1, 1 for p2, 2 for p3

var single_sph=preload("res://SingleSphere.tscn")
var two_sph=preload("res://TwoSphere.tscn")
var three_sph=preload("res://ThreeSpheres.tscn")
var four_sph=preload("res://FourSpheres.tscn")

#board data
var ball_data=[]

#visual data

var board_spheres=[]
var spatial_button=preload("res://SpatialButton.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	add_buttons()
	#pupulate ball data array
	for i in range(leftb,rightb):
		var b_arr=[]
		for j in range(upb,downb):
			b_arr.append(Space.new())
		ball_data.append(b_arr)
		
	#populate board_sphere array
	for i in range(leftb,rightb):
		var b_arr=[]
		for j in range(upb,downb):
			var s=single_sph.instance()
			$Spheres.add_child(s)
			s.translation=Vector3(j+0.5,0.5,i+0.5)
			b_arr.append(s)
			s.hide()
		board_spheres.append(b_arr)
	pass 

func print_ball_data():
	for i in ball_data:
		print("( ")
		for j in i:
			print("( ", j.n )
			print(j.color, " )")
		print("Row Ends........")
		print(" )")
	print("Done ..... ")


	
func add_buttons():
	for i in range(leftb,rightb):
		for j in range(upb,downb):
			var sb=spatial_button.instance()
			$SpatialButtons.add_child(sb)
			sb.translation=Vector3(j+0.5,1,i+0.5)
		
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("ui_click"):
		if curr_button!=null:
			button_pressed(curr_button)
	pass

func button_pressed(pos):
	ball_data[pos.x][pos.y].n+=1
	explode(pos)
	print_ball_data()
	pass
	
func explode(pos):
	#Corners.....
	if ((pos.x==leftb or pos.x==rightb-1) and (pos.y==upb or pos.y==downb-1)) and ball_data[pos.x][pos.y].n>=2 :
		var s=two_sph.instance()
		$Explosions.add_child(s)
		s.translation=Vector3(pos.y+0.5,0.5,pos.x+0.5)
		if pos.x == leftb and pos.y == upb:
			s.run_split_anim(0)
		elif pos.x==leftb and pos.y==downb-1:
			s.run_split_anim(270)
		elif pos.x==rightb-1 and pos.y==upb:
			s.run_split_anim(90)
		elif pos.x==rightb-1 and pos.y==downb-1:
			s.run_split_anim(180)
		
		ball_data[pos.x][pos.y].n-=2
		replace_sphere(pos,ball_data[pos.x][pos.y].n)
		$ExplodeTimer.start()
		
		##YIELD FOR THE ANIMATION COMPLETE
		yield(self,"splitter_complete")
		
		#print("Coordinates are ..... ",pos.x,pos.y)
		if pos.x == leftb and pos.y == upb:
			ball_data[pos.x+1][pos.y].n +=1
			ball_data[pos.x][pos.y+1].n +=1
			explode(Vector2(pos.x+1,pos.y))
			explode(Vector2(pos.x,pos.y+1))
		elif pos.x==leftb and pos.y==downb-1:
			ball_data[pos.x+1][pos.y].n +=1
			ball_data[pos.x][pos.y-1].n +=1
			explode(Vector2(pos.x+1,pos.y))
			explode(Vector2(pos.x,pos.y-1))
		elif pos.x==rightb-1 and pos.y==upb:
			ball_data[pos.x-1][pos.y].n +=1
			ball_data[pos.x][pos.y+1].n +=1
			explode(Vector2(pos.x-1,pos.y))
			explode(Vector2(pos.x,pos.y+1))
		elif pos.x==rightb-1 and pos.y==downb-1:
			ball_data[pos.x-1][pos.y].n +=1
			ball_data[pos.x][pos.y-1].n +=1
			explode(Vector2(pos.x-1,pos.y))
			explode(Vector2(pos.x,pos.y-1))
		
		return
	#Edges.....
	if (pos.x==leftb or pos.x==rightb-1 or pos.y==upb or pos.y==downb-1) and ball_data[pos.x][pos.y].n>=3:
		var s=three_sph.instance()
		$Explosions.add_child(s)
		s.translation=Vector3(pos.y+0.5,0.5,pos.x+0.5)
		if pos.x==leftb:
			s.run_split_anim(0)
		elif  pos.x==rightb-1:
			s.run_split_anim(180)
		elif pos.y==upb:
			s.run_split_anim(90)
		elif pos.y==downb-1:
			s.run_split_anim(270)
		ball_data[pos.x][pos.y].n-=3
		replace_sphere(pos,ball_data[pos.x][pos.y].n)
		$ExplodeTimer.start()
		yield(self,"splitter_complete")
		if pos.x==leftb:
			ball_data[pos.x][pos.y+1].n+=1
			ball_data[pos.x+1][pos.y].n+=1
			ball_data[pos.x][pos.y-1].n+=1
			explode(Vector2(pos.x,pos.y+1))
			explode(Vector2(pos.x+1,pos.y))
			explode(Vector2(pos.x,pos.y-1))
		elif  pos.x==rightb-1:
			ball_data[pos.x][pos.y+1].n+=1
			ball_data[pos.x-1][pos.y].n+=1
			ball_data[pos.x][pos.y-1].n+=1
			explode(Vector2(pos.x,pos.y+1))
			explode(Vector2(pos.x-1,pos.y))
			explode(Vector2(pos.x,pos.y-1))
		elif pos.y==upb:
			ball_data[pos.x+1][pos.y].n+=1
			ball_data[pos.x-1][pos.y].n+=1
			ball_data[pos.x][pos.y+1].n+=1
			explode(Vector2(pos.x+1,pos.y))
			explode(Vector2(pos.x-1,pos.y))
			explode(Vector2(pos.x,pos.y+1))
		elif pos.y==downb-1:
			ball_data[pos.x+1][pos.y].n+=1
			ball_data[pos.x][pos.y-1].n+=1
			ball_data[pos.x-1][pos.y].n+=1
			explode(Vector2(pos.x+1,pos.y))
			explode(Vector2(pos.x,pos.y-1))
			explode(Vector2(pos.x-1,pos.y))
		return
	#Spaces left
	if ball_data[pos.x][pos.y].n>=4:
		var s=four_sph.instance()
		$Explosions.add_child(s)
		s.translation=Vector3(pos.y+0.5,0.5,pos.x+0.5)
		s.run_split_anim(0)
		replace_sphere(pos,ball_data[pos.x][pos.y].n)
		ball_data[pos.x][pos.y].n -= 4
		$ExplodeTimer.start()
		yield(self,"splitter_complete")
		ball_data[pos.x][pos.y+1].n+=1
		ball_data[pos.x+1][pos.y].n+=1
		ball_data[pos.x][pos.y-1].n+=1
		ball_data[pos.x-1][pos.y].n+=1
		explode(Vector2(pos.x,pos.y+1))
		explode(Vector2(pos.x+1,pos.y))
		explode(Vector2(pos.x,pos.y-1))
		explode(Vector2(pos.x-1,pos.y))
	
	return	
	
	
	pass


func replace_sphere(pos,num):
	if num==0:
		var s=board_spheres[pos.x][pos.y]
		s.queue_free()
		s=single_sph.instance()
		$Spheres.add_child(s)
		s.translation=Vector3(pos.y+0.5,0.5,pos.x+0.5)
		s.hide()
		board_spheres[pos.x][pos.y]=s
	elif num==1:
		if board_spheres[pos.x][pos.y]!=null:
			board_spheres[pos.x][pos.y].show()
		else:
			var s=single_sph.instance()
			$Spheres.add_child(s)
			s.translation=Vector3(pos.y+0.5,0.5,pos.x+0.5)
			board_spheres[pos.x][pos.y]=s
	elif num==2:
		if board_spheres[pos.x][pos.y]!=null:
			var s=board_spheres[pos.x][pos.y]
			s.queue_free()
			s=two_sph.instance()
			$Spheres.add_child(s)
			s.translation=Vector3(pos.y+0.5,0.5,pos.x+0.5)
			board_spheres[pos.x][pos.y]=s
	elif num==3:
		if board_spheres[pos.x][pos.y]!=null:
			var s=board_spheres[pos.x][pos.y]
			s.queue_free()
			s=three_sph.instance()
			$Spheres.add_child(s)
			s.translation=Vector3(pos.y+0.5,0.5,pos.x+0.5)
			board_spheres[pos.x][pos.y]=s
	elif num==4:
		if board_spheres[pos.x][pos.y]!=null:
			var s=board_spheres[pos.x][pos.y]
			s.queue_free()
			s=four_sph.instance()
			$Spheres.add_child(s)
			s.translation=Vector3(pos.y+0.5,0.5,pos.x+0.5)
			board_spheres[pos.x][pos.y]=s
			
	pass


func _on_ExplodeTimer_timeout():
	emit_signal("splitter_complete")
	pass # Replace with function body.
