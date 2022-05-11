//
//  ViewController.swift
//  PomodoroTimer
//
//  Created by 이주송 on 2022/05/10.
//

import UIKit
import AudioToolbox

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
    var timer: DispatchSourceTimer? // [GCB] Queue를 만들어 올리기만 하면 알아서 병렬적 작동(나중에)
    var currentSeconds = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureToggleButton()
    }
    
    func startTimer() {
        if self.timer == nil {
            self.timer = DispatchSource.makeTimerSource(flags: [], queue: .main) // [GCB] UI관련작업은 main Thread에서 !
            self.timer?.schedule(deadline: .now(), repeating: 1) // 타이머의 주기 설정 메소드
            self.timer?.setEventHandler(handler: { [weak self] in
                guard let self = self else {return}
                self.currentSeconds -= 1
                let hour = self.currentSeconds / 3600
                let minutes = (self.currentSeconds % 3600) / 60
                let seconds = (self.currentSeconds % 3600) % 60
                self.timerLabel.text = String(format: "%02d:%02d:%02d", hour,minutes,seconds)
                self.prograssView.progress = Float(self.currentSeconds) / Float(self.duration)
                if self.currentSeconds ?? 0 <= 0 { // [조건문] self?.currentSeconds가 0보다 작거나 같다면 !
                    self.stopTimer()
                    AudioServicesPlaySystemSound(1005) // 완료 시 아이폰 기본 알람
                }
            })// 1초(repeating)에 한번씩 무슨일이 일어나게 할지를 핸들러 클로즈에 설정하기
            self.timer?.resume()
        }
    } // Timer instance 작성해주기
    
    func stopTimer() {
        debugPrint(timerStatus)
        if self.timerStatus == .end {
            self.timer?.resume()
        } // 일시정지 후 nil을 대입하려면 resume해야 런타임 에러 안남
        self.timerStatus = .end
        self.cancleButton.isEnabled = false
        self.setTimerInfoViewVisble(isHidden: true)
        self.dataPicker.isHidden = false
        self.toggleButton.isSelected = false
        self.timer?.cancel()
        self.timer = nil
        // 화면 벗어났을때도 타이머 종료되게 !
    }
    
    func configureToggleButton() {
        self.toggleButton.setTitle("시작", for: .normal)
        self.toggleButton.setTitle("일시정지", for: .selected)
    } // 버튼이 눌렸을때 버튼 설정이 바뀌게(viewDidLoad안에 작성)
    
    func setTimerInfoViewVisble(isHidden: Bool) {
        self.timerLabel.isHidden = isHidden
        self.prograssView.isHidden = isHidden
    } // 타이머 작동되면 isHidden 되도록 !
    
    @IBAction func tapCancleButton(_ sender: UIButton) {
        switch self.timerStatus {
        case .start, .pasue:
            self.timerStatus = .end
            self.cancleButton.isEnabled = false
            self.setTimerInfoViewVisble(isHidden: true)
            self.dataPicker.isHidden = false
            self.toggleButton.isSelected = false
            self.stopTimer()
            
        default:
            break
        }
    }// 취소버튼이 눌리면 timerLabel & prograssView & data picker 사라지고 시작버튼 안눌린 상황, 취소버튼 Enabled된 상황으로 만들기
    
    @IBAction func tapToggleButton(_ sender: UIButton) {
        debugPrint(timerStatus)
        self.duration = Int(self.dataPicker.countDownDuration) // Data Picker에서 설정한 타이머 시간을 duration으로 초 표시 가능
        switch self.timerStatus {
        case .end:
            self.currentSeconds = self.duration
            self.timerStatus = .start
            setTimerInfoViewVisble(isHidden: false)
            self.dataPicker.isHidden = true
            self.toggleButton.isSelected = true
            self.cancleButton.isEnabled = true
            self.startTimer()
            
        case .start:
            self.timerStatus = .pasue
            self.toggleButton.isSelected = false //"일시정지"로 띄워진 시작버튼(isSelected=true) 누르면 일시정지로 변경(isSelected=false)
            self.timer?.suspend()

                        
        case .pasue:
            self.timerStatus = .start
            self.toggleButton.isSelected = true // 다시 일시정지 버튼을 누르면 시작버튼 활성화
            self.timer?.resume()
        } // 열거형에 따른 스위치문(같이 묶여서 쓰인다)
    }
}

