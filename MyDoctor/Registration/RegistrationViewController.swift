//
//  RegistrationViewController.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 31.01.26.
//
import SwiftUI

struct RegistrationView: View {
    @StateObject private var viewModel = RegistrationViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: - Header (Back & Logo)
            VStack(spacing: 0) {
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.black)
                            .padding(10)
                    }
                    Spacer()
                }
                .padding(.horizontal, 10)
                .padding(.top, 5)
                
                Image("hospitalLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90, height: 90)
                    .padding(.top, 5)
            }
            .padding(.top, 0)
            
            ScrollView {
                VStack {
                    AuthFormView(mode: .registration)
                        .padding(.top, 20)
                }
                .padding(.horizontal, 10)
            }
            .scrollIndicators(.hidden)
            .scrollDismissesKeyboard(.interactively)
        }
        .navigationBarHidden(true)
    }
}
