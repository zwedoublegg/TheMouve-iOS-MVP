//
//  ContentView.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 2/16/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        if (viewModel.userSession != nil){
            MainTabView()
        } else {
            EmailLoginView()
        }
    }
}

#Preview {
    ContentView()
}
