//
//  OTPViewModel.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 01.02.26.
//

import Foundation


/*enum OTPFlow {
    case registration
    case recovery
}

class OTPViewModel {
    
    enum ViewState {
        case loading
        case loaded
        case success(OTPFlow)
        case error(String)
    }
    
    var callBack: ((ViewState) -> Void)?
    var onTimerUpdate: ((String) -> Void)?
    var onLimitReached: (() -> Void)?
    
    var email: String?
    var recoveryToken: String?
    var flow: OTPFlow = .registration
    private var timer: Timer?
    private var remainingSeconds = 60
    
    var resendCount = 0
    private let maxResendLimit = 3
    
    // MARK: - API Methods
    
    func verifyCode(_ code: String) {
            guard let email = email else {
                self.callBack?(.error("Email tapılmadı."))
                return
            }
            
            callBack?(.loading)
            
            MyDoctorManager.shared.verifyOTP(email: email, code: code) { [weak self] response in
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    self.callBack?(.loaded)
                    
                    switch response {
                    case .success(let model):
                        self.recoveryToken = model.token
                        self.callBack?(.success(self.flow))
                    case .error(let error):
                        self.callBack?(.error(error.errorMessage))
                    }
                }
            }
        }
        
        func resendCode() {
            guard resendCount < maxResendLimit else {
                onLimitReached?()
                return
            }
            
            guard let email = email else {
                self.callBack?(.error("Email tapılmadı."))
                return
            }

            callBack?(.loading)
            
            MyDoctorManager.shared.resendOTP(email: email) { [weak self] response in
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    self.callBack?(.loaded)
                    
                    switch response {
                    case .success(_):
                        self.resendCount += 1
                        self.startTimer()
                        if self.resendCount >= self.maxResendLimit {
                            self.onLimitReached?()
                        }
                    case .error(let error):
                        self.callBack?(.error(error.errorMessage))
                    }
                }
            }
        }
        
        // MARK: - Timer Logic
        func startTimer() {
            remainingSeconds = 60
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
                guard let self = self else { return }
                if self.remainingSeconds > 0 {
                    self.remainingSeconds -= 1
                    let minutes = self.remainingSeconds / 60
                    let seconds = self.remainingSeconds % 60
                    self.onTimerUpdate?(String(format: "%02d:%02d", minutes, seconds))
                } else {
                    self.timer?.invalidate()
                }
            }
        }
}*/

import Foundation
import Combine

class OTPViewModel: ObservableObject {
    @Published var otpCode: String = ""
    @Published var timeRemaining = 60
    @Published var isTimerRunning = false
    
    private var timer: AnyCancellable?
    let otpLength = 6
    
    init() {
        startTimer()
    }
    
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
    
    func resendCode() {
        if !isTimerRunning {
            print("Kod yenidən göndərildi...")
            startTimer()
        }
    }
    
    func timeString(from seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func verifyOTP() {
        print("OTP təsdiqlənir: \(otpCode)")
    }
}
