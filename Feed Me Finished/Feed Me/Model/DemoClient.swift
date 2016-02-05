//
//  DemoClient.swift
//  JustDialBase
//
//  Created by Swagat Kumar Bisoyi on 12/21/15.
//  Copyright © 2015 Swagat Kumar Bisoyi. All rights reserved.
//

import Foundation
import UIKit

public class DemoClient{
    
    // MARK: Local Variable
    
    private static let baseServerUrl: String = GlobalConstants.baseUrl + GlobalConstants.apiRead
    
    
    // MARK: Type Alias
    
    public typealias responseJSONCompletionHandler = (responseObject: NSDictionary?, error: NSError?) -> Void
    public typealias responseStringCompletionHandler = (responseObject: String?, error: NSError?) -> Void
    
    // MARK: Webservice Method
    
    public static func getFilterData(url : String, targetViewController : UIViewController, complitionHandler: responseJSONCompletionHandler){
        
        let getFilterDataUrl = url
        print(getFilterDataUrl)
        HttpUtils.getJSONRequest(getFilterDataUrl, targetViewController: targetViewController, completionHandler: complitionHandler)
    }

}