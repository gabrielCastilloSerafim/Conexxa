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
        .opacity(didFinishLaunch ? 1 : 0)
        .onAppear {
            
            if needsToDismissLaunchScreen {
                performLaunchViewDismiss()
            }
            
            toggleDidFinishLaunch()
        }
    }
}

private extension TabBar {
    
    // MARK: UIProperties
    
    var homeRootView: some View {
        
        NavigationStack {
            HomeBuilder.buildView()
        }
        .tabItem {
            Label("home".localized, systemImage: "house")
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    var scheduleRootView: some View {
        
        NavigationStack {
            SchedulesBuilder.buildView()
                .navigationTitle("schedule".localized)
        }
        .tabItem {
            Label("schedule".localized, systemImage: "calendar")
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    var favoritesRootView: some View {
        
        NavigationStack {
            FavoritesBuilder.buildView()
                .navigationTitle("favorites".localized)
        }
        .tabItem {
            Label("favorites".localized, systemImage: "heart")
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    var profileRootView: some View {
        
        NavigationStack {
            ProfileBuilder.buildView()
                .navigationTitle("profile".localized)
        }
        .tabItem {
            Label("profile".localized, systemImage: "person")
        }
        .toolbar(.hidden, for: .navigationBar)
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
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
            .environmentObject(LaunchScreenManager())
    }
}
