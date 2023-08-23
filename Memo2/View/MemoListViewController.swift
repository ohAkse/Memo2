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
            cell.contentTextFieldAction = { [weak self] in
                guard let self = self else { return }
                
                for category in categories {
                    for sectionItem in category.items {
                        if sectionItem.memoText == cell.textView.text {
                            let foundCategory = category
                            let MemoWriteVC = MemoWriteViewController()
                            
                            if let presentationController = MemoWriteVC.presentationController as? UISheetPresentationController {
                                presentationController.detents = [
                                    .medium(),
                                ]
                                presentationController.prefersGrabberVisible = true
                            }
                            MemoWriteVC.titleLabel.text = UISheetPaperType.update.typeValue
                            MemoWriteVC.category = foundCategory.name
                            MemoWriteVC.textContent.text = sectionItem.memoText
                            self.present(MemoWriteVC, animated: true)
                            
                            break
                        }
                    }
                }
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
    Category(name: "공부", items: [
        SectionItem(memoText: "Text 8 - Section 2", isSwitchOn: false),
        SectionItem(memoText: "Text 9 - Section 2", isSwitchOn: true),
        SectionItem(memoText: "Text 10 - Section 2", isSwitchOn: true),
        SectionItem(memoText: "Text 11 - Section 2", isSwitchOn: true),
        SectionItem(memoText: "Text 12- Section 1", isSwitchOn: true),
    ]),
    Category(name: "모임", items: [
        SectionItem(memoText: "Text 13 - Section 4", isSwitchOn: false),
        SectionItem(memoText: "Text 14 - Section 3", isSwitchOn: true),
        SectionItem(memoText: "Text 15 - Section 3", isSwitchOn: true),
        SectionItem(memoText: "Text 16 - Section 3", isSwitchOn: true),
        SectionItem(memoText: "Text 17 - Section 3", isSwitchOn: true),
    ])
]

class MemoListViewController : UIViewController/*, TextChangedStatus*/{

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
        let MemoCategoryVC = MemoCategoryViewController()
        if let presentationController = MemoCategoryVC.presentationController as? UISheetPresentationController {
            presentationController.detents = [
                .medium(),
            ]
            presentationController.prefersGrabberVisible = true
        }
        self.present(MemoCategoryVC, animated: true)
        
    }
    
    func setupSubviews(){
        view.addSubview(tableView)
    }
    
    func setupLayout() {
        tableView.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
}
