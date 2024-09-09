extends Control

@onready var labelScore = $VBoxContainer/LabelScore
var m = int(Global.Score / 60)
var s = Global.Score - m * 60

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	labelScore.text = "Score: " + '%02d:%02d' % [m,s]
