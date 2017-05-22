//
//  SearchController.swift
//  FourSquareVenuesDemo
//
//  Created by Chandan Kumar on 17/05/17.
//  Copyright © 2017 Chandan Kumar. All rights reserved.
//

import UIKit
import CoreLocation


class SearchController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewModel: SerachViewModel!
    
    //var searchResults = [Venue]()
    var currentLocation:CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.isHidden = true
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        // snap to current venues
        snapToVenues()
    }
    
    
    // MARK: - venues/search endpoint
    func snapToVenues() {
        viewModel.fetchVenuesWithNetworkCall(currentLocation:currentLocation) { (sucess:Bool) in
            DispatchQueue.main.async {
                if sucess {
                    self.tableView.isHidden = false
                    self.tableView.reloadData()
                }else{
                    self.showFatchErrorAlert()
                }
            }
        }
    }
    
    // MARK: - Helpers
    func showFatchErrorAlert() {
        let alert = UIAlertController(title: "Error", message: "Oops, something went wrong", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // check if segue is to the DetailsController
        if segue.identifier == "details" {
            let vc = segue.destination as! DetailsController
            if let indexPath = sender as? IndexPath {
                if let venu  = viewModel.selectedObject(indexPath:indexPath){
                    vc.selectedVenu = venu
                }
            }
            let selectedCell = tableView.indexPathForSelectedRow!
            tableView.deselectRow(at: selectedCell, animated: false)
        }
    }
}

// MARK: - TableView methods
extension SearchController :  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Set up the SearchCells with data from the searchResults array
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SearchCell
        viewModel.configureCell(cell:cell, indexPath:indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // show the DetailController
        performSegue(withIdentifier: "details", sender:indexPath)
    }
}
