//
//  HomeView.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 24/9/23.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var vm = HomeViewModel()
    
    var body: some View {
        
        ZStack {
            
            backGround
            
            VStack {
                
                artistTypePicker
                separatorView
                
                ScrollView {
                    
                    conexxaLogo
                    
                    Color(.red)
                        .frame(height: 300)
                    
                    Color(.blue)
                        .frame(height: 50)
                    
                    bestRatedBandsList
                }
            }
            .padding(.leading, 10)
            .padding(.trailing, 10)
            
        }.onAppear {
            
            vm.getBestRankedBands()
        }
    }
}

private extension HomeView {
    
    // MARK: UIProperties
    
    var backGround: some View {
        ConexxaColor.white()
            .ignoresSafeArea(.all)
    }
    
    var separatorView: some View {
        ConexxaColor.lightGray()
            .frame(height: 0.5)
    }
    
    var conexxaLogo: some View {
        HStack {
            Image("ConexxaLogoHorizontal")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150)
                .padding(.top, 10)
            Spacer()
        }
    }
    
    var artistTypePicker: some View {
        VStack {
            HStack(alignment: .center, spacing: 60) {
                VStack {
                    Image("HomeBandIcon")
                        .foregroundColor(vm.selectedArtistStyle == .band ? ConexxaColor.purple() : ConexxaColor.black())
                    Text("Bandas")
                        .bold()
                }
                .onTapGesture {
                    vm.didChangeArtistStyle(.band)
                }
                VStack {
                    Image("HomeMusicianIcon")
                        .foregroundColor(vm.selectedArtistStyle == .musician ? ConexxaColor.purple() : ConexxaColor.black())
                    Text("Músicos")
                        .bold()
                }
                .onTapGesture {
                    vm.didChangeArtistStyle(.musician)
                }
                VStack {
                    Image("HomeDJIcon")
                        .foregroundColor(vm.selectedArtistStyle == .dj ? ConexxaColor.purple() : ConexxaColor.black())
                    Text("DJ's")
                        .bold()
                }
                .onTapGesture {
                    vm.didChangeArtistStyle(.dj)
                }
            }
        }
        .ignoresSafeArea(.all)
        .frame(height: 70)
        .padding(.top, 8)
    }
    
    var bestRatedBandsList: some View {
        
        ForEach(vm.bestRankedBands, id: \.id) { band in
            ZStack {
                VStack {
                    HStack {
                        Text(band.name)
                        Spacer()
                        getStarsRating(rating: 2)
                    }
                    Image("bandImage")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
        }
    }
    
    // MARK: Methods
    
    func getStarsRating(rating: Int) -> some View {
        
        HStack(spacing: 2) {
            ForEach(0..<rating, id: \.self) { index in
                
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
        }
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
