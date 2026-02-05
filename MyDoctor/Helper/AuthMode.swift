//
//  AuthMode.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 04.02.26.
//

enum AuthMode {
    case registration
    case login
    case passwordRecovery
    case newPassword
    
    var title: String {
        switch self {
        case .registration: return "Hesab yarat"
        case .login: return "Daxil ol"
        case .passwordRecovery: return "Şifrənin bərpası"
        case .newPassword: return "Yeni şifrə"
        }
    }
    
    var buttonTitle: String {
        switch self {
        case .registration: return "Qeydiyyatdan keç"
        default: return "Növbəti"
        }
    }
}
