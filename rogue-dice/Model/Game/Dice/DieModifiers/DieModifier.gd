@abstract class_name DieModifier extends Resource

@abstract func get_title() -> String
@abstract func get_description() -> String
@abstract func get_icon() -> Texture

@abstract func _on_start_battle(die_node: DieNode) -> void

@abstract func _after_reroll(die_node: DieNode) -> void

@abstract func _after_score(die_node: DieNode,
			dice_scored_before: Array[DieNode], dice_scored_after: Array[DieNode]
		) -> void

@abstract func _on_gain_temp_bonus(die_node: DieNode, gain_amt: int) -> void

@abstract func _on_gain_perm_bonus(die_node: DieNode, gain_amt: int) -> void

@abstract func _after_scoring_done(die_node: DieNode, 
			all_die_nodes_scored: Array[DieNode]
		) -> void
