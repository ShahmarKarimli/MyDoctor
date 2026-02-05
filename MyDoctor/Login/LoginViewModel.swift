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

class LoginViewModel: ObservableObject {
    func login() {
        
    }
}
