//
//  OnboardingViewModel.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 16/9/23.
//

import Foundation

class OnboardingViewModel: ObservableObject {
    
    var appStorage: AppStorageProtocol
    
    init(appStorage: AppStorageProtocol) {
        self.appStorage = appStorage
    }
    
    func didSeeOnboardingWithSelectedOption(option: String) {
        
        appStorage.onboardingSeenWithOption = option
    }
}
