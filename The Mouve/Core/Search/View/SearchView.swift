//
//  SearchView.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 2/29/24.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @StateObject var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationStack {
            UserListView(config: .explore)
                .navigationDestination(for: User.self, destination: { user in
                    ProfileView(user: user)
                })
                .navigationTitle("Search")
                .searchable(text: $searchText, prompt: "Search")
        }
    }
}

#Preview {
    SearchView()
}
