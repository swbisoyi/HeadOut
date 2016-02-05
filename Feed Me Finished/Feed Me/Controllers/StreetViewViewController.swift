//
//  StreetViewViewController.swift
//  Feed Me
//
//  Created by Swagat Kumar Bisoyi on 12/17/15.
//  Copyright © 2015 Ron Kliffer. All rights reserved.
//

import UIKit
import GoogleMaps

class StreetViewViewController: UIViewController {
  
  @IBOutlet weak var viewStreet: UIView!
  @IBOutlet weak var sampleImageView: UIImageView!
  var panoView: GMSPanoramaView!
  var panoramaNear = CLLocationCoordinate2DMake(30.274262, -97.752371)

  override func viewDidLoad() {
    super.viewDidLoad()
    
    
//    panoView = GMSPanoramaView.panoramaWithFrame(CGRectZero,
//      nearCoordinate:panoramaNear)
//    panoView = GMSPanoramaView.panoramaWithFrame(CGRectZero, nearCoordinate: panoramaNear, radius: 20000)
    
    viewStreet.addSubview(panoView)
    viewStreet.sendSubviewToBack(panoView)
    
    let equalWidth = NSLayoutConstraint(item: panoView, attribute: .Width, relatedBy: .Equal, toItem: viewStreet, attribute: .Width, multiplier: 1.0, constant: 0)
    let equalHeight = NSLayoutConstraint(item: panoView, attribute: .Height, relatedBy: .Equal, toItem: viewStreet, attribute: .Height, multiplier: 1.0, constant: 0)
    let top = NSLayoutConstraint(item: panoView, attribute: .Top, relatedBy: .Equal, toItem: viewStreet, attribute: .Top, multiplier: 1.0, constant: 0)
    let left = NSLayoutConstraint(item: panoView, attribute: .Left, relatedBy: .Equal, toItem: viewStreet, attribute: .Left, multiplier: 1.0, constant: 0)
    
    panoView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activateConstraints([equalWidth, equalHeight, top, left])
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}

