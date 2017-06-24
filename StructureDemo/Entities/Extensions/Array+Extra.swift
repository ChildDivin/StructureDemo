//
//  Array+Extra.swift
//  Booking_system
//
//  Created by Tops on 10/8/16.
//  Copyright © 2016 Tops. All rights reserved.
//
import Foundation

extension Array where Element: Equatable {
    
    mutating func removeElement(_ element: Element) -> Element? {
        if let index = index(of: element) {
            return remove(at: index)
        }
        return nil
    }
}
