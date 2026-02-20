//
//  AccountsOptionsView.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 16.02.26.
//

//
//  ProfileSelectionView.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 16.02.26.
//

import SwiftUI

struct ProfileSelectionView: View {
    @State private var navigateToDoctor = false
    @State private var navigateToPatient = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        WelcomeComponentView(
            title: "Hansı profildə davam edəcəyinizi seçin",
            primaryButtonTitle: "Həkim",
            secondaryButtonTitle: "Pasiyent",
            primaryColor: HekimimColors.buttonSecondary,
            secondaryColor: HekimimColors.buttonPrimary,
            primaryButtonAction: {
                navigateToDoctor = true
            },
            secondaryButtonAction: {
                navigateToPatient = true
            }
        )
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .bold()
                        .foregroundColor(.teal)
                }
            }
        }
        .background(Color.white)
        .navigationDestination(isPresented: $navigateToDoctor) {
            RegistrationView(viewModel: StateObject(wrappedValue: RegistrationViewModel(accoutType: "DOCTOR")))
        }
        .navigationDestination(isPresented: $navigateToPatient) {
            RegistrationView(viewModel: StateObject(wrappedValue: RegistrationViewModel(accoutType: "PATIENT")))
        }
    }
}
