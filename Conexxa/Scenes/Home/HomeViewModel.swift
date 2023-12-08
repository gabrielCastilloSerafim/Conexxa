//
//  HomeViewModel.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 24/9/23.
//

import SwiftUI

@MainActor
final class HomeViewModel: ObservableObject {
    
    let networkService: NetworkServiceProtocol
    let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
    @Published var bestRankedBands: [Band] = []
    @Published var selectedArtistStyle: ArtistStyle = .band
    @Published var selectedWorkArea: WorkAreas = .zonaNorte
    @Published var selectedDayPeriod: DayPeriod = .night
    @Published var selectedMusicalStyle: MusicalStyle = .rock
    @Published var selectedDate: Date = Date.now
    
    init(networkService: NetworkServiceProtocol) {
        
        self.networkService = networkService
    }
    
    func getBestRankedBands() {
        
        let mockBandsArray = [
            Band(
                name: "Euforia Casual",
                rating: 4,
                bandImages: [
                    bandImage(image: Image("bandImage")),
                    bandImage(image: Image("bandImage")),
                    bandImage(image: Image("bandImage"))
                ],
                description: "Somos uma banda bastante versátil com muita experiencia no mercado, entre em nosso perfil para ver mais detalhes!",
                artistStyle: .band,
                musicalStyles: [.rock, .pop, .blues],
                price: "1400",
                workAreas: nil,
                dayPeriods: nil),
            
            Band(
                name: "Euforia Casual",
                rating: 4,
                bandImages: [
                    bandImage(image: Image("bandImage")),
                    bandImage(image: Image("bandImage")),
                    bandImage(image: Image("bandImage"))
                ],
                description: "Somos uma banda bastante versátil com muita experiencia no mercado, entre em nosso perfil para ver mais detalhes!",
                artistStyle: .band,
                musicalStyles: [.rock, .pop, .blues],
                price: "1400",
                workAreas: nil,
                dayPeriods: nil),
            
            Band(
                name: "Euforia Casual",
                rating: 4,
                bandImages: [
                    bandImage(image: Image("bandImage")),
                    bandImage(image: Image("bandImage")),
                    bandImage(image: Image("bandImage"))
                ],
                description: "Somos uma banda bastante versátil com muita experiencia no mercado, entre em nosso perfil para ver mais detalhes!",
                artistStyle: .band,
                musicalStyles: [.rock, .pop, .blues],
                price: "1400",
                workAreas: nil,
                dayPeriods: nil),
            
            Band(
                name: "Euforia Casual",
                rating: 4,
                bandImages: [
                    bandImage(image: Image("bandImage")),
                    bandImage(image: Image("bandImage")),
                    bandImage(image: Image("bandImage"))
                ],
                description: "Somos uma banda bastante versátil com muita experiencia no mercado, entre em nosso perfil para ver mais detalhes!",
                artistStyle: .band,
                musicalStyles: [.rock, .pop, .blues],
                price: "1400",
                workAreas: nil,
                dayPeriods: nil)
        ]
        
        bestRankedBands.append(contentsOf: mockBandsArray)
    }
    
    func didChangeArtistStyle(_ artistStyle: ArtistStyle) {
        
        selectedArtistStyle = artistStyle
        impactFeedbackGenerator.impactOccurred()
    }
    
    func getSelectedQueryData() -> SelectedBandQueryData {
        
        SelectedBandQueryData(
            artistStyle: selectedArtistStyle,
            workArea: selectedWorkArea,
            dayPeriod: selectedDayPeriod,
            musicalStyle: selectedMusicalStyle, 
            date: selectedDate)
    }
}
