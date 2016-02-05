//
//  ResultViewController.swift
//  Feed Me
//
//  Created by Swagat Kumar Bisoyi on 2/2/16.
//  Copyright © 2016 Ron Kliffer. All rights reserved.
//

import UIKit
import SAParallaxViewControllerSwift
import MSTwitterSplashScreen

class ResultViewController: SAParallaxViewController {
    
    
    var splashScreen : MSTwitterSplashScreen!
    var twitterSplashScreen : MSTwitterSplashScreen!
    
    
  convenience init() {
    self.init(nibName: nil, bundle: nil)
  }
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let topColor = UIColor(red: 0.683, green: 0.808, blue: 0.998, alpha: 1.0)
    let bottomColor = UIColor(red: 0.088, green: 0.410, blue: 0.997, alpha: 1.0)
    let logoColor = UIColor.whiteColor()
    var bezierPath = UIBezierPath()
    bezierPath = bezierPath.logoShape()
    
    
    let splashScreen = MSTwitterSplashScreen(splashScreenWithBezierPath: bezierPath, backgroundWithGradientFromTopColor: topColor, bottomColor: bottomColor, logoColor: logoColor)
    splashScreen.durationAnimation = 1.8;
    
    self.twitterSplashScreen = splashScreen;
    self.view.addSubview(twitterSplashScreen)

  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    let dispatchTime: dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
    dispatch_after(dispatchTime, dispatch_get_main_queue(), {
      self.twitterSplashScreen.startAnimation()
    })

  }
}
//MARK: - UICollectionViewDataSource
extension ResultViewController {
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath)
    
    if let cell = cell as? SAParallaxViewCell {
      
      for view in cell.containerView.accessoryView.subviews {
        if let view = view as? UILabel {
          view.removeFromSuperview()
        }
      }
      
      let index = indexPath.row % 6
      let imageName = String(format: "image%d", index + 1)
      if let image = UIImage(named: imageName) {
        cell.setImage(image)
      }
      let title = ["Girl with Room", "Beautiful sky", "Music Festival", "Fashion show", "Beautiful beach", "Pizza and beer"]
      let label = UILabel(frame: cell.containerView.accessoryView.bounds)
      label.textAlignment = .Center
      label.text = title[index]
      label.textColor = .whiteColor()
      label.font = .systemFontOfSize(30)
      cell.containerView.accessoryView.addSubview(label)
    }
    
    return cell
  }
}

//MARK: - UICollectionViewDelegate
extension ResultViewController {
  override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    super.collectionView(collectionView, didSelectItemAtIndexPath: indexPath)
    
    if let cells = collectionView.visibleCells() as? [SAParallaxViewCell] {
      let containerView = SATransitionContainerView(frame: view.bounds)
      containerView.setViews(cells: cells, view: view)
      
      let viewController = DetailViewController()
      viewController.transitioningDelegate = self
      viewController.trantisionContainerView = containerView
      
      self.presentViewController(viewController, animated: true, completion: nil)
    }
  }
}
