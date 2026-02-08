//
//  AuthFormView.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 04.02.26.
//

import SwiftUI

struct AuthFormView: View {
    var mode: AuthMode
    @Binding var name: String
    @Binding var email: String
    @Binding var password: String
    
    var isButtonActive: Bool? = nil
    var emailError: String? = nil
    var action: () -> Void
    
    @State private var isPasswordVisible = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            VStack(spacing: 8) {
                
                // MARK: - Ad Sahəsi
                if mode == .registration {
                    customTextField(title: "Ad", placeholder: "Nuridə", text: $name)
                    if !name.isEmpty && !isNameValid {
                        errorMessage(text: "Ad minimum 4 hərfdən ibarət olmalıdır.")
                            .padding(.bottom, 4)
                    }
                }
                
                // MARK: - Email Sahəsi
                VStack(alignment: .leading, spacing: 0) { // Error mesajı ilə bitişik olsun
                    customTextField(title: "E-mail", placeholder: "nuridaismail88@gmail.com", text: $email)
                    
                    if let error = emailError {
                        errorMessage(text: error).padding(.top, 4)
                    } else if !email.isEmpty && !isEmailValid {
                        errorMessage(text: "Düzgün email daxil edin.").padding(.top, 4)
                    }
                }
                
                // MARK: - Şifrə Sahəsi
                if mode != .passwordRecovery {
                    VStack(alignment: .leading, spacing: 0) {
                        customPasswordField(title: "Şifrə", placeholder: "Nurida1988", text: $password)
                        
                        if !password.isEmpty && !isPasswordValid {
                            errorMessage(text: "Şifrə 8-25 simvol, 1 böyük və 1 kiçik hərf olmalıdır.")
                                .padding(.top, 4)
                        }
                    }
                }
                
                
                Button(action: action) {
                    Text(mode.buttonTitle)
                        .font(.system(size: 16, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background((isButtonActive ?? isFormValid) ? Color(red: 77/255, green: 157/255, blue: 142/255) : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .disabled(!(isButtonActive ?? isFormValid))
                .padding(.top, 12)
            }
            .padding(16)
            .background(Color(red: 0.94, green: 0.96, blue: 0.96))
            .cornerRadius(20)
        }
        .padding(.horizontal, 20)
    }
    
    @ViewBuilder
    func errorMessage(text: String) -> some View {
        Text(text)
            .font(.system(size: 11))
            .foregroundColor(.red)
            .padding(.horizontal, 10)
            .fixedSize(horizontal: false, vertical: true)
    }
    
    
    var isNameValid: Bool {
        name.trimCharacters().count >= 4
    }
    
    var isEmailValid: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    var isPasswordValid: Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z]).{8,25}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
    
    var isFormValid: Bool {
        switch mode {
        case .registration:
            return isNameValid && isEmailValid && isPasswordValid
        case .passwordRecovery:
            return isEmailValid
        default:
            return isEmailValid && !password.isEmpty
        }
    }
    
    // MARK: - Custom Input Fields
    
    @ViewBuilder
    func customTextField(title: String, placeholder: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.black)
                .padding(.horizontal, 12)
                .padding(.top, 8)
            
            TextField(placeholder, text: text)
                .font(.system(size: 14))
                .padding(.horizontal, 12)
                .padding(.bottom, 8)
                .keyboardType(title == "E-mail" ? .emailAddress : .default)
                .autocapitalization(.none)
                .disableAutocorrection(true)
        }
        .background(Color.white)
        .cornerRadius(12)
    }
    
    @ViewBuilder
    func customPasswordField(title: String, placeholder: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.black)
                .padding(.horizontal, 12)
                .padding(.top, 8)
            
            ZStack(alignment: .trailing) {
                Group {
                    if isPasswordVisible {
                        TextField(placeholder, text: text)
                    } else {
                        SecureField(placeholder, text: text)
                    }
                }
                .padding(.leading, 12)
                .padding(.trailing, 40)
                .autocapitalization(.none)
                
                Button(action: { isPasswordVisible.toggle() }) {
                    Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
                .padding(.trailing, 12)
            }
            .font(.system(size: 14))
            .padding(.bottom, 12)
        }
        .background(Color.white)
        .cornerRadius(12)
    }
}

extension String {
    func trimCharacters() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
