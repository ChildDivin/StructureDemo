//
//  NSString+FirstCharacter.swift
//  Lyst
//
//  Created by Tops on 3/25/16.
//  Copyright © 2016 Tops. All rights reserved.
//

import UIKit
import Foundation

extension String {
    
    func firstcharacter(_ str:String)->String{
        if(str.characters.count >= 1){
            //"llo, playgroun"
            return str.substring(with: (str.characters.index(str.startIndex, offsetBy: 0) ..< str.characters.index(str.endIndex, offsetBy: 1-str.characters.count))).capitalized
        }
        return str.capitalized
    }
    func toBool() -> Bool {
        switch self {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return false
        }
    }
    
    func toDouble() -> Double {
        if let unwrappedNum = Double(self) {
            return unwrappedNum
        } else {
            // Handle a bad number
            print("Error converting \"" + self + "\" to Double")
            return 0.0
        }
    }
    
    func convertTODate() -> Date{
        //dateString = "2014-07-15 14:52:53"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: self)
        return date!
        
    }
    
    func convertTODateDDMMYYYY() -> Date{
        //dateString = "01/01/2016"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let date = dateFormatter.date(from: self)
        return date!
    }
    
    func convertTODateUsingOnly() -> Date{
        //dateString = "2014-07-15"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: self)
        return date!
        
    }
    
    func filter(_ pred: (Character) -> Bool) -> String {
        var res = String()
        for c in self.characters {
            if pred(c) {
                res.append(c)
            }
        }
        return res
    }
    func replace(_ string:String, replacement:String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }
    
    func removeWhitespace() -> String {
        return self.replace(" ", replacement: "")
    }
    
    var first: String {
        return String(characters.prefix(1))
    }
    var last: String {
        return String(characters.suffix(1))
    }
    
    func uppercaseFirst() -> String {
        return first.uppercased() + String(characters.dropFirst())
    }
    
    var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
            return trimmed.isEmpty
        }
    }
    
    //Validate Email
    
    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil
        } catch {
            return false
        }
    }
    
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
    //validate Password
    var isValidPassword: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[a-zA-Z_0-9\\-_,;.:#+*?=!§$%&/()@]+$", options: .caseInsensitive)
            if(regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil){
                
                if(self.characters.count>=6 && self.characters.count<=20){
                    return true
                }else{
                    return false
                }
            }else{
                return false
            }
        } catch {
            return false
        }
    }
}
