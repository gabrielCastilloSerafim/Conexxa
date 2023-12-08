//
//  LoginView.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 6/12/23.
//

import SwiftUI
import OSLog

struct LoginView: View {
    
    @EnvironmentObject var tabBarStateObject: TabBarState
    @Environment(\.dismiss) private var dismiss
    @StateObject var vm: LoginViewModel
    @FocusState private var focusedField: LiginFields?
    
    init(networkService: NetworkServiceProtocol) {
        
        _vm = StateObject(wrappedValue: LoginViewModel(networkService: networkService))
    }
    
    var body: some View {
        
        ZStack {
            
            UIFactory.defaultBackground
            
            VStack {
                loginForm
                confirmationButton
                Spacer()
            }
            spinner
        }
        .navigationTitle("login".localized)
        .navigationBarTitleDisplayMode(.large)
        .disabled(vm.screenLoading)
        .alert(vm.alertMessageData.alertTitle, isPresented: $vm.presentAlert) {
            Button("ok".localized, role: .cancel) {
                focusedField = vm.alertMessageData.alertCompletionField
            }
        } message: {
            Text(vm.alertMessageData.alertMessage)
        }
        .onChange(of: vm.endLoginProcess) { _ in
            tabBarStateObject.tabBarState = .loggedContractor
            dismiss()
        }
        .onDisappear {
            vm.cancelTasks()
        }
    }
}

private extension LoginView {
    
    var loginForm: some View {
        
        List {
            
            Section("account".localized) {
                
                TextField("email".localized, text: $vm.email)
                    .textInputAutocapitalization(.never)
                    .focused($focusedField, equals: .email)
                    .autocorrectionDisabled()
                    .keyboardType(.emailAddress)
                    .submitLabel(.next)
                    .onChange(of: vm.email, perform: { _ in
                        vm.reloadContinueButtonState()
                    })
                
                SecureField("password".localized, text: $vm.password)
                    .textInputAutocapitalization(.none)
                    .focused($focusedField, equals: .password)
                    .autocorrectionDisabled()
                    .submitLabel(.done)
                    .onChange(of: vm.password, perform: { _ in
                        vm.reloadContinueButtonState()
                    })
            }
        }
        .padding(EdgeInsets(top: 24, leading: 8, bottom: 24, trailing: 8))
        .frame(height: 200)
        .scrollDisabled(true)
        .onSubmit {
            
            switch focusedField {
                
            case .email:
                focusedField = .password
                
            case .password:
                focusedField = nil
                
            default:
                focusedField = nil
            }
            
            vm.reloadContinueButtonState()
        }
    }
    
    var confirmationButton: some View {
        
        Button {
            vm.userLoginAction()
        } label: {
            Text("confirm".localized)
                .fontWeight(.bold)
                .frame(width: 350, height: 50)
                .foregroundColor(vm.continueButtonDisabled ? ConexxaColor.black().opacity(0.7) : ConexxaColor.black())
                .background(vm.continueButtonDisabled ? ConexxaColor.lightGray() : ConexxaColor.green())
                .cornerRadius(10)
        }
        .padding(.bottom, 24)
        .padding(.leading, 24)
        .padding(.trailing, 24)
        .disabled(vm.continueButtonDisabled)
    }
    
    var spinner: some View {
        
        ConexxaSpinner(showSpinner: $vm.screenLoading)
    }
}

#Preview {
    LoginView(networkService: NetworkService())
}
