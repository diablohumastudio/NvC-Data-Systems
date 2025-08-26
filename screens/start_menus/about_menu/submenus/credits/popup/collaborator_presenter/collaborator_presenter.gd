class_name CollaboratorPresenter extends Control

var collaborator:Collaborator : set = _set_collaborator

func _set_collaborator(new_value:Collaborator) -> void:
	collaborator = new_value
	_set_presentation()

func _set_presentation():
	%CollaboratorName.text = collaborator.colaborator_name
	%Role.text = collaborator.role
	%Description.text = collaborator.description
	
	%SocialMediaButtons.create_buttons(collaborator)
