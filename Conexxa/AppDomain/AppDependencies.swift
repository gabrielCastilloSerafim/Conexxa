//
//  AppDependencies.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 22/10/23.
//

import Foundation

class AppDependencies {
    
    private static var networkServiceDependency: NetworkServiceProtocol?
    private static var userDefaultsStorageDependency: UserDefaultsStorageProtocol?
    
    static var networkService: NetworkServiceProtocol {
        
        get {
            
            if let networkServiceDependency {
                return networkServiceDependency
            }
            
            let netowkServiceInstance = NetworkService(baseURL: URL(string: ProcessInfo.processInfo.environment["API_BASE_URL"]!)!)
            networkServiceDependency = netowkServiceInstance
            
            return netowkServiceInstance
        }
    }
    
    static var userDefaultsStorage: UserDefaultsStorageProtocol {
        
        get {
            
            if let userDefaultsStorageDependency {
                return userDefaultsStorageDependency
            }
            
            let userDefaultsStorageInstance = UserDefaultsStorage()
            userDefaultsStorageDependency = userDefaultsStorageInstance
            
            return userDefaultsStorageInstance
        }
    }
    
    
}
