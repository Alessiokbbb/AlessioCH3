//
//  ContentView.swift
//  CH3REALEGIT
//
//  Created by Alessio Capuano on 10/12/24.
//

import SwiftUI

import Foundation
struct Game: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let genre: String
    let releaseDate: String
    let description: String
}

struct ContentView: View {
    var body: some View {
        NavigationStack {
            MainView()
        }
    }
}
