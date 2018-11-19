extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var arr = []
var velocity = Vector2()
func _ready():
    # Called when the node is added to the scene for the first time.
    # Initialization here
    velocity = Vector2(0, -100)
func _physics_process(delta):
    var prev_arr = arr  
    var curr_velocity = Vector2(0,-100)
    arr = get_node("Area2D").get_overlapping_bodies()
    for obj in arr:
        if obj.has_method("fix_on_moving_platform"):
            obj.on_floor = true
            obj.fix_on_moving_platform(velocity)
            if(prev_arr.find(obj) == -1):
                obj.velocity.y = 0
    for obj in prev_arr:
        if arr.find(obj) == -1:
            obj.on_floor = false
    move_and_slide(velocity, Vector2(0, -1))
#func _process(delta):
#    # Called every frame. Delta is time since last frame.
#    # Update game logic here.
#    pass
