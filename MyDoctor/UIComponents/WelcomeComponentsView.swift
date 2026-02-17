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
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.black.opacity(0.8))
            
            Spacer()
            
            // Buttons
            VStack(spacing: 15) {
                Button(action: primaryButtonAction) {
                    Text(primaryButtonTitle)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 77/255, green: 157/255, blue: 142/255))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                
                Button(action: secondaryButtonAction) {
                    Text(secondaryButtonTitle)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 100/255, green: 196/255, blue: 178/255))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 50)
        }
    }
}

// MARK: - Preview
struct WelcomeComponentView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeComponentView(
            title: "Xoş gəlmişsiniz",
            primaryButtonTitle: "Qeydiyyatdan keç",
            secondaryButtonTitle: "Daxil ol",
            primaryButtonAction: {},
            secondaryButtonAction: {}
        )
    }
}
