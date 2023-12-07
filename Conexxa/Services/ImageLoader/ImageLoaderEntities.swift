//
//  ImageLoaderEntities.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 3/12/23.
//

import Foundation

enum ImageLoaderError: Error {
    
    case couldNotGenerateImageFromData
    case badURL
    case failedWithStatusCode(statusCode: Int)
    case unknown(description: String)
}
