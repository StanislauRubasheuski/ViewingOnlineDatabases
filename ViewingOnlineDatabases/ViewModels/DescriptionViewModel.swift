//
//  DescriptionViewModel.swift
//  ViewingOnlineDatabases
//
//  Created by Stanislau on 30.05.2018.
//  Copyright © 2018 Stanislau. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class DescriptionViewModel {
    
    var country: String = ""
    var id: String = ""
    var lat: Double = 0
    var lon: Double = 0
    var name: String = ""
    
    var sourceAnnotation = MKPointAnnotation()
    
    func updateUI(completion: @escaping () -> Void) {
        let sourceLocation = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation)
        sourceAnnotation.title = name
        if let location = sourcePlacemark.location {
            sourceAnnotation.coordinate = location.coordinate
        }
            completion()
    }
    
}
