//
//  BandDetailsViewModel.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 22/10/23.
//

import Foundation

class BandDetailsViewModel: ObservableObject {
    
    let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        
        self.networkService = networkService
    }
}
