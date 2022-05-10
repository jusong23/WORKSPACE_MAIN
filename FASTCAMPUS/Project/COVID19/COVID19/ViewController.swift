//
//  ViewController.swift
//  COVID19
//
//  Created by 이주송 on 2022/05/10.
//

import UIKit

import Alamofire
import Charts

class ViewController: UIViewController{

    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var totalCaseLabel: UILabel!
    @IBOutlet weak var newCaseLabel: UILabel!
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var labelStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.indicatorView.startAnimating()
        self.fetchCovidOverview(completionHandler: {
            [weak self] result in // 순환 참조 방지, 전달인자로 result
            guard let self = self else { return } // 일시적으로 strong ref가 되게
            self.indicatorView.stopAnimating()
            self.indicatorView.isHidden = true
            self.labelStackView.isHidden = false
            self.pieChartView.isHidden = false
            switch result {
            case let .success(result):
                self.configureStackView(koreaCovidOverview: result.korea)
                
                let covidOverviewList = self.makeCovidOverviewList(cityCovideOverview: result)
                self.configureChartView(covidOverviewList: covidOverviewList)
                
            case let .failure(error):
                debugPrint("error \(error)")
            }
        }) // 함수 실행 -> 함수는 요청 O 응답 O completionHandler는 (.success(result))를 전달함
        // -> 함수가.success(result)을 전달받으면 case 문에 의해 debugPrint("success \(result)")를 출력
    }
    
    func makeCovidOverviewList(cityCovideOverview: CityCovideOverview) -> [CovidOverview] {
        return [
            cityCovideOverview.seoul,
            cityCovideOverview.busan,
            cityCovideOverview.daegu,
            cityCovideOverview.incheon,
            cityCovideOverview.gwangju,
            cityCovideOverview.gangwon,
            cityCovideOverview.daejeon,
            cityCovideOverview.ulsan,
            cityCovideOverview.sejong,
            cityCovideOverview.gyeonggi,
            cityCovideOverview.chungbuk,
            cityCovideOverview.chungnam,
            cityCovideOverview.jeonbuk,
            cityCovideOverview.jeonnam,
            cityCovideOverview.gyeongnam,
            cityCovideOverview.jeju
        ]
    }// CityCovideOverview 객체를 입력받아, [CovidOverview]에 할당해줄 것이다
    func configureChartView(covidOverviewList: [CovidOverview]){
        self.pieChartView.delegate = self
        
        let entries = covidOverviewList.compactMap {[weak self] overview -> PieChartDataEntry? in
            guard let self = self else { return nil }
            return PieChartDataEntry(
                value: removeFormatString(string: overview.newCase),
                label: overview.countryName,
                data: overview)
    }// CovidOverview 객체를 PieChartDataEntry 객체로 매핑시키는 함수
    // 각 객체는 overview라는 명찰을 한채 전달 될 것이다.
        let dataSet = PieChartDataSet(entries: entries, label: "코로나 발생 현황")
        dataSet.entryLabelColor = .black
        dataSet.valueTextColor = .black
        dataSet.sliceSpace = 1 // 엔트리 화 된 여러 데이터들의 묶음(세트) 그에대한 설정을 나타낼 것이다.
        dataSet.xValuePosition = .outsideSlice // 항목이 차트 바깥에 나오게
        dataSet.valueLinePart1OffsetPercentage = 0.8
        dataSet.valueLinePart1Length = 0.2
        dataSet.valueLinePart2Length = 0.3
        dataSet.colors =
        ChartColorTemplates.vordiplom() +
        ChartColorTemplates.joyful() +
        ChartColorTemplates.liberty() +
        ChartColorTemplates.pastel() +
        ChartColorTemplates.material() // 차트를 다양한 색상으로 표현가능
        self.pieChartView.data = PieChartData(dataSet: dataSet)
        self.pieChartView.spin(duration: 0.3, fromAngle: self.pieChartView.rotationAngle, toAngle: self.pieChartView.rotationAngle + 80)
        // 차트를 회전 시키는 메소드
    }
        
    func removeFormatString(string: String)->Double {
        let formmatter = NumberFormatter()
        formmatter.numberStyle = .decimal
        return formmatter.number(from: string)?.doubleValue ?? 0
    } // String을 Double로 바꿔주는 함수
        
    func configureStackView(koreaCovidOverview: CovidOverview) {
        self.totalCaseLabel.text = "\(koreaCovidOverview.totalCase)명"
        self.newCaseLabel.text = "\(koreaCovidOverview.newCase)명"
    }
    
    func fetchCovidOverview ( // completionHandler 클로저를 매개변수로 전달받게 !
        completionHandler: @escaping (Result<CityCovideOverview,Error>)-> Void
        // completionHandler를 Escaping 클로저로 선언: 클로저가 함수로 탈출! 함수가 반환된 후에도 클로저 실행
        // 함수의 인자가 함수의 영역을 탈출하여 밖에서도 사용할 수 있는 개념  (비동기 작업 - 대부분의 네트워크 통신)
        // 아래 responseData메소드 Parameter에 정의한 completionHandler는 fetchCovidOverview가 반환(Void)된 후에 호출!
        // 서버에서 언제 응답시켜줄지 모르기 때문
        // 즉, 시간이 지나 응답을 받아도(비동기로 응답받기 전) 아래 reponse는 응답을 못받은줄 알고 종료시키는 상황 방지
        // 함수 내 비동기 작업 후 결과를 completionHandler로 Call back을 시켜줘야 한다.
        
        // 응답받는데 성공하면 이를 CityCovideOverview 구조체에 전달, 실패하거나 Error이면 Error 열거형으로 전달되게한다.
    ) {
        let url = "https://api.corona-19.kr/korea/country/new/"
        let param = [
            "serviceKey": "Px1O9jwLSGqiCtYUfdvspkBJcNaroDHIW"
        ]
        
        AF.request(url, method: .get, parameters: param) // get 방식 : url에 data담아 보내는 형식
        // 위에 param을 정의한거 처럼 딕셔너리 형태로 저장을하면 알아서 요청한 url뒤에 query parameter가 붙여짐!
            .responseData(completionHandler: { reponse in // 응답데이터를 받을수 있는 메소드를 Chaning
                switch reponse.result { // 요청에 대한 응답 결과
                case let .success(data): // 요청 O
                    do { // 요청 O 응답 O
                        let decoder = JSONDecoder()
                        // json 객체에서 data 유형의 인스턴스로 디코딩하는 객체! Decodable, Codable 프로토콜을 준수하는 라인!
                        let result = try decoder.decode(CityCovideOverview.self, from: data)
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


extension ViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        guard let covidDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "CovidDetailViewController") as? CovidDetailViewController else { return } // storyboard의 VC를 인스턴스화 !
        guard let covidOverview = entry.data as? CovidOverview else { return } 
        // entry.data를 CovidOverview으로 다운 캐스팅하여 전달할 것임
        covidDetailViewController.covidOverview = covidOverview
        self.navigationController?.pushViewController(covidDetailViewController, animated: true)
    } // 차트가 Seleted 됐을때 호출되는 메소드 엔트리 메소드 pra를 통해 가져올 수 있음
} 
