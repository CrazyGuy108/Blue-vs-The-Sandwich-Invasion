extends Area2D

onready var max_frames = $Sprite.hframes * $Sprite.vframes

# speed in pixels/second, must be set during initialization
var speed = 0

# whether we've killed an enemy or not
var fired_enemy = false

func _process(delta):
    # move along the current direction
    move_local_x(speed * delta, true)

func _on_area_entered(area):
    """
    Called when hitting another area.
    """
    # see if we killed an enemy with fire
    if area.is_in_group("enemies") and not fired_enemy:
        area.emit_signal("fired")
        area.emit_signal("dead")
        queue_free()
        # make sure we don't kill two enemies with the same fireball
        fired_enemy = true

func _on_Timer_timeout():
    """
    Called once the fireball's Timer runs out.
    """
    queue_free()

func _on_AnimationTimer_timeout():
    """
    Called when it's time to switch to the next animation frame
    """
    $Sprite.frame = ($Sprite.frame + 1) % max_frames
