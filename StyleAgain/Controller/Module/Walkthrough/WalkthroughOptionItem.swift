//
//  WalkthroughOptionItem.swift
//  StyleAgain
//
//  Created by Macmini on 12/3/18.
//  Copyright © 2018 Style Again. All rights reserved.
//

import UIKit
struct WalkthroughOptionList: Codable
{
    var items: [WalkthroughOptionItem]?
    
    init() {
        items = [WalkthroughOptionItem]()
    }
    
    init(from decoder: Decoder) throws {
        var items = [WalkthroughOptionItem]()
        var container = try decoder.unkeyedContainer()
        while !container.isAtEnd {
            if let route = try? container.decode(WalkthroughOptionItem.self) {
                items.append(route)
            } else {
                _ = try? container.decode(WalkthroughOptionItem.self) // <-- TRICK
            }
        }
        self.items = items
    }
}

struct WalkthroughOptionItem: Codable {
    var title: String?
    var url: URL?
    var id: Int = 0
    
    init() {
        title = nil
        url = nil
    }
    
    enum CodingKeys: String, CodingKey
    {
        case title = "title"
        case url = "url"
    }
}
