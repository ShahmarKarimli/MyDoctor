//
//  PasswordRecoveryViewModel.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 02.02.26.
//

import Foundation

class PasswordRecoveryViewModel {
    
    enum ViewState {
        case loading
        case loaded
        case error(String)
        case success
    }
    
    var callBack: ((ViewState) -> Void)?
    var email: String?
    
    func startRecovery() {
        guard let mail = email, !mail.isEmpty else {
            callBack?(.error("E-mail ünvanınızı daxil edin."))
            return
        }
        
        callBack?(.loading)
        
        MyDoctorManager.shared.forgotPassword(email: mail) { [weak self] response in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.callBack?(.loaded)
                
                switch response {
                case .success:
                    self.callBack?(.success)
                case .error(let coreModel):
                    let errorMsg = coreModel.statusMessage ?? "Xəta baş verdi. E-mailinizi yoxlayın."
                    self.callBack?(.error(errorMsg))
                }
            }
        }
    }
}
