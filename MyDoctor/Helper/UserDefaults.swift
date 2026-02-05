//
//  UserDefaults.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 31.01.26.
//
import Foundation

enum UserDefaultsKeys: String {
    case accountId = "UD_KEY_ACCOUNT_ID"
    
    func setString(_ string: String) {
        UserDefaults.standard.set(string, forKey: self.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func setInt(_ int: Int) {
        UserDefaults.standard.set(int, forKey: self.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func setBool(_ bool: Bool) {
        UserDefaults.standard.set(bool, forKey: self.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func setFloat(_ float: Float) {
        UserDefaults.standard.set(float, forKey: self.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func setDouble(_ double: Double) {
        UserDefaults.standard.set(double, forKey: self.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func getString() -> String? {
        return UserDefaults.standard.string(forKey: self.rawValue)
    }
    
    func getInt(key: String) -> Int {
        return UserDefaults.standard.integer(forKey: self.rawValue)
    }
    
    func getBool(key: String) -> Bool {
        return UserDefaults.standard.bool(forKey: self.rawValue)
    }
    
    func getFloat(key: String) -> Float {
        return UserDefaults.standard.float(forKey: self.rawValue)
    }
    
    func getDouble(key: String) -> Double {
        return UserDefaults.standard.double(forKey: self.rawValue)
    }
    
    func remove() {
        UserDefaults.standard.removeObject(forKey: self.rawValue)
        UserDefaults.standard.synchronize()
    }
}

let UD_KEY_ACCOUNT_ID = "UD_KEY_ACCOUNT_ID"
