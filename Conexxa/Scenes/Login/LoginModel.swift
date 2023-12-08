//
//  LoginModel.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 8/12/23.
//

import Foundation

enum LiginFields {
    
    case email
    case password
}

enum LoginFormAlerts {
    
    case badEmail
    case invalidPassword
    case missingInformation
    case APIError(errorMessage: String)
}

struct LoginAlertsModel {
    
    let alertTitle: String
    let alertMessage: String
    let alertCompletionField: LiginFields?
}
