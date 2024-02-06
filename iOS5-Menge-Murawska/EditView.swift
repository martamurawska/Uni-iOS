//
//  EditView.swift
//  iOS5-Menge-Murawska
//
//  Created by Marta Murawska on 06.01.24.
//

import SwiftUI

struct EditView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    @Binding var card: AddressCard
    @State private var newHobby = ""
    @State private var newFriend = ""
    //@Environment(\.presentationMode) private var presentationMode
    
    
    var body: some View {
        List {
            TextField("First Name", text: $card.firstName)
            TextField("Last Name", text: $card.lastName)
            
            Section("Address") {
                TextField("Street", text: $card.street)
                TextField("PLZ", text: $card.plz)
                TextField("City", text: $card.city)
            }
            
            Section("Hobbies") {
                
                HStack {
                    TextField("Add new hobby", text: $newHobby)
                        .onSubmit {
                            if !newHobby.isEmpty {
                                card.add(hobby: Hobby(name: newHobby))
                                newHobby = ""
                            }
                        }
                    Button(action: {
                        if !newHobby.isEmpty {
                            card.add(hobby: Hobby(name: newHobby))
                            newHobby = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.blue)
                            .imageScale(.large)
                    }
                }
                
                ForEach(card.hobbys.indices, id: \.self) { index in
                    TextField("Hobby", text: $card.hobbys[index].name)
                }
                .onDelete { indexSet in
                    card.hobbys.remove(atOffsets: indexSet)
                    
                }
            }
            
            Section("Friends") {
                HStack {
                    TextField("Type friend's last name", text: $newFriend)
                        .onSubmit {
                            if !newFriend.isEmpty {
                                if let friend = viewModel.findByName(lastName: newFriend) {
                                    card.add(friend: friend)
                                    newFriend = ""
                                }
                            }
                        }
                    Button(action: {
                        if !newFriend.isEmpty {
                            if let friend = viewModel.findByName(lastName: newFriend) {
                                card.add(friend: friend)
                                newFriend = ""
                            }
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.blue)
                            .imageScale(.large)
                    }
                }
                ForEach(viewModel.friendsOf(card: card)) { friend in
                    Text(friend.firstName + " " + friend.lastName)}
                .onDelete { indexSet in
                    card.friends.remove(atOffsets: indexSet)
                    
                }
            }
            
        } .onDisappear() {
            viewModel.updateViews()
        }
    }
}

    

#Preview {
    MasterView(viewModel: ViewModel())
        .environmentObject(ViewModel())
}
