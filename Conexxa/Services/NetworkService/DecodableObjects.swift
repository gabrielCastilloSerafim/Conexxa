//
//  DecodableObjects.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 7/12/23.
//

import Foundation

struct UserRegisterResponse: Decodable {
    
    let msg: String
    let token: String
    let tokenExpTime: Double
}

struct UserLoginResponse: Decodable {
    
    let msg: String
    let token: String
    let tokenExpTime: Double
    let userId: String
}
