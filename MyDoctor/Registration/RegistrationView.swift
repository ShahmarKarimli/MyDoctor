//
//  RegistrationViewController.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 31.01.26.
//
import SwiftUI

struct RegistrationView: View {
    @StateObject private var viewModel: RegistrationViewModel
    @Environment(\.dismiss) var dismiss
    
    init(viewModel: StateObject<RegistrationViewModel>) {
        _viewModel = viewModel
    }    
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    Image("hospitalLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding(.top, 60)
                }
                .frame(maxWidth: .infinity)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Hesab yarat")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.black.opacity(0.8))
                            .padding(.horizontal, 25)
                            .padding(.top, 30)
                        
                        AuthFormView(
                            mode: .registration,
                            name: $viewModel.fullName,
                            email: $viewModel.email,
                            password: $viewModel.password,
                            isButtonActive: viewModel.isFormValid && !viewModel.isLoading,
                            emailError: viewModel.emailCheckError ?? viewModel.errorMessage ?? "",
                            action: {
                                viewModel.handleRegistration()
                            }
                        )
                        .padding(.horizontal, 5)
                    }
                }
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: { dismiss() }) {
                            Image(systemName: "chevron.left")
                                .bold()
                                .foregroundColor(.teal)
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .scrollDismissesKeyboard(.interactively)
            }
            .background(Color.white)
            .blur(radius: viewModel.isLoading ? 2 : 0)
            .disabled(viewModel.isLoading)

            if viewModel.isLoading {
                ZStack {
                    Color.black.opacity(0.2)
                        .ignoresSafeArea()
                    
                    VStack(spacing: 15) {
                        ProgressView()
                            .controlSize(.large)
                            .tint(.teal)
                        
                        Text("Zəhmət olmasa, gözləyin...")
                            .font(.subheadline)
                            .fontWeight(.medium)
                    }
                    .padding(30)
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 10)
                }
            }
        }
        .navigationDestination(isPresented: $viewModel.showOtpField) {
            OTPView(viewModel: RegisterOTPViewModel(email: viewModel.email))
        }
        .alert("Xəta", isPresented: .init(get: {
            viewModel.errorMessage != nil && viewModel.emailCheckError == nil
        }, set: { _ in viewModel.errorMessage = nil })) {
            Button("Tamam", role: .cancel) { }
        } message: {
            Text(viewModel.errorMessage ?? "")
        }
    }
}
