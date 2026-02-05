//
//  New.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 02.02.26.
//

import Foundation

import Foundation

class NewPasswordViewModel {
    
    enum ViewState {
        case loading
        case loaded
        case success
        case error(String)
    }
    
    // MARK: - Properties
    var callBack: ((ViewState) -> Void)?
    
    var token: String?
    
    // MARK: - API Call
    func resetPassword(password: String) {
        guard let token = token, !token.isEmpty else {
            self.callBack?(.error("Təhlükəsizlik tokeni tapılmadı. Zəhmət olmasa OTP mərhələsini yenidən keçin."))
            return
        }
        
        guard !password.isEmpty else {
            self.callBack?(.error("Şifrə boş ola bilməz."))
            return
        }
        
        if password.count < 6 {
            self.callBack?(.error("Şifrə ən azı 6 simvoldan ibarət olmalıdır."))
            return
        }
        
        callBack?(.loading)
        
        let requestModel = ResetPasswordRequestModel(token: token, newPassword: password)
       
        MyDoctorManager.shared.resetPassword(request: requestModel) { [weak self] response in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.callBack?(.loaded)
                
                switch response {
                case .success:
                    self.callBack?(.success)
                case .error(let error):
                    let message = error.statusMessage ?? "Şifrəni yeniləmək mümkün olmadı."
                    self.callBack?(.error(message))
                }
            }
        }
    }
}
