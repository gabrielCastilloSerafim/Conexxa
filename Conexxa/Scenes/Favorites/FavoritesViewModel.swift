//
//  FavoritesViewModel.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 24/9/23.
//

import Foundation

@MainActor
final class FavoritesViewModel: ObservableObject {
    
    let networkService: NetworkServiceProtocol
    @Published var screenState: FavoritesScreenState = .emptyScreen
    
    init(networkService: NetworkServiceProtocol) {
        
        self.networkService = networkService
    }
}
