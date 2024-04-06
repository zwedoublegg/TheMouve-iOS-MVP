//
//  CommentsViewCell.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 4/5/24.
//

import SwiftUI

struct CommentsViewCell: View {
    let comment: Comment
    
    private var user: User? {
        return comment.user
    }
    var body: some View {
        HStack {
            CircularProfileImageView(user: user, size: .xSmall)
            
            VStackLayout(alignment: .leading, spacing: 4) {
                HStack(spacing: 2){
                    Text(user?.username ?? "")
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Text("6d")
                        .foregroundColor(.gray)
                }
                
                Text(comment.commentText)
            }
            .font(.caption)
        }
        .padding(.horizontal)
    }
}

#Preview {
    CommentsViewCell(comment: Comment.MOCK_COMMENT)
}
