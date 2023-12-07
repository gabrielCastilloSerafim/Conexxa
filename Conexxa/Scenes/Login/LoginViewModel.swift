//
//  LoginViewModel.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 6/12/23.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    // Dependencies
    private let networkService: NetworkServiceProtocol
    
    // Publised variables
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var continueButtonDisabled: Bool = true
    @Published var screenLoading: Bool = false
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    var haveEmptyFields: Bool {
        
        return (email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
        password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
    }
    
    var isValidEmail: Bool {
        
        email.trimmingCharacters(in: .whitespacesAndNewlines).count > 6 &&
        email.contains("@") &&
        email.contains(".")
    }
    
    var isValidPassWord: Bool {
        
        password.trimmingCharacters(in: .whitespacesAndNewlines).count >= 8
    }
    
    func reloadContinueButtonState() {
        
        continueButtonDisabled = haveEmptyFields
    }
    
    func canContinueWithRegisterAction() -> Bool {
        
        if haveEmptyFields {
            continueButtonDisabled = true
//            missingFieldsAlert.toggle()
            return false
        }
        
        if !isValidEmail {
            continueButtonDisabled = true
//            badEmailAlert.toggle()
            return false
        }
        
        if !isValidPassWord {
            continueButtonDisabled = true
//            invalidPasswordAlert.toggle()
            return false
        }
        
        return true
    }
    
    func userLoginAction() async throws {
        
        await MainActor.run {
            screenLoading.toggle()
        }
        
        let userLogin =  UserLogin(
            email: email.trimmingCharacters(in: .newlines).lowercased(),
            password: password.trimmingCharacters(in: .newlines))
        
        
        let loginResponse = try await networkService.performRequest(
            useAuth: false,
            endPoint: APIEndPoints.LOGIN(),
            typeToBeDecoded: UserLoginResponse.self,
            httpMethod: .POST,
            requestBody: userLogin)
        
        UserDefaults.standard.setValue(loginResponse.token, forKey: Constants.JWT)
        UserDefaults.standard.setValue(loginResponse.tokenExpTime, forKey: Constants.JWT_UNIX_EXPIRATION_TIME_STAMP)
        UserDefaults.standard.setValue(loginResponse.userId, forKey: Constants.USER_ID)
        UserDefaults.standard.setValue(Constants.APP_LOGGED_IN_CONTRACTOR, forKey: Constants.CURRENT_USER_LOGIN_STATE)
        
        await MainActor.run {
            screenLoading.toggle()
        }
    }
    
}
