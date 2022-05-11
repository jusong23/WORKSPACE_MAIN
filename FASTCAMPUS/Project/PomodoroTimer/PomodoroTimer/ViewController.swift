//
//  ViewController.swift
//  PomodoroTimer
//
//  Created by 이주송 on 2022/05/10.
//

import UIKit

enum TimerStatus {
    case start
    case pasue
    case end
} // 열거형 - swicth와 함께 잘 쓰이니 참고


class ViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var prograssView: UIProgressView!
    
    @IBOutlet weak var dataPicker: UIDatePicker!
    
    @IBOutlet weak var cancleButton: UIButton!
    
    @IBOutlet weak var toggleButton: UIButton!
    
    var duration = 60 // DataPicker 1분으로 초기화
    var timerStatus: TimerStatus = .end
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureToggleButton()
    }
    
    func configureToggleButton() {
        self.toggleButton.setTitle("시작", for: .normal)
        self.toggleButton.setTitle("일시정지", for: .selected)
    } // 버튼이 눌렸을때 버튼 설정이 바뀌게(viewDidLoad안에 작성)
    
    func setTimerInfoViewVisble(isHidden: Bool) {
        self.timerLabel.isHidden = isHidden
        self.prograssView.isHidden = isHidden
    } // 타이머 작동되면 isHidden 되도록 !
    
    @IBAction func cancleButton(_ sender: Any) {
    }
    
    @IBAction func toggleButton(_ sender: Any) {
        self.duration = Int(self.dataPicker.countDownDuration) // Data Picker에서 설정한 타이머 시간을 duration으로 초 표시 가능
        switch self.timerStatus {
        case .end:
            self.timerStatus = .start
            setTimerInfoViewVisble(isHidden: false)
            self.dataPicker.isHidden = true
            self.toggleButton.isSelected = true
            self.cancleButton.isEnabled = true
        case .start:
            self.timerStatus = .pasue
        default:
            break
        } // 열거형에 따른 스위치문(같이 묶여서 쓰인다)
    }
 
    


    
}

