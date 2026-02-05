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
    static let buttonPrimary = UIColor.fromHex("#09A895")
   
}
