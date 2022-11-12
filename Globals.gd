extends Node

signal BuyItem(price)

var money = 500
var onFlyButtonPressed = false

var terrains = [
	preload("res://Terrains/Terrain1.tscn"),
	preload("res://Terrains/Terrain2.tscn"),
	preload("res://Terrains/Terrain3.tscn")
]
