//
//  FilterSelectionView.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 1/10/23.
//

import SwiftUI

struct FilterSelectionView: View {
    
    @Binding var selectedFilters: [BandsListingFilters]
    @Binding var isFilterScreenPresented: Bool
    @State var cheepFilterState = false
    @State var bestRankingFilterState = false
    @State var noneFilterState = false
    
    var body: some View {
        
        VStack {
            
            Form {
                
                formFirstSection
                formSeccondSection
                
            }.onAppear {
                
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
        .navigationTitle("filters".localized)
        .toolbar {
            
            toolBarButton
        }
    }
}

private extension FilterSelectionView {
    
    var formFirstSection: some View {
        
        Section {
            
            Toggle(isOn: $cheepFilterState, label: {
                Text("cheapest".localized)
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
            
            Toggle(isOn: $bestRankingFilterState, label: {
                Text("bestRating".localized)
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
    }
    
    var formSeccondSection: some View {
        
        Section {
            
            HStack {
                Spacer()
                Button(action: {
                    
                    isFilterScreenPresented = false
                }, label: {
                    
                    Text("apply".localized)
                        .multilineTextAlignment(.center)
                        .font(.system(size: 16, weight: .bold))
                })
                Spacer()
            }
        }
    }
    
    var toolBarButton: some View {
        
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
            
            Text("remove".localized)
                .multilineTextAlignment(.center)
                .font(.system(size: 16))
                .foregroundStyle(.red)
        })
    }
}
