//
//  MemoListViewController.swift
//  Memo2
//
//  Created by 박유경 on 2023/08/22.
//

import UIKit
class MemoListViewController : UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}


//extension MemoListViewController : UITableViewDelegate, UITableViewDataSource{
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as? CustomCell {
//            let memo = sharedInstance.getMemoList()[indexPath.item]
//            cell.contentLb.text = memo.content
//            cell.switchBtn.isOn = memo.switchIsOn
//            var attributes: [NSAttributedString.Key: Any] = [:]
//            if  memo.switchIsOn {
//                attributes[.strikethroughStyle] = NSUnderlineStyle.single.rawValue
//            }
//            cell.contentLb.attributedText = NSAttributedString(string: memo.content, attributes: attributes)
//            return cell
//        }
//        return UITableViewCell()
//    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let memoDetailViewController = storyboard?.instantiateViewController(withIdentifier: "MemoDetailVC") as? MemoDetailViewController {
//            let memo = sharedInstance.getMemoList()[indexPath.item]
//            selectedIndex = indexPath.item
//            memoDetailViewController.content = memo.content
//            memoDetailViewController.EditDelegate = self
//            self.navigationController?.pushViewController(memoDetailViewController, animated: true)
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {  (_, _, completionHandler) in
//            self.sharedInstance.deleteMemo(index: indexPath.item)
//            tableView.reloadData()
//            completionHandler(true)
//        }
//        deleteAction.image = UIImage(systemName: "trash")
//        return UISwipeActionsConfiguration(actions: [deleteAction])
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return sharedInstance.getMemoList().count
//    }
//}
//extension MemoListViewController : EditMemoDelegate{
//    func didEditPerformd(_ content: String) {
//        sharedInstance.updateMemo(index: selectedIndex, content: content)
//        listTableView.reloadData()
//    }
//}
//
//
//class MemoListViewController: UIViewController {
//    
//    @IBOutlet weak var addButton: UIBarButtonItem!
//    @IBOutlet weak var backButton: UIBarButtonItem!
//    @IBOutlet weak var listTableView: UITableView!
//    let sharedInstance = RealmManager.Instance
//    var selectedIndex : Int = 0
//    @IBAction func addMemoButtonClicked(_ sender: Any) {
//        let AddMemoController =  UIAlertController(title: "항목 추가", message: "내용을 입력해주세요.", preferredStyle: .alert)
//        AddMemoController.addTextField(configurationHandler: { _ in
//        })
//        let OKAction = UIAlertAction(title: "OK", style: .default) {  _ in
//            if let text = AddMemoController.textFields?.first?.text {
//                if text != ""{
//                    self.sharedInstance.createMemo(memo : Memo(content: text, switchIsOn: false))
//                    self.listTableView.reloadData()
//                }else{
//                    self.showAlert(title: "에러", message: "내용이 입력되지 않아 항목이 추가되지 않았습니다.")
//                }
//            }
//        }
//        let CancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
//            AddMemoController.dismiss(animated: true)
//        }
//        AddMemoController.addAction(OKAction)
//        AddMemoController.addAction(CancelAction)
//        self.present(AddMemoController, animated: true)
//    }
//    
//    @IBAction func BackbuttonClicked(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        listTableView.dataSource = self
//        listTableView.delegate = self
//        listTableView.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
//    }
//}
