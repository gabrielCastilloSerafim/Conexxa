//
//  FilterSelectionView.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 1/10/23.
//

import SwiftUI

struct FilterSelectionView: View {
    
    @Binding var selectedFilters: [BandsListingFilters]
    var inScreenSelectedFilters = [BandsListingFilters]()
    @Binding var isFilterScreenPresented: Bool
    @State var cheepFilterState = false
    @State var bestRankingFilterState = false
    @State var noneFilterState = false
    
    var body: some View {
        
        ZStack {
            
            ConexxaColor.white()
            
            VStack {
                filtersTitleAndRemoveFiltersButton
                togglesStack
                Spacer()
            }
            .onAppear {
                
                selectedFilters.forEach { filter in
                    
                    switch filter {
                        
                    case .noFilter:
                        break
                        
                    case .cheaper:
                        cheepFilterState.toggle()
                        
                    case .bestRanking:
                        bestRankingFilterState.toggle()
                    }
                }
            }
        }
    }
}

private extension FilterSelectionView {
    
    var filtersTitleAndRemoveFiltersButton: some View {
        
        HStack {
            Text("filters".localized)
                .font(.system(.title, weight: .heavy))
            
            Spacer()
            
            removeFiltersButton
        }
        .padding(.leading, 20)
        .padding(.top, 40)
        .padding(.trailing, 20)
    }
    
    var togglesStack: some View {
        
        VStack {
            
            Toggle(isOn: $cheepFilterState, label: {
                Text("cheapest".localized)
                    .font(.system(size: 18, weight: .medium))
            })
            .tint(ConexxaColor.green())
            .onChange(of: cheepFilterState) { value in
                
                if value == true && noneFilterState == true {
                    noneFilterState = false
                }
                
                if value == true && selectedFilters.contains(where: { $0 == .cheaper }) == false {
                    
                    selectedFilters.append(.cheaper)
                }
                
                if value == false {
                    
                    selectedFilters.removeAll(where: { $0 == .cheaper })
                }
            }
            .padding(.bottom, 10)
            
            Toggle(isOn: $bestRankingFilterState, label: {
                Text("bestRating".localized)
                    .font(.system(size: 18, weight: .medium))
            })
            .tint(ConexxaColor.green())
            .onChange(of: bestRankingFilterState) { value in
                
                if value == true && noneFilterState == true {
                    noneFilterState = false
                }
                
                if value == true && selectedFilters.contains(where: { $0 == .bestRanking }) == false {
                    
                    selectedFilters.append(.bestRanking)
                }
                
                if value == false {
                    
                    selectedFilters.removeAll(where: { $0 == .bestRanking })
                }
            }
        }
        .padding(.leading, 20)
        .padding(.trailing, 23)
        .padding(.top, 20)
    }
    
    var removeFiltersButton: some View {
        
        Button(action: {
            
            noneFilterState.toggle()
            
            if noneFilterState == true && cheepFilterState == true {
                cheepFilterState = false
            }
            
            if noneFilterState == true && bestRankingFilterState == true {
                bestRankingFilterState = false
            }
            
            if noneFilterState == true {
                selectedFilters.removeAll()
            }
            
        }, label: {
            
            ZStack {
                ConexxaColor.red()
                    .frame(width: 90, height: 35)
                    .cornerRadius(8)
                    .shadow(radius: 2)
                
                Text("remove".localized)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(.white)
            }
        })
    }
}

#Preview {
    FilterSelectionView(
        selectedFilters: .constant([]),
        isFilterScreenPresented: .constant(true),
        cheepFilterState: false,
        bestRankingFilterState: false,
        noneFilterState: false)
}
