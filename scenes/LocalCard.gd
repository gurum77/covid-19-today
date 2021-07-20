extends Panel
class_name LocalCard

export (String) var Name
export (String) var TotalCase
export (String) var TotalRecovered
export (String) var TotalDeath
export (String) var NewCase
export (String) var NewCCase
export (String) var NewFCase
export (String) var Percentage

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	update_text()
	pass # Replace with function body.

func update_text():
	$Container/Name.text = Name
	$Container/TotalAndNewCase/Value.text = '%s [ %s ]' % [TotalCase, NewCase]
	$Container/TotalRecovered/Value.text = '%s' % [TotalRecovered]
	$Container/TotalDeath/Value.text = '%s' % [TotalDeath]
	$Container/NewCCase/Value.text = '%s' % NewCCase
	$Container/NewFCase/Value.text = '%s' % NewFCase
	$Container/Percentage/Value.text = '%s %%' % Percentage

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
