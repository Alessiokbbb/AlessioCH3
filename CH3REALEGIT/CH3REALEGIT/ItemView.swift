//
//  ItemView.swift
//  CH3REALEGIT
//
//  Created by Alessio Capuano on 16/12/24.
//

import SwiftUI

struct ItemView: View {
    
    let imageName: String
    let title: String
    
    var body: some View {
        
        VStack{
            
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
            
            Text(title)
                .font(.headline)
                .foregroundColor(.black)
        }
        .frame(width: 100, height: 120)
        
    }
}

/*
#Preview {
    ItemView(imageName: "dsimmagine",
             title: "DS",
             goToView: EmptyView())
}
*/
