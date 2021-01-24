extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var upb=0
var downb=6
var leftb=0
var rightb=9
var curr_button=null

class Space:
	var n=0 
	var color=-1 # 0 for p1, 1 for p2, 2 for p3

var ball_data=[]
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
		ball_data[pos.x][pos.y].n-=2
		print("Coordinates are ..... ",pos.x,pos.y)
		if pos.x == leftb and pos.y == upb:
			ball_data[pos.x+1][pos.y].n +=1
			ball_data[pos.x][pos.y+1].n +=1
			print("Coordinates are ..... ",pos.x,pos.y)
		elif pos.y==leftb and pos.y==downb-1:
			ball_data[pos.x+1][pos.y].n +=1
			ball_data[pos.x][pos.y-1].n +=1
			print("Coordinates are ..... ",pos.x,pos.y)
		elif pos.y==rightb-1 and pos.y==upb:
			ball_data[pos.x-1][pos.y].n +=1
			ball_data[pos.x][pos.y+1].n +=1
			print("Coordinates are ..... ",pos.x,pos.y)
		elif pos.y==rightb-1 and pos.y==downb-1:
			ball_data[pos.x-1][pos.y].n +=1
			ball_data[pos.x][pos.y-1].n +=1
			print("Coordinates changed are ..... ",ball_data[7][5].n)
	return
	#Edges.....
	if (pos.x==leftb or pos.x==rightb-1 or pos.y==upb or pos.y==downb-1) and ball_data[pos.x][pos.y].n>=3:
		ball_data[pos.x][pos.y].n-=3
		if pos.x==leftb:
			ball_data[pos.x][pos.y+1].n+=1
			ball_data[pos.x+1][pos.y].n+=1
			ball_data[pos.x][pos.y-1].n+=1
		elif  pos.x==rightb-1:
			ball_data[pos.x][pos.y+1].n+=1
			ball_data[pos.x-1][pos.y].n+=1
			ball_data[pos.x][pos.y-1].n+=1
		elif pos.y==upb:
			ball_data[pos.x+1][pos.y].n+=1
			ball_data[pos.x-1][pos.y].n+=1
			ball_data[pos.x][pos.y+1].n+=1
		elif pos.y==downb-1:
			ball_data[pos.x+1][pos.y].n+=1
			ball_data[pos.x][pos.y-1].n+=1
			ball_data[pos.x-1][pos.y].n+=1
	return
	#Spaces left
	if ball_data[pos.x][pos.y].n>=4:
		ball_data[pos.x][pos.y+1].n+=1
		ball_data[pos.x+1][pos.y].n+=1
		ball_data[pos.x][pos.y-1].n+=1
		ball_data[pos.x-1][pos.y].n+=1	
	pass
