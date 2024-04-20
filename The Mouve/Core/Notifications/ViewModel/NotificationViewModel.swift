//
//  NotificationViewModel.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 4/10/24.
//

import Foundation

@MainActor
class NotificationViewModel: ObservableObject {
    @Published var notifications = [TMNotification]()
    private let service: NotificationService
    private var currentUser: User?

    init(service: NotificationService) {
        self.service = service
        self.currentUser = UserService.shared.currentUser
        Task {
            await fetchNotifications()
        }
    }
    
    func fetchNotifications() async {
        do {
            self.notifications = try await service.fetchNotifications() //TMNotification.MOCK_NOTIFICATIONS
            try await updateNotificationsMetadata()
        } catch {
            print("DEBUG: Failed to fect notifications with error \(error.localizedDescription)")
        }
    }
    
    private func updateNotificationsMetadata() async throws {
        for i in 0 ..< notifications.count {
            var notification = notifications[i]
            
            notification.user = try await UserService.fetchUser(withUid: notification.notificationSenderUid)
            
            if let mouveId = notification.mouveId {
                notification.mouve = try await MouveService.fetchMouve(withMouveId: mouveId)
                notification.mouve?.user = self.currentUser
            }
            
            notifications[i] = notification
        }
    }
}
