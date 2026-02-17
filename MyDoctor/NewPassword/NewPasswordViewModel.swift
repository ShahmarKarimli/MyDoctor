//
//  New.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 02.02.26.
//

import Foundation
import Combine

class NewPasswordViewModel: ObservableObject {
    @Published var password = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isSuccess = false
    
    let email: String
    
    init(email: String) {
        self.email = email
    }
    
    var isFormValid: Bool {
        let regex = "^(?=.*[a-z])(?=.*[A-Z]).{8,25}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: password)
    }
    
    func forgotPassword() {
        errorMessage = nil
        isLoading = true
        AuthManager.shared.forgotPassword(email: email, completion: { [weak self] result in
            guard let self else { return }
            self.isLoading = false
            switch result {
            case .success(_):
                self.isSuccess = true
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        })
    }
}
