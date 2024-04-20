//
//  MouveFeedView.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 2/29/24.
//

import SwiftUI

struct MouveFeedView: View {
    @StateObject var viewModel = FeedViewModel()
    @State private var selectedFilter: FeedMouvesFilter = .scene
    @State private var showMouveCard = false
    @State private var selectedMouve: Mouve?
    @State private var showNotificationsView = false
    @Namespace var animation
    
    private var filterBarWidth: CGFloat {
        let count = CGFloat(ProfileMouvesFilter.allCases.count)
        return UIScreen.main.bounds.width / count - 20 //20 used below  to adjust for padding
    }

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: true){
                HStack{
                    ForEach(FeedMouvesFilter.allCases) { filter in
                        VStack {
                            Text(filter.title)
                                .font(.subheadline)
                                .fontWeight(selectedFilter == filter ? .semibold : .regular)
                            
                            if (selectedFilter == filter) {
                                Rectangle()
                                    .foregroundColor(.black)
                                    .frame(width: filterBarWidth, height: 1.5)
                                    .matchedGeometryEffect(id: "item", in: animation)
                            } else {
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: filterBarWidth, height: 1.5)
                            }
                        }
                        .onTapGesture {
                            withAnimation (.spring()) {
                                selectedFilter = filter
                            }
                        }
                    }
                }
                LazyVStack(alignment: .center, spacing: 4, content:  {
                    switch selectedFilter {
                    case .scene:
                        ForEach (viewModel.mouves) { mouve in
                            MouveFeedCellView(mouve: mouve)
                                .transition(.move(edge: .leading)) //for animating tabe selector
                        }
                    case .following:
                        ForEach(viewModel.followingMouves) { mouve in
                            MouveFeedCellView(mouve: mouve)
                                .transition(.move(edge: .trailing))
                        }
                    }
                    
                })
            }
            .padding(.horizontal)
            .refreshable {
                Task{
                    try await viewModel.fetchMouves()
                    try await viewModel.fetchFollowingMouves()
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem (placement: .navigationBarTrailing) {
                    Button{
                        showNotificationsView.toggle()
                    } label: {
                        Image(systemName: "bell")
                            .foregroundColor(.black)
                    }
                }
            }
            .navigationDestination(isPresented: $showNotificationsView, destination: {
                NotificationsView()
            })
//            .navigationDestination(for: User.self) { user in
//                ProfileView(user: user)
//            }
        }
    }
}

#Preview {
    NavigationStack {
        MouveFeedView()
    }
}
