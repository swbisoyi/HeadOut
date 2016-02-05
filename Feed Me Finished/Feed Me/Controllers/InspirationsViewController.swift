//
//  InspirationsViewController.swift
//  RWDevCon
//
//  Created by Mic Pringle on 02/03/2015.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit
import ObjectMapper
import SDWebImage

class InspirationsViewController: UICollectionViewController {
  
  let inspirations = Inspiration.allInspirations()
    var allDummyData = [DemoData]()

  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return UIStatusBarStyle.LightContent
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let patternImage = UIImage(named: "Pattern") {
      view.backgroundColor = UIColor(patternImage: patternImage)
    }
    collectionView!.backgroundColor = UIColor.clearColor()
    collectionView!.decelerationRate = UIScrollViewDecelerationRateFast
    getData()
  }

    func getData()
    {
//        let url = "http://t.justdial.com/india_api_read/26june2015/searchziva.php?city=Mumbai&state=&case=spcall&stype=category_list&search=Hotels&docid=303533&lat=&long=&area=&max=20&pg_no=1&rnd1=0.62593&rnd2=0.20095&rnd3=0.53869&basedon=&nearme=&wap=2&login_mobile=&moviedate=2015-12-21&mvbksrc=tp%2Cpvr%2Ccinemax%2Cfc"
        let url = "http://t.justdial.com/india_api_read/26june2015/searchziva.php?city=Mumbai&state=&case=what_where&stype=what_where&search=Restaurants%20In%205%20Star%20Hotels&lat=&long=&area=&gcity=Bangalore&garea=Manyata%20Tech%20Park&glat=13.042151899999999&glon=77.62496229999999&max=20&pg_no=1&rnd1=0.34999&rnd2=0.23315&rnd3=0.54116&basedon=&nearme=&wap=2&login_mobile=&moviedate=2015-12-21&mvbksrc=tp%2Cpvr%2Ccinemax%2Cfc"
        
        DemoClient.getFilterData(url, targetViewController: self) { (responseObject, error) -> Void in
            
            for i in 0...(responseObject!["results"]?.count)!-1
            {
                let filterDataObject = Mapper<DemoData>().map(responseObject!["results"]![i])
                print(filterDataObject?.name as! String)
                self.allDummyData.append(filterDataObject!)
            }
            self.collectionView?.reloadData()
        }
    }
    
}

extension InspirationsViewController {
  
  override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return allDummyData.count
  }
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("InspirationCell", forIndexPath: indexPath) as! InspirationCell
    cell.imageView.sd_setImageWithURL(NSURL(string: allDummyData[indexPath.row].thumbnail as! String), placeholderImage: UIImage(named: "image1"))
    cell.titleLabel.text = allDummyData[indexPath.row].name as? String
    cell.timeAndRoomLabel.text = allDummyData[indexPath.row].NewAddress as? String
    cell.speakerLabel.text = "JDReviews : " + (allDummyData[indexPath.row].totJdReviews as! String)
    
    return cell
  }

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    }
    
    
    
}