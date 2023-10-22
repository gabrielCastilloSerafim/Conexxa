//
//  ProfileViewModel.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 24/9/23.
//

import Foundation

class ProfileViewModel: ObservableObject {
    
    let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        
        self.networkService = networkService
    }
    
}
