//
//  ContentView.swift
//  iOS5-Menge-Murawska
//
//  Created by Marta Murawska on 02.01.24.
//

import SwiftUI

struct MasterView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.cards) { card in
                    NavigationLink(destination: CardView(card: card)) {
                        VStack(alignment: .leading) {
                            Text(card.firstName + " " + card.lastName)
                                .font(.title3)
                            Text(card.plz + " " + card.city + ", " + card.street)
                                .font(.subheadline)
                            
                        }
                    }
                }
                .onDelete { 
                    indexSet in
                    viewModel.remove(cardsAt: indexSet)
                    viewModel.updateViews()
                }
            }
            .navigationTitle("Contacts")
            .toolbar {
                toolbarContent
            }
            .onAppear() {
                viewModel.updateViews()
                
            }
        }
    }
    
    
    @ToolbarContentBuilder var toolbarContent: some ToolbarContent {
        ToolbarItem {
            EditButton()
        }
        ToolbarItem(placement: .navigationBarLeading) {
            NavigationLink {
                AddView { firstName, lastName, street, plz, city, hobby in
                    viewModel.add(card: AddressCard(firstName: firstName, lastName: lastName, street: street, plz: plz, city: city, hobbys: [Hobby(name: hobby)], friends: []))
                    viewModel.updateViews()
                }
            } label: {
                Image(systemName: "plus")
            }
        }
    }
}
#Preview {
    MasterView(viewModel: ViewModel())
        .environmentObject(ViewModel())
}
