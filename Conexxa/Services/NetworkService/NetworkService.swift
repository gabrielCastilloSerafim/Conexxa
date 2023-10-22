//
//  NetworkService.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 22/10/23.
//

import Foundation

class NetworkService: NetworkServiceProtocol {
    
    private let baseURL: URL
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    
}
