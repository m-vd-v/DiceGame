class_name SideBar extends Node2D

@export var panel: RoadmapPanel
@export var sidebar_bg: SideBarBG

func update_sidebar() -> void:
	sidebar_bg.update_sidebar(panel)
