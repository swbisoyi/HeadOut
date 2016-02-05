//
//  LocationUtils.swift
//  JustDialBase
//
//  Created by Sriram S on 12/2/15.
//  Copyright © 2015 Swagat Kumar Bisoyi. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

public class LocationUtils : NSObject, CLLocationManagerDelegate{
    
    public static func zoomToUserLocationInMapView(mapView: MKMapView) {
        if let coordinate = mapView.userLocation.location?.coordinate {
            let region = MKCoordinateRegionMakeWithDistance(coordinate, 10000, 10000)
            mapView.setRegion(region, animated: true)
        }
    }

}