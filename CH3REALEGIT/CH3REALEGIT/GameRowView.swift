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
    
    // MODIFICA: Parametri per la selezione del gioco
    let isSelected: Bool
    let onToggleSelection: () -> Void

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

                HStack(spacing: 15) {
                    // MODIFICA: Pulsante per selezionare/deselezionare il gioco
                    Button(action: {
                        onToggleSelection()
                    }) {
                        Image(systemName: isSelected ? "checkmark.circle.fill" : "plus")
                            .font(.body)
                            .foregroundColor(isSelected ? .green : .blue)
                            .padding(8)
                            .background(Circle().stroke(isSelected ? Color.green : Color.blue, lineWidth: 1))
                    }

                    Button(action: {
                        // Azione preferiti futura
                    }) {
                        Image(systemName: "star.fill")
                            .font(.body)
                            .foregroundColor(.yellow)
                            .padding(8)
                            .background(Circle().stroke(Color.yellow, lineWidth: 1))
                    }
                }
            }

            Spacer()
        }
        .padding()
    }
}
