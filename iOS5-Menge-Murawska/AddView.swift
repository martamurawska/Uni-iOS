//
//  AddView.swift
//  iOS5-Menge-Murawska
//
//  Created by Marta Murawska on 04.01.24.
//

import SwiftUI

struct AddView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State var enteredFirstName: String = ""
    @State var enteredLastName: String = ""
    @State var enteredStreet: String = ""
    @State var enteredPlz: String = ""
    @State var enteredCity: String = ""
    @State var enteredHobbies: String = ""
    
    var completed: (String, String, String, String, String, String) -> Void
    
    var body: some View {
        Form {
            TextField("First name", text: $enteredFirstName)
            TextField("Last name", text: $enteredLastName)
            TextField("Street", text: $enteredStreet)
            TextField("PLZ", text: $enteredPlz)
            TextField("City", text: $enteredCity)
            TextField("Hobby", text: $enteredHobbies)
        }
        .navigationTitle("New Contact")
        .onDisappear {
            if enteredFirstName != "" && enteredLastName != "" {
                completed(enteredFirstName, enteredLastName, enteredStreet, enteredPlz, enteredCity, enteredHobbies)
            }
        }
    }
}

#Preview {
    MasterView(viewModel: ViewModel())
}
