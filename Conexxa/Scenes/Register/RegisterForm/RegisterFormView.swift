//
//  RegisterFormView.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 3/12/23.
//

import SwiftUI
import PhotosUI

struct RegisterFormView: View {
    
    @EnvironmentObject var tabBarStateObject: TabBarState
    @Environment(\.dismiss) private var dismiss
    @StateObject var vm: RegisterFormViewModel
    @State private var profileImageView: Image?
    @State private var profileImageItem: PhotosPickerItem?
    @FocusState private var focusedField: ContractorRegisterFields?
    
    init(networkService: NetworkServiceProtocol, userRegistrationType: UserRegistrationType) {
        
        _vm = StateObject(wrappedValue: RegisterFormViewModel(
            networkService: networkService,
            userRegistrationType: userRegistrationType))
    }
    
    var body: some View {
        
        ZStack {
            
            UIFactory.defaultBackground
            
            ScrollView {
                
                VStack {
                    imagePicker
                    contractorForm
                    confirmationButton
                }
            }
            .scrollDismissesKeyboard(.interactively)
            
            spinner
        }
        .disabled(vm.screenLoading)
        .navigationTitle("register".localized)
        .navigationBarTitleDisplayMode(.large)
        .alert(vm.alertMessageData.alertTitle, isPresented: $vm.presentAlert) {
            Button("ok".localized, role: .cancel) {
                focusedField = vm.alertMessageData.alertCompletionField
            }
        } message: {
            Text(vm.alertMessageData.alertMessage)
        }
        .onChange(of: vm.endRegistrationProcess) { _ in
            tabBarStateObject.tabBarState = .loggedContractor
            dismiss()
        }
        .onDisappear {
            vm.cancelTasks()
        }
    }
}

private extension RegisterFormView {
    
    var imagePicker: some View {
            
        PhotosPicker(selection: $profileImageItem, matching: .images, preferredItemEncoding: .automatic) {
            
            ZStack {
                
                if let profileImageView {
                    
                    profileImageView
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                    
                } else {
                    
                    profileImagePlaceHolder
                    plusButton
                        .offset(x: 40, y: 60)
                }
            }
            .padding(.top, 30)
            .padding(.bottom, 30)
        }
        .onChange(of: profileImageItem) { _ in
            
            let imageDataTask = Task {
                
                guard let data = try? await profileImageItem?.loadTransferable(type: Data.self),
                      let uiImage = UIImage(data: data) else { return }
                
                profileImageView = Image(uiImage: uiImage)
                vm.profileImageData = data
            }
            
            vm.tasks.append(imageDataTask)
        }
    }
    
    var profileImagePlaceHolder: some View {
        
        ZStack {
            
            ConexxaColor.blue()
                .frame(width: 153, height: 153)
                .clipShape(Circle())
            
            ConexxaColor.white()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
            
            Image(systemName: "person.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 80)
                .foregroundStyle(ConexxaColor.lightGray())
        }
    }
    
    var plusButton: some View {
        
        Image(systemName: "plus.circle.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 40)
            .foregroundStyle(ConexxaColor.blue())
            .background(ConexxaColor.white())
            .clipShape(Circle())
    }
    
    var contractorForm: some View {
        
        List {
            
            Section("personalInfo".localized) {
                
                TextField("name".localized, text: $vm.name)
                    .textInputAutocapitalization(.words)
                    .focused($focusedField, equals: .name)
                    .autocorrectionDisabled()
                    .submitLabel(.next)
                    .onChange(of: vm.name, perform: { _ in
                        vm.reloadContinueButtonState()
                    })
                
                TextField("surname".localized, text: $vm.surname)
                    .textInputAutocapitalization(.words)
                    .focused($focusedField, equals: .surname)
                    .autocorrectionDisabled()
                    .submitLabel(.next)
                    .onChange(of: vm.surname, perform: { _ in
                        vm.reloadContinueButtonState()
                    })
            }
            
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
                    .focused($focusedField, equals: .password)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .submitLabel(.next)
                    .onChange(of: vm.password, perform: { _ in
                        vm.reloadContinueButtonState()
                    })
                
                SecureField("passwordConfirm".localized, text: $vm.passwordConfirmation)
                    .textInputAutocapitalization(.never)
                    .focused($focusedField, equals: .passwordConfirm)
                    .autocorrectionDisabled()
                    .submitLabel(.done)
                    .onChange(of: vm.passwordConfirmation, perform: { _ in
                        vm.reloadContinueButtonState()
                    })
            }
        }
        .padding(.leading, 8)
        .padding(.trailing, 8)
        .scrollDisabled(true)
        .frame(height: 350)
        .onSubmit {
            
            switch focusedField {
                
            case .name:
                focusedField = .surname
                
            case .surname:
                focusedField = .email
                
            case .email:
                focusedField = .password
                
            case .password:
                focusedField = .passwordConfirm
                
            default:
                focusedField = nil
            }
            
            vm.reloadContinueButtonState()
        }
    }
    
    var confirmationButton: some View {
        
        Button {
            vm.userRegistrationAction()
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
    RegisterFormView(networkService: NetworkService(), userRegistrationType: .contractor)
}
