extends Area2D

@export var speed = 600
@export var damage = 1
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position.y += delta * -speed


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_entered(area):
	if area is Enemy:
		area.take_damage(1)
		queue_free()
		
