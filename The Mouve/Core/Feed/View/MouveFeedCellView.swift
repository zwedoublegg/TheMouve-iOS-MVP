//
//  MouveFeedCellView.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 2/29/24.
//

import SwiftUI

struct MouveFeedCellView: View {
    let mouve: Mouve
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 8) {
                CircularProfileImageView(user: mouve.user, size: .xSmall)
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack (spacing: 4) {
                        Text(mouve.user?.username ?? "")
                            .font(Font(UIFont(name: "PingFangHK-Light", size: 18.0)!)) // FIXME: I'm forced unwrapped
                            .fontWeight(.semibold)
                        .foregroundColor(.cyan) //TODO: Change to App color
                        
                        Image(systemName: "checkmark.seal.fill")
                            .font(.system(size: 15))
                            .foregroundColor(.black)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(mouve.mouveCaption)//Title goes here
                        .font(Font.custom("Margarette01.ttf", size: 18))
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                        .lineSpacing(0)
                        .lineLimit(2)
                    
                    Text("2pm until Midnight")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.systemGray))
                    
                    Text("$15 before 10pm")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(.bottom, 4)
                }
                
                Image("Linkedin_prof")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 80)
                    .blur(radius: 1)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1).foregroundColor(Color(.systemGray6)).shadow(radius: 10))
                    .overlay(
                        Image(systemName: "play.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                            .opacity(1)
                        )
                    
            }
//            .padding(.horizontal)
            .padding(.top)
            
            Divider()
        }
    }
}

#Preview {
    MouveFeedCellView( mouve: Mouve.MOCK_MOUVE)
}
