extends Control
class_name Overview

export (String) var newCase
export (String) var diffCase	# 전전날 대비 증감수
export (String) var newCCase
export (String) var newFCase

func _ready():
	update_text()
	
func update_text():
	$Panel/newCase.text = newCase
	$Panel/newCCase.text = newCCase
	$Panel/newFCase.text = newFCase
