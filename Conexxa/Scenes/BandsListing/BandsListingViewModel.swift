//
//  BandsListingViewModel.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 1/10/23.
//

import SwiftUI

class BandsListingViewModel: ObservableObject {
    
    @Published var searchText: String = ""
    @Published var isFilterScreenPresented: Bool = false
    @Published var selectedFilters: [BandsListingFilters] = []
    @Published var bandsList: [Band] = []
    
    var selectedFilterText: String {
        
        if selectedFilters.isEmpty {
            return BandsListingFilters.noFilter.rawValue
        }
        
        if selectedFilters.count > 1 {
            return "Vários"
        }
        
        if selectedFilters.count == 1 && selectedFilters.contains(where: { $0 == .bestRanking }) {
            return BandsListingFilters.bestRanking.rawValue
        }
        
        if selectedFilters.count == 1 && selectedFilters.contains(where: { $0 == .cheaper }) {
            return BandsListingFilters.cheaper.rawValue
        }
        
        return ""
    }
    
    func getBands() {
        
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
        
        bandsList.append(contentsOf: mockBandsArray)
    }
}
