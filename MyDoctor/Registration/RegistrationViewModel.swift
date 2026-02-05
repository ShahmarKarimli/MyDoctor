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

class RegistrationViewModel: ObservableObject {
    @Published var firstname = ""
    @Published var lastname = ""
    @Published var email = ""
    @Published var password = ""
    @Published var phoneNumber = ""
    @Published var role = "PATIENT"
    
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var otpCode = ""
    @Published var showOtpField = false
    @Published var registrationSuccess = false

    // MARK: - Register Action
    func register() {
        isLoading = true
        errorMessage = nil
        
        let userModel = RegisterRequestModel(
            firstname: firstname,
            lastname: lastname,
            email: email,
            password: password,
            phoneNumber: phoneNumber,
            role: role
        )
        
        MyDoctorManager.shared.register(user: userModel) { [weak self] response in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch response {
                case .success(_):
                    self?.showOtpField = true
                case .error(let error):
                    self?.errorMessage = "Qeydiyyat xətası: \(error.errorMessage)"
                }
            }
        }
    }

    // MARK: - OTP Verification Action
    func verifyOTP() {
        guard !otpCode.isEmpty else { return }
        
        isLoading = true
        MyDoctorManager.shared.verifyOTP(email: email, code: otpCode) { [weak self] response in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch response {
                case .success(_):
                    self?.registrationSuccess = true
                case .error(let error):
                    self?.errorMessage = error.errorMessage
                }
            }
        }
    }
    
    // MARK: - Resend OTP
    func resendCode() {
       
    }
}

    

