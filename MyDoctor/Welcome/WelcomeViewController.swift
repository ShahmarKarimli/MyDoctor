//
//  WelcomeViewController.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 31.01.26.
//

import SwiftUI

import SwiftUI

struct WelcomeView: View {
    @StateObject private var viewModel = WelcomeViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                Spacer()
                Spacer()
                
                Image("hospitalLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .foregroundColor(Color(red: 128/255, green: 203/255, blue: 196/255))
                
                Text("Xoş gəlmişsiniz")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.black.opacity(0.8))
                
                Spacer()
                
                VStack(spacing: 15) {
                    NavigationLink(destination: RegistrationView()) {
                        Text("Qeydiyyatdan keç")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 77/255, green: 157/255, blue: 142/255))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    
                    NavigationLink(destination: LoginView()) {
                        Text("Daxil ol")
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
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
