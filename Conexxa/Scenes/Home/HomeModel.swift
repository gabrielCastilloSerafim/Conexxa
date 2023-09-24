//
//  HomeModel.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 24/9/23.
//

import Foundation

struct Band: Identifiable {
    
    let id = UUID()
    let name: String
    let rating: Int
    let image: String
}

enum ArtistStyle {
    
    case band
    case musician
    case dj
}
