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
        
        NavigationStack {
            
            ZStack {
                
                backGround
                
                VStack(spacing: 0) {
                    
                    conexxaHeader
                    Divider()
                    
                    ScrollView {
                        
                        completeQueryView
                        bestRankedText
                        bestRatedBandsList
                    }
                    .scrollIndicators(.hidden)
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                
            }
            .onAppear {
                
                vm.getBestRankedBands()
            }
            .navigationBarHidden(true)
            .navigationDestination(for: NavigationDestinations.self) { destination in
                
                switch destination {
                    
                case .bandsListing:
                    BandsListingView(selectedQueryData: vm.getSelectedQueryData())
                    
                case .bandDetails:
                    BandDetailsView()
                }
            }
        }
    }
}

private extension HomeView {
    
    // MARK: UIProperties
    
    enum NavigationDestinations: Navigation {
        
        case bandsListing
        case bandDetails
    }
    
    var backGround: some View {
        
        ConexxaColor.dirtyWhite()
            .ignoresSafeArea(.all)
    }
    
    var conexxaHeader: some View {
        
        HStack {
            Image("ConexxaLogoHorizontal")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150)
            
            Spacer()
            
            HStack(spacing: 12) {
                
                VStack {
                    Image("HomeBandIcon")
                        .resizable()
                        .foregroundColor(vm.selectedArtistStyle == .band ? ConexxaColor.purple() : ConexxaColor.black())
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 30)
                    Spacer()
                    Text("band".localized)
                        .fontWeight(.medium)
                        .font(.system(size: 12))
                }
                .onTapGesture {
                    vm.didChangeArtistStyle(.band)
                }
                
                VStack {
                    Image("HomeMusicianIcon")
                        .resizable()
                        .foregroundColor(vm.selectedArtistStyle == .musician ? ConexxaColor.purple() : ConexxaColor.black())
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 30)
                    Spacer()
                    Text("musician".localized)
                        .fontWeight(.medium)
                        .font(.system(size: 12))
                }
                .onTapGesture {
                    vm.didChangeArtistStyle(.musician)
                }
                
