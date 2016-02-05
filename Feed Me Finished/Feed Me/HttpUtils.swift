//
//  HttpUtils.swift
//  JustDialBase
//
//  Created by Sriram S on 12/2/15.
//  Copyright © 2015 Swagat Kumar Bisoyi. All rights reserved.
//

import Foundation
import Alamofire
public class HttpUtils {
    
    public static func checkConnectionAndDisplayError(targetViewController: UIViewController) -> Bool{
        
        let isNetworkAvailable = Reachability.isConnectedToNetwork()
        if !isNetworkAvailable {
            MessageDisplay.displayAlert("Network not available", messageString: "Looks like you are not connected to internet!", viewController: targetViewController)
        }
        return isNetworkAvailable
    }
    
    
    public static func getRequest(url: String, targetViewController: UIViewController, completionHandler: UserUtils.responseStringCompletionHandler){
        let isNetworkAvailable = checkConnectionAndDisplayError(targetViewController)
        if isNetworkAvailable {
            Alamofire.request(.GET, url).responseString(){
                response in
                completionHandler(responseObject: response.result.value as String?, error: response.result.error as NSError?)
                print("Request: \(response.request); Response: \(response.response); Value: \(response.result)")
            }
        }
    }
    
    
    public static func putRequest(url: String, targetViewController: UIViewController, completionHandler: UserUtils.responseStringCompletionHandler){
        let isNetworkAvailable = checkConnectionAndDisplayError(targetViewController)
        if isNetworkAvailable {
            Alamofire.request(.PUT, url).responseString(){
                response in
                completionHandler(responseObject: response.result.value as String?, error: response.result.error as NSError?)
                print("Request: \(response.request); Response: \(response.response); Value: \(response.result)")
            }
        }
    }
    public static func putRequestWithBody(url: String, targetViewController: UIViewController, completionHandler: UserUtils.responseStringCompletionHandler, body : Dictionary<String, String>){
        let isNetworkAvailable = checkConnectionAndDisplayError(targetViewController)
        if isNetworkAvailable {
            Alamofire.request(.PUT, url, parameters: body).responseString(){
                response in
                completionHandler(responseObject: response.result.value as String?, error: response.result.error as NSError?)
                print("Request: \(response.request); Response: \(response.response); Value: \(response.result)")
            }
        }
    }
    
    
    public static func postRequest(url: String, targetViewController: UIViewController, completionHandler: UserUtils.responseStringCompletionHandler){
        let isNetworkAvailable = checkConnectionAndDisplayError(targetViewController)
        if isNetworkAvailable {
            Alamofire.request(.POST, url).responseString(){
                response in
                completionHandler(responseObject: response.result.value as String?, error: response.result.error as NSError?)
                print("Request: \(response.request); Response: \(response.response); Value: \(response.result)")
            }
        }
    }
    
    public static func postRequestWithBody(url: String, targetViewController: UIViewController, completionHandler: UserUtils.responseStringCompletionHandler, body : Dictionary<String, String>){
        let isNetworkAvailable = checkConnectionAndDisplayError(targetViewController)
        if isNetworkAvailable {
            Alamofire.request(.POST, url, parameters: body).responseString(){
                response in
                completionHandler(responseObject: response.result.value as String?, error: response.result.error as NSError?)
                print("Request: \(response.request); Response: \(response.response); Value: \(response.result)")
            }
        }
    }
    
    
    
    public static func getJSONRequest(url: String, targetViewController: UIViewController?, completionHandler: UserUtils.responseJSONCompletionHandler){
        let isnetworkAvailable = checkConnectionAndDisplayError(targetViewController!)
        if isnetworkAvailable{
            Alamofire.request(.GET, url).responseJSON(){
                response in
                print(response.result.value)
                completionHandler(responseObject: response.result.value as? NSDictionary, error: response.result.error as NSError?)
            }
        }
    }
    
    public static func putJSONRequest(url: String, targetViewController: UIViewController, completionHandler: UserUtils.responseJSONCompletionHandler){
        let isnetworkAvailable = checkConnectionAndDisplayError(targetViewController)
        if isnetworkAvailable {
            Alamofire.request(.PUT, url).responseJSON(){
                response in
                completionHandler(responseObject: response.result.value as? NSDictionary, error: response.result.error as NSError?)
            }
        }
    }
    
    
    public static func postJSONRequestWithBody(url: String, targetViewController: UIViewController, completionHandler: UserUtils.responseJSONCompletionHandler,body : Dictionary<String, String>){
        let isnetworkAvailable = checkConnectionAndDisplayError(targetViewController)
        if isnetworkAvailable {
            Alamofire.request(.POST, url, parameters: body).responseJSON(){
                response in
                completionHandler(responseObject: response.result.value as? NSDictionary, error: response.result.error as NSError?)
            }
        }
    }
    
    public static func putJSONRequestWithBody(url: String, targetViewController: UIViewController, completionHandler: UserUtils.responseJSONCompletionHandler,body : Dictionary<String, String>){
        let isnetworkAvailable = checkConnectionAndDisplayError(targetViewController)
        if isnetworkAvailable {
            Alamofire.request(.PUT, url, parameters: body).responseJSON(){
                response in
                completionHandler(responseObject: response.result.value as? NSDictionary, error: response.result.error as NSError?)
            }
        }
    }
    
    
    
    public static func deleteJSONRequest(url: String, targetViewController: UIViewController, completionHandler: UserUtils.responseJSONCompletionHandler){
        let isnetworkAvailable = checkConnectionAndDisplayError(targetViewController)
        if isnetworkAvailable{
            Alamofire.request(.DELETE, url).responseJSON(){
                response in
                completionHandler(responseObject: response.result.value as? NSDictionary, error: response.result.error as NSError?)
            }
        }
    }
}
