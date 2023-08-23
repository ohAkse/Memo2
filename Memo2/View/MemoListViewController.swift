//
//  MemoListViewController.swift
//  Memo2
//
//  Created by 박유경 on 2023/08/22.
//

import UIKit
let footerHeight = 40.0
let headerHeight = 40.0
let cellFontSize = 30.0
extension MemoListViewController: UITableViewDelegate, UITableViewDataSource {
    
    ///MARK : 섹션 헤더
    // 섹션 헤더의 높이를 설정
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return footerHeight // 원하는 높이로 설정
    }
    // 섹션 헤더의 내용을 설정
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()

        let category = categories[section]

        headerView.backgroundColor = .gray // 헤더의 배경색을 설정합니다.
        let headerLabel = UILabel()
        headerLabel.setupCustomLabelFont(text: category.name, isBold: false, textSize : 20)
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
        footerLabelLabel.setupCustomLabelFont(text: "완료되지 않은 항목은 총 \(section)건 입니다.", isBold: false, textSize : 20)
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
            var attributes: [NSAttributedString.Key: Any] = [:]

            attributes[.font] = UIFont.systemFont(ofSize: cellFontSize)

            if cell.switchButton.isOn {
                attributes[.strikethroughStyle] = NSUnderlineStyle.single.rawValue
            } else {
                attributes.removeValue(forKey: .strikethroughStyle)
            }
            configureTextView(for: cell.textView, with: sectionItem.memoText, isSwitchOn: cell.switchButton.isOn)
            
            cell.switchButtonAction = { [weak self] in
                guard let self = self else {
                    return
                }
                self.configureTextView(for: cell.textView, with: sectionItem.memoText, isSwitchOn: cell.switchButton.isOn)
            }
            return cell
        }else{
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func configureTextView(for textView: UITextView, with text: String, isSwitchOn: Bool) {
        var attributes: [NSAttributedString.Key: Any] = [:]
        
        attributes[.font] = UIFont.systemFont(ofSize: cellFontSize)
        
        if isSwitchOn {
            attributes[.strikethroughStyle] = NSUnderlineStyle.single.rawValue
        } else {
            attributes.removeValue(forKey: .strikethroughStyle)
        }
        
        textView.attributedText = NSAttributedString(string: text, attributes: attributes)
    }
}

class MemoListViewController : UIViewController{
    var categories: [Category] = [
        Category(name: "운동", items: [
            SectionItem(memoText: "Text 1 - Section 1", isSwitchOn: true),
            SectionItem(memoText: "Text 2 - Section 1", isSwitchOn: false),
            SectionItem(memoText: "Text 3 - Section 1", isSwitchOn: true),
            SectionItem(memoText: "Text 4 - Section 1", isSwitchOn: true),
            SectionItem(memoText: "Text 5 - Section 1", isSwitchOn: true),
            SectionItem(memoText: "Text 6 - Section 1", isSwitchOn: true),
            SectionItem(memoText: "Text 7 - Section 1", isSwitchOn: true)
        ]),
        Category(name: "식사", items: [
            SectionItem(memoText: "Text 8 - Section 2", isSwitchOn: false),
            SectionItem(memoText: "Text 9 - Section 2", isSwitchOn: true),
            SectionItem(memoText: "Text 10 - Section 2", isSwitchOn: true),
            SectionItem(memoText: "Text 11 - Section 2", isSwitchOn: true),
            SectionItem(memoText: "Text 12- Section 1", isSwitchOn: true),
        ]),
        Category(name: "음주", items: [
            SectionItem(memoText: "Text 13 - Section 4", isSwitchOn: false),
            SectionItem(memoText: "Text 14 - Section 3", isSwitchOn: true),
            SectionItem(memoText: "Text 15 - Section 3", isSwitchOn: true),
            SectionItem(memoText: "Text 16 - Section 3", isSwitchOn: true),
            SectionItem(memoText: "Text 17 - Section 3", isSwitchOn: true),
        ])
    ]
    
    lazy var tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.showsVerticalScrollIndicator = false
        tableView.register(TodoListCell.self, forCellReuseIdentifier: "TodoListCell")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupSubviews()
        setupLayout()
        setupTableFHView()

    }
    func setupTableFHView(){
        let tableViewHeader = UIView(frame: CGRect(x: 0, y: 0 , width: view.bounds.width, height: headerHeight))
        tableViewHeader.backgroundColor = .white
        let headerLabel = UILabel()
        headerLabel.setupCustomLabelFont(text: "Todo List", isBold: true, textSize: 30)
        headerLabel.sizeToFit()

        headerLabel.center.x = tableViewHeader.center.x
        headerLabel.center.y = tableViewHeader.frame.size.height / 2

        tableViewHeader.addSubview(headerLabel)

        tableView.tableHeaderView = tableViewHeader
        
        let tableViewFooter = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: footerHeight))
        tableViewFooter.backgroundColor = .gray
        let footerLabel = UILabel()
        footerLabel.setupCustomLabelFont(text: "총 완료되지 않은 건은 n건입니다.", isBold: true, textSize: 30)
        footerLabel.sizeToFit()

        footerLabel.center.x = tableViewFooter.center.x
        footerLabel.center.y = tableViewFooter.frame.size.height / 2

        tableViewFooter.addSubview(footerLabel)
        tableView.tableFooterView = tableViewFooter
        
        
    }
    
    func setupNavigationBar(){
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    @objc func addButtonTapped() {
        print("추가 버튼 기능 필요")
    }
    
    func setupSubviews(){
        view.addSubview(tableView)
    }
    
    func setupLayout() {
        tableView.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading) // 왼쪽을 safeArea에 맞춤
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing) // 오른쪽을 safeArea에 맞춤
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
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
