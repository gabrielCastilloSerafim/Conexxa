//
//  BandDetailsView.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 15/10/23.
//

import SwiftUI

struct BandDetailsView: View {
    
    @StateObject private var vm: BandDetailsViewModel
    
    init(networkService: NetworkServiceProtocol) {
        _vm = StateObject(wrappedValue: BandDetailsViewModel(networkService: networkService))
    }
    
    var body: some View {
        Text("This soon will be the band details viewer...")
    }
}

#Preview {
    BandDetailsView(networkService: NetworkService())
}
