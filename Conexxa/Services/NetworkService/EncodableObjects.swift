//
//  EncodableObjects.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 7/12/23.
//

import Foundation

struct ContractorRegister: Encodable {
    
    let name: String
    let surname: String
    let email: String
    let password: String
    let confirmpassword: String
}

struct UserLogin: Encodable {
    
    let email: String
    let password: String
}
