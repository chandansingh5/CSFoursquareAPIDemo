//
//  DetailsController.swift
//  FourSquareVenuesDemo
//
//  Created by Chandan Kumar on 17/05/17.
//  Copyright © 2017 Chandan Kumar. All rights reserved.
//

import UIKit

class DetailsController: UIViewController {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    
    var selectedVenu : Venue? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        if let selectedVenu = selectedVenu {
            lblName.text = "Name : "+selectedVenu.name!
            lblAddress.text = "Address : "+selectedVenu.address!
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
