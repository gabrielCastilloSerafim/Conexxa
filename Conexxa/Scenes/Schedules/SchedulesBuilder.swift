//
//  SchedulesBuilder.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 24/9/23.
//

import SwiftUI

class SchedulesBuilder {
    
    static func buildView(schedulesViewModel: SchedulesViewModelProtocol = SchedulesViewModel()) -> some View {
        
        SchedulesView(viewModel: schedulesViewModel)
    }
}

