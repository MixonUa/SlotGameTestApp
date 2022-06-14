//
//  SlotItemCost.swift
//  SlotGameTestApp
//
//  Created by Михаил Фролов on 14.06.2022.
//

import Foundation

struct SlotItemCost {
    let winItem: String
    
    var itemAmount: Int {
        switch winItem {
        case "\(winItem.prefix(5))_item1":
            return 2
        case "\(winItem.prefix(5))_item2":
            return 4
        case "\(winItem.prefix(5))_item3":
            return 6
        case "\(winItem.prefix(5))_item4":
            return 8
        case "\(winItem.prefix(5))_item5":
            return 10
        case "\(winItem.prefix(5))_item6":
            return 12
        case "\(winItem.prefix(5))_item7":
            return 14
        case "\(winItem.prefix(5))_item8":
            return 16
        case "\(winItem.prefix(5))_item9":
            return 18
        
        default:
            return 0
        }
    }
}


