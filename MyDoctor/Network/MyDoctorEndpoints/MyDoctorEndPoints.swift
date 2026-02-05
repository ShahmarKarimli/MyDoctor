//
//  MyDoctorEndPoints.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 31.01.26.
//

import Foundation

enum MyDoctorEndPoints: String {
    // Authentication Controller endpoints
    case verify = "/auth/verify"
    case resetPassword = "/auth/reset-password"
    case resendVerification = "/auth/resend-verification"
    case register = "/auth/register"
    case checkEmail = "/auth/check-email"
    case login = "/auth/login"
    case forgotPassword = "/auth/forgot-password"
    
    // Base API yolu
    static var mainPath: String {
        return "/api"
    }
    
    var path: String {
        return MyDoctorEndPoints.mainPath + self.rawValue
    }
}
