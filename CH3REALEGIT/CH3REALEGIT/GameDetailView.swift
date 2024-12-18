//
//  GameDetailView.swift
//  CH3REALEGIT
//
//  Created by Alessio Capuano on 13/12/24.
//

import SwiftUI

struct GameDetailsView: View {
    let consoleName: String
    let games: [Game]
    @Environment(\.dismiss) var dismiss

    @State private var selectedGames = Set<UUID>()

    let onFavoriteToggle: (Game) -> Void
    let isFavorite: (Game) -> Bool // MODIFICA: closure per controllare se un gioco è preferito

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Button(action: { dismiss() }) {
                        HStack {
                            Image(systemName: "chevron.left")
                                .font(.title2)
                                .foregroundColor(.blue)
                            Text("Back")
                                .font(.body)
                                .foregroundColor(.blue)
                        }
                    }
                    Spacer()
                }
                .padding()

                Text(consoleName)
                    .font(.largeTitle)
                    .bold()
                    .padding()

                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20) {
                        ForEach(games) { game in
                            NavigationLink {
                                gameviewerview(game: game)
                            } label: {
                                GameRowView(
                                    game: game,
                                    isSelected: selectedGames.contains(game.id),
                                    onToggleSelection: {
                                        if selectedGames.contains(game.id) {
                                            selectedGames.remove(game.id)
                                        } else {
                                            selectedGames.insert(game.id)
                                        }
                                    },
                                    onFavoriteToggle: {
                                        onFavoriteToggle(game)
                                    },
                                    isFavorite: isFavorite(game),    // MODIFICA
                                    showControls: true               // MODIFICA: qui si vedono i controlli
                                )
                            }
                            Divider()
                        }
                    }
                    .padding()
                }

                Spacer()

                Button(action: {
                    shareGames()
                }) {
                    Image(systemName: "square.and.arrow.up")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding()
                        .background(Circle().fill(Color.blue))
                        .shadow(radius: 5)
                }
                .padding(.bottom, 20)
            }
            .toolbar(.hidden, for: .navigationBar)
        }
    }

    private func buildGamesData() -> String {
        let filteredGames = selectedGames.isEmpty ? games : games.filter { selectedGames.contains($0.id) }

        var result = "Games for \(consoleName):\n\n"
        for game in filteredGames {
            result += "**\(game.title.uppercased())**:\n-(\(game.genre))\n-(\(game.description))\n-(\(game.releaseDate))\n\n"
        }

        return result
    }

    private func shareGames() {
        let gamesData = buildGamesData()
        let tempURL = createTemporaryFile(with: gamesData)
        let activityViewController = UIActivityViewController(activityItems: [tempURL], applicationActivities: nil)

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootVC = windowScene.windows.first?.rootViewController {
            rootVC.present(activityViewController, animated: true, completion: nil)
        }
    }

    private func createTemporaryFile(with content: String) -> URL {
        let tempDirectory = FileManager.default.temporaryDirectory
        let fileURL = tempDirectory.appendingPathComponent("\(consoleName)_games.txt")

        do {
            try content.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            print("Error writing file: \(error)")
        }
        return fileURL
    }
}
