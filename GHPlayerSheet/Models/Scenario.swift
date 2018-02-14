import Foundation

struct Scenario {
    
    let number: String
    let name: String
    let requirements: String
    let goal: String
    var difficulty: String?
    
    init(number: String, name: String, requirements: String, goal: String) {
        self.number = number
        self.name = name
        self.requirements = requirements
        self.goal = goal
    }
    
    private static func generateScenarios() -> [Scenario] {
        let scenario1 = Scenario(number: "1", name: "Black Barrow", requirements: "None", goal: "Kill all enemies")
        let scenario2 = Scenario(number: "2", name: "Barrow Lair", requirements: "First Steps (Party) COMPLETE", goal: "Kill the Bandit Commander and all revealed enemies")
        let scenario3 = Scenario(number: "3", name: "Inox Encampment", requirements: "The Merchant Flees (Global) INCOMPLETE", goal: "Kill a number of enemies to five times the number of characters")
        let scenario4 = Scenario(number: "4", name: "Crypt of the Damned", requirements: "None", goal: "Kill all enemies")
        let scenario5 = Scenario(number: "5", name: "Ruinous Crypt", requirements: "None", goal: "Kill all enemies")
        let scenario6 = Scenario(number: "6", name: "Decaying Crypt", requirements: "None", goal: "Reveal the M tile and kill all revealed enemies")
        let scenario7 = Scenario(number: "7", name: "Vibrant Grotto", requirements: "The Power of Enhancement (Global) and The Merchant Flees (Global) COMPLETE", goal: "Loot all treasure tiles")
        let scenario8 = Scenario(number: "8", name: "Gloomhaven Warehouse", requirements: "Jekserah's Plan (Party) COMPLETE and The Dead Invade (Global) INCOMPLETE", goal: "Kill both Inox Bodyguards")
        let scenario9 = Scenario(number: "9", name: "Diamond Mine", requirements: "The Merchant Flees (Global) INCOMPLETE", goal: "Kill the Merciless Overseer and loot the treasure tile")
        let scenario10 = Scenario(number: "10", name: "Plane of Elemental Power", requirements: "The Rift Neutralized (Global) INCOMPLETE", goal: "Kill all enemies")
        let scenario11 = Scenario(number: "11", name: "Gloomhaven Square A", requirements: "End of the Invasion (Global) INCOMPLETE", goal: "Kill the Captiain of the Guard")
        let scenario12 = Scenario(number: "12", name: "Gloomhaven Square B", requirements: "End of the Invasion (Global) INCOMPLETE", goal: "Kill Jekserah")
        let scenario13 = Scenario(number: "13", name: "Temple of the Seer", requirements: "None", goal: "Kill all enemies")
        let scenario14 = Scenario(number: "14", name: "Frozen Hollow", requirements: "None", goal: "Kill all enemies")
        let scenario15 = Scenario(number: "15", name: "Shrine of Strength", requirements: "None", goal: "Loot the treasure tile")
        let scenario16 = Scenario(number: "16", name: "Mountain Pass", requirements: "None", goal: "Kill all enemies")
        let scenario17 = Scenario(number: "17", name: "Lost Island", requirements: "None", goal: "Kill all enemies")
        let scenario18 = Scenario(number: "18", name: "Abandoned Sewers", requirements: "None", goal: "Kill all enenmies")
        let scenario19 = Scenario(number: "19", name: "Forgotten Crypt", requirements: "The Power of Enhancement (Global) COMPLETE", goal: "Protect Hail (a) until she reaches the altar (b)")
        let scenario20 = Scenario(number: "20", name: "Necromancer's Sanctum", requirements: "The Merchant Flees (Global) COMPLETE", goal: "Kill Jekserah")
        let scenario21 = Scenario(number: "21", name: "Infernal Throne", requirements: "The Rift Neutralized(Global) INCOMPLETE", goal: "Kill the Prime Demon")
        let scenario22 = Scenario(number: "22", name: "Temple of the Elements", requirements: "A Demon's Errand (Party) or Following Clues (Party) COMPLETE", goal: "Destroy all altars (a)")
        let scenario23 = Scenario(number: "23", name: "Deep Ruins", requirements: "None", goal: "Occupy all pressure plates simultaneously")
        let scenario24 = Scenario(number: "24", name: "Echo Chamber", requirements: "None", goal: "Open all doors (fog tiles)")
        let scenario25 = Scenario(number: "25", name: "Icecrag Ascent", requirements: "None", goal: "All characters must escape through the exit (a)")
        let scenario26 = Scenario(number: "26", name: "Ancient Cistern", requirements: "Water-Breathing (Global) or Through the Ruins (Party) COMPLETE", goal: "Cleanse all water pumps")
        let scenario27 = Scenario(number: "27", name: "Ruinious Rift", requirements: "Artifact: Lost INCOMPLETE (Global) and Stonebreaker's Censer (Party) COMPLETE", goal: "Protect Hail (a) for ten rounds")
        let scenario28 = Scenario(number: "28", name: "Outer Ritual Chamber", requirements: "Dark Bounty (Party) COMPLETE", goal: "Kill all enemies")
        let scenario29 = Scenario(number: "29", name: "Sanctuary of Gloom", requirements: "An Invitation (Party) COMPLETE", goal: "Kill all enemies")
        let scenario30 = Scenario(number: "30", name: "Shrine of the Depths", requirements: "The Voice's Command (Party)", goal: "Loot the treasure tile")
        let scenario31 = Scenario(number: "31", name: "Plane of Night", requirements: "The Power of Enhancement (Global) and Artifact: Recovered (Global) COMPLETE", goal: "Destroy the rock column (a)")
        let scenario32 = Scenario(number: "32", name: "Decrepit Wood", requirements: "The Voice's Command (Party) COMPLETE", goal: "Reveal the G tile, kill all revealed enemies, and loot the treasure tile")
        let scenario33 = Scenario(number: "33", name: "Savvas Armory", requirements: "The Voice's Command (Party) or The Drake's Command (Party) COMPLETE", goal: "Loot all treasure tiles, then all characters must escape through the exit (a)")
        let scenario34 = Scenario(number: "34", name: "Scorched Summit", requirements: "The Drake's Command (Party) COMPLETE and The Drake Aided (Global) INCOMPLETE", goal: "Kill the Elder Drake")
        let scenario35 = Scenario(number: "35", name: "Gloomhaven Battlements A", requirements: "A Demon's Errand (Party) COMPLETE and The Rift Neutralized (Global) INCOMPLETE", goal: "Destroy door (1) and kill the Captain of the Guard")
        let scenario36 = Scenario(number: "36", name: "Gloomhaven Battlements B", requirements: "A Demon's Errand (Party) COMPLETE and The Rift Neutralized (Global) INCOMPLETE", goal: "Kill the Prime Demon")
        let scenario37 = Scenario(number: "37", name: "Doom Trench", requirements: "Water-Breathing (Global) COMPLETE", goal: "All characters must escape through the exit (a)")
        let scenario38 = Scenario(number: "38", name: "Slave Pens", requirements: "None", goal: "Kill all enemies and protect the Orchid (a)")
        let scenario39 = Scenario(number: "39", name: "Treacherous Divide", requirements: "None", goal: "Destroy the altar (a)")
        let scenario40 = Scenario(number: "40", name: "Ancient Defense Network", requirements: "The Voice's Command (Party) and The Voice's Treasure (Party) COMPLETE", goal: "Occupy both pressure plates (a) simultaneously")
        let scenario41 = Scenario(number: "41", name: "Timeworn Tomb", requirements: "The Voice's Command (Party) COMPLETE", goal: "All characters must escape through the exit (a)")
        let scenario42 = Scenario(number: "42", name: "Realm of the Voice", requirements: "The Scepter and the Voice (Party) COMPLETE and The  Voice Freed (Global) INCOMPLETE", goal: "Destroy all vocal chords")
        let scenario43 = Scenario(number: "43", name: "Drake Nest", requirements: "The Power of Enhancement (Global) COMPLETE", goal: "Kill a number of drakes equal to four times the number of characters")
        let scenario44 = Scenario(number: "44", name: "Tribal Assault", requirements: "Redthorn's Aid (Party) COMPLETE", goal: "Kill all enemies and protect all captive Orchids (a)")
        let scenario45 = Scenario(number: "45", name: "Rebel Swamp", requirements: "City Rule: Demonic (Global) COMPLETE", goal: "Destroy all totems (a)")
        let scenario46 = Scenario(number: "46", name: "Nightmare Peak", requirements: "Across the Divide (Party) COMPLETE", goal: "Kill the Winged Horror")
        let scenario47 = Scenario(number: "47", name: "Lair of the Unseeing Eye", requirements: "Through the Trench (Party) COMPLETE", goal: "Kill the Sightless Eye")
        let scenario48 = Scenario(number: "48", name: "Shadow Weald", requirements: "Redthorn's Aid (Party) COMPLETE", goal: "Kill the Dark Rider")
        let scenario49 = Scenario(number: "49", name: "Rebel's Stand", requirements: "City Rule: Demonic (Global) COMPLETE", goal: "Kill the Siege Cannon")
        let scenario50 = Scenario(number: "50", name: "Ghost Fortress", requirements: "City Rule: Demonic (Global) COMPLETE and Annihilation of Order (Global) INCOMPLETE", goal: "Loot all treasure tiles")
        let scenario51 = Scenario(number: "51", name: "The Void", requirements: "End of Corruption (Global) x3 COMPLETE", goal: "Kill the Gloom")
        let scenario52 = Scenario(number: "52", name: "Noxious Cellar", requirements: "\"Seeker of Xorn\" personal quest", goal: "All characters must loot one treasure tile")
        let scenario53 = Scenario(number: "53", name: "Crypt Basement", requirements: "\"Seeker of Xorn\" personal quest", goal: "Survive for ten rounds")
        let scenario54 = Scenario(number: "54", name: "Palace of Ice", requirements: "\"Seeker of Xorn\" personal quest, \"Staff of Xorn\" item equipped", goal: "Place the fully charged Staff of Xorn on the altar (a)")
        let scenario55 = Scenario(number: "55", name: "Foggy Thicket", requirements: "\"Take Back the Trees\" personal quest", goal: "Loot the treasure tile in the third room")
        let scenario56 = Scenario(number: "56", name: "Bandit's Wood", requirements: "\"Take Back the Trees\" personal quest", goal: "Kill all enemies and protect at least one captive Orchid")
        let scenario57 = Scenario(number: "57", name: "Investigation", requirements: "\"Vengeance\" personal quest", goal: "Kill the Infiltrator")
        let scenario58 = Scenario(number: "58", name: "Bloody Shack", requirements: "\"Vengeance\" personal quest", goal: "Kill the Harvester")
        let scenario59 = Scenario(number: "59", name: "Forgotten Grove", requirements: "\"Finding the Cure\" personal quest", goal: "Kill all enemies and loot the treasure tile")
        let scenario60 = Scenario(number: "60", name: "Alchemy Lab", requirements: "\"Finding the Cure\" personal quest", goal: "Loot all treasure tiles, then all characters must escape through the entrance")
        let scenario61 = Scenario(number: "61", name: "Fading Lighthouse", requirements: "\"The Fall of Man\" personal quest", goal: "Loot all treasure tiles")
        let scenario62 = Scenario(number: "62", name: "Pit of Souls", requirements: "\"The Fall of Man\" personal quest", goal: "Kill the Hungry Soul")
        let scenario63 = Scenario(number: "63", name: "Magma Pit", requirements: "None", goal: "Kill all enemies")
        let scenario64 = Scenario(number: "64", name: "Underwater Lagoon", requirements: "Water-Breathing (Global) COMPLETE", goal: "Kill all enemies")
        let scenario65 = Scenario(number: "65", name: "Sulfur Mine", requirements: "None", goal: "Kill all enemies and loot all treasure tiles")
        let scenario66 = Scenario(number: "66", name: "Clockwork Cove", requirements: "None", goal: "Occupy pressure plate (e)")
        let scenario67 = Scenario(number: "67", name: "Arcane Library", requirements: "None", goal: "Kill the Arcane Golem")
        let scenario68 = Scenario(number: "68", name: "Toxic Moor", requirements: "None", goal: "Kill all enemies and protect the tree (a)")
        let scenario69 = Scenario(number: "69", name: "Well of the Unfortunate", requirements: "None", goal: "Bring the doll to the well (a)")
        let scenario70 = Scenario(number: "70", name: "Chained Isle", requirements: "None", goal: "Kill all demons")
        let scenario71 = Scenario(number: "71", name: "Windswept Highlands", requirements: "None", goal: "Loot all treasure tiles, then all characters must escape through the exit (a)")
        let scenario72 = Scenario(number: "72", name: "Oozing Grove", requirements: "None", goal: "Destroy all trees and kill all Oozes")
        let scenario73 = Scenario(number: "73", name: "Rockslide Ridge", requirements: "None", goal: "Kill all enemies and loot all treasure tiles")
        let scenario74 = Scenario(number: "74", name: "Merchant Ship", requirements: "High Sea Escort (Party) COMPLETE", goal: "Kill all enenemies and keep the ship afloat")
        let scenario75 = Scenario(number: "75", name: "Overgrown Graveyard", requirements: "Grave Job (Party) COMPLETE", goal: "Dig up all graves and kill the Bloated Regent")
        let scenario76 = Scenario(number: "76", name: "Harrower Hive", requirements: "Bravery", goal: "Reveal all rooms and kill all enemies")
        let scenario77 = Scenario(number: "77", name: "Vault of Secrets", requirements: "None", goal: "Loot all treasure tiles and kill all City Guards before the alarm is raised")
        let scenario78 = Scenario(number: "78", name: "Sacrifice Pit", requirements: "None", goal: "Kill all enemies and stop the sacrifice")
        let scenario79 = Scenario(number: "79", name: "Lost Temple", requirements: "Fish's Aid (Party) COMPLETE", goal: "Kill the Betrayer")
        let scenario80 = Scenario(number: "80", name: "Vigil Keep", requirements: "None", goal: "All Characters must loot one treasure tile and then escape")
        let scenario81 = Scenario(number: "81", name: "Temple of the Eclipse", requirements: "None", goal: "Kill the Colorless")
        let scenario82 = Scenario(number: "82", name: "Burning Mountain", requirements: "None", goal: "Sacrifice one artifact or escape with all artifacts")
        let scenario83 = Scenario(number: "83", name: "Shadows Within", requirements: "Bad Business (Party) COMPLETE", goal: "Kill all enemies")
        let scenario84 = Scenario(number: "84", name: "Crystalline Cave", requirements: "Tremors (Party) COMPLETE", goal: "Kill all enemies and protect the crystal (a)")
        let scenario85 = Scenario(number: "85", name: "Sun Temple", requirements: "None", goal: "Kill all enemies")
        let scenario86 = Scenario(number: "86", name: "Harried Village", requirements: "None", goal: "Save seven villagers before five are killed")
        let scenario87 = Scenario(number: "87", name: "Corrupted Cove", requirements: "The Poison's Source (Party) COMPLETE", goal: "Kill the Giant Ooze")
        let scenario88 = Scenario(number: "88", name: "Plane of Water", requirements: "Water-Breathing (Global) and Water Staff (Party) COMPLETE", goal: "Bring the Lurker King's claw to the crystal (a)")
        let scenario89 = Scenario(number: "89", name: "Syndicate Hideout", requirements: "Sin-Ra (Party) COMPLETE", goal: "Kill all enemies")
        let scenario90 = Scenario(number: "90", name: "Demonic Rift", requirements: "None", goal: "Close the rift")
        let scenario91 = Scenario(number: "91", name: "Wild Melee", requirements: "None", goal: "Kill all enemies")
        let scenario92 = Scenario(number: "92", name: "Back Alley Brawl", requirements: "Debt Collection (Party) COMPLETE", goal: "Kill all non-city enemies")
        let scenario93 = Scenario(number: "93", name: "Sunken Vessel", requirements: "A Map to Treasure (Party) COMPLETE", goal: "Kill all enemies")
        let scenario94 = Scenario(number: "94", name: "Vermling Nest", requirements: "None", goal: "Kill all enemies and loot the treasure tile")
        let scenario95 = Scenario(number: "95", name: "Payment Due", requirements: "Through the Nest (Party) COMPLETE", goal: "Kill the Prime Lieutenant")
        return [scenario1, scenario2, scenario3, scenario4, scenario5, scenario6, scenario7, scenario8, scenario9, scenario10, scenario11, scenario12, scenario13, scenario14, scenario15, scenario16, scenario17, scenario18, scenario19, scenario20, scenario21, scenario22, scenario23, scenario24, scenario25, scenario26, scenario27, scenario28, scenario29, scenario30, scenario31, scenario32, scenario33, scenario34, scenario35, scenario36, scenario37, scenario38, scenario39, scenario40, scenario41, scenario42, scenario43, scenario44, scenario45, scenario46, scenario47, scenario48, scenario49, scenario50, scenario51, scenario52, scenario53, scenario54, scenario55, scenario56, scenario57, scenario58, scenario59, scenario60, scenario61, scenario62, scenario63, scenario64, scenario65, scenario66, scenario67, scenario68, scenario69, scenario70, scenario71, scenario72, scenario73, scenario74, scenario75, scenario76, scenario77, scenario78, scenario79, scenario80, scenario81, scenario82, scenario83, scenario84, scenario85, scenario86, scenario87, scenario88, scenario89, scenario90, scenario91, scenario92, scenario93, scenario94, scenario95]
    }
    
    static func allScenarios() -> [Scenario] {
        return generateScenarios()
    }
    
    static func scenarioFromNumber(_ number: String) -> Scenario? {
        for scenario in Scenario.generateScenarios() {
            if scenario.number == number {
                return scenario
            }
        }
        return nil
    }
}
