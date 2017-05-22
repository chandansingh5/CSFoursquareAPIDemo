//
//  SearchHepler.swift
//  FourSquareVenuesDemo
//
//  Created by Chandan Kumar on 17/05/17.
//  Copyright © 2017 Chandan Kumar. All rights reserved.
//

//MARK:- IMPORT MODULES
import Foundation
import CoreLocation



//MARK:- REQUEST MANAGER
final class RequestManager{
    
    let client_id = "WIGRPYPTTIFWN04TO1MZEAR1JDL0KXWGWFOWVM4STIKPK2M1"
    let client_secret = "JSGLBUJIV45NYP3IUUWWZYFJNVXYFN2IDUUSPCO5E5KKVAIG"
    
    //MARK:- Class variable
    static let networkManager = RequestManager()
    
    //MARK:- Private Methods
    private init(){}
    
    //MARK:- Network Call
     func fetchFromNetwork(forService currentLocation:CLLocationCoordinate2D,completion:@escaping (_ result:AnyObject?,_ sucess:Bool) -> Void){
        let url = "https://api.foursquare.com/v2/venues/search?ll=\(currentLocation.latitude),\(currentLocation.longitude)&v=20160607&intent=checkin&radius=4000&client_id=\(client_id)&client_secret=\(client_secret)"
        let callURL = URL.init(string:url)
        let request = URLRequest.init(url:callURL!)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            guard let data = data, error == nil else {
                return completion(nil,false)
            }
            let json = JSON(data: data)
            if let currentVenueArray = json["response"]["venues"].array {
                let venuArray = self.parseData(response: currentVenueArray)
                completion(venuArray as AnyObject?,true)
            }else{
                return completion(nil,false)
            }

        })
        task.resume()
    }
    
    func parseData(response:[JSON]) -> [Venue]? {
       var currentVenueArray = [Venue]()
        for venuelist in response {
            currentVenueArray.append(Venue.init(venue:venuelist))
        }
        return currentVenueArray
    }
}

