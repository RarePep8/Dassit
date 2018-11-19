extends TileMap

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var timer = 0
var delay = 1
func _ready():
    # Called when the node is added to the scene for the first time.
    # Initialization here
    pass

func _process(delta):
    # Called every frame. Delta is time since last frame.
    # Update game logic here.
    timer += delta
    if(timer >= delay):
        timer -= delay
        var platform = load("res://platform.tscn")
        var platform_instance = platform.instance()
        platform_instance.position = Vector2(randi()%400,400)
        add_child(platform_instance)
    