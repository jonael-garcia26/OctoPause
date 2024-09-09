extends HBoxContainer

@onready var NemoGuiClass = preload("res://gui/nemoGUI.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func setMaxNemos(max : int):
	for i in range(max):
		var nemo = NemoGuiClass.instantiate()
		add_child(nemo)
		
func updateNemos(currHealth: int):
	var nemos = get_children()
	
	for i in range(currHealth):
		nemos[i].update(true)
		
	for i in range(currHealth, nemos.size()):
		nemos[i].update(false)
	
