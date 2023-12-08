//
//  OnboardingViewModel.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 16/9/23.
//

import Foundation

final class OnboardingViewModel: ObservableObject {
    
    @Published var registrationPickerPresentation: Bool = false
    @Published var registerNavigation: Bool = false
    @Published var loginNavigation: Bool = false
    @Published var userRegistrationType: UserRegistrationType?
    
    func didDismissRegistersModal() {
        
        guard userRegistrationType != nil else { return }
        registerNavigation.toggle()
    }
    
}
