//
//  weatherOverview.swift
//  newWeather
//
//  Created by 이주송 on 2022/05/11.
//    

import Foundation

struct weatherOverview: Codable {
    let status: String
    let status_message: String
    let meta: meta
    
    enum CodingKeys: String, CodingKey {
        case status
        case status_message
        case meta = "@meta"
    }
}
 // json 객체 안에 있는거 받아 오려면 다 적어야 한다. (다 받아야 한다.)

struct meta: Codable {
    let server_time: Int
    let server_timezone: String
    let api_version: Int
    let execution_time: String
}
