//
//  ProfileView.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 2/29/24.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    
    private var user: User {
        return viewModel.user
    }
    private var isFollowed: Bool {
        return user.isFollowed ?? false
    }
    init(user: User){
        self.viewModel = ProfileViewModel(user: user)
    }
  
    var body: some View {
        ScrollView(showsIndicators: false, content: {
            VStack(alignment: .center, spacing: 4, content: {
                
                ProfileHeaderView(user: user)
                
                HStack(alignment: .center, spacing: 4, content: {
                    Button(action: {
                        handleFollowTapped()
                    }, label: {
                        Text( isFollowed ? "Following" : "Follow")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(isFollowed ? .black : .white)
                            .frame(width: 200, height: 32)
                            .background(isFollowed ? .white : .black)
                            .cornerRadius(8)
                            .overlay {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(isFollowed ? .black : .clear, lineWidth: 1)
                            }
                    })
                    
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "person.line.dotted.person")
                            .modifier(UserSocialMediaButtonModifier())
                    })
                    
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "person.line.dotted.person")
                            .modifier(UserSocialMediaButtonModifier())
                    })
                })
                .padding(.vertical)
                
                UserContentListView(user: user)
            })
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {

                } label: {
                    Image(systemName: "text.bubble")
                        .foregroundColor(.black)
                }
                
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .padding(.horizontal)
    }
    
    func handleFollowTapped() {
        if isFollowed {
            viewModel.unfollow()
        } else {
            viewModel.follow()
        }
    }
}

#Preview {
    ProfileView( user: User.MOCK_USER )
}
