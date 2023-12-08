//
//  NetworkServiceEntities.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 22/10/23.
//

import Foundation

protocol NetworkServiceProtocol {
    
    func performRequest<D: Decodable, E: Encodable>(
        useAuth: Bool,
        endPoint: String,
        typeToBeDecoded: D.Type,
        httpMethod: HttpMethods,
        requestBody: E?) async throws -> D
}

struct GNetworkError: Error, Decodable {
    
    let msg: String
}

enum HttpMethods: String {
    
    case GET
    case POST
    case PUT
    case PATCH
    case DELETE
}
