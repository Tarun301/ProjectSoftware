extends Label

onready var timer = get_node("../Timer")

func _process(delta):
	self.text = "Timer:    " + str(timer.time_left)
