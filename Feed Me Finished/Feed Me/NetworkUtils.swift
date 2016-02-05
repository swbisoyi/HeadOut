//
//  NetworkUtils.swift
//  JustDialBase
//
//  Created by Sriram S on 12/2/15.
//  Copyright © 2015 Swagat Kumar Bisoyi. All rights reserved.
//

import Foundation
import SystemConfiguration

public class Reachability{
  
  public static func isConnectedToNetwork() -> Bool {
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    let defualtRouteRechability = withUnsafePointer(&zeroAddress){
      SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
    }
    
    var flags = SCNetworkReachabilityFlags()
    if !SCNetworkReachabilityGetFlags(defualtRouteRechability!, &flags){
      return false
    }
    
    let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
    let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
    
    return (isReachable && !needsConnection)
  }
}
