//
//  FavoritesView.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 24/9/23.
//

import SwiftUI

struct FavoritesView: View {
    
    @StateObject private var vm: FavoritesViewModel
    
    init(networkService: NetworkServiceProtocol) {
        
        _vm = StateObject(wrappedValue: FavoritesViewModel(networkService: networkService))
    }
    
    var body: some View {
        
        ZStack {
            
            UIFactory.defaultBackground
            
            emptyScreen
                .opacity( vm.screenState == .emptyScreen ? 1 : 0)
        }
        .navigationTitle("favorites".localized)
    }
    
}

private extension FavoritesView {
    
    var emptyScreen: some View {
        
        ConexxaEmptyScreen(
            image: Image(systemName: "heart.fill"),
            imageColor: ConexxaColor.red(),
            title: "noFavorites".localized,
            subtitle: "noFavoritesExplanation".localized)
    }
}

#Preview {
    FavoritesView(networkService: NetworkService())
}
