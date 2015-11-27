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
        
        self.weatherImage.image = UIImage(named: self.weatherImageFile)
        
        self.tempLabel.text = "\(tempString)"
        self.humidityLabel.text = "\(humidityString) %"
        self.windLabel.text = "\(windString) m/s"
    }
    
}
