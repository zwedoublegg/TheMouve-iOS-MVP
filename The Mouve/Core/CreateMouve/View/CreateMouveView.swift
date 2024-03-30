//
//  CreateMouveView.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 2/29/24.
//

import SwiftUI

struct CreateMouveView: View {
    @StateObject var viewModel = CreateMouveViewModel()
    @State private var mouveCaption = ""
    @Environment(\.dismiss) var dismiss
    
    private var user: User? {
        return UserService.shared.currentUser
    }

    var body: some View {
        NavigationStack {
            VStack {
                HStack(alignment: .top, content: {
                    CircularProfileImageView(user: user, size: .medium)
                    
                    VStack (alignment: .leading, spacing: 4, content: {
                        Text("What's the mouve?")
                            .foregroundColor(Color(.black)) //TODO: Change this gray colour
                            .fontWeight(.semibold)
                        
                        TextField("Example: the name, a brief description, when it starts and ends, the location and if it's free or not", text: $mouveCaption, axis: .vertical).multilineTextAlignment(.leading) //TODO: Make placeholder multiline
                    })
                    .font(.callout)
                    
                    Image(systemName: "photo.badge.plus.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                })
                
                Spacer()
            }
            .padding()
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading, content: {
                    Button ("Cancel") {
                        dismiss()
                    }
                    .font(.subheadline)
                    .foregroundColor(.black)
                })
                
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button ("Continue") {
//                        Task { try await viewModel.uploadMouve(mouveCaption: mouveCaption)}
                        Task { try await viewModel.sendPromptToGPT(prompt: mouveCaption)}
//                        dismiss()
                    }
                    .opacity(mouveCaption.isEmpty ? 0.5 : 1.0)
                    .disabled(mouveCaption.isEmpty)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                })
            })
        }
    }
}

#Preview {
    CreateMouveView()
}
