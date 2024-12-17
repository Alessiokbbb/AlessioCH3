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
    
    var body: some View {
        NavigationStack {
            VStack {
                // Custom Back Button Styled Like System Default
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
                
                // Console Title
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
                                GameRowView(game: game)
                            }
                            Divider()
                        }
                    }
                    .padding()
                }
                
                Spacer()
                
                // Share Button
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
            .toolbar(.hidden, for: .navigationBar) // Hide default navigation bar
        }
    }
    
    // Share Function to Create and Share Games Data
    private func shareGames() {
        let gamesData = buildGamesData()
        let tempURL = createTemporaryFile(with: gamesData)
        let activityViewController = UIActivityViewController(activityItems: [tempURL], applicationActivities: nil)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootVC = windowScene.windows.first?.rootViewController {
            rootVC.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    // Build Data String for Games
    private func buildGamesData() -> String {
        var result = "Games for \(consoleName):\n\n"
        for game in games {
            result += "**\(game.title.uppercased())**:\n-(\(game.genre))\n-(\(game.description))\n-(\(game.releaseDate))\n\n"
        }

        return result
    }
    
    // Create Temporary File with Content
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
