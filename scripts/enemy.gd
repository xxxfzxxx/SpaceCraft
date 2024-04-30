class_name Enemy extends Area2D

@export var hp = 1
@export var speed = 150
@export var points = 100
signal killed(points)
signal hit
enum EnemyType {
	ENEMY,
	DIVER_ENEMY,
	SATELLITE,
	STATION
}
@export var enemy_type: EnemyType = EnemyType.ENEMY

var direction = Vector2.DOWN
var amplitude = randf_range(50, 200)
var frequency = randf_range(2, 6)
var time_passed = 0.0
var init_x_pos = 0.0
var rotation_angle = 0.0
var rotation_speed = 1.0  # Adjust this value to control the speed of rotation

# Called when the node enters the scene tree for the first time.
func _ready():
	init_x_pos = global_position.x

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	if enemy_type == EnemyType.ENEMY:
		global_position.y += delta * speed * direction.y
		# Implement movement for the Enemy class
		#print("Ememy")
	elif enemy_type == EnemyType.DIVER_ENEMY:
		# Implement movement for the DiverEnemy class in an S shape
		
		global_position.y += delta * speed * direction.y
		
		## Update the x position using a sine function to create oscillating motion
		#global_position.x = init_x_pos + amplitude * sin(frequency * time_passed)
		#
		## Update time_passed
		#time_passed += delta
	elif enemy_type == EnemyType.STATION:
		global_position.y += delta * speed * direction.y
		rotation_angle += rotation_speed * delta
		global_rotation = rotation_angle
	elif enemy_type == EnemyType.SATELLITE:
		global_position.y += delta * speed * direction.y
		
		# Update the x position using a sine function to create oscillating motion
		global_position.x = init_x_pos + amplitude * sin(frequency * time_passed)
		
		# Update time_passed
		time_passed += delta
		
func die():
	queue_free()

func take_damage(amount):
	hp -= amount
	if hp <= 0:
		killed.emit(points)
		die()
	else:
		hit.emit()

func _on_body_entered(body):
	if body is Player:
		body.die()
		die()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
