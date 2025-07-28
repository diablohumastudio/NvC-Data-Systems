### Action Condition System
## Definition

Action Condition System is used to change the state of the app. By state, we refer to variables that change and affect the functioning of the app. 
It is a event driven system, composed by classes Actions, Conditions, and State_Changers and the Singleton System Node that manage all this.

Action through set_action function in System, call evaluate() and change_state() functions of Conditions and StateChangers respectively. 

Conditions communicate, if fulfilled at the moment of evaluate, through a fulfilled signal, to their connected elements that they have been fulfilled. 

By their communicative nature they are designed for creating process that react to multiple (and different kinds) of reasons in an easy way. Eg. like if you win a level AND collect 100 coins.

StateChangers, when called change_state(), change the value of accessible properties of state. 

These are design mostly to change directly properties of the state, in a centralize way. 

## Uses

This folder contains the action_condition_system node and attached script. This node is intended to be used as a Singleton through adding the file to Globals/Autoloads in project.godot (project settings). 

We have to create the conditions and state_changers that we are going to use. First Create the .gd files, overriding evaluate() and change_state() function so they satisfied our needs. All of this MUST have a type (explained below). Also create the specific .tres files of this kinds. This way we can have (by adding exported properties), configurable "same kind" of conditions/state_changer. 

Actions are used in the moment we want to trigger the event. We do this by calling the Singleton's function SingletonsName.set_action(Action). 

For not consuming to much processing, actions have a property type, and so do conditions and state_changers. So an action only triggers the function of conditions and state_changers that match to their type.  

So, for every kind of action we MUST create, a value in the Action enum Types. And we MUST define the type of the Condition or StateChanger in the constructor. 

Actions can also have a payload (open for what you need). So for every kind of action you CAN create a Class that inherits Payload, and that can have any external (received from were you trigger the action) reference you need. Preferable as a subclass inside of the file Action.gd.

We defined in the Singleton Node's exported properties, the folder were we are going to save the .tres Conditions and StateChanges files. Singleton will get these files, cached them, and called their functions (evaluate and change_state) at the moment we use function set_action. 

The set_action will receive as an argument, an action, and call the functions of the Conditions and StateChanges that have the same Type, and send to the functions the payload as an argument. 

## Recommendation Use Notes

Highly recommended to manage global states, like config or user data. 

Not recommended for game state, like positions, animations, or other properties of highly interactive nodes. For this, is better to save the package scene or use other approaches.     

If used for a piece of state (or any other object) you want to react to several conditions, since they don't have a state to monitor, you should use a var to save the progress of the conditions like having a array of fulfilled conditions and compare it to total conditions to fullfil. 