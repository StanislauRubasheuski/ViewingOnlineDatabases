//
//  DescriptionAttributes.swift
//  ViewingOnlineDatabases
//
//  Created by Stanislau on 29.05.2018.
//  Copyright © 2018 Stanislau. All rights reserved.
//

import Foundation

struct DescriptionAttributes: Decodable {
    let data: [DataAttributes]
    let page: Int
    let status: String
    
    enum dataKeys: CodingKey {
        case data
        case page
        case status
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: dataKeys.self)
        var dataArrayForType = try container.nestedUnkeyedContainer(forKey: dataKeys.data)
        var data = [DataAttributes]()
        while !dataArrayForType.isAtEnd {
            data.append(try dataArrayForType.decode(DataAttributes.self))
        }
        self.page = try container.decode(Int.self, forKey: dataKeys.page)
        self.status = try container.decode(String.self, forKey: dataKeys.status)
        self.data = data
    }
}
