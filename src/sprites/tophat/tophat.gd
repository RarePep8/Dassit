extends KinematicBody2D

const GRAVITY = 1500.0
const WALK_SPEED = 250
const JUMP_SPEED = 550
var velocity = Vector2()
var can_jump_second = true
    
func _physics_process(delta):
    velocity.y += delta*GRAVITY
    if Input.is_action_pressed("ui_left"):
        if(velocity.x > 0 and is_on_floor()):
            velocity.x = 0
        if(velocity.x > -WALK_SPEED):
            velocity.x += -8
    elif Input.is_action_pressed("ui_right"):
        if(velocity.x < 0 and is_on_floor()):
            velocity.x = 0
        if(velocity.x < WALK_SPEED):
            velocity.x +=  8
    else:
        if(velocity.x > 0):
            velocity.x += -5
        if(velocity.x < 0):
            velocity.x += 5

    if is_on_floor():
        can_jump_second = true
    if is_on_floor() or can_jump_second:
        if Input.is_action_just_pressed("ui_up"):
            if(can_jump_second and not is_on_floor()):
                can_jump_second = false
                velocity.y = -0.8*JUMP_SPEED
            else:
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


    if Input.is_action_just_pressed("p1_shoot"):
        var bullet = load("res://projectile2.tscn")
        var bi = bullet.instance()
        bi.position = get_position() + Vector2(-15 if $AnimatedSprite.flip_h else 15, 0)
        bi.direction_scale = -1 if $AnimatedSprite.flip_h else 1
        bi.set_collision_mask_bit(1, false)
        get_parent().add_child(bi)
        print(bi.direction_scale)