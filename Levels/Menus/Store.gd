extends Control

var HBoxSlideOffset;

var FirstItemIdx = 0;
var LastItemIdx = 3;

var RemoveItemIdx = 0;

func _ready():
	var HBoxNodeWidth = $Items.get_child(0).rect_size.x;
	HBoxSlideOffset = HBoxNodeWidth + 20;

func _on_LeftArrow_pressed():
	if $TweenyItems.is_active():
		return
	
	var initialVal = $Items.rect_position;
	var finalVal = initialVal;
	finalVal.x -= HBoxSlideOffset;
	SwapItemsLeft();
	StartSlideTween(initialVal, finalVal);

func _on_RightArrow_pressed():
	if $TweenyItems.is_active():
		return
	
	var initialVal = $Items.rect_position;
	var finalVal = initialVal;
	finalVal.x += HBoxSlideOffset;
	SwapItemsRight();
	StartSlideTween(initialVal, finalVal);

func _on_TweenyHboxContainer_tween_completed(_object, _key):
	$Items.get_child(RemoveItemIdx).queue_free();

func SwapItemsLeft():
	var firstItem = $Items.get_child(FirstItemIdx);
	var lastItem = $Items.get_child(LastItemIdx);
	
	var clone = firstItem.duplicate();
	clone.rect_position = lastItem.rect_position;
	clone.rect_position.x += HBoxSlideOffset;

	RemoveItemIdx = FirstItemIdx;
	$Items.add_child(clone);
	
	
func SwapItemsRight():
	var firstItem = $Items.get_child(FirstItemIdx);
	var lastItem = $Items.get_child(LastItemIdx);
	
	var clone = lastItem.duplicate();
	clone.rect_position = firstItem.rect_position;
	clone.rect_position.x -= HBoxSlideOffset;

	RemoveItemIdx = LastItemIdx + 1;
	$Items.add_child(clone);
	$Items.move_child(clone, 0);


func StartSlideTween(initialVal, finalVal):
	$TweenyItems.interpolate_property($Items,
									 "rect_position",
									 initialVal,
									 finalVal,
									 0.25,
									 Tween.TRANS_LINEAR,
									 Tween.EASE_IN);
	$TweenyItems.start();


func _on_BackBtn_pressed():
	get_tree().change_scene("res://Levels/TestLevel.tscn")
