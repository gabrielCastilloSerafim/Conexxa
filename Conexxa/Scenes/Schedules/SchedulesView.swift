//
//  SchedulesView.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 24/9/23.
//

import SwiftUI

struct SchedulesView: View {
    
    let viewModel: SchedulesViewModelProtocol
    
    init(viewModel: SchedulesViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        ZStack {
            
            backGround
        }
    }
}

private extension SchedulesView {
    
    var backGround: some View {
        ConexxaColor.white()
            .ignoresSafeArea(.all)
    }
}

struct SchedulesView_Previews: PreviewProvider {
    static var previews: some View {
        SchedulesView(viewModel: SchedulesViewModel())
    }
}
