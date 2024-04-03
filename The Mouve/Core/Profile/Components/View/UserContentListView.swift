//
//  UserContentListView.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 3/13/24.
//

import SwiftUI

struct UserContentListView: View {
    @StateObject var viewModel: UserContentListViewModel
    @State private var selectedFilter: ProfileMouvesFilter = .mouves
    @Namespace var animation
    
    private var filterBarWidth: CGFloat {
        let count = CGFloat(ProfileMouvesFilter.allCases.count)
        return UIScreen.main.bounds.width / count - 20 //20 used below  to adjust for padding
    }
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: UserContentListViewModel(user: user))
    }
    var body: some View {
        VStack{ // This displays the user's content list
            HStack{
                ForEach(ProfileMouvesFilter.allCases) { filter in
                    VStack {
                        Text(filter.title)
                            .font(.subheadline)
                            .fontWeight(selectedFilter == filter ? .semibold : .regular)
                        
                        if (selectedFilter == filter) {
                            Rectangle()
                                .foregroundColor(.black)
                                .frame(width: filterBarWidth, height: 1)
                                .matchedGeometryEffect(id: "item", in: animation)
                        } else {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: filterBarWidth, height: 1)
                        }
                    }
                    .onTapGesture {
                        withAnimation (.spring()) {
                            selectedFilter = filter
                        }
                    }
                }
            }
            
            LazyVStack(alignment: .center, spacing: 4, content:{
                switch selectedFilter {
                case .mouves:
//                    ForEach(viewModel.attendingMouves) { mouve in
                    ForEach(0 ... 1, id: \.self) { mouve in
                        MouveFeedCellView(mouve: Mouve.MOCK_MOUVE)
                            .transition(.move(edge: .leading))
                    }
                case .createdMouves:
                    ForEach(viewModel.mouves) { mouve in
                        MouveFeedCellView(mouve: mouve)
                            .transition(.move(edge: .trailing))
                    }
                }
            })
        }
    }
}

#Preview {
    UserContentListView( user: User.MOCK_USER )
}
