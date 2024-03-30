//
//  ProfileView.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 2/29/24.
//

import SwiftUI

struct ProfileView: View {
    //Dependency injection
    let user: User
  
    var body: some View {
        ScrollView(showsIndicators: false, content: {
            VStack(alignment: .center, spacing: 4, content: {
                
                ProfileHeaderView(user: user)
                
                HStack(alignment: .center, spacing: 4, content: { //TODO: Optimize code with viewmodels
                    Button(action: {
                        
                    }, label: {
                        Text("Follow")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 200, height: 32)
                            .background(.black)
                            .cornerRadius(8)
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
}

#Preview {
    ProfileView( user: User.MOCK_USER )
}
