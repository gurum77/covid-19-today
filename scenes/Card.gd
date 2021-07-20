extends Control
class_name Card


export (String) var title
export (String) var description
export (Color) var description_color

func _ready():
	$Panel/Title.text = title
	$Panel/Description.text = description
	$Panel/Description.modulate = description_color
