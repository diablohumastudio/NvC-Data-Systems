# Project Memory - Diablo Huma Studio Game
- A project for creating the systems for achivements, level progress, money, saving user data and allies market system for a game we have already done that is similar to PvZ.

## Project Overview 
- Godot game project with allies system
- Main branch: `main`
- Working on allies market and inventory features

## Code Conventions
- GDScript language
- Scene files (.tscn) for UI components
- Resource files (.tres) for data
- Follow existing naming patterns (snake_case for files, PascalCase for classes)

## Key Systems
- **Allies System**: Core gameplay feature for collecting/upgrading allies
- **User Data**: Save system with user_data, user_allies_inventory
- **Market System**: Shop interface for purchasing allies
- **State Management**: Action payloads for unlock/upgrade operations

## Recent Work
- Implemented allies market screen with details popup
- Added ally unlock/upgrade functionality
- Created ally details popup with buy/upgrade buttons
- Font sizes increased by 8 points in popup UI

## File Structure
- `data/allies/` - Ally data and models
- `screens/allies_market/` - Market UI screens
- `screens/allies_market/ally_details_popup/` - Popup component

## Testing & Build
- Project uses Godot engine
- No specific test commands identified yet
- Check git status before committing changes

## Godot Resource Management
- **IMPORTANT**: After creating any .tres resource files, ALWAYS run the Godot reimport command to generate proper UIDs
- Reimport command: `"/Volumes/Fer/RespaldoFER/Documentos/GODOT/Editor/Executables/Godot_v4.4.1-stable_macos.universal.app/Contents/MacOS/Godot" --headless --path "/Users/fernandobarahona/Documents/DiabloHumaStudio/save_user_data" --editor --quit`
- This prevents the need to manually re-save files in Godot to generate UIDs

## Conversation History
- **IMPORTANT**: Always read CLAUDE.log at the start of new conversations to understand previous context and decisions
- This file contains conversation history, important project decisions, and implementation notes
- Update this file when significant decisions or changes are made

## Creation of new allies system
- I want a system that you recibe money (in-menu money) for finishing a level. 
- With this money you can buy allies in allies_market. Yo can unlock locked allies, and you can upgrade unlocked ones until maximun level. 
- Levels are not lineal, so you can have diferent branches of unlocking levels.
- So in popup inside the market should be presented an graph representing the levels and branches, with an icon for each level, with normal color if is unlocked, shining if is the one you can unlocked and gray if is after that.
- Then in the game screen you can buy with in-game money an allie and palace it in game_screen. This will be in the base_level.
- In that screen you can upgrade individually each ally to next level (you chose a branch o unlocking) untill the max of that branch that have been already unlocked in the market screen. 
- For that when you press the allie it displays a popup similar to the one on the market. 

## Creation of new allies system 2
### tehc specs
#### First opt with my system
1. i have a level system in the project. In the ud_level i has a completed (and a completed with no canons dead) and a locked property. It is based on conditions for unlock and uses one state changer for completed.
2. I want to use a similar system for the ally_levels. So:
3. In ally_levels there are buyed and locked properties. locked uses conditions and buyed a state changer. 
4. So if these properties are in ally_level theres nothing more to ud_level so maybe it has to go. 
5. One problem is that if ally_level has this conditions it has to be saved. i dont know if creating an ud_ally_level would create to much complexity (so maybe we sabe entire ally_level) maybe you can tell me what you think. 
6. Another probelem is that for linking ally (what i want to be called AllyData) with ally_levels we need a function similar to _set_ud_level() in class Level, maybe one called _set_ally_levels that do the same but iterating for all ally_levels. This function gets the ally_levels from previously saved in user_data (in the beggining of user_data_system) that has the same id that the one configure by editor in ally. So we have to save a lot of resourses of type ally_level. So creting an exported var in allies_inventory called ally_levels instead of ud_allies. (if we create ud_ally_level class should be called ud_ally_levels)  
7. Another problem is that the property conditions: Array[Condition] is an array, so it wont get saved. So is neede to do again the same as in ud_levels. creating an typed dictionary conditions: Dictionary[Condition, bool].   
#### Second opt with my sist
1. If we don't use array of conditions and instead use state_changers, we can have ther property levels:Array[AllyLevel] and the property ud_ally: UDAlly in Ally class. And we can have ud_ally saved and in it the properties levels_unlocked and levels_buyed of type Array[AllyLevel.IDs] (we have to first create the enum IDs in AllyLevel), so we dont have to save all the ally_levels (those will only be saved in res folder and be compare in market and in game with unlocke_ally_levels for enabling button). 
2. The problem here are the requisites of ally_level, they should be an AllyLevelId. So it wont be as powerfull (versatile) as condition system (that we can unocked ally_level not only by buying the previous ally_level but maybe soldiers_killed or number of achivements unlocked or consecutive days played or anything i can think). Maybe you can tell me if this is true. 