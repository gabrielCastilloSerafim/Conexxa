//
//  OnboardingView.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 10/9/23.
//

import SwiftUI

// ProcessInfo.processInfo.environment["API_BASE_URL"]

struct OnboardingView: View {
    
    let viewModel: OnboardingViewModelProtocol
    
    init(viewModel: OnboardingViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(viewModel: OnboardingViewModel(appStorage: Storage(), router: OnboardingBuilder()))
    }
}
