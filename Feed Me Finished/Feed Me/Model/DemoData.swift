//
//  DemoData.swift
//  JustDialBase
//
//  Created by Swagat Kumar Bisoyi on 12/21/15.
//  Copyright © 2015 Swagat Kumar Bisoyi. All rights reserved.
//

import UIKit
import ObjectMapper

class DemoData : Mappable {
    var docId : AnyObject?
    var name : AnyObject?
    var address : AnyObject?
    var thumbnail : AnyObject?
    var NewAddress : AnyObject?
    var totJdReviews : AnyObject?
    
    required init?(_ map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        docId    <- map["docId"]
        name         <- map["name"]
        address      <- map["address"]
        thumbnail       <- map["thumbnail"]
        totJdReviews  <- map["totJdReviews"]
        NewAddress  <- map["NewAddress"]
        
    }

}
