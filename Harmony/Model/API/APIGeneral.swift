//
//  APIGeneral.swift
//  Harmony
//
//  Created by apprenant49 on 05/07/2023.
//

import Foundation

class APIGeneral {
    
    func StringToLanguage(string: String) -> Language? {
        return Language.allCases.first { string == "\($0)" }
    }
    
    func ArrayStringToLanguages(array: [String]) -> [Language] {
        var languages: [Language] = []
        
        for element in array {
            let lang = self.StringToLanguage(string: element)
            if lang != nil {
                languages.append(lang!)
            }
        }
        
        return languages
    }
    
    func StringToContinent(string: String) -> Continent? {
        return Continent.allCases.first { string == "\($0)" }
    }
    
    func StringToDate(string: String) -> Date? {
//        var dd = string.replacingOccurrences(of: "..000Z", with: "")
//        print("REPLACE: " + dd)
        let datef = DateFormatter()
        datef.locale = Locale(identifier: "fr_FR")
        datef.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
        return datef.date(from: string)
    }
    
    func dateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "fr_FR")
        
        return dateFormatter.string(from: date)
    }
}
