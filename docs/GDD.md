# Game Design Document - NvC Data Systems
## WWII Tower Defense Game

**Version:** 1.0  
**Date:** December 2024  
**Project:** DiabloHumaStudio/save_user_data  

---

## Table of Contents

1. [Game Overview](#1-game-overview)
2. [Core Gameplay](#2-core-gameplay)
3. [Game Systems](#3-game-systems)
4. [Content Design](#4-content-design)
5. [User Experience](#5-user-experience)
6. [Technical Design](#6-technical-design)
7. [Art & Audio](#7-art--audio)
8. [Progression & Monetization](#8-progression--monetization)

---

## 1. Game Overview

### 1.1 High-Level Concept
**Genre:** Tower Defense with WWII Historical Theme  
**Setting:** Stalingrad Campaign (Summer/Winter Operations)  
**Platform:** PC (Godot Engine 4.4)  

**Core Concept:** Players defend strategic positions during WWII battles by placing and upgrading allied units. Features dual economy system with in-game tactical purchases and meta-game progression currencies.

### 1.2 Unique Selling Points
- **Dual Economy System**: In-game coins for tactical purchases + meta-currency for permanent upgrades
- **Branching Progression**: Non-linear ally upgrade paths with condition-based unlocks
- **Historical Authenticity**: WWII Stalingrad setting with period-appropriate units and scenarios
- **Data-Driven Balance**: Sophisticated condition/action system for precise game balance

### 1.3 Target Audience
- **Primary**: Strategy game enthusiasts who enjoy tower defense mechanics
- **Secondary**: History buffs interested in WWII tactical scenarios
- **Age Range**: 13+ (historical war theme)

---

## 2. Core Gameplay

### 2.1 Core Game Loop
```
Select Level → Place Allies → Defend Against Waves → Earn Coins → 
Upgrade/Buy New Allies → Complete Level → Unlock New Content → Repeat
```

### 2.2 Player Actions
- **Ally Selection**: Choose from available allies via AlliesSelector interface
- **Tactical Placement**: Position allies on TerrainGrid for optimal defense
- **Resource Management**: Spend in-game balance strategically during combat
- **Progression Decisions**: Unlock and upgrade allies in the market system

### 2.3 Victory/Defeat Conditions
- **Victory**: Survive all enemy waves with at least one cannon remaining
- **Defeat**: All cannons destroyed by enemy units reaching the end
- **Performance Metrics**: Tracked via canons_alive, enemies_killed, efficiency ratings

---

## 3. Game Systems

### 3.1 Ally System
**Current Implementation:**
- **Types**: BAYONETE_SOLDIER (combat), CHEST (resource provider)
- **Upgrade Paths**: Multi-level progression with branching options
- **Placement**: Grid-based positioning with strategic considerations

### 3.2 Economy System
**Dual Currency Model:**
- **In-Game Balance**: Earned during combat, spent on ally placement/upgrades
- **Meta-Currency**: Earned from level completion, spent in allies market
- **Balance Tracking**: Real-time via GSS.balance with change notifications

### 3.3 Progression System
**Level Progression:**
- **Available Levels**: Level1, Level2, Level2p, Level3, LevelEx, LevelEx2, Level4
- **Unlock Conditions**: Condition-based system using Action-Condition System (ACS)
- **Achievement System**: 4 achievement types tracking completion and performance

### 3.4 Enemy System
**Current Enemies:**
- **HandGunGerman**: Primary enemy type with shooter behavior
- **Wave Spawning**: Configurable timing and positioning strategies
- **AI Behavior**: State machine-driven enemy actions

---

## 4. Content Design

### 4.1 Level Design
**Grid-Based Combat Areas:**
- **TerrainGrid**: Ally placement zones
- **EnemiesSpawnersGrid**: Enemy spawn points and wave management
- **Background Integration**: Historical Stalingrad environments

### 4.2 Ally Design
**Unit Categories:**
- **Combat Units**: Direct damage dealers (Bayonete Soldier)
- **Support Units**: Resource providers and utility (Chest)
- **Upgrade System**: Level-based stat progression with unlock requirements

### 4.3 Achievement Design
**Current Achievements:**
- Level completion rewards
- Enemy elimination milestones
- Performance-based challenges
- Total kill count objectives

---

## 5. User Experience

### 5.1 UI/UX Flow
**Main Game Interface:**
- **AlliesSelector**: Bottom panel for unit selection
- **TerrainGrid**: Main battlefield for ally placement
- **BalanceDisplayer**: Real-time resource tracking
- **Game State**: Win/loss feedback and progression

### 5.2 Settings & Accessibility
**Current Features:**
- Audio system integration (Wwise)
- Volume controls
- Debug/testing tools

---

## 6. Technical Design

### 6.1 Architecture Overview
**Core Systems:**
- **ACS (Action-Condition System)**: State management and unlock logic
- **UDS (User Data System)**: Save/load and progression persistence
- **GSS (Game State System)**: Runtime game state and balance tracking
- **SMS (Scene Manager System)**: Screen transitions and scene loading

### 6.2 Data Management
**Resource Architecture:**
- **Data-Driven Design**: .tres resource files for all game content
- **Modular Structure**: Separate ally, level, achievement, and enemy data
- **Version Control**: All content tracked in git repository

---

## 7. Art & Audio

### 7.1 Visual Style
**WWII Historical Theme:**
- Period-appropriate unit designs
- Authentic Stalingrad environment assets
- Clear visual hierarchy for gameplay clarity

### 7.2 Audio Design
**Wwise Integration:**
- Dynamic music system
- Historical sound effects
- Combat audio feedback

---

## 8. Progression & Monetization

### 8.1 Progression Hooks
**Unlock Systems:**
- Level-gated content progression
- Achievement-based rewards
- Ally upgrade trees with branching paths

### 8.2 Future Content Plans
**Planned Features:**
- Additional historical campaigns
- Extended ally roster
- Advanced achievement categories
- Simulation and balance testing tools

---

## Development Notes

This GDD is a living document that evolves with development. See `CLAUDE.md` for implementation details and development history.

**Key Technical References:**
- Action-Condition System: `global_systems/data_systems/action_condition_system/`
- Ally Data Models: `data/game_characters/allies/models/`
- Level System: `data/levels/model/`
- Game State: `screens/game/game_state_system/`