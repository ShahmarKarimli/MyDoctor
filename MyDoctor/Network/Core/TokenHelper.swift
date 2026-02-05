//
//  TokenHelper.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 31.01.26.
//

import Foundation
import Security

protocol TokenHelper {
    
    
}

extension TokenHelper {
    func saveTokens(token: String/*, refreshToken: String*/) -> Bool {
        let tokenData = token.data(using: .utf8)!
        
        let tokenQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "accessToken",
            kSecValueData as String: tokenData
        ]
        
//        let refreshTokenQuery: [String: Any] = [
//            kSecClass as String: kSecClassGenericPassword,
//            kSecAttrAccount as String: "refreshToken",
//            kSecValueData as String: refreshTokenData
//        ]
        
        //Delete any existing items
        SecItemDelete(tokenQuery as CFDictionary)
      //  SecItemDelete(refreshTokenQuery as CFDictionary)
        
        //Add new tokens to the keychain
        let tokenStatus = SecItemAdd(tokenQuery as CFDictionary, nil)
      //  let refreshTokenStatus = SecItemAdd(refreshTokenQuery as CFDictionary, nil)
        
        return tokenStatus == errSecSuccess /*&& refreshTokenStatus == errSecSuccess*/
    }
    
    func retrieveToken() -> /*(token:*/ String?/*, refreshToken: String?)*/ {
        let tokenQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "accessToken",
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
//        let refreshTokenQuery: [String: Any] = [
//            kSecClass as String: kSecClassGenericPassword,
//            kSecAttrAccount as String: "refreshToken",
//            kSecReturnData as String: kCFBooleanTrue!,
//            kSecMatchLimit as String: kSecMatchLimitOne
//        ]
        
        var tokenResult: AnyObject?
      //  var refreshTokenResult: AnyObject?
        
        SecItemCopyMatching(tokenQuery as CFDictionary, &tokenResult)
      //  SecItemCopyMatching(refreshTokenQuery as CFDictionary, &refreshTokenResult)
        
        let token = tokenResult as? Data
     //   let refreshToken = refreshTokenResult as? Data
        
        return //(
           /* token: */token != nil ? String(data: token!, encoding: .utf8) : nil//,
           // refreshToken: refreshToken != nil ? String(data: refreshToken!, encoding: .utf8) : nil
        //)
    }
    
    func deleteToken() {
        let tokenQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "accessToken",
        ]
//        let refreshTokenQuery: [String: Any] = [
//            kSecClass as String: kSecClassGenericPassword,
//            kSecAttrAccount as String: "refreshToken"
//        ]
        SecItemDelete(tokenQuery as CFDictionary)
       // SecItemDelete(refreshTokenQuery as CFDictionary)
    }
}
