//
//  ResetPasswordOTPViewModel.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 17.02.26.
//

class ResetPasswordOTPViewModel: OTPViewModel {
    let password: String
    
    init(password: String, email: String) {
        self.password = password
        super.init(email: email)
    }
    
    override func verifyOTP() {
        super.verifyOTP()
        let requestModel = ResetPasswordRequestModel(
            email: email,
            otp: otpCode,
            newPassword: password
        )
        
        AuthManager.shared.resetPassword(request: requestModel) { [weak self] response in
            guard let self else { return }
            self.isLoading = false
            switch response {
            case .success(_):
                self.isVerified = true
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                /*if error.status == 429 {
                    self.errorMessage = "Çox sayda cəhd edildi. Zəhmət olmasa bir az gözləyin."
                } else {
                    self.errorMessage = "Şifrə yenilənmədi. OTP kodu səhv ola bilər."
                }*/
            }
        }
    }
    
    override func resendCode() {
        super.resendCode()
        errorMessage = nil
        AuthManager.shared.forgotPassword(email: email, completion: { [weak self] result in
            guard let self else { return }
            self.isLoading = false
            switch result {
            case .success(_):
                self.errorMessage = nil
                self.startTimer()
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        })
    }
}
