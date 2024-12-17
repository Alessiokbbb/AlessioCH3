import SwiftUI
import UniformTypeIdentifiers

struct MainView: View {
    @State private var selectedConsoles: Set<String> = [] // Tracks selected consoles
    @State private var selectionMode: Bool = false // Selection mode toggle
    @State private var isShareSheetPresented = false // Share sheet state
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.largeTitle)
                        .padding(.leading)
                    Spacer()
                    Button(action: {
                        selectionMode.toggle()
                        if !selectionMode {
                            selectedConsoles.removeAll() // Clear selection when toggling off
                        }
                    }) {
                        Image(systemName: selectionMode ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(.blue)
                            .font(.largeTitle)
                            .padding(.trailing)
                    }
                }
                .padding(.top)

                ScrollView {
                    consoleSection(title: "Nintendo", consoles: [
                        ("DS", "dsimmagine", dsGames),
                        ("Wii", "wiiimmagine", wiiGames),
                        ("Switch", "switchimmagine", switchGames)
                    ])

                    consoleSection(title: "Altre", consoles: [
                        ("PSP/PSVita", "pspimmagine", pspGames),
                        ("PS4", "ps4immagine", ps4Games),
                        ("Steam", "steamimmagine", steamGames)
                    ])
                }
                .padding(.top)

                Spacer()

                Button(action: {
                    shareSelectedConsoles() // Share action for selected consoles
                }) {
                    Image(systemName: "square.and.arrow.up")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding()
                        .background(Circle().fill(Color.blue))
                        .shadow(radius: 5)
                }
                .disabled(selectedConsoles.isEmpty || !selectionMode)
                .padding(.bottom, 20)
            }
        }
    }
    
    // Function to build a section of consoles
    private func consoleSection(title: String, consoles: [(name: String, image: String, games: [Game])]) -> some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(title)
                .font(.title)
                .bold()
                .padding(.leading)
            HStack(spacing: 20) {
                ForEach(consoles, id: \.name) { console in
                    ZStack {
                        if selectionMode {
                            Button(action: {
                                toggleConsoleSelection(console.name)
                            }) {
                                ItemView(imageName: console.image, title: console.name)
                                    .opacity(selectedConsoles.contains(console.name) ? 0.5 : 1.0)
                                    .overlay(alignment: .topTrailing) {
                                        if selectedConsoles.contains(console.name) {
                                            Image(systemName: "checkmark.circle.fill")
                                                .foregroundColor(.green)
                                                .padding(5)
                                        }
                                    }
                            }
                        } else {
                            Button(action: {
                                shareConsole(console.name, games: console.games)
                            }) {
                                NavigationLink(destination: GameDetailsView(consoleName: console.name, games: console.games)) {
                                    ItemView(imageName: console.image, title: console.name)
                                }
                            }
                        }
                    }
                }
            }
        }
        .padding(.bottom, 10)
    }
    
    // Function to toggle selection state
    private func toggleConsoleSelection(_ console: String) {
        if selectedConsoles.contains(console) {
            selectedConsoles.remove(console)
        } else {
            selectedConsoles.insert(console)
        }
    }

    // Share selected consoles and their games
    private func shareSelectedConsoles() {
        let selectedData = buildGamesData(for: selectedConsoles)
        let tempURL = createTemporaryFile(with: selectedData)
        showShareSheet(with: tempURL)
    }

    // Share specific console and its games
    private func shareConsole(_ console: String, games: [Game]) {
        let consoleData = buildGamesData(for: [console], specificGames: games)
        let tempURL = createTemporaryFile(with: consoleData)
        showShareSheet(with: tempURL)
    }

    // Build the data for specific or selected consoles
    private func buildGamesData(for consoles: Set<String>, specificGames: [Game]? = nil) -> String {
        var result = "Selected Consoles and Games:\n\n"
        let allConsoles = [
            ("DS", dsGames),
            ("Wii", wiiGames),
            ("Switch", switchGames),
            ("PSP/PSVita", pspGames),
            ("PS4", ps4Games),
            ("Steam", steamGames)
        ]
        
        if let games = specificGames {
            result += "Games for Console:\n\n"
            for game in games {
                result += " - \(game.title) (\(game.genre))\n   Release Date: \(game.releaseDate)\n   Description: \(game.description)\n\n"
            }
            return result
        }
        
        for (console, games) in allConsoles where consoles.contains(console) {
            result += "Console: \(console)\n"
            for game in games {
                result += " - \(game.title) (\(game.genre))\n   Release Date: \(game.releaseDate)\n   Description: \(game.description)\n\n"
            }
            result += "\n"
        }
        return result
    }

    // Show share sheet with file URL
    private func showShareSheet(with fileURL: URL) {
        let activityViewController = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootVC = windowScene.windows.first?.rootViewController {
            rootVC.present(activityViewController, animated: true, completion: nil)
        }
    }

    // Create a temporary file with the content
    private func createTemporaryFile(with content: String) -> URL {
        let tempDirectory = FileManager.default.temporaryDirectory
        let fileURL = tempDirectory.appendingPathComponent("selected_consoles.txt")
        
        do {
            try content.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            print("Error writing file: \(error)")
        }
        return fileURL
    }
}



