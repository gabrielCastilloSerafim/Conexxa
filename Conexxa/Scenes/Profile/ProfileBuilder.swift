//
//  ProfileBuilder.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 24/9/23.
//

import SwiftUI

class ProfileBuilder {
    
    static func buildView(profileViewModel: ProfileViewModelProtocol = ProfileViewModel()) -> some View {
        
        ProfileView(viewModel: profileViewModel)
    }
}
