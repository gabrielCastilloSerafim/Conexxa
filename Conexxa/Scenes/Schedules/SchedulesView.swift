//
//  SchedulesView.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 24/9/23.
//

import SwiftUI

struct SchedulesView: View {
    
    @StateObject private var vm: SchedulesViewModel
    
    init(networkService: NetworkServiceProtocol) {
        
        _vm = StateObject(wrappedValue: SchedulesViewModel(networkService: networkService))
    }
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                backGround
                
                emptyScreen
                    .opacity( vm.screenState == .emptyScreen ? 1 : 0)
                
            }
            .navigationTitle("schedule".localized)
        }
    }
}

private extension SchedulesView {
    
    var backGround: some View {
        ConexxaColor.dirtyWhite()
            .ignoresSafeArea(.all)
    }
    
    var emptyScreen: some View {
        
        ConexxaEmptyScreen(
            image: Image(systemName: "calendar"),
            imageColor: ConexxaColor.blue(),
            title: "noBookings".localized,
            subtitle: "noBookingsExplanation".localized)
    }
}

#Preview {
    SchedulesView(networkService: AppDependencies.networkService)
}
