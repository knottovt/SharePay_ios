//
//  PersonDetail.swift
//  SharePay
//
//  Created by Visarut Tippun on 3/5/21.
//  Copyright © 2021 knttx. All rights reserved.
//

import UIKit

struct PersonDetail {
    var person:Person?
    var image:UIImage?
    
    init(person:Person, image:UIImage?) {
        self.person = person
        self.image = image
    }
    
    private enum CodingKeys: String, CodingKey {
        case person
        case image
    }
}

extension PersonDetail: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.person = try? container.decode(Person.self, forKey: .person)
        if let base64ImageData = try? container.decode(String.self, forKey: .image),
           let imageData = Data(base64Encoded: base64ImageData) {
            self.image = UIImage(data: imageData)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var value = encoder.container(keyedBy: CodingKeys.self)
        try? value.encode(self.person, forKey: .person)
        if let imageData:Data = self.image?.jpegData(compressionQuality: 0.25) {
            let base64ImageData = imageData.base64EncodedString()
            try? value.encode(base64ImageData, forKey: .image)
        }
    }
}
