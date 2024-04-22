//
//  NewMessageView.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 3/14/24.
//

import SwiftUI

struct NewMessageView: View {
    
    @Binding var selectedUser: User?
    @Environment(\.dismiss) var dismiss
    @State private var searchText = ""
    @StateObject private var viewModel = NewMessageViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                TextField("To: ", text: $searchText)
                    .frame(height: 44)
                    .padding(.leading)
                    .background(Color(.systemGroupedBackground))
                
                Text("friends")
                    .foregroundColor(.gray)
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                ForEach (viewModel.users){ user in
                    VStack {
                        HStack {
                            CircularProfileImageView(user: user, size: .small)
                            
                            Text(user.username)
                                .font(.footnote)
                                .fontWeight(.semibold)
                            
                            Spacer()
                        }
                        .padding(.leading)
                        
                        Divider()
                            .padding(.leading, 56)
                    }
                    .onTapGesture {
                        selectedUser = user
                        dismiss()
                    }
                }
            }
            .navigationTitle("New Message")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel"){
                        dismiss()
                    }
                    .foregroundColor(.black)
                }
            }
        }
    }
}

#Preview {
    NavigationStack{
        NewMessageView(selectedUser: .constant(User.MOCK_USER))
    }
}
