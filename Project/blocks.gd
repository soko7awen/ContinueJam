extends TileMap

var iPiece = [[1,1,1],[0,0,0]]
var oPiece = [[1,1,0],[1,1,0]]
var tPiece = [[1,1,1],[0,1,0]]
var jPiece = [[1,1,1],[0,0,1]]
var lPiece = [[1,1,1],[1,0,0]]
var sPiece = [[0,1,1],[0,1,1]]
var zPiece = [[1,1,0],[0,1,1]]

func _ready():
	for i in 3:
		for j in 2:
			if zPiece[j][i] == 1:
				set_cell(0,Vector2i(i,j),0,Vector2i(0,0))
