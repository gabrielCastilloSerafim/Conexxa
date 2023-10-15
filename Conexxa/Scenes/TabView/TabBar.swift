//
//  TabBar.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 24/9/23.
//

import SwiftUI

struct TabBar: View {
    
    @EnvironmentObject var launchScreenManager: LaunchScreenManager
    @State var didFinishLaunch: Bool = false
    let needsToDismissLaunchScreen: Bool
    
    init (needsToDismissLaunchScreen: Bool = true) {
        self.needsToDismissLaunchScreen = needsToDismissLaunchScreen
    }
    
    var body: some View {
        
        TabView {
            
            homeRootView
            scheduleRootView
            favoritesRootView
            profileRootView
        }
        .navigationBarHidden(true)
        .opacity(didFinishLaunch ? 1 : 0)
        .onAppear {
            
            if needsToDismissLaunchScreen {
                performLaunchViewDismiss()
            }
            
            toggleDidFinishLaunch()
            setupDefaultAppearence()
        }
    }
}

private extension TabBar {
    
    // MARK: UIProperties
    
    var homeRootView: some View {
        
        HomeView()
            .tabItem {
                Label("home".localized, systemImage: "house")
            }
    }
    
    var scheduleRootView: some View {
        
        SchedulesView()
            .tabItem {
                Label("schedule".localized, systemImage: "calendar")
            }
    }
    
    var favoritesRootView: some View {
        
        FavoritesView()
            .tabItem {
                Label("favorites".localized, systemImage: "heart")
            }
    }
    
    var profileRootView: some View {
        
        ProfileView()
            .tabItem {
                Label("profile".localized, systemImage: "person")
            }
    }
    
    // MARK: Methods
    
    func performLaunchViewDismiss() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            launchScreenManager.dismiss()
        }
    }
    
    func toggleDidFinishLaunch() {
        
        let delayFactor = needsToDismissLaunchScreen ? 4.1 : 0.5
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delayFactor) {
            withAnimation(.easeInOut(duration: 0.45)) {
                didFinishLaunch.toggle()
            }
        }
    }
    
    func setupDefaultAppearence() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }
}

#Preview {
    TabBar()
        .environmentObject(LaunchScreenManager())
}
