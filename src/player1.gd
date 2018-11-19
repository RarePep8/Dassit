extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
    # Called when the node is added to the scene for the first time.
    # Initialization here
    var character = load("res://sprites/tophat/tophat.tscn")
    var character_instance = character.instance()
    character_instance.init("p1_shoot", "p1_left", "p1_right", "p1_up")
    character_instance.position = Vector2(100,400)
    add_child(character_instance)

#func _process(delta):
#    # Called every frame. Delta is time since last frame.
#    # Update game logic here.
#    pass
