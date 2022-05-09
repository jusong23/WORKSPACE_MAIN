//
//  WeatherInformation.swift
//  Weather
//
//  Created by 이주송 on 2022/05/09.
//

import Foundation

struct WeatherInformation: Codable {
    let weather: [Weather] // json파일에서 weather는 배열이므로 밑에 처럼 타입 선언을 한 것
    let temp: Temp
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case weather
        case temp = "main"
        case name
    }
} // json 인코딩, 디코딩 가능 weather informaiton 객체 <-> json
// 날씨 정보 json 파일을 weather informaiton struct로 변환하는 작업(디코딩)

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
// json 파일을 변환하고자 하면 , json파일의 key와 사용자가 정의한 struct의 타입이 일치해야!

struct Temp: Codable {
    let temp: Double
    let feelsLike: Double
    let minTemp: Double
    let maxTemp: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case minTemp = "temp_min"
        case maxTemp = "temp_max"
    }
    // json파일과 구조체에 선언된 이름이 달라도 Mappint될수 있도록, CodingKey 프로토콜을 채택한  열거형 선언
}


