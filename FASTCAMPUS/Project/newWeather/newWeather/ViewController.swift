//
//  ViewController.swift
//  newWeather
//
//  Created by 이주송 on 2022/05/11.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var metaLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchWeatherOverview(completionHandler: {
            [weak self] result in // 순환 참조 방지, 전달인자로 result
            guard let self = self else { return } // 일시적으로 strong ref가 되게
            switch result {
            case let .success(result):
                self.configureStackView(movieOverview: result)
            case let .failure(error):
                debugPrint("error \(error)")
            }
        })
    }
    
    func configureStackView(movieOverview: weatherOverview) {
        self.statusLabel.text = "\(movieOverview.status)"
        self.messageLabel.text = "\(movieOverview.status_message)"
        self.metaLabel.text = "\(movieOverview.meta.execution_time)"
    }

    func fetchWeatherOverview ( // completionHandler 클로저를 매개변수로 전달받게 !
        completionHandler: @escaping (Result<weatherOverview,Error>)-> Void
        // completionHandler를 Escaping 클로저로 선언: 클로저가 함수로 탈출! 함수가 반환된 후에도 클로저 실행
        // 함수의 인자가 함수의 영역을 탈출하여 밖에서도 사용할 수 있는 개념  (비동기 작업 - 대부분의 네트워크 통신)
        // 아래 responseData메소드 Parameter에 정의한 completionHandler는 fetchCovidOverview가 반환(Void)된 후에 호출!
        // 서버에서 언제 응답시켜줄지 모르기 때문
        // 즉, 시간이 지나 응답을 받아도(비동기로 응답받기 전) 아래 reponse는 응답을 못받은줄 알고 종료시키는 상황 방지
        // 함수 내 비동기 작업 후 결과를 completionHandler로 Call back을 시켜줘야 한다.
        
        // 응답받는데 성공하면 이를 CityCovideOverview 구조체에 전달, 실패하거나 Error이면 Error 열거형으로 전달되게한다.
    ) {
        let url = "https://yts.mx/api/v2/list_movies.json?sort_by=download_count/"

        AF.request(url, method: .get) // get 방식 : url에 data담아 보내는 형식
        // 위에 param을 정의한거 처럼 딕셔너리 형태로 저장을하면 알아서 요청한 url뒤에 query parameter가 붙여짐!
            .responseData(completionHandler: { reponse in // 응답데이터를 받을수 있는 메소드를 Chaning
                switch reponse.result { // 요청에 대한 응답 결과
                case let .success(data): // 요청 O
                    do { // 요청 O 응답 O
                        let decoder = JSONDecoder()
                        // json 객체에서 data 유형의 인스턴스로 디코딩하는 객체! Decodable, Codable 프로토콜을 준수하는 라인!
                        let result = try decoder.decode(weatherOverview.self, from: data)
                        // 서버에서 전달받은 data를 매핑시켜줄 객체타입으로 CityCovideOverview를 설정
                        completionHandler(.success(result))
                        // 응답이 완료되면. Completion Handler가 호출됨 -> result를 넘겨받아 data가 구조체로 매핑
                    } catch { // 요청 O 응답 X
                        completionHandler(.failure(error))
                        // 응답을 못받으면 error를 받음
                    }
                case let .failure(error): // 요청 X
                    completionHandler(.failure(error))
                }
            })
    }
}



