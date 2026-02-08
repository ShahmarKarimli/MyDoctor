//
//  PasswordRecoveryViewModel.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 02.02.26.
//

import Foundation

/*class PasswordRecoveryViewModel {
    
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
}*/


import Foundation
import Combine

class PasswordRecoveryViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    @Published var showOtpScreen: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    func startRecovery() {
        guard isEmailValid else {
            self.errorMessage = "Düzgün e-mail daxil edin."
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        MyDoctorManager.shared.forgotPassword(email: email) { [weak self] response in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                switch response {
                case .success(_):
                    self?.showOtpScreen = true
                case .error(let error):
                    self?.errorMessage = error.statusMessage ?? "Bu e-mail ilə bağlı hesab tapılmadı."
                }
            }
        }
    }
    
    // Sadə email validasiyası
    var isEmailValid: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
}
