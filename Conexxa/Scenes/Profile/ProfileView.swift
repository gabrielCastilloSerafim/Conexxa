//
//  ProfileView.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 24/9/23.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var tabBarStateObject: TabBarState
    @StateObject private var vm: ProfileViewModel
    
    init(networkService: NetworkServiceProtocol) {
        
        _vm = StateObject(wrappedValue: ProfileViewModel(networkService: networkService))
    }
    
    var body: some View {
        
        ZStack {
            
            UIFactory.defaultBackground
            profileForm
            
        }
        .navigationTitle("profile".localized)
    }
}

private extension ProfileView {
    
    var profileForm: some View {
        
        Form {
            
            Button(action: {
                
                vm.performUserLogOut()
                tabBarStateObject.tabBarState = .none
                
            }, label: {
                Text("Log Out")
                    .foregroundStyle(.red)
            })
        }
        .padding(.top, 24)
    }
}

#Preview {
    ProfileView(networkService: NetworkService())
}
