//
//  StoryView.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 3/28/24.
//

import SwiftUI

struct StoryView: View {
    @Environment(\.dismiss) var dismiss
    @State var imagesData = ["Linkedin_prof", "em", "cindy", "2222"]
    @State var currentItemData = 0
    @State var timer:  Timer?
    
    var body: some View {
        ZStack{
            VStack{
                content
            }
        }
    }
    
    var content: some View {
        VStack{
            ZStack(alignment: .top) {
                images
                slider
                    .padding(.top, 10)
                title
                    .padding(.top, 30)
            }
        }
    }
    
    var slider: some View {
        ZStack{
            VStack{
                GeometryReader{ geometry in
                    ZStack(alignment: .leading){
                        ForEach(0..<imagesData.count, id: \.self){ item in
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundColor(item <= currentItemData ? .cyan : .gray)// .white : .gray)
                                .frame(width: geometry.size.width / CGFloat(imagesData.count) - 5, height: 2)
                                .offset(x: CGFloat(item) * (geometry.size.width / CGFloat(imagesData.count)), y: 0)
                            
                        }
                    }
                }
                .frame(
                    minWidth: UIScreen.main.bounds.width - 5,
                    maxWidth: UIScreen.main.bounds.width - 5,
                    minHeight: 5,
                    maxHeight: 5
                )
                .onAppear{
                    animateToNextIndex()
                }
                Spacer()
            }
            
            HStack{
                Rectangle()
                    .fill(.black.opacity(0.000000001))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .onTapGesture {
                        if currentItemData > 0 {
                            currentItemData -= 1
                        }
                        else if currentItemData == 0 {
                            print("Already at the start")
                        }
                    }
                
                Rectangle()
                    .fill(.black.opacity(0.000000001))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .onTapGesture {
                        if currentItemData < imagesData.count - 1 {
                            currentItemData += 1
                        }
                        else if currentItemData == imagesData.count - 1 {
                            print("Already at the end")
                        }
                    }
            }
        }
    }
    
    var images: some View {
        ZStack{
            Image(imagesData[currentItemData])
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.bottom)
                .scaledToFill()
        }
    }
    
    var title: some View {
        HStack(alignment: .center, spacing: 4){
            Text("Mouve Title Here. Let's See now that this is long")
                .font(.system(size: 14))
                .foregroundColor(.white)
                .bold()
                .padding(.horizontal, 8)
            
            Spacer()
            
            Button {
                print("More from Stories")
            } label: {
                Image(systemName: "ellipsis")
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 20, maxWidth: 20, minHeight: 20, maxHeight: 20)
                    .foregroundColor(.white)
            }
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 20, maxWidth: 20, minHeight: 20, maxHeight: 20)
                    .foregroundColor(.white)
            }
            .padding(.horizontal)
        }
        .frame(
            minWidth: UIScreen.main.bounds.width,
            maxWidth: UIScreen.main.bounds.width
        )
    }
    
    func animateToNextIndex() {
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) {_ in
            currentItemData = (currentItemData + 1) % imagesData.count
            
            if (currentItemData == imagesData.count - 1) {
                timer?.invalidate()
                timer = nil
            }
            
        }
    }
}

#Preview {
    StoryView()
}
