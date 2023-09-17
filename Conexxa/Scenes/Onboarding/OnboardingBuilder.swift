//
//  OnboardingRouter.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 16/9/23.
//

import SwiftUI

class OnboardingBuilder {
    
    static func buildView(
        onboardingViewModel: OnboardingViewModel = OnboardingViewModel(
            appStorage: Storage(),
            router: OnboardingBuilder())) -> some View {
        
        OnboardingView(viewModel: onboardingViewModel)
    }
    
    
}
