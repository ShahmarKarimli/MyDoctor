//
//  OTPViewModel.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 01.02.26.
//
import Foundation
import Combine

import Foundation
import Combine

class OTPViewModel: ObservableObject {
    
  
    @Published var otpCode = ""
    @Published var timeRemaining = 59
    @Published var isTimerRunning = false
    @Published var errorMessage: String?
    @Published var isBlocked = false
    @Published var isLoading = false
    @Published var isRegistrationComplete = false
    
    private var wrongAttempts = 0
    private var resendAttempts = 0
    let maxAttempts = 3
    let otpLength = 6
    private var timer: AnyCancellable?
    var coordinator: AppCoordinator?
    var email: String = ""

    init() { startTimer() }

    func startTimer() {
        timeRemaining = 60
        isTimerRunning = true
        timer?.cancel()
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                } else {
                    self.isTimerRunning = false
                    self.timer?.cancel()
                }
            }
    }

    func verifyOTP() {
        guard !isBlocked, otpCode.count == otpLength else { return }
        
        isLoading = true
        errorMessage = nil
        
        MyDoctorManager.shared.verifyOTP(email: email, code: otpCode) { [weak self] response in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch response {
                case .success(_):
                    self?.isRegistrationComplete = true
                case .error(let error):
                    self?.handleWrongAttempt(error.statusMessage ?? "Kod yanlışdır")
                }
            }
        }
    }

    private func handleWrongAttempt(_ message: String) {
        wrongAttempts += 1
        otpCode = ""
        
        if wrongAttempts >= maxAttempts {
            isBlocked = true
            errorMessage = "Çox sayda cəhd aşkarlandı. Zəhmət olmasa, bir az sonra yenidən cəhd edin."
            isTimerRunning = false
            timer?.cancel()
        } else {
            errorMessage = "\(message). Qalan cəhd: \(maxAttempts - wrongAttempts)"
        }
    }

    func resendCode() {
        guard !isBlocked, !isTimerRunning else { return }
        
        resendAttempts += 1
        if resendAttempts >= 3 {
            isBlocked = true
            errorMessage = "Çox sayda cəhd aşkarlandı. Zəhmət olmasa, bir az sonra yenidən cəhd edin."
            return
        }

        isLoading = true
        MyDoctorManager.shared.resendOTP(email: email) { [weak self] response in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch response {
                case .success(_):
                    self?.errorMessage = nil
                    self?.startTimer()
                case .error(let error):
                    self?.errorMessage = error.statusMessage ?? "Xəta baş verdi"
                }
            }
        }
    }
    
    func timeString(from totalSeconds: Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
