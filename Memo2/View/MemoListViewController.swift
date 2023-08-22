//
//  MemoListViewController.swift
//  Memo2
//
//  Created by 박유경 on 2023/08/22.
//

import UIKit
struct SectionItem {
    var memoText: String
    var isSwitchOn: Bool
}

struct Category {
    var name: String
    var items: [SectionItem]
}


let footerHeight = 40.0
let headerHeight = 40.0
extension MemoListViewController: UITableViewDelegate, UITableViewDataSource {
    
    ///MARK : 섹션 헤더
    // 섹션 헤더의 높이를 설정
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return footerHeight // 원하는 높이로 설정
    }
    
    // 섹션 헤더의 내용을 설정합니다.
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        
        let category = categories[section]
        
        headerView.backgroundColor = .gray // 헤더의 배경색을 설정합니다.
        let headerLabel = UILabel()
        headerLabel.setupCustomLabelFont(text: category.name, isBold: true, textSize : 20)
        headerLabel.frame = CGRect(x: 20, y: ( ((headerHeight)/2) - headerLabel.frame.size.height) / 2,width: tableView.bounds.width, height: headerLabel.intrinsicContentSize.height)
        headerView.addSubview(headerLabel)
        return headerView
    }
    
    ///MARK : 섹션 푸터
    // 섹션 푸터의 높이를 설정
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return headerHeight
    }
    // 섹션 푸터의 내용을 설정
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .white
        
        let footerLabelLabel = UILabel()
        footerLabelLabel.setupCustomLabelFont(text: "완료되지 않은 항목은 총 \(section)건 입니다.", isBold: true, textSize : 25)
        footerLabelLabel.frame = CGRect(x: 20, y: ( ((footerHeight)/2) - footerLabelLabel.frame.size.height) / 2, width: tableView.bounds.width, height: footerLabelLabel.intrinsicContentSize.height)
        footerView.addSubview(footerLabelLabel)
        return footerView
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    ///MARK : 셀 관련
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories[section].items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListCell") as? TodoListCell {
            let category = categories[indexPath.section]
            let sectionItem = category.items[indexPath.row]
            
            cell.textView.text = sectionItem.memoText
            cell.switchButton.isOn = sectionItem.isSwitchOn
            return cell
        }else{
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

class MemoListViewController : UIViewController{
    var categories: [Category] = [
        Category(name: "운동", items: [
            SectionItem(memoText: "Text 1 - Section 1", isSwitchOn: true),
            SectionItem(memoText: "Text 2 - Section 1", isSwitchOn: false)
        ]),
        Category(name: "식사", items: [
            SectionItem(memoText: "Text 3 - Section 2", isSwitchOn: false),
            SectionItem(memoText: "Text 4 - Section 2", isSwitchOn: true)
        ])
    ]
    
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.setupCustomLabelFont(text: "Todo List", isBold: true)
        return label
    }()
    
    lazy var tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupLayout()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TodoListCell.self, forCellReuseIdentifier: "TodoListCell")
    }
    
    func setupSubviews(){
        view.addSubview(titleLabel)
        view.addSubview(tableView)
    }
    
    func setupLayout() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(50)
        }
        tableView.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading) // 왼쪽을 safeArea에 맞춤
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing) // 오른쪽을 safeArea에 맞춤
            make.top.equalTo(titleLabel.snp.bottom)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom) // 아래를 safeArea 바텀에 맞춤
        }
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
