//
//  MouveCardView.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 4/3/24.
//

import SwiftUI

struct MouveCardView: View {
//    let mouve: Mouve
    @State private var bio = ""
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: MouveCardViewModel
    
    private var mouve: Mouve {
        return viewModel.mouve
    }
    
    private var didAttend: Bool {
        return mouve.didAttend ?? false
    }
    
    init(mouve: Mouve){
        self._viewModel = StateObject(wrappedValue:MouveCardViewModel(mouve: mouve))
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.secondarySystemBackground)
                    .edgesIgnoringSafeArea([.bottom, .horizontal])
                
                VStack{
                    HStack{ //Name and profile image
                        VStack (alignment: .leading, content: {
                            Text(verbatim: "Name")
                                .fontWeight(.semibold)
                            
                            Text(verbatim: mouve.mouveCaption)
                        })
                        Spacer()
                    }
                    
                    Divider()
                    
                    /*
                     Users edit Bio here
                     */
                    VStack (alignment: .leading, content: {
                        Text("Bio")
                            .fontWeight(.semibold)
                        
                        TextField("Enter your bio...", text: $bio, axis: .vertical)
                    })
                    
                    Divider()
                    
                    Button {
                        handleAttendtapped()
                    } label: {
                        Image(systemName: didAttend ? "heart.fill" : "heart")
                            .foregroundColor(didAttend ? .red : .black)
                    }
                }
                .font(.footnote)
                .padding()
                .background(.white)
                .cornerRadius(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10).stroke(Color(.systemGray4), lineWidth: 1)
                }
                .padding()
                
                .navigationTitle(mouve.mouveCaption)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarLeading, content: {
                        Button ("Cancel") {
                            dismiss()
                        }
                        .font(.subheadline)
                        .foregroundColor(.black)
                    })
                    
                    ToolbarItem(placement: .navigationBarTrailing, content: {
                        Button ("Done") {
                            Task {
                                dismiss()
                            }
                        }
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    })
                })
            }
        }
    }
    
    private func handleAttendtapped() {
        Task {
            if didAttend {
                try await viewModel.unAttend()
            } else {
                try await viewModel.attend()
            }
        }
    }
}

#Preview {
    MouveCardView(mouve: Mouve.MOCK_MOUVE)
}
