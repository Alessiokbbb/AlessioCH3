//
//  GameItemView.swift
//  CH3REALEGIT
//
//  Created by Alessio Capuano on 13/12/24.
//

import SwiftUI

struct GameItemView: View {
    let imageName: String
    let title: String
    let isCustomImage: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack {
                if isCustomImage {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                        .padding(12)
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                } else {
                    Image(systemName: imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                        .foregroundColor(.gray)
                        .padding(12)
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }

                Text(title)
                    .font(.headline)
                    .foregroundColor(.black)
            }
            .frame(width: 100, height: 120)
        }
    }
}
