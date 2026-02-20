//
//  UIColor+DesignSystem.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 01.02.26.
//

import UIKit

public extension UIColor {
    static func fromHex(_ hex: String) -> UIColor {
        var hexString = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

        if hexString.hasPrefix("#") {
            hexString = String(hexString.dropFirst())
        }

        let scanner = Scanner(string: hexString)
        var color: UInt64 = 0
        scanner.scanHexInt64(&color)
        let mask = 0x000000FF
        let redRaw = Int(color >> 16) & mask
        let greenRaw = Int(color >> 8) & mask
        let blueRaw = Int(color) & mask
        let red   = CGFloat(redRaw) / 255.0
        let green = CGFloat(greenRaw) / 255.0
        let blue  = CGFloat(blueRaw) / 255.0

        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }

    static func rgba(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat = 1.0) -> UIColor {
        return UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
    }

    static let accent = UIColor.fromHex("#51AE39")
    static let backgroundPrimary = UIColor.fromHex("#F5F6F8")
    static let backGroundSecondary = UIColor.fromHex("#E4E4E4")
    static let backgroundF0 = UIColor.fromHex("#f0f0f0")
    static let textBlack = UIColor.fromHex("#000000")
    static let textPrimary = UIColor.fromHex("#2E2E2E")
    static let textSecondary = UIColor.fromHex("#617388")
    static let textAccent = UIColor.fromHex("#6CC654")
    static let textSuccess = UIColor.fromHex("#3F8F2A")
    static let textError = UIColor.fromHex("#F5222D")
    static let textInverted = UIColor.fromHex("#FFFFFF")
    static let buttonDisabled = UIColor.fromHex("#9A9A9A")
   // static let buttonPrimary = UIColor.fromHex("#09A895")
   
}


import SwiftUI

enum HekimimColors {
    static let background = Color(hex: "#E9F3F2")
    static let card = Color.white
    static let primary = Color(hex: "#07A795")
    static let textPrimary = Color.black
    static let textSecondary = Color(hex: "#4C4C4C")
    static let buttonSecondary = Color(hex: "#ACD4D4")
    static let buttonPrimary = Color(hex: "#09A895")
    static let badgeFill = Color(hex: "#E7F3F1")
    static let divider = Color(hex: "#E6E6E6")
    
    static let grayButton = Color(hex: "#D6D6D6")
    static let grayButtonText = Color(hex: "#6F6F6F")
    static let secondaryButton = Color(hex: "#24C4AC")
    
    static let lightButtonFill = Color(hex: "#EAF6F3")
    static let lightButtonBorder = Color(hex: "#D6EEE8")
    
    static let iconGray = Color(hex: "#9AA0A6")
}

extension Color {
    init(hex: String) {
        let hex = hex.replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: hex)
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let r = Double((rgb >> 16) & 0xff) / 255
        let g = Double((rgb >> 8) & 0xff) / 255
        let b = Double(rgb & 0xff) / 255

        self.init(red: r, green: g, blue: b)
    }
}
