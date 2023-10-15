//
//  BandsListingModel.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 1/10/23.
//

import Foundation

struct SelectedBandQueryData {
    
    let artistStyle: ArtistStyle
    let workArea: WorkAreas
    let dayPeriod: DayPeriod
    let musicalStyle: MusicalStyle
    let date: Date
    
    var dateString: String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: date)
    }
}

enum BandsListingFilters: String, CaseIterable {
    
    case noFilter = "Nenhum"
    case cheaper = "Mais barato"
    case bestRanking = "Melhor avaliação"
}
