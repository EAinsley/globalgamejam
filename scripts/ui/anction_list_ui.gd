extends ItemList
class_name ActionList

func replace_list(list: Array[SmallTalk]) -> void:
	clear()
	for small_talk in list:
		if small_talk:
			add_item(small_talk.name, small_talk.icon, true)


func _on_item_selected(index: int) -> void:
	print("select 1")
