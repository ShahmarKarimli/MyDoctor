//
//  MyDoctorManager.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 01.02.26.
//

import Foundation

class AuthManager {
    
    static let shared = AuthManager()
    private init() {}
    
    // MARK: - Registration
    func register(user: RegisterRequestModel, completion: @escaping (NetworkResponse<MessageDTO>) -> Void) {
        let model = NetworkRequestModel(
            path: MyDoctorEndPoints.register.path, //
            method: .post,
            pathParams: nil,
            body: user,
            queryParams: nil
        )
        NetworkManager.shared.request(model: model, completion: completion)
    }
    
    // MARK: - Login
    func login(user: LoginRequestModel, completion: @escaping (NetworkResponse<TokenDTO>) -> Void) {
        let model = NetworkRequestModel(
            path: MyDoctorEndPoints.login.path,
            method: .post,
            pathParams: nil,
            body: user, //
            queryParams: nil
        )
        NetworkManager.shared.request(model: model, completion: completion)
    }
    
    // MARK: - OTP Verification
    func verifyOTP(email: String, code: String, completion: @escaping (NetworkResponse<TokenDTO>) -> Void) {
        let body = VerifyOtpRequestModel(email: email, code: code)
        let model = NetworkRequestModel(
            path: MyDoctorEndPoints.verify.path,
            method: .post,
            pathParams: nil,
            body: body,
            queryParams: nil
        )
        NetworkManager.shared.request(model: model, completion: completion)
    }
    
    // MARK: - Resend OTP
    func resendOTP(email: String, completion: @escaping (NetworkResponse<MessageDTO>) -> Void) {
        let body: [String: Any] = ["email": email]
        
        let model = NetworkRequestModel(
            path: MyDoctorEndPoints.resendVerification.path, 
            method: .post,
            pathParams: nil,
            body: body,
            queryParams: nil
        )
        
        NetworkManager.shared.request(model: model, completion: completion)
    }
    
    func checkEmail(email: String, completion: @escaping (NetworkResponse<CheckEmailResponse>) -> Void) {
        let queryParams = ["email": email]
        let model = NetworkRequestModel(
            path: MyDoctorEndPoints.checkEmail.path,
            method: .get,
            pathParams: nil,
            body: nil,
            queryParams: queryParams
        )
        NetworkManager.shared.request(model: model, completion: completion)
    }
    
    func forgotPassword(email: String, completion: @escaping (NetworkResponse<MessageDTO>) -> Void) {
        let body = EmailRequestModel(email: email)
        
        let model = NetworkRequestModel(
            path: MyDoctorEndPoints.forgotPassword.path,
            method: .post,
            pathParams: nil,
            body: body,
            queryParams: nil
        )
        NetworkManager.shared.request(model: model, completion: completion)
    }
    
    func resetPassword(request: ResetPasswordRequestModel, completion: @escaping (NetworkResponse<MessageDTO>) -> Void) {
        let model = NetworkRequestModel(
            path: MyDoctorEndPoints.resetPassword.path,
            method: .post,
            pathParams: nil,
            body: request, 
            queryParams: nil
        )
        NetworkManager.shared.request(model: model, completion: completion)
    }
    
}
