//
//  MemoCompleteViewController.swift
//  Memo2
//
//  Created by 박유경 on 2023/08/22.
//

import UIKit

class MemoCompleteViewController : UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

//extension MemoCompleteViewController : UITableViewDelegate, UITableViewDataSource{
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as? CustomCell {
//            let memo = MemoList[indexPath.item]
//            if  memo.switchIsOn {
//                cell.contentLb.text = memo.content
//                cell.dateTimeLb.text = "수정시간:\(memo.insertDate.GetCurrentTime())"
//            }
//            return cell
//        }
//        return UITableViewCell()
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return MemoList.count
//    }
//}
//
//class MemoCompleteViewController: UIViewController {
//    @IBAction func AscendingClicked(_ sender: UIBarButtonItem) {
//        MemoList = MemoList.filter { $0.switchIsOn }
//            .sorted { $0.insertDate < $1.insertDate }
//        tableView.reloadData()
//    }
//    @IBAction func DescendingClicked(_ sender: UIBarButtonItem) {
//        MemoList = MemoList.filter { $0.switchIsOn }
//            .sorted { $0.insertDate > $1.insertDate }
//        tableView.reloadData()
//    }
//    @IBAction func BackButtonClicked(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
//    }
//    @IBOutlet weak var BackButton: UIBarButtonItem!
//    @IBOutlet weak var tableView: UITableView!
//    var MemoList = RealmManager.Instance.getMemoList().filter{ $0.switchIsOn}
//    
//    override func viewDidLoad() {
//        tableView.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
//        tableView.dataSource = self
//        tableView.delegate = self
//        super.viewDidLoad()
//    }
//}
