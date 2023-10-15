//
//  HomeModel.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 24/9/23.
//

import SwiftUI

struct Band: Identifiable {
    
    let id = UUID()
    let name: String
    let rating: Int
    let bandImages: [bandImage]
    let description: String
    let artistStyle: ArtistStyle?
    let musicalStyles: [MusicalStyle]
    let price: String
    let workAreas: [WorkAreas]?
    let dayPeriods: [DayPeriod]?
}

struct bandImage: Identifiable {
    
    let id = UUID()
    let image: Image
}

enum ArtistStyle {
    
    case band
    case musician
    case dj
}

enum WorkAreas: String, CaseIterable {
    
    case zonaSul = "São Paulo, Zona Sul"
    case zonaLeste = "São Paulo, Zona Leste"
    case zonaOeste = "São Paulo, Zona Oeste"
    case zonaNorte = "São Paulo, Zona Norte"
}

enum DayPeriod: String, CaseIterable {
    
    case morning = "Manhã"
    case afternoon = "Tarde"
    case night = "Noite"
}

enum MusicalStyle: String, CaseIterable {
    
    case rock = "Rock"
    case electronic = "Electronica"
    case samba = "Samba"
    case sertanejo = "Sertanejo"
    case pop = "Pop"
    case funk = "Funk"
    case blues = "Blues"
}
