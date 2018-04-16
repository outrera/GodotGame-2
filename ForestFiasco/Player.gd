extends Area2D
signal hit
export (int) var SPEED
var screensize
const GRAVITY = 200
var velocity = Vector2() # the player's movement vector
var Jumped=0
var onFloor=1
var stat = Hpmp.new()
var dead=0
var hp=100

func _ready():
    screensize = get_viewport_rect().size
    
    
func _process(delta):
    if(dead==0):
#    velocity.y += delta * GRAVITY
        var new = Phys.new()
        var y=new.grav(velocity.y,delta,GRAVITY)
        velocity.y=y
        if Input.is_action_pressed("ui_right"):
            velocity.x += 100
        if Input.is_action_pressed("ui_left"):
            velocity.x -= 100
        if Input.is_action_pressed("ui_down"):
            pass
        if Input.is_action_pressed("ui_up"): 
            if Jumped==0:
                velocity.y -= delta*GRAVITY*800
                Jumped=1
        
        if velocity.y > 90 && velocity.y<110:
            Jumped=0
    
        if velocity.length() > 0:
    #        velocity = velocity.normalized() * SPEED
           $AnimatedSprite.play()
        else:
            $AnimatedSprite.stop()
        position.x += velocity.x * delta
        position.y += velocity.y * delta
        #position.x = clamp(position.x, 0, screensize.x)
        position.x = clamp(position.x, 0, 2000)
        position.y = clamp(position.y, 0, 250)
        velocity.x = clamp(velocity.x, -300, 300)
        velocity.y = clamp(velocity.y, -100, 100)
        
        if velocity.x>=0 && velocity.x<5 && velocity.y<=100 && velocity.y>95:
             $AnimatedSprite.animation = "default"
        elif velocity.y != 100:
            $AnimatedSprite.animation = "up"
        elif velocity.x != 0:
            $AnimatedSprite.animation = "right"
            $AnimatedSprite.flip_v = false
            $AnimatedSprite.flip_h = velocity.x < 0
       
    #        $AnimatedSprite.flip_v = velocity.y > 0
        velocity.x = 0

func _on_Player_body_entered(body):
  
    if(body.get_name() == "gobboChild"):
#        hide()
        hp = stat.stats(0,-99)
        print(hp)
        $Camera2D/HPBar.set_value(hp)
    elif(body.get_name() == "platformChild"):
        velocity.y -= GRAVITY
    else:
        print("not gobbo or platform")
    #$CollisionShape2D.disabled = true
    if(hp<=0):
        hide()
        $CollisionShape2D.disabled = true
        dead=1
#func overlaps_body(body):
#    if(body.get_name() == "platformChild"):
#        velocity.y -= GRAVITY
#    else:
#        print("not gobbo or platform")
#    $CollisionShape2D.disabled = true
    
func start(pos):
    position = pos
    show()
    $CollisionShape2D.disabled = false
    
    
