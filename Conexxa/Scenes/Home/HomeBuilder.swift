//
//  HomeBuilder.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 24/9/23.
//

import SwiftUI

class HomeBuilder {
    
    static func buildView(homeViewModel: HomeViewModelProtocol = HomeViewModel()) -> some View {
        
        HomeView(viewModel: homeViewModel)
    }
}
