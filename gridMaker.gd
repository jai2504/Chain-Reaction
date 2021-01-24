extends ImmediateGeometry


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var upb=0
var downb=6
var leftb=0
var rightb=9

# Called when the node enters the scene tree for the first time.
func _ready():
	renderGrid()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func renderGrid():
	self.begin(Mesh.PRIMITIVE_LINE_STRIP)
	
	
	# horizontal lines(1st layer)
	for i in range(upb,downb+1):
		if i%2==0:
			self.add_vertex(Vector3(i,0,leftb))
			self.add_vertex(Vector3(i,0,rightb))
		else:
			self.add_vertex(Vector3(i,0,rightb))
			self.add_vertex(Vector3(i,0,leftb))
			
	for i in range(downb,upb-1,-1):
		if i%2==0:
			self.add_vertex(Vector3(i,0,leftb))
			self.add_vertex(Vector3(i,0,rightb))
		else:
			self.add_vertex(Vector3(i,0,rightb))
			self.add_vertex(Vector3(i,0,leftb))
	for i in range(leftb,rightb+1):
		if i%2==0:
			self.add_vertex(Vector3(upb,0,i))
			self.add_vertex(Vector3(downb,0,i))
		else:
			self.add_vertex(Vector3(downb,0,i))
			self.add_vertex(Vector3(upb,0,i))
	self.add_vertex(Vector3(upb,0,rightb)) 
	self.add_vertex(Vector3(upb,0,leftb))
	
	# vertical lines
	for i in range(upb,downb+1):
		if i%2==0:
			self.add_vertex(Vector3(i,0,leftb))
			self.add_vertex(Vector3(i,1,leftb))
		else:
			self.add_vertex(Vector3(i,1,leftb))
			self.add_vertex(Vector3(i,0,leftb))
	
	for i in range(leftb,rightb+1):
		if i%2==0:
			self.add_vertex(Vector3(downb,0,i))
			self.add_vertex(Vector3(downb,1,i))
		else:
			self.add_vertex(Vector3(downb,1,i))
			self.add_vertex(Vector3(downb,0,i))		
			
	for i in range(downb,upb-1,-1):
		if i%2==0:
			self.add_vertex(Vector3(i,0,rightb))
			self.add_vertex(Vector3(i,1,rightb))
		else:
			self.add_vertex(Vector3(i,1,rightb))
			self.add_vertex(Vector3(i,0,rightb))
	for i in range(rightb,leftb-1,-1):
		if i%2==0:
			self.add_vertex(Vector3(upb,0,i))
			self.add_vertex(Vector3(upb,1,i))
		else:
			self.add_vertex(Vector3(upb,1,i))
			self.add_vertex(Vector3(upb,0,i))		
			
	# horizontal lines (second layer)
	for i in range(upb,downb+1):
		if i%2==0:
			self.add_vertex(Vector3(i,1,leftb))
			self.add_vertex(Vector3(i,1,rightb))
		else:
			self.add_vertex(Vector3(i,1,rightb))
			self.add_vertex(Vector3(i,1,leftb))
			
	for i in range(downb,upb-1,-1):
		if i%2==0:
			self.add_vertex(Vector3(i,1,leftb))
			self.add_vertex(Vector3(i,1,rightb))
		else:
			self.add_vertex(Vector3(i,1,rightb))
			self.add_vertex(Vector3(i,1,leftb))
	for i in range(leftb,rightb+1):
		if i%2==0:
			self.add_vertex(Vector3(upb,1,i))
			self.add_vertex(Vector3(downb,1,i))
		else:
			self.add_vertex(Vector3(downb,1,i))
			self.add_vertex(Vector3(upb,1,i))
	self.add_vertex(Vector3(upb,1,rightb)) 
	self.add_vertex(Vector3(upb,1,leftb))
	self.end()
	pass
