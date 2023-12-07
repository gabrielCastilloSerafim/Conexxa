//
//  TabBar.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 24/9/23.
//

import SwiftUI

struct TabBar: View {
    
    @StateObject var tabBarState: TabBarState
    @AppStorage(Constants.CURRENT_USER_LOGIN_STATE) var currentUserLoginState: String?
    
    init () {
        
        switch UserDefaults.standard.string(forKey: Constants.CURRENT_USER_LOGIN_STATE) {
            
        case Constants.APP_GUEST_MODE:
            
            _tabBarState = StateObject(wrappedValue: TabBarState(tabBarState: .guest))
            
        case Constants.APP_LOGGED_IN_CONTRACTOR:
            
            _tabBarState = StateObject(wrappedValue: TabBarState(tabBarState: .loggedContractor))
            
        case Constants.APP_LOGGED_IN_MUSICIAN:
            
            _tabBarState = StateObject(wrappedValue: TabBarState(tabBarState: .loggedMusician))
            
        default:
            
            _tabBarState = StateObject(wrappedValue: TabBarState(tabBarState: nil))
        }
        
        setupDefaultAppearence()
    }
    
    var body: some View {
        
        TabView(selection: .constant(TabBarItems.home.rawValue)) {
            
            switch tabBarState.tabBarState {
                
            case .guest:
                
                // Configure tab bar for guest mode
                homeRootView
                scheduleRootView
                favoritesRootView
                profileRootView
                
            case .loggedMusician:
                
                // Configure tab bar for contractor mode
                homeRootView
                scheduleRootView
                favoritesRootView
                profileRootView
                
            case .loggedContractor:
                
                // Configure tab bar for musician mode
                homeRootView
                scheduleRootView
                favoritesRootView
                profileRootView
                
            default:
                
                // User did not see onboarding yet present it
                onboardingView
            }
        }
        .environmentObject(tabBarState)
    }
}

private extension TabBar {
    
    // MARK: UIProperties
    
    var onboardingView: some View {
        
        NavigationStack {
            OnboardingView()
        }
    }
    
    var homeRootView: some View {
        
        NavigationStack {
            HomeView(networkService: NetworkService())
        }
        .tabItem {
            Label("home".localized, systemImage: "house")
        }
        .tag(TabBarItems.home.rawValue)
    }
    
    var scheduleRootView: some View {
        
        NavigationStack {
            SchedulesView(networkService: NetworkService())
        }
        .tabItem {
            Label("schedule".localized, systemImage: "calendar")
        }
        .tag(TabBarItems.bookings.rawValue)
    }
    
    var favoritesRootView: some View {
        
        NavigationStack {
            FavoritesView(networkService: NetworkService())
        }
        .tabItem {
            Label("favorites".localized, systemImage: "heart")
        }
        .tag(TabBarItems.favorites.rawValue)
    }
    
    var profileRootView: some View {
        
        NavigationStack {
            ProfileView(networkService: NetworkService())
        }
        .tabItem {
            Label("profile".localized, systemImage: "person")
        }
        .tag(TabBarItems.profile.rawValue)
    }
    
    // MARK: Methods
    
    func setupDefaultAppearence() {
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }
}

#Preview {
    TabBar()
}
