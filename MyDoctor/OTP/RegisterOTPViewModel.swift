//
//  RegisterOTPViewModel.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 17.02.26.
//

class RegisterOTPViewModel: OTPViewModel {
    override func verifyOTP() {
        super.verifyOTP()
        AuthManager.shared.verifyOTP(email: email, code: otpCode) { [weak self] response in
            guard let self else { return }
            self.isLoading = false
            switch response {
            case .success(let model):
                _ = self.saveTokens(token: model.token)
                self.isVerified = true
            case .failure(let error):
                self.handleWrongAttempt(
                    error.localizedDescription)
            }
        }
    }
    
    override func resendCode() {
        super.resendCode()
        AuthManager.shared.resendOTP(email: email) { [weak self] response in
            guard let self else { return }
            self.isLoading = false
            switch response {
            case .success(_):
                self.errorMessage = nil
                self.startTimer()
            case .failure(let error):
                self.errorMessage = error.localizedDescription//"Xəta baş verdi"
            }
        }
    }
}
