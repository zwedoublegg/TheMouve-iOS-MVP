//
//  ProfileHeaderView.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 3/8/24.
//

import SwiftUI

struct ProfileHeaderView: View {
    var user: User?
    
    init(user: User?){
        self.user = user
    }
    
    var body: some View {
        CircularProfileImageView(user: user, size: .large)
        
        Text(user?.username ?? "")
            .font(.title2)
            .fontWeight(.semibold)
        
        if let bio = user?.bio {
            Text("This is the user bio and tell me what you think about this artist \(bio)")
                .multilineTextAlignment(.center)
                .font(.headline)
                .fontWeight(.regular)
        }
        
        HStack { // This displays user's stats
            Text("Following 200")
            Text("||")
            Text("12 Friends")
            Text("||")
            Text("1200 Followers")
        }
        .font(.footnote)
        .fontWeight(.semibold)
        .foregroundColor(.gray)
        .padding(.top)
    }
}

#Preview {
    ProfileHeaderView(user: User.MOCK_USER)
}