// Real game data
let dsGames = [
    Game(imageName: "pokemonblack", title: "Pokémon Black", genre: "RPG", releaseDate: "2009", description: "A classic RPG where you collect and train Pokémon to become a champion."),
    Game(imageName: "marioeluigi", title: "Mario & Luigi Bowser's Inside Story", genre: "RPG", releaseDate: "2009", description: "Join Mario and Luigi in an epic quest inside Bowser's body."),
    Game(imageName: "phoenixwright", title: "Phoenix Wright: Ace Attorney", genre: "Visual Novel", releaseDate: "2005", description: "A courtroom drama where you defend clients and uncover the truth."),
    Game(imageName: "zeldaspirit", title: "The Legend of Zelda: Spirit Tracks", genre: "Adventure", releaseDate: "2009", description: "An adventurous journey where Link explores dungeons using a magical train."),
    Game(imageName: "nintendogs", title: "Nintendogs", genre: "Simulation", releaseDate: "2005", description: "A pet simulation game where you raise and train virtual puppies."),
    Game(imageName: "proflayton", title: "Professor Layton and the Curious Village", genre: "Puzzle", releaseDate: "2007", description: "Solve mind-bending puzzles in an engaging mystery adventure."),
    Game(imageName: "kirbysuperstarultra", title: "Kirby Super Star Ultra", genre: "Platformer", releaseDate: "2008", description: "Help Kirby save Dream Land in a series of platforming challenges."),
    Game(imageName: "mariokartds", title: "Mario Kart DS", genre: "Racing", releaseDate: "2005", description: "Race with Mario and friends in exciting kart tracks."),
    Game(imageName: "animalcrossing", title: "Animal Crossing: Wild World", genre: "Simulation", releaseDate: "2005", description: "Live your best life in a charming animal-filled village."),
    Game(imageName: "dragonquestv", title: "Dragon Quest V", genre: "RPG", releaseDate: "2008", description: "Dragon Quest V: Hand of the Heavenly Bride follows the hero's life journey across generations, blending family, monster recruitment, and classic turn-based battles in a timeless JRPG.")
]

