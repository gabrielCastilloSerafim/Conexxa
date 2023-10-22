//
//  BandsListingView.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 1/10/23.
//

import SwiftUI

struct BandsListingView: View {
    
    @StateObject private var vm: BandsListingViewModel
    let selectedQueryData: SelectedBandQueryData
    
    init(networkService: NetworkServiceProtocol, selectedQueryData: SelectedBandQueryData) {
        
        _vm = StateObject(wrappedValue: BandsListingViewModel(networkService: networkService))
        self.selectedQueryData = selectedQueryData
    }
    
    var body: some View {
        
        ZStack {
            
            backGround
            
            ScrollView {
                
                VStack {
                    
                    queryInfoView
                    Divider()
                    Spacer()
                }
                
                resultsList
            }
        }
        .navigationTitle("bands".localized)
        .searchable(
            text: $vm.searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "bandName".localized)
        .onAppear {
            vm.getBands()
        }
        .navigationDestination(for: NavigationDestinations.self) { destination in
            
            switch destination {
                
            case .bandDetails:
                BandDetailsView(networkService: AppDependencies.networkService)
            }
        }
        .sheet(isPresented: $vm.isFilterScreenPresented, onDismiss: vm.didDismissFiltersModal, content: {
            FilterSelectionView(
                selectedFilters: $vm.selectedFilters,
                isFilterScreenPresented: $vm.isFilterScreenPresented)
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        })
    }
}

private extension BandsListingView {
    
    // MARK: UIProperties
    
    enum NavigationDestinations: Navigation {
        
        case bandDetails
    }
    
    var backGround: some View {
        
        ConexxaColor.dirtyWhite()
            .ignoresSafeArea(.all)
    }
    
    var queryInfoView: some View {
        
        HStack {
            
            VStack(alignment: .leading) {
                
                Text("filters".localized)
                    .font(.system(size: 20, weight: .semibold))
                
                HStack(spacing: 0) {
                    
                    Image(systemName: vm.selectedFilters.isEmpty ? "line.3.horizontal.decrease.circle" : "line.3.horizontal.decrease.circle.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(ConexxaColor.purple())
                    
                    Button(action: {
                        vm.isFilterScreenPresented = true
                    }, label: {
                        Text(vm.selectedFilterText)
                    })
                    .padding(.leading, 10)
                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                
                Text(selectedQueryData.workArea.rawValue)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(ConexxaColor.black())
                
                Spacer()
                
                Text(selectedQueryData.dateString)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(ConexxaColor.black())
                
                Spacer()
                
                Text(selectedQueryData.dayPeriod.rawValue)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(ConexxaColor.black())
            }
        }
        .frame(height: 68)
        .padding(.top, 8)
        .padding(.bottom, 0)
        .padding(.leading, 20)
        .padding(.trailing, 20)
    }
    
    var resultsList: some View {
        LazyVStack {
            ForEach(vm.bandsList, id: \.id) { band in
                
                BandCell(
                    band: band,
                    navigationLink: NavigationDestinations.bandDetails)
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.top, 10)
            }
        }
    }
}

#Preview {
    BandsListingView(
        networkService: AppDependencies.networkService,
        selectedQueryData: SelectedBandQueryData(
        artistStyle: .band,
        workArea: .zonaNorte,
        dayPeriod: .night,
        musicalStyle: .rock,
        date: Date.now))
}
