//
//  DetachViewController.swift
//  ViewingOnlineDatabases
//
//  Created by Stanislau on 29.05.2018.
//  Copyright © 2018 Stanislau. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class DescriptionViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate  {
    @IBOutlet weak var IDLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    let model = DescriptionViewModel()
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        model.updateUI {
            self.mapView.showAnnotations([self.model.sourceAnnotation], animated: true)
            self.IDLabel.text = "ID: \(self.model.id)"
            self.countryLabel.text = "Country: \(self.model.country)"
        }
    }

    func setupUI() {
        mapView.delegate = self
        mapView.showsScale = true
        mapView.showsPointsOfInterest = true
        mapView.showsUserLocation = true
    }
    

    
    func updateFull() {
        let sourceLocation = CLLocationCoordinate2D(latitude: model.lat, longitude: model.lon)
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation)
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let sourceAnnotation = MKPointAnnotation()
        sourceAnnotation.title = model.name
        
        if let location = sourcePlacemark.location {
            sourceAnnotation.coordinate = location.coordinate
        }

        self.mapView.showAnnotations([sourceAnnotation], animated: true)
        self.IDLabel.text = "ID: \(self.model.id)"
        self.countryLabel.text = "Country: \(self.model.country)"


    }
    


}