let wiiGames = [
    Game(imageName: "kirbyreturn", title: "Kirby's Return to Dream Land", genre: "Platformer", releaseDate: "2011", description: "Join Kirby and friends in a colorful platforming adventure."),
    Game(imageName: "donkeykongcountry", title: "Donkey Kong Country Returns", genre: "Platformer", releaseDate: "2010", description: "A side-scrolling platformer featuring Donkey Kong and Diddy Kong."),
    Game(imageName: "mariogalaxy", title: "Super Mario Galaxy", genre: "Platformer", releaseDate: "2007", description: "Explore galaxies and save Princess Peach in this 3D platformer."),
    Game(imageName: "smashbrawl", title: "Super Smash Bros. Brawl", genre: "Fighting", releaseDate: "2008", description: "Battle with Nintendo's iconic characters in epic matchups."),
    Game(imageName: "zeldatwilight", title: "The Legend of Zelda: Twilight Princess", genre: "Adventure", releaseDate: "2006", description: "Embark on a quest as Link to defeat evil and save Hyrule."),
    Game(imageName: "mariokartwii", title: "Mario Kart Wii", genre: "Racing", releaseDate: "2008", description: "Race with Mario and friends in classic and new tracks."),
    Game(imageName: "wiisportsresort", title: "Wii Sports Resort", genre: "Sports", releaseDate: "2009", description: "Enjoy sports activities in this motion-controlled game."),
    Game(imageName: "xenoblade", title: "Xenoblade Chronicles", genre: "RPG", releaseDate: "2010", description: "Embark on an epic RPG journey in a vast open world."),
    Game(imageName: "metroidm", title: "Metroid: Other M", genre: "Action", releaseDate: "2010", description: "Uncover Samus's past in this action-packed Metroid game."),
    Game(imageName: "punchout", title: "Punch-Out!!", genre: "Sports", releaseDate: "2009", description: "Step into the ring and fight as Little Mac to become a champion.")
]

