//
//  GoogleDataProvider.swift
//  Feed Me
//
/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit
import Foundation
import CoreLocation
import SwiftyJSON

class GoogleDataProvider {
  let apiKey = "AIzaSyBnd-VqgKIaNuh7o8ONzNrCkrIbbjkoX0s"
  
  var photoCache = [String:UIImage]()
  var placesTask: NSURLSessionDataTask?
  var session: NSURLSession {
    return NSURLSession.sharedSession()
  }
  
  func fetchPlacesNearCoordinate(coordinate: CLLocationCoordinate2D, radius: Double, types:[String], completion: (([GooglePlace]) -> Void)) -> ()
  {
    var urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=\(apiKey)&location=\(coordinate.latitude),\(coordinate.longitude)&radius=\(radius)&rankby=prominence&sensor=true"
    let typesString = types.count > 0 ? types.joinWithSeparator("|") : "food"
    urlString += "&types=\(typesString)"
    urlString = urlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
    
    if let task = placesTask where task.taskIdentifier > 0 && task.state == .Running {
      task.cancel()
    }
    
    UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    placesTask = session.dataTaskWithURL(NSURL(string: urlString)!) {data, response, error in
      UIApplication.sharedApplication().networkActivityIndicatorVisible = false
      var placesArray = [GooglePlace]()
      if let aData = data {
        let json = JSON(data:aData, options:NSJSONReadingOptions.MutableContainers, error:nil)
        if let results = json["results"].arrayObject as? [[String : AnyObject]] {
          for rawPlace in results {
            let place = GooglePlace(dictionary: rawPlace, acceptedTypes: types)
            placesArray.append(place)
            if let reference = place.photoReference {
              self.fetchPhotoFromReference(reference) { image in
                place.photo = image
              }
            }
            else
            {
              
              for rawValue in rawPlace
              {
                if rawValue.0 == "icon"
                {
                  let url = NSURL(string: rawValue.1 as! String)
                  let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
                  place.photo = UIImage(data: data!)
                }
              }
            }
          }
        }
      }
      dispatch_async(dispatch_get_main_queue()) {
        completion(placesArray)
      }
    }
    placesTask?.resume()
  }
  func fetchDirectionsFrom(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D, completion: ((String?) -> Void)) -> ()
  {
    let urlString = "https://maps.googleapis.com/maps/api/directions/json?key=\(apiKey)&origin=\(from.latitude),\(from.longitude)&destination=\(to.latitude),\(to.longitude)&mode=walking"
    
    UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    session.dataTaskWithURL(NSURL(string: urlString)!) {data, response, error in
      UIApplication.sharedApplication().networkActivityIndicatorVisible = false
      var encodedRoute: String?
      var anyObj : [String:AnyObject]!
      do {
        anyObj = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! [String:AnyObject]
        // use anyObj here
      } catch {
        print("json error: \(error)")
      }
      
      
      if let json = anyObj {
        if let routes = json["routes"] as AnyObject? as? [AnyObject] {
          if let route = routes.first as? [String : AnyObject] {
            if let polyline = route["overview_polyline"] as AnyObject? as? [String : String] {
              if let points = polyline["points"] as AnyObject? as? String {
                encodedRoute = points
              }
            }
          }
        }
      }
      dispatch_async(dispatch_get_main_queue()) {
        completion(encodedRoute)
      }
      }.resume()
  }
  
  
  func fetchPhotoFromReference(reference: String, completion: ((UIImage?) -> Void)) -> () {
    if let photo = photoCache[reference] as UIImage! {
      completion(photo)
    } else {
      let urlString = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=200&photoreference=\(reference)&key=\(apiKey)"
      
      UIApplication.sharedApplication().networkActivityIndicatorVisible = true
      session.downloadTaskWithURL(NSURL(string: urlString)!) {url, response, error in
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        let downloadedPhoto = UIImage(data: NSData(contentsOfURL: url!)!)
        self.photoCache[reference] = downloadedPhoto
        dispatch_async(dispatch_get_main_queue()) {
          completion(downloadedPhoto)
        }
        }.resume()
    }
  }
}
