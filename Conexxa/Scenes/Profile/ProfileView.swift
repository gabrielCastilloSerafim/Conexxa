//
//  ProfileView.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 24/9/23.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject private var vm: ProfileViewModel
    
    init(networkService: NetworkServiceProtocol) {
        
        _vm = StateObject(wrappedValue: ProfileViewModel(networkService: networkService))
    }
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                backGround
            }
            .navigationTitle("profile".localized)
        }
    }
}

private extension ProfileView {
    
    var backGround: some View {
        ConexxaColor.dirtyWhite()
            .ignoresSafeArea(.all)
    }
}

#Preview {
    ProfileView(networkService: AppDependencies.networkService)
}
