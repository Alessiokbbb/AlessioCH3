//
//  CirclebuttonView.swift
//  CH3REALEGIT
//
//  Created by Alessio Capuano on 13/12/24.
//
import SwiftUI

struct CircleButtonView: View {
    var body: some View {
        Image(systemName: "circle")
            .font(.largeTitle)
            .foregroundColor(.gray)
            .padding()
            .background(Circle().fill(Color(.systemGray5)))
    }
}
import Foundation
