extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var direction_scale = 1;
func _ready():
    # Called when the node is added to the scene for the first time.
    # Initialization here
    pass
#func _process(delta):
#    # Called every frame. Delta is time since last frame.
#    # Update game logic here.
#    pass

func _physics_process(delta):
    var collision = move_and_collide(direction_scale * Vector2(10,0))
    if(collision != null and collision.get_collider().get_name() == "TileMap"):
        print(collision.get_collider().get_name())
        destroy()
    
    
func destroy():
    queue_free()