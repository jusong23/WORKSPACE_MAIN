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
     
    @IBAction func tapFetchWeatherButton(_ sender: UIButton) {
        if let cityName = self.cityNameTextField.text {
            self.getCurrentWeather(cityName: cityName)
            self.view.endEditing(true) // 버튼 눌리면 키보드 내려가는 기능
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func getCurrentWeather(cityName: String) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=5448715390df41aed509eef3faa3053b") else { return }
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return } // 요청 성공 시 다음라인 가도록
            let decoder = JSONDecoder() // json 객체에서 data 유형의 인스턴스로 디코딩하는 객체! Decodable, Codable 프로토콜을 준수하는 라인!
            let weatherInformation = try? decoder.decode(WeatherInformation.self, from: data)
            // 1st Parameter : json을 매핑시켜줄 Codable Protocol을 준수하는 사용자 정의 타입(구조체 만들어 둔거)
            // 2nd Parameter : 서버에서 응답받은 json 데이터
            debugPrint(weatherInformation)
        }.resume() // dataTask.resume() 호출하여 작업 실행!
    }
}

