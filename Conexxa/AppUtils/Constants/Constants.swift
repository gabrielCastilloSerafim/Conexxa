//
//  Constants.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 24/9/23.
//

import Foundation

struct Constants {
    
    // User defaults keys
    static let CURRENT_USER_LOGIN_STATE = "loginState" // Associated value -> String
    static let JWT = "jwt" // Associated value -> String
    static let JWT_UNIX_EXPIRATION_TIME_STAMP = "jwtExp" // Associated value -> Double
    static let USER_ID = "uid" // Associated value -> String
    
    // App use modes
    static let APP_GUEST_MODE = "guest"
    static let APP_LOGGED_IN_MUSICIAN = "musician"
    static let APP_LOGGED_IN_CONTRACTOR = "contractor"
    
}
