//
//  ViewController.swift
//  TodoList
//
//  Created by 이주송 on 2022/05/07.
//

import UIKit

class ViewController: UIViewController {
    
var tasks = [Task]() // 넣을 할일 구조체들을 여기에 정의

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
    }

    @IBAction func tapEditButton(_ sender: Any) {
    }
    
    @IBAction func tapAddButton(_ sender: Any) {
        let alert = UIAlertController(title: "할 일 등록", message: nil, preferredStyle: .alert )
        let registerButton = UIAlertAction(title: "등록", style: .default, handler: { [weak self] _ in
            guard let title = alert.textFields?[0].text else {return}
            let task = Task(title: title, done: false)
            self?.tasks.append(task)
            self?.tableView.reloadData()
            // Alert의 텍스트필드에 기입할때마다 tasks 배열에 저장 됨
        })
        
        // 등록 버튼 눌렀을때 실행해야하는 행동을 클로저에 정의
        let cancelButton = UIAlertAction(title:"취소", style: .cancel , handler: nil)
        // 취소 버튼 눌렀을때 아무것도 실행하지 않는 것을  클로저에 정의
        alert.addAction(registerButton)
        alert.addAction(cancelButton)
        alert.addTextField(configurationHandler: {textField in
            textField.placeholder = "한 일을 등록해주세요"
        }) // 클로저를 받고 있다. 알럿 표시 이전 텍스트필드를 구성하기 위한 클로저 알럿에 표시할 텍스트 필드를 나타내는 클로저
        self.present(alert, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks.count
    } // 행의 갯수
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let task = self.tasks[indexPath.row]
        cell.textLabel?.text = task.title
        return cell
        //바로 위 cellForRowAt의 파라미터인 indexPath를 전달
    } // dequeueReusableCell : 위에 numberOfRowsInSection에서 return한 즉, 내가 사용한 만큼만 셀이 재사용되어 메모리 누수 방지
} // 옵셔널 붙지않는 위의 두 함수는 UITableViewDataSource에서 필수 이다.
