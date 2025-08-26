class_name UserData extends Resource

@export_storage var user_name: String = ""
@export_storage var player_balance: int = 0
@export_storage var progress: UserProgress = UserProgress.new()
@export_storage var ud_achievements: UserAchievements = UserAchievements.new()
@export_storage var stats: UserStats = UserStats.new()
@export_storage var allies_inventory: UserAlliesInventory = UserAlliesInventory.new()
@export_storage var settings: UserSettings = UserSettings.new()
