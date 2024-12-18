//
//  GameRowView.swift
//  CH3REALEGIT
//
//  Created by Alessio Capuano on 13/12/24.
//

//
//  GameRowView.swift
//  CH3REALEGIT
//
//  Created by Alessio Capuano on 13/12/24.
//

import Foundation
import SwiftUI

struct GameRowView: View {
    let game: Game
    let isSelected: Bool
    let onToggleSelection: () -> Void
    let onFavoriteToggle: () -> Void
    let isFavorite: Bool       // MODIFICA: Per sapere se il gioco è tra i preferiti
    let showControls: Bool     // MODIFICA: Per mostrare o nascondere i pulsanti

    var body: some View {
        HStack(spacing: 20) {
            ZStack {
                RoundedRectangle(cornerRadius: 0)
                    .stroke(Color.gray, lineWidth: 1)
                    .frame(width: 100, height: 100)

                Image(game.imageName)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .scaledToFill()
                    .containerShape(RoundedRectangle(cornerRadius: 12))
            }
            VStack(alignment: .leading, spacing: 10) {
                Text(game.title)
                    .font(.headline)
                    .foregroundColor(.black)

                Text(game.genre)
                    .font(.subheadline)
                    .foregroundColor(.gray)

                if showControls {
                    HStack(spacing: 15) {
                        Button(action: {
                            onToggleSelection()
                        }) {
                            Image(systemName: isSelected ? "checkmark.circle.fill" : "plus")
                                .font(.body)
                                .foregroundColor(isSelected ? .green : .blue)
                                .padding(8)
                                .background(Circle().stroke(isSelected ? Color.green : Color.blue, lineWidth: 1))
                        }

                        // Se il gioco è nei preferiti, mostra star.fill gialla, altrimenti star grigia
                        Button(action: {
                            onFavoriteToggle()
                        }) {
                            Image(systemName: isFavorite ? "star.fill" : "star")
                                .font(.body)
                                .foregroundColor(isFavorite ? .yellow : .gray)
                                .padding(8)
                                .background(Circle().stroke(isFavorite ? Color.yellow : Color.gray, lineWidth: 1))
                        }
                    }
                }
            }
            Spacer()
        }
        .padding()
    }
}


