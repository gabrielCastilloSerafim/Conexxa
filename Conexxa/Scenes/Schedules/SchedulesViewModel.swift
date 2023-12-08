//
//  SchedulesViewModel.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 24/9/23.
//

import Foundation

@MainActor
final class SchedulesViewModel: ObservableObject {
    
    let networkService: NetworkServiceProtocol
    @Published var screenState: ScheduleScreenState = .emptyScreen
    
    init(networkService: NetworkServiceProtocol) {
        
        self.networkService = networkService
    }
}
