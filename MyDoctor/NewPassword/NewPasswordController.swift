//
//  NewPasswordController.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 02.02.26.
//

import SwiftUI

struct NewPasswordView: View {
    @StateObject private var viewModel: NewPasswordViewModel
    @Environment(\.dismiss) var dismiss
    
    init(email: String) {
        _viewModel = StateObject(wrappedValue: NewPasswordViewModel(email: email))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: - Header
            VStack(alignment: .leading, spacing: 0) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.black)
                        .padding(.vertical, 10)
                }
                .padding(.horizontal, 20)
                
                HStack {
                    Spacer()
                    Image("hospitalLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                    Spacer()
                }
                .padding(.top, 10)

                Text("Yeni şifrə")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.horizontal, 25)
                    .padding(.top, 25)
            }
            
            ScrollView {
                VStack {
                    AuthFormView(
                        mode: .newPassword,
                        name: .constant("Shahmar"),
                        email: .constant(viewModel.email),
                        password: $viewModel.password,
                        isLoading: viewModel.isLoading,
                        isButtonActive: viewModel.isFormValid,
                        emailError: viewModel.errorMessage,
                        action: {
                            viewModel.forgotPassword()
                        }
                    )
                    .padding(.top, 20)
                    
                    Text("Yeni şifrənizi daxil edin və yadda saxlayın.")
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                        .padding(.top, 15)
                        .padding(.horizontal, 25)
                }
            }
        }
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $viewModel.isSuccess, destination: {
            OTPView(viewModel: ResetPasswordOTPViewModel(password: viewModel.password, email: viewModel.email))
        })
    }
}

