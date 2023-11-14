//
//  ProfileModel.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 14/11/23.
//

import SwiftUI

struct User: Identifiable {
    
    let id = UUID()
    let name: String
    let surname: String
    let profileImage: Image
}
