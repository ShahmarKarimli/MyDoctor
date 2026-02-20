//
//  WelcomeComponentsView.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 16.02.26.
//


import SwiftUI

struct WelcomeComponentView: View {
    let title: String
    let primaryButtonTitle: String
    let secondaryButtonTitle: String
    let primaryColor: Color
    let secondaryColor: Color
    let primaryButtonAction: () -> Void
    let secondaryButtonAction: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Spacer()
            
            // Logo
            Image("hospitalLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .foregroundColor(Color(red: 128/255, green: 203/255, blue: 196/255))
            
            // Title
            Text(title)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.black.opacity(0.8))
            
            Spacer()
            
            // Buttons
            VStack(spacing: 15) {
                Button(action: primaryButtonAction) {
                    Text(primaryButtonTitle)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(primaryColor)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                
                Button(action: secondaryButtonAction) {
                    Text(secondaryButtonTitle)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(secondaryColor)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 50)
        }
    }
}

