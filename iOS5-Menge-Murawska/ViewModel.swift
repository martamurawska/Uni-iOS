//
//  ViewModel.swift
//  iOS5-Menge-Murawska
//
//  Created by Marta Murawska on 02.01.24.
//

import Foundation

class ViewModel: ObservableObject {
    @Published private var addressBook = AddressBook()
    @Published private var addressCard = AddressCard()
    
    
    init() {
        loadModel()
        // print(fileURL)
        addressBook.sortByLastName()
        
    }
    
    var cards: [AddressCard] {
        get {
            addressBook.addressCards
        }
        set {
            addressBook.addressCards = newValue
        }
    }
    
    
    func add(card: AddressCard) {
        addressBook.add(card: card)
        addressBook.sortByLastName()
    }
    
    
    func remove(cardsAt indices: IndexSet) {
        addressBook.addressCards.remove(atOffsets: indices)
    }
    
    func findById(id: UUID) -> AddressCard? {
        addressBook.findById(id: id)
    }
    
    func friendsOf(card: AddressCard) -> [AddressCard] {
        addressBook.friendsOf(card: card)
    }
    
    func updateViews() {
        objectWillChange.send()
    }
    
    func add(hobby: Hobby) {
        addressCard.add(hobby: hobby)
    }
    
    func add(friend: AddressCard) {
        addressCard.add(friend: friend)
    }
    
    func findByName(lastName: String) -> AddressCard? {
        addressBook.findByName(lastName: lastName)
    }
    
    private var fileURL: URL? {
        FileManager.default.urls(for: .documentDirectory,
                                 in: .userDomainMask)
        .first?.appendingPathComponent("filename.json")
    }
    
    
    func loadModel() {
        do {
            
            if let fileURL = fileURL, FileManager.default.fileExists(atPath: fileURL.path) {
                let data = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                let loadedModel = try decoder.decode(AddressBook.self, from: data)
                addressBook = loadedModel
            }
        } catch {
            print("Error loading data: \(error)")
        }
    }
    
    func saveModel() {
        do {
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(addressBook)
            
            if let fileURL = fileURL {
                try encodedData.write(to: fileURL, options: .atomic)
            }
        } catch {
            print("Error saving data: \(error)")
        }
    }
    
}
