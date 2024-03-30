//
//  MouveFeedView.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 2/29/24.
//

import SwiftUI

struct MouveFeedView: View {
    @StateObject var viewModel = FeedViewModel()

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false){
                ContentListHeaderView()
                LazyVStack(alignment: .center, spacing: 4, content:  {
                    ForEach (viewModel.mouves) { mouve in
                        MouveFeedCellView( mouve: mouve)
                    }
                })
                .padding(.horizontal)
            }
            .refreshable {
                Task{ try await viewModel.fetchMouves() }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem (placement: .navigationBarTrailing) {
                    Button{
                        
                    } label: {
                        Image(systemName: "bell")
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        MouveFeedView()
    }
}
