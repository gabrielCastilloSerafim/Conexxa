//
//  OnboardingViewModel.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 16/9/23.
//

import Foundation

protocol OnboardingViewModelProtocol {
    
    var appStorage: AppStorageProtocol { get }
    var router: OnboardingBuilder { get } 
    
    func didSeeOnboardingWithSelectedOption(option: String)
}

class OnboardingViewModel: OnboardingViewModelProtocol {
    
    var appStorage: AppStorageProtocol
    let router: OnboardingBuilder
    
    init(appStorage: AppStorageProtocol, router: OnboardingBuilder) {
        
        self.appStorage = appStorage
        self.router = router
    }
    
    func didSeeOnboardingWithSelectedOption(option: String) {
        
        appStorage.onboardingSeenWithOption = option
    }
}
