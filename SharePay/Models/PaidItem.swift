//
//  PaidItem.swift
//  SharePay
//
//  Created by Visarut Tippun on 3/5/21.
//  Copyright © 2021 knttx. All rights reserved.
//

import Foundation

struct PaidItem {
    var id:Int?
    var name:String?
    var price:Double?
    var persons:[Person] = []
    
    init(name:String, price:Double, persons:[Person]) {
        self.id = Int(Date().timeIntervalSince1970)
        self.name = name
        self.price = price
        self.persons = persons
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case price
        case persons
    }
}

extension PaidItem: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container.decode(Int.self, forKey: .id)
        self.name = try? container.decode(String.self, forKey: .name)
        self.price = try? container.decode(Double.self, forKey: .price)
        self.persons = (try? container.decode([Person].self, forKey: .persons)) ?? []
    }
    
    func encode(to encoder: Encoder) throws {
        var value = encoder.container(keyedBy: CodingKeys.self)
        try? value.encode(self.id, forKey: .id)
        try? value.encode(self.name, forKey: .name)
        try? value.encode(self.price, forKey: .price)
        try? value.encode(self.persons, forKey: .persons)
    }
    
    func pricePerPerson() -> Double {
        return Double(self.price ?? 0) / Double(self.persons.count)
    }
}
