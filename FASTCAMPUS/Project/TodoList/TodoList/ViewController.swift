//
//  ViewController.swift
//  TodoList
//
//  Created by 이주송 on 2022/05/07.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var editButton: UIBarButtonItem! // weak으로 하면 edit버튼이 해제가되어 재사용 불가
    // UIBarButtonItem 정의
    
    @IBOutlet weak var tableView: UITableView!
    var doneButton: UIBarButtonItem?
    var tasks = [Task]() {
        didSet {
            self.saveTasks()
        }
    } // 넣을 할일 구조체들을 여기에 정의

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTap))
        // 위에서 정의한 doneButton 생성 버튼 눌러질때만(동적호출용도) 사용되는 메소드
        // doneButton이 눌리면 #selector 하겠다~
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.loadTasks()
    }
    
    @objc func doneButtonTap() {
        self.navigationItem.leftBarButtonItem = self.editButton
        self.tableView.setEditing(false, animated: true)
    }

    @IBAction func tapEditButton(_ sender: Any) {
        guard !self.tasks.isEmpty else { return } // tasks 배열이 비어있지 '않을' 때만 실행하겠다
        self.navigationItem.leftBarButtonItem = self.doneButton // 위에서 생성한 doneButton을 이제야 사용!
        self.tableView.setEditing(true, animated: true)
    }
    
    @IBAction func tapAddButton(_ sender: Any) {
        
        let alert = UIAlertController(title: "할 일 등록", message: nil, preferredStyle: .alert )
        let registerButton = UIAlertAction(title: "등록", style: .default, handler: { [weak self] _ in
            guard let title = alert.textFields?[0].text else {return}
            let task = Task(title: title, done: false)
            self?.tasks.append(task)
            self?.tableView.reloadData() // 마지막에 !
            // Alert의 텍스트필드에 기입할때마다 tasks 배열에 저장 됨
        })// 등록 버튼 눌렀을때 실행해야하는 행동을 클로저에 정의
        
        
        let cancelButton = UIAlertAction(title:"취소", style: .cancel , handler: nil)
        // 취소 버튼 눌렀을때 아무것도 실행하지 않는 것을  클로저에 정의
        
        
        alert.addAction(registerButton)
        alert.addAction(cancelButton)
        alert.addTextField(configurationHandler: {textField in
            textField.placeholder = "한 일을 등록해주세요"
        }) // 클로저를 받고 있다. 알럿 표시 이전 텍스트필드를 구성하기 위한 클로저 알럿에 표시할 텍스트 필드를 나타내는 클로저
        self.present(alert, animated: true, completion: nil)
    }
    
    func saveTasks() {
        let data = self.tasks.map {
            ["title": $0.title,
             "done": $0.done
            ]
        }
        
        let userDefaluts = UserDefaults.standard
        userDefaluts.set(data, forKey: "tasks") // value, key 값을 parameter로 각각 저장
        // task 배열의 요소들을 딕셔너리형태로 저장
    }
    
    func loadTasks() {
        let userDefaluts = UserDefaults.standard
        guard let data = userDefaluts.object(forKey: "tasks") as? [[String: Any]] else {return}
        self.tasks = data.compactMap({
            guard let title = $0["title"] as? String else { return nil }
            guard let done = $0["done"] as? Bool else { return nil } // done 키로 딕셔너리 value를 가져오는 과정
            return Task(title: title, done: done)
        })
        // 딕셔너리 배열 형태로 타입캐스팅
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
        if task.done {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
        //바로 위 cellForRowAt의 파라미터인 indexPath를 전달
    } // dequeueReusableCell : 위에 numberOfRowsInSection에서 return한 즉, 내가 사용한 만큼만 셀이 재사용되어 메모리 누수 방지
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        self.tasks.remove(at: indexPath.row) // tasks 배열에서 삭제
        tableView.deleteRows(at: [indexPath], with: .automatic )
        // tasks 배열에서 삭제된 것이 tableView에도 적용
        if self.tasks.isEmpty {
            self.doneButtonTap()
        }
    } // 편집모드에서 선택된 셀 알려주는 메소드
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    } // 셀을 재정렬 하는 메소드 (셀 오른쪽에 재정렬 이모지 띄움)

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        var tasks = self.tasks
        let task = tasks[sourceIndexPath.row]
        tasks.remove(at: sourceIndexPath.row)
        tasks.insert(task, at: destinationIndexPath.row)
        self.tasks = tasks // 위에 변경된 tasks 배열을 tasks에 적용
    }
// 어디서 옮기고 어디로 이동했는지 알 수 있는 메소드
    
} // 옵셔널 붙지않는 위의 두 함수는 UITableViewDataSource에서 필수 이다.






extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var task = self.tasks[indexPath.row] // 눌린 셀을 테스크 배열에 대입
        task.done = !task.done
        self.tasks[indexPath.row] = task // 변경된 값(Done이 체크된거)을 원래 task에 덮어씌워 줌
        self.tableView.reloadRows(at: [indexPath], with: .automatic) // 해당 행만 reload되게 ! with는 애니메이션
        
        
        //        debugPrint([indexPath]) -> 눌린 테이블을 전달하는 인자 [0]으로 전달
        //        debugPrint([indexPath.row]) -> 눌린 테이블이 테이블뷰에서 몇번째 인지!

    }
} // 어떤 Cell이 선택되었는 지 알기 위함
