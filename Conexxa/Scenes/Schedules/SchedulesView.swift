//
//  SchedulesView.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 24/9/23.
//

import SwiftUI

struct SchedulesView: View {
    
    @StateObject private var vm = SchedulesViewModel()
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                backGround
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
}

#Preview {
    SchedulesView()
}
