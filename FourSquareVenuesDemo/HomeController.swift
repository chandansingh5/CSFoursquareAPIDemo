//
//  HomeController.swift
//  FourSquareVenuesDemo
//
//  Created by Chandan Kumar on 17/05/17.
//  Copyright © 2017 Chandan Kumar. All rights reserved.
//

import UIKit
import CoreLocation

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}

class HomeController: UIViewController {

    @IBOutlet weak var btnSearch: UIButton!
   
    let locationManager = CLLocationManager()
    var currentLocation:CLLocationCoordinate2D!
    var flag = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set up location manager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // always make sure the Button is visible
        if btnSearch.isHidden {
            btnSearch.isHidden = false
        }
        // request location access
        locationManager.requestWhenInUseAuthorization()
        flag = true
    }
    

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Pass the latitude and longitude to the new view controller
        if segue.identifier == "showSearch" {
            let vc = segue.destination as! SearchController
            vc.currentLocation = currentLocation
        }
    }
    
    // MARK: - Helpers
    func showLocationAlert() {
        let alert = UIAlertController(title: "Location Disabled", message: "Please enable location for VenuDemo", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
   
    // MARK: - ButtonAction
    @IBAction func btngetCurrentLocationAction(_ sender: Any) {
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .authorizedWhenInUse:
                locationManager.startUpdatingLocation()
            default:
                showLocationAlert()
            }
        } else {
            showLocationAlert()
        }
    }
    
}

// MARK: - Location manager delegate

extension HomeController : CLLocationManagerDelegate {
    
func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // show the activity indicator
        btnSearch.isHidden = true
        if locations.last?.timestamp.timeIntervalSinceNow < -30.0 || locations.last?.horizontalAccuracy > 80 {
            return
        }
        // set a flag so segue is only called once
        if flag {
            currentLocation = locations.last?.coordinate
            locationManager.stopUpdatingLocation()
            flag = false
            performSegue(withIdentifier: "showSearch", sender: self)
        }
    }
    
}
