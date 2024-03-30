//
//  UserContentListView.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 3/13/24.
//

import SwiftUI

struct UserContentListView: View {
    @StateObject var viewModel: UserContentListViewModel
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: UserContentListViewModel(user: user))
    }
    var body: some View {
        VStack{ // This displays the user's content list
            ContentListHeaderView()
            
            LazyVStack(alignment: .center, spacing: 4, content:{
                ForEach(viewModel.mouves) { mouve in
                    MouveFeedCellView(mouve: mouve)
                }
            })
        }
    }
}

#Preview {
    UserContentListView( user: User.MOCK_USER )
}
