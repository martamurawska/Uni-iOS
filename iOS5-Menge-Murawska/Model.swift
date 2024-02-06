//
//  Model.swift
//  iOS5-Menge-Murawska
//
//  Created by Marta Murawska on 02.01.24.
//

import Foundation

class AddressCard : Identifiable, Codable, Equatable, Hashable {
    
    var id: UUID = UUID()
    var firstName: String = ""
    var lastName: String = ""
    var street: String = ""
    var plz: String = ""
    var city: String = ""
    var hobbys: [Hobby] = []
    var friends: [UUID] = []
    
    init() {
    }
    
    
    init (firstName: String, lastName: String, street: String, plz: String, city: String, hobbys: [Hobby], friends: [UUID]) {
        // id = UUID()
        self.firstName = firstName
        self.lastName = lastName
        self.street = street
        self.plz = plz
        self.city = city
        self.hobbys = hobbys
        self.friends = friends
    }
    
    
    static func == (left: AddressCard , right: AddressCard) -> Bool { //static?
        return left.id == right.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    func add(hobby: Hobby) {
        hobbys.append(hobby)
    }
    
    func remove(hobby: Hobby) {
        if let index = hobbys.firstIndex(of: hobby) {
            hobbys.remove(at: index)
        }
    }
    
    func add(friend: AddressCard) {
        friends.append(friend.id)
    }
    
    func remove(friend: AddressCard) {
        if let index = friends.firstIndex(of: friend.id) {
            friends.remove(at: index)
        }
    }
    
    
}

class AddressBook : Codable {
    
    var addressCards = [AddressCard]()
    
    /* init() {
     
     var card1 = AddressCard(firstName: "Anne", lastName: "Müller", street: "Blumenstraße", plz: "10234", city: "Berlin", hobbys: [], friends: [])
     
     var card2 = AddressCard(firstName: "Jannis", lastName: "Müller", street: "Blumenstraße", plz: "10234", city: "Berlin", hobbys: [], friends: [])
     
     var card3 = AddressCard(firstName: "Lucas", lastName: "Nowak", street: "Kantstraße", plz: "10344", city: "Berlin", hobbys: [], friends: [])
     
     var card4 = AddressCard(firstName: "Lucas", lastName: "Abc", street: "Musterstraße", plz: "90755", city: "München", hobbys: [Hobby(name: "Basketball"), Hobby(name: "Tanzen"), Hobby(name: "nähen"), Hobby(name: "Brettspiele")], friends: [UUID(uuidString: "40D6EE5D-6C2E-4FF3-8311-F0185F89A159") ?? UUID()])
     
     addressCards.append(card1)
     addressCards.append(card2)
     addressCards.append(card3)
     addressCards.append(card4)
     
     }*/
    
    func add(card: AddressCard) {
        addressCards.append(card)
    }
    
    func remove(card: AddressCard) {
        if let index = addressCards.firstIndex(of: card) {
            addressCards.remove(at: index)
        }
    }
    
    func sortByLastName() {
        addressCards.sort(by: { $0.lastName < $1.lastName } )
    }
    
    func findByName(lastName: String) -> AddressCard? {
        for addresscard in addressCards {
            if addresscard.lastName == lastName {
                return addresscard
            }
        }
        return nil
    }
    
    func findById(id: UUID) -> AddressCard? {
        for addresscard in addressCards {
            if addresscard.id == id {
                return addresscard
            }
        }
        return nil
    }
    
    func friendsOf(card: AddressCard) -> [AddressCard] {
        var friendsArray : [AddressCard] = []
        for id in card.friends {
            if let card = findById(id: id) {
                friendsArray.append(card)
            }
        }
        return friendsArray
    }
    
    
}

class Hobby : Identifiable, Codable, Equatable {
    var name: String
    var id: UUID
    
    init (name: String) {
        self.name = name
        id = UUID()
    }
    
    static func == (left: Hobby , right: Hobby) -> Bool { //static?
        return left.id == right.id
    }
}
