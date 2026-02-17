import Foundation
import Combine

@MainActor
class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage: String? = nil
    @Published var isLoading = false
    @Published var isLoggedIn = false
    
    func handleLogin() {
        // Hər cəhddə köhnə xətanı sıfırlayırıq
        errorMessage = nil
        
        let trimmedEmail = email.trimmingCharacters(in: .whitespaces)
        
        // Boşluq yoxlanışı
        guard !trimmedEmail.isEmpty && !password.isEmpty else {
            errorMessage = "E-mail və ya şifrə daxil edilməyib"
            return
        }
        
        isLoading = true
        let requestModel = LoginRequestModel(email: trimmedEmail, password: password)
        
        AuthManager.shared.login(user: requestModel) { [weak self] response in
            guard let self = self else { return }
            
            Task { @MainActor in
                self.isLoading = false
                
                switch response {
                case .success:
                    self.errorMessage = nil
                    self.isLoggedIn = true
                    
                case .failure(let coreModel):
                    self.isLoggedIn = false
                    self.errorMessage = "E-mail və ya şifrə yanlışdır"
                }
            }
        }
    }
    
    private func handleLoginError(_ coreModel: ErrorModel) {
        let statusCode = coreModel.status ?? 0
        switch statusCode {
        case 401, 403:
            errorMessage = "E-mail və ya şifrə yanlışdır"
        default:
            errorMessage = "E-mail və ya şifrə yanlışdır"
        }
    }
    
    func handleForgotPassword() {
        let trimmedEmail = email.trimmingCharacters(in: .whitespaces)
        
        guard !trimmedEmail.isEmpty else {
            self.errorMessage = "Zəhmət olmasa email ünvanınızı daxil edin."
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        AuthManager.shared.forgotPassword(email: trimmedEmail) { [weak self] response in
            guard let self = self else { return }
            
            Task { @MainActor in
                self.isLoading = false
                
                switch response {
                case .success:
                    print("Şifrə sıfırlama sorğusu uğurlu oldu")
                    
                case .failure(let coreModel):
                    self.errorMessage = "E-mail və ya şifrə yanlışdır"
                }
            }
        }
    }
}
