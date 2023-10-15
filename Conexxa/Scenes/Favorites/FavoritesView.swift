//
//  FavoritesView.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 24/9/23.
//

import SwiftUI

struct FavoritesView: View {
    
    @StateObject private var vm = FavoritesViewModel()
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                backGround
            }
            .navigationTitle("favorites".localized)
        }
    }
}

private extension FavoritesView {
    
    var backGround: some View {
        ConexxaColor.dirtyWhite()
            .ignoresSafeArea(.all)
    }
}

#Preview {
    FavoritesView()
}
