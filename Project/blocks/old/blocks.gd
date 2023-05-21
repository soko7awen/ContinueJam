extends RigidBody2D

#const blockShapesNames = ["iPiece","oPiece","tPiece","jPiece","lPiece","sPiece","zPiece"]
const blockShapes = [[[1,1,1,1],[0,0,0,0]],[[1,1,0,0],[1,1,0,0]],[[1,1,1,0],[0,1,0,0]],[[1,1,1,0],[0,0,1,0]],[[1,1,1,0],[1,0,0,0]],[[1,1,0,0],[0,1,1,0]],[[0,1,1,0],[1,1,0,0]]]
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	pass
	
func make_blocks(blockShape):
	var shape = blockShapes[blockShape]
	for i in 3:
		for j in 2:
			if shape[j][i] == 1:
				$Tiles.set_cell(0,Vector2i(i,j),0,Vector2i(0,0))
