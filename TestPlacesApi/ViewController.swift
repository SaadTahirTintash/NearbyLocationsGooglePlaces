//
//  ViewController.swift
//  TestPlacesApi
//
//  Created by Tintash on 26/08/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit
import GooglePlaces

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let locationManager = CLLocationManager()
    var isFetchingLocations = false
    
    var placesClient : GMSPlacesClient!
    
    var nearbyLocations : [GMSPlaceLikelihood]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeFetchState(isFetching: false)
        tableView.dataSource = self
        locationManager.requestAlwaysAuthorization()
        placesClient = GMSPlacesClient.shared()
    }
    
    @IBAction func getCurrentPlace(_ sender: UIButton) {
        
        guard !isFetchingLocations else {
            print("Already Fetching Locations!")
            return
        }
        
        changeFetchState(isFetching: true)
        placesClient.currentPlace { [weak self] (placeLikelihoodList, error) in
        
            self?.changeFetchState(isFetching: false)
            if let error = error {
                print("Current Place error: \(error.localizedDescription)")
                return
            }
            
            if let placeLikelihoodList = placeLikelihoodList {
                self?.nearbyLocations = placeLikelihoodList.likelihoods
                self?.tableView.reloadData()
            }
        }
    }
    
    func changeFetchState(isFetching: Bool) {
        
        isFetchingLocations = isFetching
        activityIndicator.isHidden = !isFetching
        
        if isFetching {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
        
        
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nearbyLocations?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell")!
        
        let place = nearbyLocations?[indexPath.row].place
        if let place = place {
            cell.textLabel?.text = place.name
        }
        
        return cell
    }
    
}

