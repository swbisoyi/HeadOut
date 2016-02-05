//
//  AlertViewUtils.swift
//  JustDialBase
//
//  Created by Sriram S on 12/2/15.
//  Copyright © 2015 Swagat Kumar Bisoyi. All rights reserved.
//

import Foundation
import UIKit

public class MessageDisplay {
  
  public static func displayAlert(titleString : String, messageString: String, viewController: UIViewController) {
    let alertview = UIAlertController(title: titleString, message: messageString, preferredStyle: .Alert)
    alertview.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
    viewController.presentViewController(alertview, animated: true, completion: nil)
  }
  
//  public static func displayErrorAlert(responseError : ResponseError, targetViewController : UIViewController){
//    let alertview = UIAlertController(title: responseError.userMessage, message: responseError.hintForCorrection, preferredStyle: .Alert)
//    alertview.addAction(UIAlertAction(title: "OK", style: .Default , handler: nil))
//    targetViewController.presentViewController(alertview, animated: true, completion: nil)
//  }
  
  public static func displayAlertWithButtons(titleString : String, messageString: String,firstButtonTitle: String, secondButtonTitle: String , viewController: UIViewController) {
    let alertview = UIAlertController(title: titleString, message: messageString, preferredStyle: .Alert)
    alertview.addAction(UIAlertAction(title: firstButtonTitle, style: .Cancel, handler: nil))
    alertview.addAction(UIAlertAction(title: secondButtonTitle, style: .Default, handler: nil))
    viewController.presentViewController(alertview, animated: true, completion: nil)
  }
}
