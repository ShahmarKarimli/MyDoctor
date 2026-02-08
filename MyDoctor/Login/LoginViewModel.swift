//
//  LoginViewModel.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 02.02.26.
//


/*
 import Foundation

class LoginViewModel {
    enum ViewState {
        case loading
        case loaded
        case error(String)
        case success
    }
    
    var callBack: ((ViewState) -> Void)?
    var email: String?
    var password: String?
    
    func loginUser() {
        guard let mail = email, !mail.isEmpty,
              let pass = password, !pass.isEmpty else {
            callBack?(.error("E-mail və şifrəni daxil edin."))
            return
        }
        
        callBack?(.loading)
        let requestModel = LoginRequestModel(email: mail, password: pass)
        
        MyDoctorManager.shared.login(user: requestModel) { [weak self] response in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.callBack?(.loaded)
                
                switch response {
                case .success(let model):
                    if model.statusCode == 200 {
                        self.callBack?(.success)
                    } else {
                        self.callBack?(.error(model.statusMessage ?? "E-mail və ya şifrə yanlışdır."))
                    }
                    
                case .error(let coreModel):
                    let errorMsg = coreModel.statusMessage ?? "E-mail və ya şifrə yanlışdır."
                    self.callBack?(.error(errorMsg))
                }
            }
        }
    }
}
*/

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage: String? = nil
    @Published var isLoading = false
    @Published var isLoggedIn = false
    
    func handleLogin() {
        guard !email.isEmpty && !password.isEmpty else {
            errorMessage = "E-mail və şifrə boş ola bilməz"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        let requestModel = LoginRequestModel(email: email, password: password)
        
        MyDoctorManager.shared.login(user: requestModel) { [weak self] response in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch response {
                case .success(let data):
                    print("Giriş uğurlu: \(data.statusMessage ?? "")")
                    self?.isLoggedIn = true
                case .error(let error):
                    self?.errorMessage = error.statusMessage ?? "E-mail və ya şifrə yanlışdır."
                }
            }
        }
    }
}
