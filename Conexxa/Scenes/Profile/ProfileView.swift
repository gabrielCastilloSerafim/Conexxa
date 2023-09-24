//
//  ProfileView.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 24/9/23.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject private var vm = ProfileViewModel()
    
    var body: some View {
        
        ZStack {
            
            backGround
        }
    }
}

private extension ProfileView {
    
    var backGround: some View {
        ConexxaColor.white()
            .ignoresSafeArea(.all)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
