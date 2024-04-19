//
//  Notification.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 4/10/24.
//

import SwiftUI

struct NotificationsView: View {
    @StateObject var viewModel = NotificationViewModel(service: NotificationService())
    
    var body: some View {
//        NavigationStack{
            ScrollView {
                LazyVStack (spacing: 20) {
                    ForEach(viewModel.notifications) { notification in
                        NotificationCell(notification: notification)
                            .padding(.top)
                    }
                }
            }
//            .navigationDestination(for: User.self, destination: { user in
//                ProfileView(user: user)
//            })
            .navigationTitle("Notifications")
//            .navigationBarTitleDisplayMode(.automatic)
            .navigationBarTitleDisplayMode(.inline)
//        }
    }
}

#Preview {
    NotificationsView()
}