let switchGames = [
    Game(imageName: "papermario", title: "Paper Mario: The Origami King", genre: "RPG", releaseDate: "2020", description: "Save the kingdom from the Origami King with Mario and friends."),
    Game(imageName: "smashbros", title: "Super Smash Bros. Ultimate", genre: "Fighting", releaseDate: "2018", description: "The ultimate brawler featuring a massive roster of characters."),
    Game(imageName: "marioodyssey", title: "Super Mario Odyssey", genre: "Platformer", releaseDate: "2017", description: "Join Mario on a globe-trotting adventure to save Princess Peach."),
    Game(imageName: "zeldabotw", title: "The Legend of Zelda: Breath of the Wild", genre: "Adventure", releaseDate: "2017", description: "Explore Hyrule in an open-world RPG adventure."),
    Game(imageName: "splatoon3", title: "Splatoon 3", genre: "Shooter", releaseDate: "2022", description: "Ink-splatting fun with team-based multiplayer battles."),
    Game(imageName: "mariokart8", title: "Mario Kart 8 Deluxe", genre: "Racing", releaseDate: "2017", description: "Race with updated tracks and characters in the ultimate kart game.")
]
         
         let pspGames = [
             Game(imageName: "gta", title: "Grand Theft Auto: Vice City Stories", genre: "Action", releaseDate: "2006", description: "Explore Vice City in an open-world action game."),
             Game(imageName: "persona4", title: "Persona 4 Golden", genre: "JRPG", releaseDate: "2012", description: "Unravel a murder mystery while building friendships in this JRPG."),
             Game(imageName: "kingdomhearts", title: "Kingdom Hearts: Birth by Sleep", genre: "Action RPG", releaseDate: "2010", description: "Discover the origins of the Kingdom Hearts saga."),
             Game(imageName: "godofwar", title: "God of War: Chains of Olympus", genre: "Action", releaseDate: "2008", description: "Experience Kratos' epic battles against the gods."),
             Game(imageName: "crisiscore", title: "Crisis Core: Final Fantasy VII", genre: "RPG", releaseDate: "2007", description: "Follow Zack Fair's story in the Final Fantasy VII universe."),
             Game(imageName: "ratchetclank", title: "Ratchet & Clank: Size Matters", genre: "Platformer", releaseDate: "2007", description: "Help Ratchet and Clank save the day in this portable adventure."),
             Game(imageName: "metalgearsolid", title: "Metal Gear Solid: Peace Walker", genre: "Stealth Action", releaseDate: "2010", description: "Join Snake on covert missions to stop a nuclear threat."),
             Game(imageName: "daxter", title: "Daxter", genre: "Platformer", releaseDate: "2006", description: "Play as Daxter in this fun spin-off of Jak and Daxter."),
             Game(imageName: "patapon", title: "Patapon", genre: "Rhythm", releaseDate: "2007", description: "Lead a tribe of warriors to victory through rhythm-based gameplay."),
             Game(imageName: "lumines", title: "Lumines", genre: "Puzzle", releaseDate: "2004", description: "Match blocks to the rhythm in this addictive puzzle game.")
         ]

         let ps4Games = [
             Game(imageName: "reddead", title: "Red Dead Redemption 2", genre: "Action Adventure", releaseDate: "2018", description: "Explore the Wild West in this epic open-world adventure."),
             Game(imageName: "persona5J", title: "Persona 5", genre: "JRPG", releaseDate: "2016", description: "Join the Phantom Thieves and change hearts in this stylish JRPG."),
             Game(imageName: "bloodborne", title: "Bloodborne", genre: "Soulslike", releaseDate: "2015", description: "Face terrifying beasts in a gothic horror world."),
             Game(imageName: "spiderman", title: "Marvel's Spider-Man", genre: "Action", releaseDate: "2018", description: "Swing through New York City as Spider-Man in this thrilling adventure."),
             Game(imageName: "godofwarps4", title: "God of War", genre: "Action Adventure", releaseDate: "2018", description: "Follow Kratos and Atreus on a mythological journey."),
             Game(imageName: "horizon", title: "Horizon Zero Dawn", genre: "RPG", releaseDate: "2017", description: "Uncover the mystery of a post-apocalyptic world ruled by machines."),
             Game(imageName: "uncharted4", title: "Uncharted 4: A Thief's End", genre: "Adventure", releaseDate: "2016", description: "Join Nathan Drake on his final treasure-hunting adventure."),
             Game(imageName: "lastofus2", title: "The Last of Us Part II", genre: "Action Adventure", releaseDate: "2020", description: "Experience a tale of revenge and survival in a post-apocalyptic world."),
             Game(imageName: "ff15", title: "Final Fantasy XV", genre: "JRPG", releaseDate: "2016", description: "Embark on a road trip adventure with Prince Noctis and his friends."),
             Game(imageName: "nioh", title: "Nioh", genre: "Soulslike", releaseDate: "2017", description: "Face challenging battles in a supernatural feudal Japan.")
         ]

         let steamGames = [
             Game(imageName: "cuphead", title: "Cuphead", genre: "Run & Gun", releaseDate: "2017", description: "Fight unique bosses in this hand-drawn, 1930s-inspired game."),
             Game(imageName: "hollowknight", title: "Hollow Knight", genre: "Metroidvania", releaseDate: "2017", description: "Explore a vast interconnected world in this challenging platformer."),
             Game(imageName: "balatro", title: "Balatro", genre: "Roguelike", releaseDate: "2023", description: "Master poker hands and cards in this roguelike deckbuilder."),
             Game(imageName: "eldenring", title: "Elden Ring", genre: "Soulslike", releaseDate: "2022", description: "Explore an open world filled with dangers and secrets."),
             Game(imageName: "stardewvalley", title: "Stardew Valley", genre: "Simulation", releaseDate: "2016", description: "Build your farm and relationships in this charming life sim."),
             Game(imageName: "celeste", title: "Celeste", genre: "Platformer", releaseDate: "2018", description: "Climb to the top of Celeste Mountain in this touching platformer."),
             Game(imageName: "valheim", title: "Valheim", genre: "Survival", releaseDate: "2021", description: "Explore and survive a vast Viking-inspired world."),
             Game(imageName: "terraria", title: "Terraria", genre: "Sandbox", releaseDate: "2011", description: "Dig, fight, and build in this 2D sandbox adventure."),
             Game(imageName: "factorio", title: "Factorio", genre: "Simulation", releaseDate: "2020", description: "Design and manage factory production lines."),
             Game(imageName: "portal2", title: "Portal 2", genre: "Puzzle", releaseDate: "2011", description: "Solve physics-based puzzles with portals in this humorous adventure.")
         ]



// Other games' data follows the same structure with appropriate descriptions and release dates.

#Preview {
    MainView()
}

