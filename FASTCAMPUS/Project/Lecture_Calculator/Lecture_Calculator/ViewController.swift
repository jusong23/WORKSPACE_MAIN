//
//  ViewController.swift
//  Lecture_Calculator
//
//  Created by 이주송 on 2022/05/03.
//

import UIKit

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
    // 프로퍼티 선언
    
    
    @IBOutlet weak var numberOutputLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tapNumberButton(_ sender: UIButton) {
    }
    
    @IBAction func tapClearButton(_ sender: UIButton) {
    }
    
    @IBAction func tapDotButton(_ sender: UIButton) {
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

