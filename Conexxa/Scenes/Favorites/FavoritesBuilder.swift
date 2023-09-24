//
//  FavoritesBuilder.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 24/9/23.
//

import SwiftUI

class FavoritesBuilder {
    
    static func buildView(favoritesViewModel: FavoritesViewModelProtocol = FavoritesViewModel()) -> some View {
        
        FavoritesView(viewModel: favoritesViewModel)
    }
}
