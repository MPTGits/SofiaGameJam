extends Button

signal buy_item

export (String) var title = "Title" setget set_title
export (Texture) var item_sprite

export (float) var damage = 0.25 setget set_damage
export (float) var speed = 0.25 setget set_speed
export (float) var price = 25.0 setget set_price

# Called when the node enters the scene tree for the first time.
func _ready():
	$ItemSprite.texture = item_sprite;

func set_title(value):
	title = value;
	$Title.text = title;
		
func set_damage(value):
	$Damage.init(value);
	
func set_speed(value):
	$Speed.init(value);

func set_price(value):
	price = value;
	$Price.text = str(price);

func _on_Item_pressed():
	Globals.emit_signal("BuyItem", price);
