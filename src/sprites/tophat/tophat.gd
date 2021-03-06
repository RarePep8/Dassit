extends KinematicBody2D

const GRAVITY = 1500
const WALK_SPEED = 250
const JUMP_SPEED = 550
var velocity = Vector2()
var can_jump_second = true
var shoot_key = ""
var left_key = ""
var right_key = ""
var jump_key = ""
var on_floor = false
func init(var shoot_key, var left_key, var right_key, var up_key):
    self.shoot_key = shoot_key
    self.left_key = left_key
    self.right_key = right_key
    self.jump_key = up_key
func fix_on_moving_platform(p_velocity):
    if on_floor:
        move_and_slide(p_velocity, Vector2(0, -1))
        on_floor = true
func _physics_process(delta):
    print(velocity.y)
    if(!on_floor):
        velocity.y += GRAVITY*delta
    if Input.is_action_pressed(left_key):
        if(velocity.x > 0 and is_on_floor()):
            velocity.x = 0
        if(velocity.x > -WALK_SPEED):
            velocity.x += -8
    elif Input.is_action_pressed(right_key):
        if(velocity.x < 0 and is_on_floor()):
            velocity.x = 0
        if(velocity.x < WALK_SPEED):
            velocity.x +=  8
    else:
        if(velocity.x > 0):
            velocity.x += -5
        if(velocity.x < 0):
            velocity.x += 5
    if is_on_floor() or on_floor:
        can_jump_second = true
    if is_on_floor() or can_jump_second or on_floor:
        if Input.is_action_just_pressed(jump_key):
            if(can_jump_second and not is_on_floor()):
                can_jump_second = false
                velocity.y = -0.8*JUMP_SPEED
            else:
                velocity.y = -JUMP_SPEED
            
    
    if Input.is_action_pressed(left_key) or Input.is_action_pressed(right_key):
        $AnimatedSprite.animation = "right"
        $AnimatedSprite.flip_h = Input.is_action_pressed(left_key)
    else:
        
        $AnimatedSprite.animation = "default"
    $AnimatedSprite.play()
    # We don't need to multiply velocity by delta because MoveAndSlide already takes delta time into account.

    # The second parameter of move_and_slide is the normal pointing up.
    # In the case of a 2d platformer, in Godot upward is negative y, which translates to -1 as a normal.
    velocity = move_and_slide(velocity, Vector2(0, -1))


    if Input.is_action_just_pressed(shoot_key):
        var bullet = load("res://projectile2.tscn")
        var bi = bullet.instance()
        bi.position = get_position() + Vector2(-15 if $AnimatedSprite.flip_h else 15, 0)
        bi.direction_scale = -1 if $AnimatedSprite.flip_h else 1
        bi.set_collision_mask_bit(1, false)
        get_parent().add_child(bi)
        print(bi.direction_scale)