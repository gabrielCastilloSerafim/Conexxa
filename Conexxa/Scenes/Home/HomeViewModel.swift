//
//  HomeViewModel.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 24/9/23.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    
    let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
    @Published var bestRankedBands: [Band] = []
    @Published var selectedArtistStyle: ArtistStyle = .band
    @Published var selectedWorkArea: WorkAreas = .zonaNorte
    @Published var selectedDayPeriod: DayPeriod = .night
    @Published var selectedMusicalStyle: MusicalStyle = .rock
    @Published var selectedDate: Date = Date.now
    @Published var region: String = ""
    
    func getBestRankedBands() {
        
        let mockBandsArray = [
            Band(name: "Euforia Casual", rating: 5, image: "bandImage"),
            Band(name: "Euforia Casual", rating: 5, image: "bandImage"),
            Band(name: "Euforia Casual", rating: 5, image: "bandImage"),
            Band(name: "Euforia Casual", rating: 5, image: "bandImage"),
            Band(name: "Euforia Casual", rating: 5, image: "bandImage"),
        ]
        
        bestRankedBands.append(contentsOf: mockBandsArray)
    }
    
    func didChangeArtistStyle(_ artistStyle: ArtistStyle) {
        
        selectedArtistStyle = artistStyle
        impactFeedbackGenerator.impactOccurred()
        
        
    }
}
