//
//  FavoritesView.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 24/9/23.
//

import SwiftUI

struct FavoritesView: View {
    
    let viewModel: FavoritesViewModelProtocol
    
    init(viewModel: FavoritesViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        ZStack {
            
            backGround
        }
    }
}

private extension FavoritesView {
    
    var backGround: some View {
        ConexxaColor.white()
            .ignoresSafeArea(.all)
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView(viewModel: FavoritesViewModel())
    }
}