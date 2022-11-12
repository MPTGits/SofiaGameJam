extends Control

var max_stat = 2.0
export (float) var stat = 0.25 setget set_stat
export (String) var title = "StatType" setget set_title

func _ready():
	stat = $StatForeground.scale.x;
	$StatValue.text = str(stat * 100);
	$StatType.text = title;

func set_stat(value):
	stat = clamp(value, 0.0, max_stat)
	$StatForeground.scale.x = stat;
	$StatValue.text = str(stat * 100);
	
func set_title(value):
	title = value;
	$StatType.text = title;

func init(value):
	set_stat(value);
