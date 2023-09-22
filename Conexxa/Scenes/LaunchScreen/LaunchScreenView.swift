//
//  LaunchScreenView.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 17/9/23.
//

import SwiftUI

struct LaunchScreenView: View {
    
    @EnvironmentObject var launchScreenManager: LaunchScreenManager
    @State private var firstPhaseIsAnimating: Bool = false
    @State private var secondPhaseIsAnimating: Bool = false
    
    private let timer = Timer.publish(
        every: 0.65,
        on: .main,
        in: .common).autoconnect()
    
    var body: some View {
        
        ZStack {
            backGround
            conexxaImage
        }
        .onReceive(timer) { input in
            
            switch launchScreenManager.state {
                
            case .first:
                
                // First phase with continuous scaling
                withAnimation(.easeInOut(duration: 0.65)) {
                    firstPhaseIsAnimating.toggle()
                }
                
            case .second:
                
                // Second phase with continuous scaling
                withAnimation(.easeInOut(duration: 0.5)) {
                    secondPhaseIsAnimating.toggle()
                }
                
            default:
                break
            }
        }
    }
}

private extension LaunchScreenView {
    
    var backGround: some View {
        ConexxaColor.white()
            .ignoresSafeArea(.all)
            .opacity(secondPhaseIsAnimating ? 0 : 1)
    }
    
    var conexxaImage: some View {
        Image("ConexxaLogoHorizontal")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 240, height: 128)
            .padding(.bottom, 12)
            .scaleEffect(firstPhaseIsAnimating ? 0.87 : 1)
            .scaleEffect(secondPhaseIsAnimating ? UIScreen.main.bounds.size.height/4 : 1)
            .opacity(secondPhaseIsAnimating ? 0 : 1)
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
            .environmentObject(LaunchScreenManager())
    }
}
