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
    var presentingAlertType: RegisterFormAlerts?
    
    // Publised variables
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var passwordConfirmation: String = ""
    @Published var continueButtonDisabled: Bool = true
    @Published var presentAlert: Bool = false
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
            presentingAlertType = .missingInformation
            presentAlert.toggle()
            return false
        }
        
        if !isValidEmail {
            continueButtonDisabled = true
            presentingAlertType = .badEmail
            presentAlert.toggle()
            return false
        }
        
        if !isValidPassWord {
            continueButtonDisabled = true
            presentingAlertType = .invalidPassword
            presentAlert.toggle()
            return false
        }
        
        if !passwordsMatch {
            continueButtonDisabled = true
            presentingAlertType = .passwordMissmatch
            presentAlert.toggle()
            return false
        }
        
        return true
    }
    
    var alertMessageData: RegisterAlertsModel {
        
        switch presentingAlertType {
            
        case .badEmail:
            
            return RegisterAlertsModel(
                alertTitle: "badEmailAlertTitle".localized,
                alertMessage: "badEmailAlertMessage".localized,
                alertCompletionField: .email)
            
        case .passwordMissmatch:
            
            return RegisterAlertsModel(
                alertTitle: "passwordMissmatchAlertTitle".localized,
                alertMessage: "passwordMissmatchAlertMessage".localized,
                alertCompletionField: .password)
            
        case .invalidPassword:
            
            return RegisterAlertsModel(
                alertTitle: "invalidPasswordAlertTitle".localized,
                alertMessage: "invalidPasswordAlertMessage".localized,
                alertCompletionField: .password)
            
        case .missingInformation:
            
            return RegisterAlertsModel(
                alertTitle: "missingInformationAlertTitle".localized,
                alertMessage: "missingInformationAlertMessage".localized,
                alertCompletionField: nil)
            
        case .APIError(let errorMessage):
            
            return RegisterAlertsModel(
                alertTitle: "upsAlert".localized,
                alertMessage: errorMessage,
                alertCompletionField: nil)
            
        case .none:
            
            return RegisterAlertsModel(
                alertTitle: "upsAlert".localized,
                alertMessage: "tryAgainLater".localized,
                alertCompletionField: nil)
        }
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
        
        do {
            
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
            
        } catch {
            
            let errorMessage = (error as? GNetworkError)?.msg ?? "tryAgainLater".localized
            
            await MainActor.run {
                screenLoading.toggle()
                presentingAlertType = .APIError(errorMessage: errorMessage)
                presentAlert.toggle()
            }
            
            throw AppGenericError.networkDataRequestFailed
        }
    }
}
