//
//  gameviewerview.swift
//  CH3REALEGIT
//
//  Created by Alessio Capuano on 16/12/24.
//

import SwiftUI

struct gameviewerview: View {
    
    var game : Game
    
    var body: some View {
        
        
        VStack{
           
            
            Text(game.title)
                .font(.largeTitle)
                .padding()
            Image(game.imageName)
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .frame(width: 300, height: 300)
                .scaledToFill()
                
                
            
            Text(game.genre)
        
                .padding()
            
        }
        .padding()
        .background(.gray.opacity(0.2))
        .containerShape(RoundedRectangle(cornerRadius: 20))
    }
}
/*
#Preview {
    gameviewerview()
}
*/
