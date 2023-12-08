//
//  LoginViewModel.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 6/12/23.
//

import Foundation
import OSLog

@MainActor
final class LoginViewModel: ObservableObject {
    
    // Dependencies
    private let networkService: NetworkServiceProtocol
    
    // Properties
    private var logger = Logger(subsystem: "LoginView", category: "NetworkRequest")
    private var tasks: [Task<Void, Never>] = []
    var loginFormAlerts: LoginFormAlerts?
    
    // Publised variables
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var continueButtonDisabled: Bool = true
    @Published var screenLoading: Bool = false
    @Published var presentAlert: Bool = false
    @Published var endLoginProcess: Bool = false
    
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
    
    var alertMessageData: LoginAlertsModel {
        
        switch loginFormAlerts {
            
        case .badEmail:
            
            return LoginAlertsModel(
                alertTitle: "badEmailAlertTitle".localized,
                alertMessage: "badEmailAlertMessage".localized,
                alertCompletionField: .email)
            
        case .invalidPassword:
            
            return LoginAlertsModel(
                alertTitle: "invalidPasswordAlertTitle".localized,
                alertMessage: "invalidPasswordAlertMessage".localized,
                alertCompletionField: .password)
            
        case .missingInformation:
            
            return LoginAlertsModel(
                alertTitle: "missingInformationAlertTitle".localized,
                alertMessage: "missingInformationAlertMessage".localized,
                alertCompletionField: nil)
            
        case .APIError(let errorMessage):
            
            return LoginAlertsModel(
                alertTitle: "upsAlert".localized,
                alertMessage: errorMessage,
                alertCompletionField: nil)
            
        case .none:
            
            return LoginAlertsModel(
                alertTitle: "upsAlert".localized,
                alertMessage: "tryAgainLater".localized,
                alertCompletionField: nil)
        }
    }
    
    func cancelTasks() {
        tasks.forEach({ $0.cancel() })
    }
    
    func reloadContinueButtonState() {
        continueButtonDisabled = haveEmptyFields
    }
    
    func canContinueWithRegisterAction() -> Bool {
        
        if haveEmptyFields {
            loginFormAlerts = .missingInformation
            presentAlert.toggle()
            continueButtonDisabled = true
            return false
        }
        
        if !isValidEmail {
            loginFormAlerts = .badEmail
            presentAlert.toggle()
            continueButtonDisabled = true
            return false
        }
        
        if !isValidPassWord {
            loginFormAlerts = .invalidPassword
            presentAlert.toggle()
            continueButtonDisabled = true
            return false
        }
        
        return true
    }
    
    func userLoginAction() {
        
        guard canContinueWithRegisterAction() else { return }
        
        let userLoginTask = Task {
            
            screenLoading.toggle()
            
            let userLogin =  UserLogin(
                email: email.trimmingCharacters(in: .newlines).lowercased(),
                password: password.trimmingCharacters(in: .newlines))
            
            do {
                
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
                
                screenLoading.toggle()
                endLoginProcess.toggle()
                
            } catch {
                
                let errorMessage = (error as? GNetworkError)?.msg ?? "".localized
                
                screenLoading.toggle()
                loginFormAlerts = .APIError(errorMessage: errorMessage)
                presentAlert.toggle()
                
                logger.error("User login failed with error: \(error.localizedDescription)")
            }
        }
        
        tasks.append(userLoginTask)
    }
    
}
