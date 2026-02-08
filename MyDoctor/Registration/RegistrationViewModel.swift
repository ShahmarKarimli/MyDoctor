//
//  RegistrationViewModel.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 31.01.26.
//

import Foundation

/*class RegisterViewModel {
    enum ViewState {
        case loading
        case loaded
        case error(String)
        case success
    }
    
    var callBack: ((ViewState) -> Void)?
    
    var firstname: String?
    var email: String?
    var password: String?
    
    // MARK: - Main Action
    func checkAndRegister() {
        guard let fullInput = firstname, !fullInput.trimmingCharacters(in: .whitespaces).isEmpty,
              let mail = email, !mail.isEmpty,
              let pass = password, !pass.isEmpty else {
            callBack?(.error("Zəhmət olmasa bütün xanaları doldurun."))
            return
        }
        
        callBack?(.loading)
        
        MyDoctorManager.shared.checkEmail(email: mail) { [weak self] response in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    if !data.available {
                        self.callBack?(.loaded)
                        self.callBack?(.error("Bu E-mail artıq istifadə olunub"))
                    } else {
                        self.performRegistration(fullInput: fullInput, mail: mail, pass: pass)
                    }
                case .error(let coreModel):
                    self.callBack?(.loaded)
                    self.callBack?(.error(coreModel.statusMessage ?? "Yoxlanış zamanı xəta baş verdi."))
                }
            }
        }
    }
    
    // MARK: - Private Registration Logic
    private func performRegistration(fullInput: String, mail: String, pass: String) {
        let components = fullInput.trimmingCharacters(in: .whitespaces).components(separatedBy: " ")
        let fname = components.first ?? ""
        let lname = components.count > 1 ? components.dropFirst().joined(separator: " ") : ""
        
        let requestModel = RegisterRequestModel(
            firstname: fname,
            lastname: lname,
            email: mail,
            password: pass,
            phoneNumber: "0000000000",
            role: "PATIENT"
        )
        
        MyDoctorManager.shared.register(user: requestModel) { [weak self] response in
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    self.callBack?(.loaded)
                    
                    switch response {
                    case .success(_):
                        self.callBack?(.success)
                    case .error(let coreModel):
                        if coreModel.statusCode == 409 {
                            self.callBack?(.error("Bu E-mail artıq bazada mövcuddur. Lütfən daxil olun."))
                        } else {
                            let errorMsg = coreModel.statusMessage ?? "Qeydiyyat zamanı xəta baş verdi."
                            self.callBack?(.error(errorMsg))
                        }
                    }
                }
            }
    }
}*/

import Foundation
import Combine

class RegistrationViewModel: ObservableObject {
    @Published var firstname = ""
    @Published var lastname = ""
    @Published var email = ""
    @Published var password = ""
    @Published var phoneNumber = ""
    
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var showOtpField = false
    @Published var emailCheckError: String?
    
    var isFormValid: Bool {
        let hasUpperCase = password.rangeOfCharacter(from: .uppercaseLetters) != nil
        let hasLowerCase = password.rangeOfCharacter(from: .lowercaseLetters) != nil
        let isLengthValid = password.count >= 8 && password.count <= 25
        
        let isEmailValid = !email.isEmpty && email.contains("@") && email.contains(".")
        
        let isNameValid = !firstname.trimmingCharacters(in: .whitespaces).isEmpty
        
        return isNameValid && isEmailValid && hasUpperCase && hasLowerCase && isLengthValid
    }
    
    // MARK: - Əsas Qeydiyyat Funksiyası
    func handleRegistration() {
        guard isFormValid else { return }
        
        self.isLoading = true
        self.errorMessage = nil
        self.emailCheckError = nil
        
        MyDoctorManager.shared.checkEmail(email: email) { [weak self] response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    if data.available {
                        self?.performActualRegistration()
                    } else {
                        self?.isLoading = false
                        self?.emailCheckError = "Bu E-mail artıq istifadə olunub"
                    }
                case .error(let error):
                    self?.isLoading = false
                    self?.errorMessage = error.statusMessage ?? "Yoxlanış zamanı xəta."
                }
            }
        }
    }
    
    private func performActualRegistration() {
        let components = firstname.trimmingCharacters(in: .whitespaces).components(separatedBy: " ")
        let fname = components.first ?? ""
        let lname = components.count > 1 ? components.dropFirst().joined(separator: " ") : "Patient"
        
        let requestModel = RegisterRequestModel(
            firstname: fname,
            lastname: lname,
            email: email,
            password: password,
            phoneNumber: phoneNumber.isEmpty ? "0000000000" : phoneNumber,
            role: "PATIENT"
        )
        
        MyDoctorManager.shared.register(user: requestModel) { [weak self] response in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch response {
                case .success(_):
                    self?.showOtpField = true
                case .error(let error):
                    self?.errorMessage = error.statusMessage ?? "Qeydiyyat xətası."
                }
            }
        }
    }
}

    

