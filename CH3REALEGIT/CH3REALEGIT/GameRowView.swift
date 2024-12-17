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

    var body: some View {
        HStack(spacing: 20) {
            ZStack {
                RoundedRectangle(cornerRadius: 0)
                    .stroke(Color.gray, lineWidth: 1)
                    .frame(width: 100, height: 100)
                
                Image(game.imageName)
                    .resizable()
                    .frame(width: 100, height: 100) // Slightly smaller game cover
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

                // Icons for Add and Favourite
                HStack(spacing: 15) {
                    Button(action: {
                        // Add action
                    }) {
                        Image(systemName: "plus")
                            .font(.body) // Smaller icon size
                            .foregroundColor(.blue)
                            .padding(8)
                            .background(Circle().stroke(Color.blue, lineWidth: 1))
                    }

                    Button(action: {
                        // Favourite action
                    }) {
                        Image(systemName: "star.fill")
                            .font(.body) // Smaller icon size
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
