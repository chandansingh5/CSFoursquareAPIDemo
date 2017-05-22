//
//  SerachViewModel.swift
//  FourSquareVenuesDemo
//
//  Created by Chandan Singh on 22/05/17.
//  Copyright © 2017 Chandan Kumar. All rights reserved.
//

import UIKit
import CoreLocation

class SerachViewModel: NSObject {

    var searchResults : [Venue]?
    
    func fetchVenuesWithNetworkCall(currentLocation:CLLocationCoordinate2D , completion : @escaping (_ sucess:Bool) -> ()) {
        let sharedManager = RequestManager.networkManager
        sharedManager.fetchFromNetwork(forService:currentLocation) { (responseObject:AnyObject? ,sucess:Bool) in
                if sucess {
                    let results = responseObject as! [Venue]
                    self.searchResults = results.sorted (by: {$0.distance < $1.distance})
            }
            completion(sucess)
        }
    }
    
    func numberOfRowsInSection(section : Int) -> Int {
       return searchResults?.count ?? 0
    }
    
    func selectedObject(indexPath:IndexPath) -> Venue? {
         if let resultVenu = searchResults?[indexPath.row] {
            return resultVenu
        }
        return nil
    }
    
    func configureCell(cell:SearchCell ,indexPath : IndexPath) {
        if let resultVenu = searchResults?[indexPath.row] {
            cell.title.text = resultVenu.name
            cell.distance.text = "\(resultVenu.distance)m"
        }else{
            cell.title.text = ""
            cell.distance.text = "\(0)m"
        }
    }
    
}
