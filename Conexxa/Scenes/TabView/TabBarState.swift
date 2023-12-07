//
//  TabBarState.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 3/12/23.
//

import Foundation

class TabBarState: ObservableObject {
    
    @Published var tabBarState: TabBarStates?
    
    init(tabBarState: TabBarStates?) {
        self.tabBarState = tabBarState
    }
}

enum TabBarStates {
    
    case guest
    case loggedMusician
    case loggedContractor
}
