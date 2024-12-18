//
//  FavouriteView.swift
//  CH3REALEGIT
//
//  Created by Alessio Capuano on 18/12/24.
//

import SwiftUI

struct FavoritesView: View {
    @Binding var favorites: [Game]
    @Environment(\.dismiss) var dismiss

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

                Text("Favourite games")
                    .font(.largeTitle)
                    .bold()
                    .padding()

                if favorites.isEmpty {
                    // MODIFICA: Mostra un testo "carino" quando non ci sono preferiti
                    VStack(spacing: 20) {
                        Image(systemName: "star")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.gray)
                        Text("No games added yet")
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    Spacer()
                } else {
                    // Lista dei giochi preferiti
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 20) {
                            ForEach(favorites) { game in
                                HStack {
                                    NavigationLink {
                                        gameviewerview(game: game)
                                    } label: {
                                        GameRowView(
                                            game: game,
                                            isSelected: false,
                                            onToggleSelection: {},
                                            onFavoriteToggle: {},
                                            isFavorite: true,
                                            showControls: false
                                        )
                                    }
                                    Button(action: {
                                        removeFavorite(game)
                                    }) {
                                        Image(systemName: "trash")
                                            .foregroundColor(.red)
                                            .padding()
                                    }
                                }
                                Divider()
                            }
                        }
                        .padding()
                    }

                    Spacer()

                    Button(action: {
                        shareFavorites()
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
            }
            .toolbar(.hidden, for: .navigationBar)
        }
    }

    private func removeFavorite(_ game: Game) {
        if let index = favorites.firstIndex(where: { $0.id == game.id }) {
            favorites.remove(at: index)
        }
    }

    private func shareFavorites() {
        let data = buildFavoritesData()
        let tempURL = createTemporaryFile(with: data)
        let activityViewController = UIActivityViewController(activityItems: [tempURL], applicationActivities: nil)
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootVC = windowScene.windows.first?.rootViewController {
            rootVC.present(activityViewController, animated: true, completion: nil)
        }
    }

    private func buildFavoritesData() -> String {
        var result = "Favorites:\n\n"
        for game in favorites {
            result += "**\(game.title.uppercased())**:\n-(\(game.genre))\n-(\(game.description))\n-(\(game.releaseDate))\n\n"
        }
        return result
    }

    private func createTemporaryFile(with content: String) -> URL {
        let tempDirectory = FileManager.default.temporaryDirectory
        let fileURL = tempDirectory.appendingPathComponent("favorites_games.txt")
        do {
            try content.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            print("Error writing file: \(error)")
        }
        return fileURL
    }
}
