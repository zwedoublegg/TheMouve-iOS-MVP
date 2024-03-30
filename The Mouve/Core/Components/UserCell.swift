//
//  UserCell.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 3/1/24.
//

import SwiftUI

struct UserCell: View {
    let user:User
    var body: some View {
        HStack {
            CircularProfileImageView(user: user, size: .small)
            
            VStack(alignment: .leading) {
                Text(user.fullName)
                    .fontWeight(.semibold)
                
                Text(user.username)
            }
            .font(.footnote)
            
            Spacer()
            
            Text("Follow")
                .font(.subheadline)
                .fontWeight(.semibold)
                .frame(width: 100, height: 32)
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1).foregroundColor(Color(.systemGray4)))
        }
        .padding(.horizontal)
    }
}

#Preview {
    UserCell(user: User.MOCK_USER)
}
