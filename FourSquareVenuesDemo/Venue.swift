//
//  Venue.swift
//
//  Foursquare
//
//  Contains:
//  struct Venue
//
//  Generated by SwiftPoet on 24/05/2016
//
//

import Foundation

/**
 Venue
 */

struct Venue {
    
    var name : String?
    var id : String?
    var address:String?
    let distance:Int
    
    public init (venue:JSON) {
        
        if let id = venue["id"].string{
            self.id = id;
        }
        if let name = venue["name"].string{
            self.name = name;
        }
        if let location = venue["location"]["distance"].int {
            self.distance  = location
        }else {
            self.distance = 0
        }
        if let formattedAddress = venue["location"]["formattedAddress"].array {
            let paramsJSON = formattedAddress.map { $0.stringValue}
            self.address = paramsJSON.joined(separator: " ")
        }
    }
}
