//
//  ContentListHeaderView.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 3/8/24.
//

import SwiftUI

struct ContentListHeaderView: View {
    @State private var selectedFilter: ProfileMouvesFilter = .mouves
    @Namespace var animation
    
    private var filterBarWidth: CGFloat {
        let count = CGFloat(ProfileMouvesFilter.allCases.count)
        return UIScreen.main.bounds.width / count - 20 //20 used below  to adjust for padding
    }
    
    var body: some View {
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
    }
}

#Preview {
    ContentListHeaderView()
}
