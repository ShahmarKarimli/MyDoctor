//
//  OtpViewController.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 01.02.26.
//

import SwiftUI

import SwiftUI

struct OTPView: View {
    @StateObject private var viewModel = OTPViewModel()
    @FocusState private var isFocused: Bool
    @Environment(\.dismiss) var dismiss
    var email: String

    var body: some View {
        VStack(spacing: 0) {
            // MARK: - Custom Header
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.black)
                        .padding(10)
                }
                Spacer()
            }
            .padding(.horizontal, 10)
            .padding(.top, 5)

            // MARK: - Title Section
            VStack(alignment: .leading, spacing: 10) {
                // Şəkildəki başlıq
                Text("OTP kodunu daxil edin")
                    .font(.system(size: 22, weight: .bold))
                
                Text("E-mailinizə göndərilən 6 rəqəmli kodu daxil edin")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 24)
            .padding(.top, 20)

            // MARK: - OTP Input Field (Hidden TextField + Visual Boxes)
            ZStack {
                TextField("", text: $viewModel.otpCode)
                    .frame(width: 1, height: 1)
                    .opacity(0.01)
                    .keyboardType(.numberPad)
                    .focused($isFocused)
                    .disabled(viewModel.isBlocked)
                    .onChange(of: viewModel.otpCode) { newValue in
                        if newValue.count == 6 {
                            viewModel.verifyOTP()
                        } else if newValue.count > 6 {
                            viewModel.otpCode = String(newValue.prefix(6))
                        }
                    }

                HStack(spacing: 12) {
                    ForEach(0..<6, id: \.self) { index in
                        otpBox(at: index)
                    }
                }
            }
            .padding(.top, 30)

            // MARK: - Timer & Resend Section
            HStack(spacing: 15) {
                // Timer (Bloklananda rəngi dəyişir)
                Text(viewModel.timeString(from: viewModel.timeRemaining))
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(viewModel.isBlocked ? .gray.opacity(0.5) : .black)
                
                Button(action: {
                    viewModel.resendCode()
                }) {
                    Text("Kodu yenidən göndər")
                        .font(.system(size: 14))
                        .foregroundColor(viewModel.isTimerRunning || viewModel.isBlocked ? .gray.opacity(0.5) : Color(red: 77/255, green: 157/255, blue: 142/255))
                        .underline(!viewModel.isTimerRunning && !viewModel.isBlocked)
                }
                .disabled(viewModel.isTimerRunning || viewModel.isBlocked)
            }
            .padding(.top, 25)

            // MARK: - Error Message (Figma OTP 2 dizaynı)
            if let error = viewModel.errorMessage {
                Text(error)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.red)
                    .padding(.horizontal, 40)
                    .padding(.top, 20)
                    .multilineTextAlignment(.center) // Şəkildə mərkəzdədir
            }

            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        // MARK: - Navigation Logic
        .navigationDestination(isPresented: $viewModel.isRegistrationComplete) {
            WelcomeView()
        }
        .onAppear {
            viewModel.email = email
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isFocused = true
            }
        }
    }

    // MARK: - OTP Box Design
    @ViewBuilder
    func otpBox(at index: Int) -> some View {
        let char = viewModel.otpCode.count > index ?
            String(viewModel.otpCode[viewModel.otpCode.index(viewModel.otpCode.startIndex, offsetBy: index)]) : ""
        
        Text(char.isEmpty ? "X" : char)
            .font(.system(size: 22, weight: .bold))
            .foregroundColor(char.isEmpty ? .gray.opacity(0.3) : .black)
            .frame(width: 48, height: 58)
            .background(Color(red: 0.94, green: 0.97, blue: 0.97))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(viewModel.errorMessage != nil ? Color.red.opacity(0.3) : Color.clear, lineWidth: 1.5)
            )
    }
}
