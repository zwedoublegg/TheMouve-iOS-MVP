//
//  Comments.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 4/5/24.
//

import SwiftUI

struct CommentsView: View {
    @State private var commentText = ""
    @StateObject var viewModel: CommentsViewModel
    
    private var currentUser: User? {
        return UserService.shared.currentUser
    }
    
    init( mouve: Mouve){
        self._viewModel = StateObject(wrappedValue: CommentsViewModel(mouve: mouve))
    }
    
    var body: some View {
        VStack{
            Text(verbatim: "Comments")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(.top, 24)
            
            Divider()
            
            ScrollView {
                LazyVStack (spacing: 24) {
                    ForEach(viewModel.comments) { comment in
                        CommentsViewCell(comment: comment)
                    }
                }
            }
            .padding(.top)
            
            Divider()
            
            HStack(spacing: 12, content: {
                CircularProfileImageView(user: currentUser, size: .xSmall)
                
                ZStack(alignment: .trailing, content: {
                    TextField("Add a comment...", text: $commentText, axis: .vertical)
                        .font(.footnote)
                        .padding(12)
                        .padding(.trailing, 40)
                        .overlay {
                            Capsule()
                                .stroke(Color(.systemGray4), lineWidth: 1)
                        }
                    
                    Button {
                        if !commentText.isEmpty {
                            Task{
                                try await viewModel.uploadComment(commentText: commentText)
                                commentText = ""
                            }
                        }
                        
                    } label: {
                        Text("Post")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(.systemBlue))
                    }
                    .padding(.horizontal)
                })
                
            })
            .padding(12)
        }
    }
}

#Preview {
    CommentsView(mouve: Mouve.MOCK_MOUVE)
}
