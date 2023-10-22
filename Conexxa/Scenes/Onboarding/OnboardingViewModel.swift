//
//  OnboardingViewModel.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 16/9/23.
//

import Foundation

class OnboardingViewModel: ObservableObject {
    
    var userDefaultsStaorage: UserDefaultsStorageProtocol
    
    init(userDefaultsStaorage: UserDefaultsStorageProtocol) {
        
        self.userDefaultsStaorage = userDefaultsStaorage
    }
    
    func didSeeOnboardingWithSelectedOption(option: String) {
        
        userDefaultsStaorage.onboardingSeenWithOption = option
    }
}
