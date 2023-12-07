//
//  RegisterFormViewModel.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 3/12/23.
//

import Foundation

class RegisterFormViewModel: ObservableObject {
    
    // Dependencies
    private var networkService: NetworkServiceProtocol
    
    // Properties
    let userRegistrationType: UserRegistrationType
    var profileImageData: Data?
    
    // Publised variables
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var passwordConfirmation: String = ""
    @Published var continueButtonDisabled: Bool = true
    @Published var badEmailAlert: Bool = false
    @Published var passwordMissMatchAlert: Bool = false
    @Published var invalidPasswordAlert: Bool = false
    @Published var missingFieldsAlert: Bool = false
    @Published var screenLoading: Bool = false

    
    init(networkService: NetworkServiceProtocol, userRegistrationType: UserRegistrationType) {
        
        self.networkService = networkService
        self.userRegistrationType = userRegistrationType
    }
    
    var isValidEmail: Bool {
        
        email.trimmingCharacters(in: .whitespacesAndNewlines).count > 6 &&
        email.contains("@") &&
        email.contains(".")
    }
    
    var isValidPassWord: Bool {
        
        password.trimmingCharacters(in: .whitespacesAndNewlines).count >= 8
    }
    
    var passwordsMatch: Bool {
        
        password == passwordConfirmation
    }
    
    var haveEmptyFields: Bool {
        
        return (name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
        surname.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
        email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
        password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
        passwordConfirmation.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
    }
    
    var canContinueWithRegisterAction: Bool {
        
        if haveEmptyFields {
            continueButtonDisabled = true
            missingFieldsAlert.toggle()
            return false
        }
        
        if !isValidEmail {
            continueButtonDisabled = true
            badEmailAlert.toggle()
            return false
        }
        
        if !isValidPassWord {
            continueButtonDisabled = true
            invalidPasswordAlert.toggle()
            return false
        }
        
        if !passwordsMatch {
            continueButtonDisabled = true
            passwordMissMatchAlert.toggle()
            return false
        }
        
        return true
    }
    
    func reloadContinueButtonState() {
        
        continueButtonDisabled = haveEmptyFields
    }
    
    func userRegistrationAction() async throws {
        
        await MainActor.run {
            screenLoading.toggle()
        }
        try await registerUser()
    }
    
    private func registerUser() async throws {
        
        let contractorRegister = ContractorRegister(
            name: name.trimmingCharacters(in: .newlines),
            surname: surname.trimmingCharacters(in: .newlines),
            email: email.trimmingCharacters(in: .newlines).lowercased(),
            password: password.trimmingCharacters(in: .newlines),
            confirmpassword: password.trimmingCharacters(in: .newlines))
        
        
        let registrationResponse = try await networkService.performRequest(
            useAuth: false,
            endPoint: APIEndPoints.REGITER(),
            typeToBeDecoded: UserRegisterResponse.self,
            httpMethod: .POST,
            requestBody: contractorRegister)
        
        UserDefaults.standard.setValue(registrationResponse.token, forKey: Constants.JWT)
        UserDefaults.standard.setValue(registrationResponse.tokenExpTime, forKey: Constants.JWT_UNIX_EXPIRATION_TIME_STAMP)
        UserDefaults.standard.setValue(Constants.APP_LOGGED_IN_CONTRACTOR, forKey: Constants.CURRENT_USER_LOGIN_STATE)
        
        await MainActor.run {
            screenLoading.toggle()
        }
    }
}
