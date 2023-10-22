//
//  ConexxaEmptyScreen.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 22/10/23.
//

import SwiftUI

struct ConexxaEmptyScreen: View {
    
    let image: Image
    let imageColor: Color
    let title: String
    let subtitle: String
    
    var body: some View {
        
        VStack {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
                .foregroundStyle(imageColor)
                .padding(.bottom, 20)
            
            Text(title)
                .multilineTextAlignment(.center)
                .font(.system(size: 19, weight: .bold))
                .padding(.bottom, 10)
            
            Text(subtitle)
                .multilineTextAlignment(.center)
                .font(.system(size: 13, weight: .thin))
                .frame(width: 200)
        }
    }
}

#Preview {
    ConexxaEmptyScreen(
        image: Image(systemName: "star.fill"),
        imageColor: ConexxaColor.yellow(),
        title: "Title",
        subtitle: "Subtile Subtile Subtile Subtile Subtile Subtile Subtile")
}
