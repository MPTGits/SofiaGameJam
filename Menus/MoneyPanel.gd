extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$MoneyBackground/MoneyValue.text = str(Globals.money);
	Globals.connect("BuyItem", self, "handle_buy_item");

func handle_buy_item(price):
	if Globals.money >= price:
		Globals.money -= price;
		$MoneyBackground/MoneyValue.text = str(Globals.money);
