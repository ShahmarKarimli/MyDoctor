
import SwiftUI

struct AuthFormView: View {
    var mode: AuthMode
    @Binding var name: String
    @Binding var email: String
    @Binding var password: String
    
    var isLoading: Bool = false
    var isButtonActive: Bool? = nil
    var emailError: String? = nil
    var action: () -> Void
    var forgotAction: (() -> Void)? = nil
    
    @State private var isPasswordVisible = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(spacing: 12) {
                
                // MARK: - Ad Sahəsi (Yalnız Registration üçün)
                if mode == .registration {
                    VStack(alignment: .leading, spacing: 0) {
                        customTextField(title: "Ad", placeholder: "Adınız", text: $name)
                        if !name.isEmpty && !isNameValid {
                            errorMessage(text: "Ad minimum 4 hərfdən ibarət olmalıdır.")
                                .padding(.top, 4)
                        }
                    }
                }
                
                // MARK: - E-mail Sahəsi
                VStack(alignment: .leading, spacing: 0) {
                    customTextField(title: "E-mail", placeholder: "email@gmail.com", text: $email)
                    
                    if mode != .login && !email.isEmpty && !isEmailValid && (emailError == nil || emailError!.isEmpty) {
                        errorMessage(text: "Düzgün email daxil edin.")
                            .padding(.top, 4)
                    }
                    
                    if let error = emailError, !error.isEmpty {
                        errorMessage(text: error)
                            .padding(.top, 4)
                            .transition(.opacity)
                    }
                }
                
                // MARK: - Şifrə Sahəsi
                if mode != .passwordRecovery {
                    VStack(alignment: .leading, spacing: 0) {
                        customPasswordField(title: "Şifrə", placeholder: "••••••••", text: $password)
                        if mode == .registration && !password.isEmpty && !isPasswordValid {
                            errorMessage(text: "Şifrə 8-25 simvol, 1 böyük və 1 kiçik hərf olmalıdır.")
                                .padding(.top, 4)
                        }
                    }
                }
                
                // MARK: - Şifrəni Unutmusunuz? (Yalnız Login üçün)
                if mode == .login {
                    HStack {
                        if let forgotAction = forgotAction {
                            Button(action: forgotAction) {
                                Text("Şifrəni unutmusunuz?")
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundColor(.gray)
                                    .underline()
                                    .padding(.horizontal, 10)
                            }
                            .disabled(isLoading)
                        }
                        Spacer()
                    }
                    .padding(.top, 4)
                }
                
                // MARK: - Əsas Düymə
                Button(action: action) {
                    ZStack {
                        if isLoading {
                            ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .white))
                        } else {
                            Text(mode.buttonTitle)
                                .font(.system(size: 16, weight: .semibold))
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(buttonBackgroundColor)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
                .disabled(buttonIsDisabled)
                .padding(.top, 15)
            }
            .padding(16)
            .background(Color(red: 0.94, green: 0.96, blue: 0.96))
            .cornerRadius(20)
            
            // MARK: - Recovery Məlumatı
            if mode == .passwordRecovery {
                Text("Şifrənin bərpası üçün e-poçt ünvanınızı daxil edin.")
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
                    .padding(.top, 15)
                    .padding(.horizontal, 5)
            }
        }
        .padding(.horizontal, 20)
        .animation(.default, value: emailError) // Xəta çıxanda yumşaq keçid üçün
    }
    
    // MARK: - Yardımçı Hesablamalar
    var buttonBackgroundColor: Color {
        if isLoading || buttonIsDisabled {
            return Color.gray.opacity(0.6)
        }
        return Color(red: 77/255, green: 157/255, blue: 142/255)
    }
    
    var buttonIsDisabled: Bool {
        if isLoading { return true }
        if let isButtonActive = isButtonActive {
            return !isButtonActive || (emailError != nil && !emailError!.isEmpty)
        }
        return !canClickButton
    }
    
    var canClickButton: Bool {
        switch mode {
        case .login:
            return isEmailValid && !password.isEmpty
        case .registration:
            return isNameValid && isEmailValid && isPasswordValid && (emailError == nil || emailError!.isEmpty)
        case .passwordRecovery:
            return isEmailValid
        case .newPassword:
            return isPasswordValid
        }
    }

    @ViewBuilder
    func errorMessage(text: String) -> some View {
        Text(text)
            .font(.system(size: 12))
            .foregroundColor(.red)
            .padding(.horizontal, 10)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var isNameValid: Bool { name.trimmingCharacters(in: .whitespaces).count >= 4 }
    var isEmailValid: Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email)
    }
    var isPasswordValid: Bool {
        let regex = "^(?=.*[a-z])(?=.*[A-Z]).{8,25}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: password)
    }
    
    // MARK: - Reusable Inputlar
    @ViewBuilder
    func customTextField(title: String, placeholder: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.black.opacity(0.7))
                .padding(.horizontal, 12)
            TextField(placeholder, text: text)
                .font(.system(size: 15))
                .padding(12)
                .background(Color.white)
                .cornerRadius(10)
                .autocapitalization(.none)
                .autocorrectionDisabled()
        }
    }
    
    @ViewBuilder
    func customPasswordField(title: String, placeholder: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.black.opacity(0.7))
                .padding(.horizontal, 12)
            HStack {
                if isPasswordVisible {
                    TextField(placeholder, text: text)
                } else {
                    SecureField(placeholder, text: text)
                }
                Button(action: { isPasswordVisible.toggle() }) {
                    Image(systemName: isPasswordVisible ? "eye.fill" : "eye.slash.fill")
                        .foregroundColor(.gray)
                }
            }
            .font(.system(size: 15))
            .padding(12)
            .background(Color.white)
            .cornerRadius(10)
        }
    }
}
