//
//  ConexxaSpinner.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 7/12/23.
//

import SwiftUI

struct ConexxaSpinner: View {
    
    // MARK: - Properties
    @Binding var showSpinner: Bool
    
    // MARK: - Body
    var body: some View {
        
        ZStack {
            
            ConexxaColor.lightGray()
                .opacity(0.4)
                .blur(radius: 20)
                .ignoresSafeArea()
                .cornerRadius(20)
                .shadow(color: .gray,radius: 1)
                .frame(width: 80, height: 80)
            
            ProgressView()
                .controlSize(.large)
                .progressViewStyle(CircularProgressViewStyle(tint: ConexxaColor.black()))
        }
        .opacity(showSpinner ? 1 : 0)
        .disabled(showSpinner)
    }
}

#Preview {
    ConexxaSpinner(showSpinner: .constant(true))
}
