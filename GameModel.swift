//
//  GameModel.swift
//  Bout Time
//
//  Created by Aaron Revalee on 10/26/17.
//  Copyright © 2017 OedipusRexed. All rights reserved.
//

import Foundation

struct EventData {
    var Event: String
    var Year: String
    var URL: String
}

enum EventError:Error {
    case invalidResource
    case conversionFailure
    case invalidEvent
}

class PlistConverter {
    class func arrayFromList(fromFile name: String, ofType type: String) throws -> [[String: String]] {
        guard let path = Bundle.main.path(forResource: name, ofType: type) else {
            throw EventError.invalidResource
            
        }
        guard let array = NSArray(contentsOfFile: path), let castArray = array as? [[String:String]]
            else {
                throw EventError.conversionFailure
        }
        return castArray
    }
}

    class EventUnpacker {
        class func eventFromArray(array: [[String : String]]) throws -> [EventData] {
            var eventsArray: [EventData] = []
            
            for anEvent in array {
                if let Event = anEvent["Event"], let Year = anEvent["Year"], let URL = anEvent["URL"] {
                    let newEvent = EventData(Event: Event, Year: Year, URL: URL)
                    eventsArray.append(newEvent)
                } else {
                    throw EventError.invalidEvent
                }
                
            }
            return eventsArray
        }
}

