extends KinematicBody2D

const GRAVITY = 400.0
const WALK_SPEED = 200

var velocity = Vector2()

func _physics_process(delta):
    velocity.y += delta*GRAVITY
    if Input.is_action_pressed("ui_left"):
        velocity.x = -WALK_SPEED
    elif Input.is_action_pressed("ui_right"):
        velocity.x =  WALK_SPEED
    else:
        velocity.x = 0

    if is_on_floor():
        if Input.is_action_pressed("ui_up"):
            velocity.y = -WALK_SPEED
    
    if velocity.x != 0:
        $AnimatedSprite.animation = "right"
        $AnimatedSprite.flip_h = velocity.x < 0
    else:
        
        $AnimatedSprite.animation = "default"
    $AnimatedSprite.play()
    # We don't need to multiply velocity by delta because MoveAndSlide already takes delta time into account.

    # The second parameter of move_and_slide is the normal pointing up.
    # In the case of a 2d platformer, in Godot upward is negative y, which translates to -1 as a normal.
    velocity = move_and_slide(velocity, Vector2(0, -1))