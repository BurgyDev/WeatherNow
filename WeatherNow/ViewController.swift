//
//  ViewController.swift
//  WeatherNow
//
//  Created by Yong Jae Kim on 2015. 11. 25..
//  Copyright © 2015년 Yong Jae Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var pageViewController: UIPageViewController!
    var weatherImages: NSArray!
    var temperature: NSArray!
    var humidity: NSArray!
    var windyPower: NSArray!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /*func viewControllerAtIndex(index : Int ) -> WeatherViewController {
        if (self.temperature.count == 0 || index >= self.temperature.count ) {
            return WeatherViewController()
        }
        
        var vc : WeatherViewController = self.storyboard?.instantiateViewControllerWithIdentifier("WeatherViewController") as! WeatherViewController
        
    }*/

}

