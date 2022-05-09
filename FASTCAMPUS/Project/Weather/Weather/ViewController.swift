//
//  ViewController.swift
//  Weather
//
//  Created by 이주송 on 2022/05/09.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var cityNameTextField: UITextField!
    
    @IBOutlet var weatherDiscription: UILabel!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var tempLabel: UILabel!
    
    @IBOutlet var maxTempLabel: UILabel!
    
    @IBOutlet var minTempLabel: UILabel!
     
    @IBAction func tapFetchWeatherButton(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

