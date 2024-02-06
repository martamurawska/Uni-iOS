//
//  CardView.swift
//  iOS5-Menge-Murawska
//
//  Created by Marta Murawska on 02.01.24.
//

import SwiftUI

struct CardView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    @State var card: AddressCard
    @State private var isEditing = false
    
    var body: some View {
        List {
            Section("Address") {
                Text(card.street)
                Text(card.plz)
                Text(card.city)
            }
            
            
            Section("Hobbies") {
                
                LazyVGrid(columns:
                            [GridItem(.adaptive(minimum: 80))]) {
                    ForEach(card.hobbys) { hobby in
                        Text(hobby.name)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 35)
                    .background(Color(red: 89 / 255, green: 169 / 255, blue: 253 / 255))
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                }
            }
            .listRowBackground(Color.clear)
            
            
            Section("Friends") {
                ForEach(viewModel.friendsOf(card: card)) { friend in
                    NavigationLink(destination: CardView(card: friend)) {
                        Text(friend.firstName + " " + friend.lastName)}
                }
            }
            
        }
        .navigationTitle(card.firstName + " " + card.lastName)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: EditView(card: $card), isActive: $isEditing) {
                    Button(action: {
                        isEditing.toggle()
                    }) {
                        Text("Edit")
                    }
                }
            }
        }
    }
}

#Preview {
    MasterView(viewModel: ViewModel())
        .environmentObject(ViewModel())
}
