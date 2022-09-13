extends Node

func add(parent, child):
	parent.call_deferred("add_child", child)

func delete(child):
	child.call_deferred("queue_free")
