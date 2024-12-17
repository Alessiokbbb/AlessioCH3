//
//  HeaderView.swift
//  CH3REALEGIT
//
//  Created by Alessio Capuano on 13/12/24.
import SwiftUI

struct HeaderView: View {
    let title: String
    let dismissAction: () -> Void

    var body: some View {
        HStack {
            Button(action: dismissAction) {
                Image(systemName: "arrow.left")
                    .font(.title)
                    .foregroundColor(.gray)
            }

            Spacer()

            Text(title)
                .font(.title2)
                .bold()
                .foregroundColor(.black)

            Spacer()
        }
        .padding()
    }
}
