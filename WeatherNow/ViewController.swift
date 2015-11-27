//
//  ViewController.swift
//  WeatherNow
//
//  Created by Yong Jae Kim on 2015. 11. 25..
//  Copyright © 2015년 Yong Jae Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource {
    
    var pageViewController: UIPageViewController!
    var weatherImages: NSArray!
    var temperature: NSArray!
    var humidity: NSArray!
    var windPower: NSArray!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.weatherImages = NSArray(objects: "Sun","Snow","Sun","Sun")
        
        self.temperature = NSArray(objects: "15","14","13","-1")
        self.humidity = NSArray(objects: "98","89","70","55")
        self.windPower = NSArray(objects: "38","23","25","34")
        
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        
        self.pageViewController.dataSource = self
        
        let startVC = self.viewControllerAtIndex(0) as WeatherViewController
        let memberViewControllers = NSArray(objects: startVC)
        
        self.pageViewController.setViewControllers(memberViewControllers as! [WeatherViewController], direction: .Forward, animated: true, completion: nil)
        
        self.pageViewController.view.frame = CGRectMake(0, 60, self.view.frame.width, self.view.frame.size.height - 60)
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
    }
    
    func viewControllerAtIndex(index : Int ) -> WeatherViewController {
        if (self.temperature.count == 0 || index >= self.temperature.count ) {
            return WeatherViewController()
        }
        
        let weatherVC : WeatherViewController = self.storyboard?.instantiateViewControllerWithIdentifier("WeatherViewController") as! WeatherViewController
        
        weatherVC.weatherImageFile = weatherImages[index] as? String
        weatherVC.tempString = temperature[index] as? String
        weatherVC.humidityString = humidity[index] as? String
        weatherVC.windString = windPower[index] as? String
        
        weatherVC.pageIndex = index
        
        return weatherVC
        
    }
    
    // MARK: -Page View Controller DataSource
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! WeatherViewController
        var index = vc.pageIndex as Int
        
        if (index == 0 || index == NSNotFound) {
            return nil
        }
        
        index--
        return self.viewControllerAtIndex(index)
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! WeatherViewController
        var index = vc.pageIndex as Int
        
        if (index == NSNotFound) {
            return nil
        }
        
        index++
        
        if (index == self.temperature.count) {
            return nil
        }
        
        return self.viewControllerAtIndex(index)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.temperature.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    

}

