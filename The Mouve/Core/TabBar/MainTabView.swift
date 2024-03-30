//
//  MainTabView.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 2/29/24.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    @State private var showCreateMouveView = false
    var body: some View {
        TabView(selection: $selectedTab) {
            MouveFeedView()
                .tabItem {
                    VStack {
                        Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                            .environment(\.symbolVariants, selectedTab == 0 ? .fill : .none)
                        Text("Home")
                    }
                }
                .onAppear {selectedTab = 0 }
                .tag(0)
            SearchView()
                .tabItem {
                    VStack {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                }
                .onAppear {selectedTab = 1 }
                .tag(1)
            Text("")
                .tabItem {
                    Image(systemName: "plus")
                }
                .onAppear {selectedTab = 2 }
                .tag(2)
            MessageListView()
                .tabItem {
                    VStack {
                        Image(systemName: selectedTab == 3 ? "bubble.left.and.bubble.right.fill" : "bubble.left.and.bubble.right")
                            .environment(\.symbolVariants, selectedTab == 3 ? .fill : .none)
                        Text("Messages")
                    }
                }
                .onAppear {selectedTab = 3 }
                .tag(3)
            CurrentUserProfileView()
                .tabItem {
                    VStack {
                        Image(systemName: selectedTab == 4 ? "person.fill" : "person")
                            .environment(\.symbolVariants, selectedTab == 4 ? .fill : .none)
                        Text("Profile")
                    }
                }
                .onAppear {selectedTab = 4 }
                .tag(4)
        }
        .onChange(of: selectedTab) {
            showCreateMouveView = selectedTab == 2
        }
        .sheet(isPresented: $showCreateMouveView, onDismiss: {
            selectedTab = 0
        }, content: {
            CreateMouveView()
        })
        .tint(.black)//TODO: Set this to default app color
    }
}

#Preview {
    MainTabView()
}
