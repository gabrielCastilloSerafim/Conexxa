//
//  RegisterFormModel.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 7/12/23.
//

import Foundation

struct RegisterAlertsModel {
    
    let alertTitle: String
    let alertMessage: String
    let alertCompletionField: ContractorRegisterFields?
}

enum RegisterFormAlerts {
    
    case badEmail
    case passwordMissmatch
    case invalidPassword
    case missingInformation
    case APIError(errorMessage: String)
}

enum ContractorRegisterFields {
    
    case name
    case surname
    case email
    case password
    case passwordConfirm
}
