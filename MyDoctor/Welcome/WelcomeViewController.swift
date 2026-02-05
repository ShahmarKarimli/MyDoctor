//
//  WelcomeViewController.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 31.01.26.
//

import Foundation

import SwiftUI

struct WelcomeView: View {
    @StateObject private var viewModel = WelcomeViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                
                Text("Xoş gəlmişsiniz")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.primary)
                
                Spacer()
                
                VStack(spacing: 15) {
                    NavigationLink(destination: RegistrationView()) {
                        Text("Qeydiyyatdan keç")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 77/255, green: 182/255, blue: 172/255))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    
                    NavigationLink(destination: LoginView()) {
                        Text("Daxil ol")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 100/255, green: 200/255, blue: 185/255))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }
                .padding(.horizontal, 20)
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
