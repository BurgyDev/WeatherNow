//
//  WeatherViewController.swift
//  WeatherNow
//
//  Created by Yong Jae Kim on 2015. 11. 25..
//  Copyright © 2015년 Yong Jae Kim. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet var weatherImage: UIImageView!

    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    @IBOutlet var windLabel: UILabel!
    
    var weatherImageFile : String!
    var humidityString: String!
    var windString: String!
    var tempString: String!
    var pageIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dayLabel.text = self.calculateDay()
        self.weatherImage.image = UIImage(named: self.weatherImageFile)
        
        self.tempLabel.text = "\(tempString)"
        self.humidityLabel.text = "\(humidityString) %"
        self.windLabel.text = "\(windString) m/s"
    }
    
    func calculateDay() -> String {
        let timeStamp = NSTimeIntervalSince1970
        let date = NSDate(timeIntervalSince1970: timeStamp)
        let cal = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let weekDayComponent = cal?.components(NSCalendarUnit.Weekday, fromDate: date)
        
        let today = weekDayComponent?.weekday
        
        switch(today!){
            
        case 1: return "Friday"
        case 2: return "Saturday"
        case 3: return "Sunday"
        case 4: return "Monday"
        case 5: return "Tuesday"
        case 6: return "Wednesday"
        case 7: return "Thursday"
        default: return ""
            
        }

    }
    
}
