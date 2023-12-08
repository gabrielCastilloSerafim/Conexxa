//
//  ProfileViewModel.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 24/9/23.
//

import Foundation

@MainActor
final class ProfileViewModel: ObservableObject {
    
    let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        
        self.networkService = networkService
    }
    
    func performUserLogOut() {
        
        UserDefaults.standard.setValue(nil, forKey: Constants.JWT)
        UserDefaults.standard.setValue(nil, forKey: Constants.JWT_UNIX_EXPIRATION_TIME_STAMP)
        UserDefaults.standard.setValue(nil, forKey: Constants.CURRENT_USER_LOGIN_STATE)
    }
}
