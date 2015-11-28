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
    var weatherImages: [String]!
    var temperature: [String]!
    var humidity: [String]!
    var windPower: [String]!
    var dayArray: [String]!
    
    var weatherArray = [Weather]()
    var downloadCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        calculateDay()
        downloadData()
    }
    
    func calculateDay() {
        
        var i : Int = 0
        let timeStamp = NSTimeIntervalSince1970
        let date = NSDate(timeIntervalSince1970: timeStamp)
        let cal = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let weekDayComponent = cal?.components(NSCalendarUnit.Weekday, fromDate: date)
        
        let today = weekDayComponent!.weekday
        
        dayArray = ["\(today)", "\(today+1)", "\(today+2)", "\(today+3)"]
        
    }

    
    func downloadData() {
        var i = 0
        let loopArray = [3,11,19,27]
        
        for i=0; i<4; i+=1{
            print(i)
            weatherArray.append(Weather(dayId: loopArray[i]))
            let count = self.weatherArray.count-1
            print("count : \(count)")
            weatherArray[count].downloadWeatherData({ () -> () in
                if self.downloadCount == 3 {
                    self.setPageView()
                } else {
                    self.downloadCount++
                    print("count : \(self.downloadCount)")
                }
            })
        }
    }
    
    func setPageView() {
        
        self.weatherImages = ["Sun","Sun","Snow","Sun"]
        
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        
        self.pageViewController.dataSource = self
        
        if let startVC = self.viewControllerAtIndex(0) as? WeatherViewController {
            let memberViewControllers = NSArray(objects: startVC)
        
            self.pageViewController.setViewControllers(memberViewControllers as! [WeatherViewController], direction: .Forward, animated: true, completion: nil)
        
            self.pageViewController.view.frame = CGRectMake(0, 60, self.view.frame.width, self.view.frame.size.height - 60)
        
            self.addChildViewController(self.pageViewController)
            self.view.addSubview(self.pageViewController.view)
            self.pageViewController.didMoveToParentViewController(self)
        }
    }
    
    func viewControllerAtIndex(index : Int ) -> WeatherViewController {
        
        if (self.weatherArray.count == 0 || index >= self.weatherArray.count ) {
            return WeatherViewController()
        }
        
        let weatherVC : WeatherViewController = self.storyboard?.instantiateViewControllerWithIdentifier("WeatherViewController") as! WeatherViewController
        print("temperature : \(weatherArray[index].temperature)")
        weatherVC.dayString = dayArray[index]
        weatherVC.tempString = weatherArray[index].temperature
        weatherVC.humidityString = weatherArray[index].humidity
        weatherVC.windString = weatherArray[index].windSpeed
        weatherVC.weatherImageFile = weatherArray[index].weatherState
        
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
        
        if (index == self.weatherArray.count) {
            return nil
        }
        
        return self.viewControllerAtIndex(index)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.weatherArray.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    

}

