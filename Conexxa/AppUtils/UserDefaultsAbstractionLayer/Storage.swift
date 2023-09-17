//
//  Storage.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 16/9/23.
//

import Foundation

struct Storage: AppStorageProtocol {
    
    @UserDefault(key: .onboardingSeenWithOption)
    var onboardingSeenWithOption: String?
    
}

extension Key {
    
    static let onboardingSeenWithOption: Key = "onboardingSeen"
}


protocol AppStorageProtocol {
    
    var onboardingSeenWithOption: String? { get set }
}
