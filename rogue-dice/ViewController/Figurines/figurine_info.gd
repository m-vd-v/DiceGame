extends Control

func show_info(figurine: Figurine) -> void:
	update(figurine)
	show()

func update(figurine: Figurine) -> void:
	%TitleLabel.text = figurine.get_title()
	%DescrLabel.text = figurine.get_description()
