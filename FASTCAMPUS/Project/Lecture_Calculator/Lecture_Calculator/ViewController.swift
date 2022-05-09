//
//  ViewController.swift
//  Lecture_Calculator
//
//  Created by 이주송 on 2022/05/03.
// Source Tree Hi? ddbs
// git test
import UIKit
//9자리 넘으면 밀려나는 방식으로 구현해보기
enum Operation {
    case Add
    case Subtract
    case Divide
    case Multiply
    case unknown
} // 열거형

class ViewController: UIViewController {

    var disPlayNumber = ""
    var firstOperand = "" // 첫번째 피연산자
    var secondOpearand = "" // 새롭게 입력된 값(두번째 피연산자)
    var result = "" // 계산의 결과값
    var currentOpearation: Operation = .unknown
    // 프로퍼티 선언, unknown으로 초기화
    // 현재 계산기에 어떤 연산자가 입력되었는 지 알기 위해 연산자를 저장하는 것
    
    
    @IBOutlet weak var numberOutputLabel: UILabel!
//
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tapNumberButton(_ sender: UIButton) {
        guard let numberValue = sender.title(for: .normal) else { return } // 받은 버튼의 title(숫자 값)을 받는 과정
        if disPlayNumber.count < 9 {
            self.disPlayNumber += numberValue
            // = 표시로 하면 숫자가 1의 자리에서 끝난다.
            self.numberOutputLabel.text = self.disPlayNumber
        }
    }
    
    @IBAction func tapClearButton(_ sender: UIButton) {
        self.disPlayNumber = ""
        // 안그럼 다시 이전값이 뜨게된다.
        self.firstOperand = ""
        self.secondOpearand = ""
        self.result = ""
        self.currentOpearation = .unknown
        self.numberOutputLabel.text = "0"
    }
    
    @IBAction func tapDotButton(_ sender: UIButton) {
        if self.disPlayNumber.count < 8, !self.disPlayNumber.contains("."){
            // 문자열 "." 이 포함하지 않는 조건
            self.disPlayNumber += self.disPlayNumber.isEmpty ? "0." : "."
            self.numberOutputLabel.text = self.disPlayNumber
        }
    }
    
    @IBAction func tapDivideButton(_ sender: UIButton) {
    }
    
    @IBAction func tapMultiplyButton(_ sender: UIButton) {
    }
    
    @IBAction func tapSubtractButton(_ sender: UIButton) {
    }
    
    @IBAction func tapPlusButton(_ sender: UIButton) {
    }
    
    @IBAction func tapEqualButton(_ sender: UIButton) {
    }
    
}

