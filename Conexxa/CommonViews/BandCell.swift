//
//  BandCell.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 12/10/23.
//

import SwiftUI

struct BandCell: View {
    
    let band: Band
    let navigationLink: any Navigation
    
    var body: some View {
        
        ZStack {
            
            VStack {
                
                bandImageTabs
                bandNameAndRatingRow
                descriptionRow
                priceAndContractRow
            }
        }
        .glass(cornerRadius: 20)
        .padding(.bottom, 8)
    }
}

private extension BandCell {
    
    var bandImageTabs: some View {
        TabView {
            
            ForEach(band.bandImages) { bandImage in
             
                bandImage.image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .interactive))
        .frame(height: 200)
        .clipShape(
            .rect(
                topLeadingRadius: 20,
                topTrailingRadius: 20))
        .shadow(radius: 3)
    }
    
    var bandNameAndRatingRow: some View {
        HStack {
            
            Text(band.name)
                .font(.system(size: 21, weight: .bold))
            Spacer()
            generateStarsRatingView(starRating: band.rating)
        }
        .padding(.leading, 15)
        .padding(.trailing, 15)
        .padding(.top, 8)
        .padding(.bottom, 8)
    }
    
    var descriptionRow: some View {
        VStack {
            
            Text(band.description)
                .font(.system(size: 12, weight: .regular))
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack {
                    ForEach(band.musicalStyles, id: \.self) { musicalStyle in
                        
                        Text(musicalStyle.rawValue)
                            .padding(5)
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundStyle(ConexxaColor.white())
                            .background(ConexxaColor.blue())
                            .cornerRadius(6)
                    }
                }
            }
            .padding(.top, 2)
            .padding(.leading, 5)
            .padding(.trailing, 5)
        }
        .padding(.leading, 15)
        .padding(.trailing, 15)
    }
    
    var priceAndContractRow: some View {
        HStack {
            Text("\("currencySymbol".localized) \(band.price)")
                .font(.system(size: 21, weight: .heavy))
            
            Spacer()
            
            NavigationLink(value: navigationLink) {
                Text("seeDetails".localized)
                    .font(.system(size: 16, weight: .semibold))
                    .padding(.horizontal, 20)
                    .padding(.vertical, 8)
                    .foregroundColor(ConexxaColor.white())
                    .background(ConexxaColor.green())
                    .cornerRadius(10)
                    .shadow(radius: 2)
            }
        }
        .padding(.leading, 20)
        .padding(.trailing, 15)
        .padding(.bottom, 10)
    }
    
    func generateStarsRatingView(starRating: Int) -> some View {
        
        HStack(spacing: 2) {
            ForEach(0..<5, id: \.self) { index in
                
                Image(systemName: "star.fill")
                    .foregroundColor(index < starRating ? ConexxaColor.yellow() : ConexxaColor.lightGray())
            }
        }
    }
}

#Preview {
    
    enum MockNavigation: Navigation {
        case mock
    }
    
    return BandCell(
        band: Band(
            name: "Euforia Casual",
            rating: 4,
            bandImages: [
                bandImage(image: Image("bandImage")),
                bandImage(image: Image("bandImage")),
                bandImage(image: Image("bandImage"))
            ],
            description: "Somos uma banda bastante versátil com muita experiencia no mercado, entre em nosso perfil para ver mais detalhes!",
            artistStyle: .band,
            musicalStyles: [.rock, .pop, .blues],
            price: "1400",
            workAreas: nil,
            dayPeriods: nil), 
            navigationLink: MockNavigation.mock)
}
