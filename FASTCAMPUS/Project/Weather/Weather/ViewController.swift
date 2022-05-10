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
     
    @IBOutlet var weatherStackView: UIStackView!
    
    @IBAction func tapFetchWeatherButton(_ sender: UIButton) {
        if let cityName = self.cityNameTextField.text {
            self.getCurrentWeather(cityName: cityName)
            self.view.endEditing(true) // 버튼 눌리면 키보드 내려가는 기능
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func showAlert(mesaage: String){
        let alert = UIAlertController(title: "Error", message: mesaage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func configureView(weatherInformation: WeatherInformation) {
        self.cityNameLabel.text = weatherInformation.name
        if let weather = weatherInformation.weather.first {
            self.weatherDiscription.text = weather.description
        }
        self.tempLabel.text = "\(Int(weatherInformation.temp.temp - 273.15))°C"
        self.minTempLabel.text = "\(Int(weatherInformation.temp.minTemp - 273.15))°C"
        self.maxTempLabel.text = "\(Int(weatherInformation.temp.maxTemp - 273.15))°C"
    } // 함수안에서 쓰일 parameter weatherInforma tion는 앞에서 정의한 WeatherInformation 배열에 저장된 값들이다!
    
    func getCurrentWeather(cityName: String) {
    guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=5448715390df41aed509eef3faa3053b") else { return }
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { [weak self] data, response, error in
            
            let successRange = (200..<300)
        guard let data = data, error == nil else { return } // 요청 성공 시 다음라인 가도록
        let decoder = JSONDecoder() // json 객체에서 data 유형의 인스턴스로 디코딩하는 객체! Decodable, Codable 프로토콜을 준수하는 라인!
            if let response = response as? HTTPURLResponse, successRange.contains(response.statusCode) {
                guard let weatherInformation = try? decoder.decode(WeatherInformation.self, from: data) else { return }
                // 1st Parameter : json을 매핑시켜줄 Codable Protocol을 준수하는 사용자 정의 타입(구조체 만들어 둔거)
                // 2nd Parameter : 서버에서 응답받은 json 데이터
                DispatchQueue.main.async {       // 메인 Thread에서 작업하도록
                    self?.weatherStackView.isHidden = false
                    self?.configureView(weatherInformation: weatherInformation)
                }
            } else {
                guard let errorMessage = try? decoder.decode(ErrorMessage.self, from: data) else { return }
                DispatchQueue.main.async {
                    self?.showAlert(mesaage: errorMessage.message)
                }
            }
        }.resume() // dataTask.resume() 호출하여 작업 실행!
    } // json 객체의 서버 데이터가 앞에서 정의한 WeatherInformation 배열에 저장!
}

