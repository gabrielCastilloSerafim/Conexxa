//
//  OnboardingViewModel.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 16/9/23.
//

import Foundation

protocol OnboardingViewModelProtocol {
    
    var appStorage: AppStorageProtocol { get }
    
    func didSeeOnboardingWithSelectedOption(option: String)
}

class OnboardingViewModel: OnboardingViewModelProtocol {
    
    var appStorage: AppStorageProtocol
    
    init(appStorage: AppStorageProtocol) {
        self.appStorage = appStorage
    }
    
    func didSeeOnboardingWithSelectedOption(option: String) {
        
        appStorage.onboardingSeenWithOption = option
    }
}
