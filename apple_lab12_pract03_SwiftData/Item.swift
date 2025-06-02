//
//  Item.swift
//  apple_lab12_pract03_SwiftData
//
//  Created by Jaime Gomez on 1/6/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