                VStack {
                    Image("HomeDJIcon")
                        .resizable()
                        .foregroundColor(vm.selectedArtistStyle == .dj ? ConexxaColor.purple() : ConexxaColor.black())
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 30)
                    Spacer()
                    Text("dj".localized)
                        .fontWeight(.medium)
                        .font(.system(size: 12))
                }
                .onTapGesture {
                    vm.didChangeArtistStyle(.dj)
                }
            }
            .padding(.trailing, 10)
        }
        .frame(height: 45)
        .padding(.top, 12)
        .padding(.bottom, 10)
        .padding(.leading, 10)
    }
    
    var bestRatedBandsList: some View {
        
        LazyVStack {
            ForEach(vm.bestRankedBands, id: \.id) { band in
                
                BandCell(
                    band: band,
                    navigationLink: NavigationDestinations.bandDetails)
            }
        }
    }
    
    var queryInfoBackgroundView: some View {
        
        ZStack {
            
            ZStack {
                
                Color.gray
                    .opacity(0.25)
                    .ignoresSafeArea()
                
                Color.white
                    .opacity(0.7)
                    .blur(radius: 200)
                    .ignoresSafeArea()
                
                GeometryReader { proxy in
                    
                    let size = proxy.size
                    
                    Circle()
                        .fill(ConexxaColor.green())
                        .padding(25)
                        .blur(radius: 50)
                        .offset(x: -size.width/2, y: -size.height/2.2)
                    
                    Circle()
                        .fill(ConexxaColor.blue())
                        .padding(25)
                        .blur(radius: 50)
                        .offset(x: size.width/2, y: size.height/2.2)
                }
                
            }
            .cornerRadius(20)
            
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .frame(height: 420)
                .opacity(0.25)
                .shadow(radius: 10.0)
        }
    }
    
    var bestRankedText: some View {
        
        VStack(spacing: 0) {
            HStack {
                
                Text("bestRanked".localized)
                    .font(.system(size: 25, weight: .bold))
                    .padding(.top, 20)
                
                Spacer()
            }
            Divider()
                .padding(.bottom, 10)
                .padding(.top, 10)
        }
    }
    
    var completeQueryView: some View {
        
        ZStack {
            
            queryInfoBackgroundView
            
            VStack {
                
                HStack {
                    Text("bands".localized)
                        .font(.system(size: 27, weight: .bold))
                        .foregroundStyle(ConexxaColor.white())
                        .shadow(radius: 10)
                        .padding(.top, 10)
                    
                    Spacer()
                }
                
                Spacer()
                
                VStack(alignment: .leading) {
                    
                    Text("region".localized)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(ConexxaColor.black())
                        .padding(.leading, 10)
                        .padding(.top, 10)
                    
                    HStack {
                        
                        Image(systemName: "mappin.and.ellipse")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(ConexxaColor.black())
                            .frame(height: 25)
                        
                        Picker("region", selection: $vm.selectedWorkArea) {
                            ForEach(WorkAreas.allCases, id: \.self) { workArea in
                                Text(workArea.rawValue)
                            }
                        }
                        
                        Spacer()
                    }
                    .padding(.leading, 10)
                    .padding(.bottom, 10)
                }
                .glass(cornerRadius: 10)
                
                Spacer()
                
                HStack(spacing: 20) {
                    
                    VStack(alignment: .leading) {
                        
                        Text("musicStyle".localized)
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(ConexxaColor.black())
                            .padding(.leading, 10)
                            .padding(.top, 10)
                        
                        HStack {
                            
                            Image(systemName: "music.note")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundStyle(ConexxaColor.black())
                                .frame(height: 25)
                            
                            Picker("musicStyle", selection: $vm.selectedMusicalStyle) {
                                ForEach(MusicalStyle.allCases, id: \.self) { workArea in
                                    Text(workArea.rawValue)
                                }
                            }
                            
                            Spacer()
                        }
                        .padding(.leading, 10)
                        .padding(.bottom, 10)
                    }
                    .glass(cornerRadius: 10)
                    
                    VStack(alignment: .leading) {
                        
                        Text("period".localized)
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(ConexxaColor.black())
                            .padding(.leading, 10)
                            .padding(.top, 10)
                        
                        HStack {
                            
                            Image(systemName: "clock.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundStyle(ConexxaColor.black())
                                .frame(height: 25)
                            
                            Picker("period", selection: $vm.selectedDayPeriod) {
                                ForEach(DayPeriod.allCases, id: \.self) { workArea in
                                    Text(workArea.rawValue)
                                }
                            }
                            
                            Spacer()
                        }
                        .padding(.leading, 10)
                        .padding(.bottom, 10)
                    }
                    .glass(cornerRadius: 10)
                    
                }
                
                Spacer()
                
                VStack(alignment: .leading) {
                    
                    Text("date".localized)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(ConexxaColor.black())
                        .padding(.leading, 10)
                        .padding(.top, 10)
                    
                    HStack {
                        
                        Image(systemName: "calendar.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(ConexxaColor.black())
                            .frame(height: 25)
                        
                        DatePicker(selection: $vm.selectedDate, in: ...Date.now, displayedComponents: .date) {
                            Text("select".localized)
                        }
                        .datePickerStyle(.compact)
                        .foregroundStyle(ConexxaColor.purple())
                        
                        Spacer()
                    }
                    .padding(.leading, 10)
                    .padding(.bottom, 10)
                }
                .glass(cornerRadius: 10)
                
                Spacer()
                
                NavigationLink(value: NavigationDestinations.bandsListing) {
                    Text("search".localized)
                        .font(.system(size: 19, weight: .semibold))
                        .padding(.horizontal, 52)
                        .padding(.vertical, 10)
                        .foregroundColor(ConexxaColor.white())
                        .background(ConexxaColor.green())
                        .cornerRadius(16)
                }
                
                Spacer()
            }
            .padding(.leading, 15)
            .padding(.trailing, 15)
        }
        .padding(.top, 10)
    }
}

#Preview {
    HomeView()
}
