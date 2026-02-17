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
    
    var body: some View {
        WelcomeComponentView(
            title: "Hansı profildə davam edəcəyinizi seçin",
            primaryButtonTitle: "Həkim",
            secondaryButtonTitle: "Pasiyent",
            primaryButtonAction: {
                navigateToDoctor = true
            },
            secondaryButtonAction: {
                navigateToPatient = true
            }
        )
        .navigationDestination(isPresented: $navigateToDoctor) {
            RegistrationView(viewModel: StateObject(wrappedValue: RegistrationViewModel(accoutType: "DOCTOR")))
        }
        .navigationDestination(isPresented: $navigateToPatient) {
            RegistrationView(viewModel: StateObject(wrappedValue: RegistrationViewModel(accoutType: "PATIENT")))
        }
    }
}
