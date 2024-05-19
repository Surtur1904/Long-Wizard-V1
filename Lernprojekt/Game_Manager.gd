extends Node

@onready var points_label = $"../UI/Panel/PointsLabel"

var points = 0

func add_point():
	points +=1
	print(points)
	points_label.text = "Nomms : " + str(points)
	


