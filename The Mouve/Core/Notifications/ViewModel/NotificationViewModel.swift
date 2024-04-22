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
//            if let user = notification.user {
//                user.isFollowed = try await UserService.checkIfUserIsFollowed(uid: self.currentUser?.uid ?? "")
//            }
//            notification.user?.isFollowed = try await UserService.checkIfUserIsFollowed(uid: self.currentUser?.uid ?? "")
            
            if let mouveId = notification.mouveId {
                notification.mouve = try await MouveService.fetchMouve(withMouveId: mouveId)
                notification.mouve?.user = self.currentUser
            }
            
            notifications[i] = notification
        }
    }
}

extension NotificationViewModel {
//    func follow(userFromNotification user: User) {
//        Task {
//            try await UserService.follow(uid: user.id)
//            user.isFollowed = true
//            
//            NotificationManager.shared.uploadFollowNotification(toUid: user.id)
//        }
//    }
//    
//    func unfollow(userFromNotification user: User) {
//        Task {
//            try await UserService.unfollow(uid: user.id)
//            user.isFollowed = false
//            
//            try await NotificationManager.shared.deleteFollowNotification(notificationOwnerUid: user.id)
//        }
//    }
//    
//    func checkIfUserIsFollowed(userFromNotification user: User) {
//        guard user.isFollowed == nil else {return}
//        Task {
//            user.isFollowed = try await UserService.checkIfUserIsFollowed(uid: user.id)
//        }
//    }
}
