//
//  CurrentUserProfileView.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 3/8/24.
//

import SwiftUI

struct CurrentUserProfileView: View {
    @StateObject var viewModel = CurrentUserProfileViewModel()
    @State private var showEditProfile = false
    
    private var currentUser: User? {
        return viewModel.currentUser
    }
    
    var body: some View {
        NavigationStack{
            ScrollView(showsIndicators: false, content: {
                VStack(alignment: .center, spacing: 4, content: {
                    if let user = currentUser {
                        ProfileHeaderView(user: user)
                    }
                    
                    HStack(alignment: .center, spacing: 6, content: { //TODO: Optimize code with viewmodels
                        Button(action: {
                            showEditProfile.toggle()
                        }, label: {
                            Text("Edit Profile")
                                .modifier(CurrentUserHeaderButtonModifier())
                        })
                        
                        Button(action: {
                            
                        }, label: {
                            Text("Share Profile")
                                .modifier(CurrentUserHeaderButtonModifier())
                        })
                    })
                    .sheet(isPresented: $showEditProfile, content: {
                        if let user = currentUser {
                            EditProfileView(user: user)
                        }
                    })
                    .padding(.vertical)
                    
                    if let user = currentUser {
                        UserContentListView(user: user)
                    }
                })
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        AuthService.shared.signOut()
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .foregroundColor(.black)
                    }

                }
            }
            .padding(.horizontal)
            
        }
    }
}

#Preview {
    CurrentUserProfileView()
}
