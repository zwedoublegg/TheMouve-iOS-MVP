//
//  NotificationCell.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 4/18/24.
//

import SwiftUI

struct NotificationCell: View {
    let notification: TMNotification
    @State private var showUserProfile = false
    
    var body: some View {

        HStack {
            NavigationLink(value: notification.user) {
                CircularProfileImageView(user: notification.user, size: .xSmall)
//                .onTapGesture(perform: {
//                    showUserProfile.toggle()
//                })
            }
            
            //Notification message
            HStack {
                Text(notification.user?.username ?? "")
                    .font(.subheadline)
                    .fontWeight(.semibold) +
                
//                if let _ = notification.user?.isVerified {
//                    Text("")
//                }
                
                Text(Image(systemName: "checkmark.seal.fill"))
                    .font(.system(size: 12))
                    .foregroundColor(.black) +
                
                Text(" \(notification.type.notificationMessage)")
                    .font(.subheadline) +
                Text(" \(notification.timestamp.timestampString())")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            if notification.type == .follow{
                Button {
                    print("Follow handled here")
                } label: {
                    Text("Follow")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(width: 100, height: 32)
                        .foregroundColor(.white)
                        .background(.black)
                        .cornerRadius(5)
                }
            } else {
                Image("Linkedin_prof")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .padding(.leading, 4)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    NotificationCell(notification: TMNotification.MOCK_NOTIFICATIONS[0])
}
