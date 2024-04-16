//
//  ProfileHeaderView.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 3/8/24.
//

import SwiftUI

struct ProfileHeaderView: View {
    var user: User
    
    private var userStats: UserStats {
        return user.stats ?? .init(followingCount: 0, followersCount: 0, friendsCount: 0, mouveCount: 0)
    }
    init(user: User){
        self.user = user
    }
    
    var body: some View {
        CircularProfileImageView(user: user, size: .large)
        
        Text(user.username)
            .font(.title2)
            .fontWeight(.semibold)
        
        if let bio = user.bio {
            Text("This is the user bio and tell me what you think about this artist \(bio)")
                .multilineTextAlignment(.center)
                .font(.headline)
                .fontWeight(.regular)
        }
        
        HStack { // This displays user's stats
            NavigationLink(value: UserListConfig.following(uid: user.id)) {
                Text("Following \(userStats.followingCount)")
            }
            Text("||")
            NavigationLink(value: UserListConfig.followers(uid: user.id)) {
                Text("\(userStats.followingCount) Friends")
            }
            Text("||")
            NavigationLink(value: UserListConfig.followers(uid: user.id)) {
                Text("\(userStats.followersCount) Followers")
            }
        }
        .navigationDestination(for: UserListConfig.self, destination: { config in
            Text(config.navigationTitle)
        })
        .font(.footnote)
        .fontWeight(.semibold)
        .foregroundColor(.gray)
        .padding(.top)
    }
}

#Preview {
    ProfileHeaderView(user: User.MOCK_USER)
}
