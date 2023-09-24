//
//  ConexxaApp.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 10/9/23.
//

import SwiftUI

@main
struct ConexxaApp: App {
    
    @StateObject var launchScreenManager = LaunchScreenManager()
    
    var body: some Scene {
        
        WindowGroup {
            
            ZStack {
                
                switch Storage().onboardingSeenWithOption {
                    
                case Constants.APP_GUEST_MODE:
                    
                    TabBar()
                    
                case Constants.APP_LOGGED_IN_CONTRACTOR:
                    
                    TabBar()
                    
                case Constants.APP_LOGGED_IN_MUSICIAN:
                    
                    TabBar()
                    
                default:
                    
                    OnboardingBuilder.buildView()
                }
                
                if launchScreenManager.state != .completed {
                    LaunchScreenView()
                }
            }
            .environmentObject(launchScreenManager)
        }
    }
}
