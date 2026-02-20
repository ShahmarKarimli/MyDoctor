//
//  WelcomeViewController.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 31.01.26.
//

import SwiftUI

//
//  WelcomeViewController.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 31.01.26.
//

import SwiftUI

struct WelcomeView: View {
    @StateObject private var viewModel = WelcomeViewModel()
    @State private var navigateToRegistration = false
    @State private var navigateToLogin = false
   
    
    var body: some View {
        NavigationStack {
            WelcomeComponentView(
                title: "Xoş gəlmişsiniz",
                primaryButtonTitle: "Qeydiyyatdan keç",
                secondaryButtonTitle: "Daxil ol",
                primaryColor: HekimimColors.buttonPrimary,
                secondaryColor: HekimimColors.secondaryButton,
                primaryButtonAction: {
                    navigateToRegistration = true
                },
                secondaryButtonAction: {
                    navigateToLogin = true
                }
            )
            .navigationDestination(isPresented: $navigateToRegistration) {
                ProfileSelectionView()
                    .navigationBarBackButtonHidden(true)
            }
            .navigationDestination(isPresented: $navigateToLogin) {
                LoginView()
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
