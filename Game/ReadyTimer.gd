extends Timer



onready var label = get_node("../Label")


func _on_ReadyTimer_timeout():
	Global.ready = true
	label.text = ""
