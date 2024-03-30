//
//  EmailRegistrationView.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 2/29/24.
//

import SwiftUI

struct EmailRegistrationView: View {
    @State private var viewModel = RegistrationViewModel()
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Spacer()
            
            Image("The_Mouve-test-logo")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            VStack {
                TextField("Enter your email", text: $viewModel.email)
                    .autocapitalization(.none)
                    .modifier(TheMouveTextFieldModifier())
                
                SecureField("Enter your password", text: $viewModel.password)
                    .modifier(TheMouveTextFieldModifier())
                
                TextField("Enter your full name", text: $viewModel.fullName)
                    .modifier(TheMouveTextFieldModifier())
                
                TextField("Enter Your username", text: $viewModel.username)
                    .autocapitalization(.none)
                    .modifier(TheMouveTextFieldModifier())
            }
            
            Button {
                Task { try await viewModel.createUser() }
            } label: {
                Text("Sign Up")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 352, height: 44)
                    .background(.black)//TODO: Change this to App color
                    .cornerRadius(8)
            }
            .padding(.vertical)
            
            Spacer()
            
            Divider()
            
            Button {
                dismiss()
            } label: {
                HStack(spacing: 3) {
                    Text("Already have an account?")
                    Text("Sign In")
                        .fontWeight(.semibold)
                }
                .foregroundColor(.black)
                .font(.footnote)
            }
            .padding(.vertical, 16)
        }
    }
}

#Preview {
    EmailRegistrationView()
}
