//
//  ContentView.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 10/9/23.
//

import SwiftUI

// ProcessInfo.processInfo.environment["API_BASE_URL"]

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}