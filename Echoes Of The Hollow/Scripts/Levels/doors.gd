class_name Hidden_doors
extends TileMapLayer

var tween : Tween 

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		tween = create_tween()
		tween.tween_property(self,"modulate",Color.TRANSPARENT,0.5).set_delay(0.2).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_LINEAR)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		tween = create_tween()
		tween.tween_property(self,"modulate",Color.WHITE,0.5).set_ease(Tween.EASE_IN)
