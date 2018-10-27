extends KinematicBody2D

const GRAVITY = 400.0
const WALK_SPEED = 200
const JUMP_SPEED = 250
var velocity = Vector2()

func _physics_process(delta):
    velocity.y += delta*GRAVITY
    if Input.is_action_pressed("ui_left"):
        if(velocity.x > 0 and is_on_floor()):
            velocity.x = 0
        if(velocity.x > -WALK_SPEED):
            velocity.x += -5
    elif Input.is_action_pressed("ui_right"):
        if(velocity.x < 0 and is_on_floor()):
            velocity.x = 0
        if(velocity.x < WALK_SPEED):
            velocity.x +=  5
    else:
        if(velocity.x > 0):
            velocity.x += -3
        if(velocity.x < 0):
            velocity.x += 3

    if is_on_floor():
        if Input.is_action_pressed("ui_up"):
            velocity.y = -JUMP_SPEED
    
    if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
        $AnimatedSprite.animation = "right"
        $AnimatedSprite.flip_h = Input.is_action_pressed("ui_left")
    else:
        
        $AnimatedSprite.animation = "default"
    $AnimatedSprite.play()
    # We don't need to multiply velocity by delta because MoveAndSlide already takes delta time into account.

    # The second parameter of move_and_slide is the normal pointing up.
    # In the case of a 2d platformer, in Godot upward is negative y, which translates to -1 as a normal.
    velocity = move_and_slide(velocity, Vector2(0, -1))