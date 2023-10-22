//
//  OnboardingView.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 10/9/23.
//

import SwiftUI

struct OnboardingView: View {
    
    @EnvironmentObject var launchScreenManager: LaunchScreenManager
    @State var didFinishLaunch: Bool = false
    @StateObject private var vm: OnboardingViewModel
    
    init(userDefaultsStorage: UserDefaultsStorageProtocol) {
        
        _vm = StateObject(wrappedValue: OnboardingViewModel(userDefaultsStaorage: userDefaultsStorage))
    }
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                backgroundColor
                
                VStack {
                    
                    logoImage
                    sloganLabel
                    Spacer()
                }
                
                blurCircle
                
                VStack {
                    
                    noRegistrationButton
                    musicianRegistrationButton
                }
                .padding(.top, 197)
            }
            .opacity(didFinishLaunch ? 1 : 0)
            .onAppear {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    launchScreenManager.dismiss()
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.1) {
                    withAnimation(.easeInOut(duration: 0.45)) {
                        didFinishLaunch.toggle()
                    }
                }
            }
        }
    }
}

private extension OnboardingView {
    
    var backgroundColor: some View {
        ConexxaColor.dirtyWhite()
            .ignoresSafeArea(.all)
    }
    
    var logoImage: some View {
        Image("ConexxaLogoVertical")
            .resizable()
            .scaledToFit()
            .frame(height: 100)
            .padding(.top, 100)
            .padding(.trailing, 12)
    }
    
    var sloganLabel: some View {
        Text("slogan".localized)
            .foregroundColor(ConexxaColor.black())
            .fontWeight(.medium)
            .padding(.top, 20)
    }
    
    var blurCircle: some View {
        Circle()
            .padding(.top, 195)
            .padding(.leading, 25)
            .padding(.trailing, 25)
            .blur(radius: 10)
            .foregroundColor(ConexxaColor.black())
    }
    
    var noRegistrationButton: some View {
        NavigationLink() {
            TabBar(needsToDismissLaunchScreen: false)
        } label: {
            Text("noRegistrationButtonText".localized)
                .fontWeight(.bold)
                .frame(width: 230, height: 60)
                .foregroundColor(ConexxaColor.black())
                .background(ConexxaColor.green())
                .cornerRadius(10)
        }
        .simultaneousGesture(TapGesture().onEnded({
            vm.didSeeOnboardingWithSelectedOption(option: Constants.APP_GUEST_MODE)
        }))
    }
    
    var musicianRegistrationButton: some View {
        Button {
            
            print("Here")
            
        } label: {
            Text("musicianRegisterButtonText".localized)
                .fontWeight(.bold)
                .frame(width: 230, height: 60)
                .foregroundColor(ConexxaColor.green())
                .background(ConexxaColor.blue())
                .cornerRadius(10)
        }
        .padding(.top, 25)
    }
}

#Preview {
    OnboardingView(userDefaultsStorage: AppDependencies.userDefaultsStorage)
        .environmentObject(LaunchScreenManager())
}
