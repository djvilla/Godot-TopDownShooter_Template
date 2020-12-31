extends Node2D

signal dead
signal hurt
signal healed
signal health_changed
signal gibbed

export (int) var max_health = 5
var cur_health = 1

export (int) var gib_at = -10

func _ready():
	init()

func init():
	cur_health = max_health
	emit_signal("health_changed", cur_health)

func hurt(damage: int):
	if cur_health <= 0:
		return
	cur_health -= damage
	if cur_health <= gib_at:
		emit_signal("gibbed")
	if cur_health <= 0:
		emit_signal("dead")
	else:
		emit_signal("hurt")
	emit_signal("health_changed", cur_health)

func heal(amount: int):
	if cur_health <= 0:
		return
	cur_health += amount
	if cur_health > max_health:
		cur_health = max_health
	emit_signal("healed")
	emit_signal("health_changed", cur_health)

