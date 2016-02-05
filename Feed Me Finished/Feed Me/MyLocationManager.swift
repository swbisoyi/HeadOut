//
//  MyLocationManager.swift
//  JustDialBase
//
//  Created by Sriram S on 12/2/15.
//  Copyright © 2015 Swagat Kumar Bisoyi. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class MyLocationManager: CLLocationManager, CLLocationManagerDelegate {
    func fetchLocation()
    {
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        print(locationManager.location!.coordinate)

    }
    

}
