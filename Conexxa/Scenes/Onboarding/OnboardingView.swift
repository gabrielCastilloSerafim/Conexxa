//
//  OnboardingView.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 10/9/23.
//

import SwiftUI

struct OnboardingView: View {
    
    @StateObject private var vm: OnboardingViewModel
    @EnvironmentObject var tabBarStateObject: TabBarState
    @Environment(\.dismiss) private var dismiss
    @AppStorage(Constants.CURRENT_USER_LOGIN_STATE) var currentUserLoginState: String?
    
    init() {
        
        _vm = StateObject(wrappedValue: OnboardingViewModel())
    }
    
    var body: some View {
            
        ZStack {
            
            UIFactory.defaultBackground
            
            VStack {
                
                logoImage
                sloganLabel
                Spacer()
            }
            
            blurRectangle
            
            VStack {
                
                noRegistrationButton
                registerButton
                loginButton
            }
            .padding(.top, 197)
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationDestination(isPresented: $vm.registerNavigation, destination: {
            RegisterFormView(networkService: NetworkService(), userRegistrationType: vm.userRegistrationType ?? .contractor)
        })
        .navigationDestination(isPresented: $vm.loginNavigation, destination: {
            LoginView(networkService: NetworkService())
        })
        .sheet(isPresented: $vm.registrationPickerPresentation, onDismiss: vm.didDismissRegistersModal, content: {
            RegisterTypePickerView(
                isRegistrationPickerPresented: $vm.registrationPickerPresentation,
                userRegistrationType: $vm.userRegistrationType)
            .presentationDetents([.medium])
            .presentationDragIndicator(.visible)
        })
    }
}

private extension OnboardingView {
    
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
    
    var blurRectangle: some View {
        Rectangle()
            .frame(width: 330, height: 320)
            .cornerRadius(30)
            .padding(.top, 200)
            .padding(.leading, 25)
            .padding(.trailing, 25)
            .blur(radius: 10)
            .foregroundColor(ConexxaColor.black())
    }
    
    var noRegistrationButton: some View {
        Button {
            currentUserLoginState = Constants.APP_GUEST_MODE
            tabBarStateObject.tabBarState = .guest
            dismiss()
            
        } label: {
            Text("noRegistrationButtonText".localized)
                .fontWeight(.bold)
                .frame(width: 240, height: 55)
                .foregroundColor(ConexxaColor.black())
                .background(ConexxaColor.green())
                .cornerRadius(10)
        }
    }
    
    var registerButton: some View {
        Button {
            vm.registrationPickerPresentation.toggle()
        } label: {
            Text("registerButtonText".localized)
                .fontWeight(.bold)
                .frame(width: 240, height: 55)
                .foregroundColor(ConexxaColor.white())
                .background(ConexxaColor.purple())
                .cornerRadius(10)
        }
        .padding(.top, 25)
    }
    
    var loginButton: some View {
        Button {
            vm.loginNavigation.toggle()
        } label: {
            Text("loginButton".localized)
                .fontWeight(.bold)
                .frame(width: 240, height: 55)
                .foregroundColor(ConexxaColor.white())
                .background(ConexxaColor.purple())
                .cornerRadius(10)
        }
        .padding(.top, 25)
    }
}

#Preview {
    OnboardingView()
}
