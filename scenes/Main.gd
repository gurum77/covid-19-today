extends Control

var card = preload("res://scenes/Card.tscn")
var local_card = preload("res://scenes/LocalCard.tscn")
onready var total_grid = $ScrollContainer/VBoxContainer/TotalPanel/GridContainer
onready var now_grid = $ScrollContainer/VBoxContainer/NowPanel/GridContainer
onready var local_container = $ScrollContainer/VBoxContainer/LocalPanel/Container
onready var overview = $Overview

# Called when the node enters the scene tree for the first time.
func _ready():
	# 코로나 현황을 가져온다.
	# API 설명 : https://github.com/dhlife09/Corona-19-API
	$HTTPRequest.request('https://api.corona-19.kr/korea/?serviceKey=BusniSYjP9kogRvlpVrT6KFxWJtC1Dmqy')
	$HTTPRequest2.request('https://api.corona-19.kr/korea/country/new/?serviceKey=BusniSYjP9kogRvlpVrT6KFxWJtC1Dmqy')
	 

func clear_children(parent):
	var nodes = parent.get_children()
	for node in nodes:
		parent.remove_child(node)
	
	
func _on_HTTPRequest_request_completed(_result, _response_code, _headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	print(json.result)
	
	clear_children(total_grid)
	add_total_card(json.result, 'TotalCase', '확진자', Color.red)
	add_total_card(json.result, 'TotalDeath', '사망자', Color.darkgray)
	add_total_card(json.result, 'TotalRecovered', '완치자', Color.darkgreen)
	add_total_card(json.result, 'TotalChecking', '검사자', Color.orange)
	
	# now
	clear_children(now_grid)
	add_now_card(json.result, 'NowCase', '격리자', Color.peru)
	add_now_card(json.result, 'checkingCounter', '검사중', Color.brown)
	
func add_now_card(json_result, key, title, description_color):
	var ins = card.instance()
	if ins is Card:
		ins.title = title
		ins.description = json_result[key]
		ins.description_color = description_color
		now_grid.add_child(ins)
	
		
func add_total_card(json_result, key, title, description_color):
	var ins = card.instance()
	if ins is Card:
		ins.title = title
		ins.description = json_result[key]
		ins.description_color = description_color
		total_grid.add_child(ins)


func _on_HTTPRequest2_request_completed(_result, _response_code, _headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	
	# today
	overview.newCase = json.result['korea']['newCase']
	overview.newCCase = json.result['korea']['newCcase']
	overview.newFCase = json.result['korea']['newFcase']
	overview.update_text()
	
	# 지역발생
	add_local_card(json.result, 'seoul')
	add_local_card(json.result, 'busan')
	add_local_card(json.result, 'daegu')
	add_local_card(json.result, 'incheon')
	add_local_card(json.result, 'gwangju')
	add_local_card(json.result, 'daejeon')
	add_local_card(json.result, 'ulsan')
	add_local_card(json.result, 'sejong')
	add_local_card(json.result, 'gyeonggi')
	add_local_card(json.result, 'gangwon')
	add_local_card(json.result, 'chungbuk')
	add_local_card(json.result, 'chungnam')
	add_local_card(json.result, 'jeonbuk')
	add_local_card(json.result, 'jeonnam')
	add_local_card(json.result, 'gyeongbuk')
	add_local_card(json.result, 'gyeongnam')
	add_local_card(json.result, 'jeju')
	add_local_card(json.result, 'quarantine')
	
	
func add_local_card(json_result, local_key):
	var ins = local_card.instance()
	if ins is LocalCard:
		ins.Name = json_result[local_key]['countryName']
		ins.TotalCase = json_result[local_key]['totalCase']
		ins.TotalDeath = json_result[local_key]['death']
		ins.TotalRecovered = json_result[local_key]['recovered']
		ins.NewCase = json_result[local_key]['newCase']
		ins.NewCCase = json_result[local_key]['newCcase']
		ins.NewFCase = json_result[local_key]['newFcase']
		ins.Percentage = json_result[local_key]['percentage']
		
		local_container.add_child(ins)
		
