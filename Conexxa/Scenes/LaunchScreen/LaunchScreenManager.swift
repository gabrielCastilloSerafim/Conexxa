//
//  LaunchScreenManager.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 17/9/23.
//

import Foundation

enum LaunchScreenPhases {
    case first
    case second
    case completed
}

final class LaunchScreenManager: ObservableObject {
    
    @Published private(set) var state: LaunchScreenPhases = .first
    
    func dismiss() {
        
        self.state = .second
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            self.state = .completed
        }
    }
}
