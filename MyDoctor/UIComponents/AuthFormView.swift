//
//  AuthFormView.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 04.02.26.
//

import SwiftUI

struct AuthFormView: View {
    var mode: AuthMode
    
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(mode.title)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.black)
            
            VStack(spacing: 12) {
                
                if mode == .registration {
                    VStack(alignment: .leading, spacing: 4) {
                        customTextField(title: "Ad", placeholder: "Nuridə", text: $name)
                        if !name.isEmpty && !isNameValid {
                            errorMessage(text: "Ad minimum 4 hərfdən ibarət olmalıdır.")
                        }
                    }
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    customTextField(title: "E-mail", placeholder: "nuridaismail88@gmail.com", text: $email)
                    if !email.isEmpty && !isEmailValid {
                        errorMessage(text: "Düzgün email daxil edin.")
                    }
                }
                
                if mode != .passwordRecovery {
                    VStack(alignment: .leading, spacing: 4) {
                        customPasswordField(title: "Şifrə", placeholder: "Nurida1988", text: $password)
                        if !password.isEmpty && !isPasswordValid {
                            errorMessage(text: "Şifrə minimum 8 simvol, 1 böyük və 1 kiçik hərfdən ibarət olmalıdır.")
                        }
                    }
                }
                
                // MARK: - Təsdiq Düyməsi
                Button(action: {
                }) {
                    Text(mode.buttonTitle)
                        .font(.system(size: 16, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isFormValid ? Color(red: 77/255, green: 182/255, blue: 172/255) : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .disabled(!isFormValid)
                .padding(.top, 10)
            }
            .padding(16)
            .background(Color(red: 0.94, green: 0.96, blue: 0.96))
            .cornerRadius(20)
            
            if mode == .passwordRecovery {
                Text("Şifrənin bərpası üçün e-poçt ünvanınızı daxil edin.")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                    .padding(.horizontal, 5)
            }
        }
        .padding(.horizontal, 20)
    }
    
    // MARK: - Error Message View
    @ViewBuilder
    func errorMessage(text: String) -> some View {
        Text(text)
            .font(.system(size: 11))
            .foregroundColor(.red)
            .padding(.horizontal, 10)
            .transition(.opacity)
    }

    // MARK: - Validation Rules
    var isNameValid: Bool {
        let nameRegex = "^[A-Za-zƏəİıIıÖöĞğŞşÇç\\s]{4,}$"
        let namePredicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        return namePredicate.evaluate(with: name.trimmingCharacters(in: .whitespaces))
    }

    var isEmailValid: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        let hasValidFormat = emailPredicate.evaluate(with: email)
        let hasNoDoubleDot = !email.contains("..")
        let hasNoAtDot = !email.contains("@.")
        
        return hasValidFormat && hasNoDoubleDot && hasNoAtDot
    }

    var isPasswordValid: Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z]).{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
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
    
    // MARK: - Custom Fields
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
                .onChange(of: text.wrappedValue) { oldValue, newValue in
                    if title == "Ad" {
                        let filtered = newValue.filter { $0.isLetter || $0.isWhitespace }
                        if filtered.count > 50 {
                            text.wrappedValue = String(filtered.prefix(50))
                        } else if filtered != newValue {
                            text.wrappedValue = filtered
                        }
                    }
                    
                    if title == "E-mail" {
                        var filtered = newValue.filter { !$0.isWhitespace }.lowercased()
                        while filtered.contains("..") {
                            filtered = filtered.replacingOccurrences(of: "..", with: ".")
                        }
                        let parts = filtered.components(separatedBy: "@")
                        if parts.count > 2 {
                            filtered = parts[0] + "@" + parts[1...].joined(separator: "").replacingOccurrences(of: "@", with: "")
                        }
                        filtered = filtered.replacingOccurrences(of: "@.", with: "@")
                        if filtered != newValue {
                            text.wrappedValue = filtered
                        }
                    }
                }
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
                .disableAutocorrection(true)
                
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
