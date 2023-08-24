//
//  MemoListViewController.swift
//  Memo2
//
//  Created by 박유경 on 2023/08/22.
//

import UIKit
let footerHeight = 40.0
let headerHeight = 40.0
let cellFontSize = 24.0
extension MemoListViewController: UITableViewDelegate, UITableViewDataSource {
    ///MARK : 커스텀 함수
    private func createSectionHeaderView(title: String) -> UIView {
        let headerView = UIView()
        headerView.backgroundColor = .lightGray
        
        let headerLabel = UILabel()
        headerLabel.setupCustomLabelFont(text: title, isBold: false, textSize: 20)
        headerLabel.frame = CGRect(x: 20, y: (((footerHeight) / 2) - headerLabel.frame.size.height) / 2, width: tableView.bounds.width, height: headerLabel.intrinsicContentSize.height)
        
        headerView.addSubview(headerLabel)
        return headerView
    }
    
    private func createSectionFooterView(text: String) -> UIView {
        let footerView = UIView()
        
        let footerLabel = UILabel()
        footerLabel.setupCustomLabelFont(text: text, isBold: false, textSize: 20)
        footerLabel.frame = CGRect(x: 20, y: (((footerHeight) / 2) - footerLabel.frame.size.height) / 2, width: tableView.bounds.width, height: footerLabel.intrinsicContentSize.height)
        
        footerView.addSubview(footerLabel)
        return footerView
    }
    
    func findSectionItem(with text: String) -> (category: String, item: SectionItem)? {
        for category in categories {
            if let sectionItem = category.items.first(where: { $0.memoText == text }) {
                return (category.name, sectionItem)
            }
        }
        return nil
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
    
    ///MARK : 섹션 헤더
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return footerHeight // 원하는 높이로 설정
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let category = categories[section]
        return createSectionHeaderView(title: category.name)
    }

    ///MARK : 섹션 푸터
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return headerHeight
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let category = categories[section]
        let text = "완료되지 않은 항목은 총 \(category.items.filter{$0.isSwitchOn == false}.count)건 입니다."
        return createSectionFooterView(text: text)
    }
    ///MARK : 셀
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories[section].items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListCell") as? TodoListCell else {
            return UITableViewCell()
        }
        
        let category = categories[indexPath.section]
        let sectionItem = category.items[indexPath.row]

        cell.textView.text = sectionItem.memoText
        cell.switchButton.isOn = sectionItem.isSwitchOn

        var attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: cellFontSize)
        ]

        if cell.switchButton.isOn {
            attributes[.strikethroughStyle] = NSUnderlineStyle.single.rawValue
        }

        configureTextView(for: cell.textView, with: sectionItem.memoText, isSwitchOn: cell.switchButton.isOn)
        
        cell.switchButtonAction = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async{ [weak self] in
                guard let self = self else { return }
                instance.updateData(category: category.name, cellIndex: indexPath.row, content: sectionItem.memoText, isSwitchOn: cell.switchButton.isOn)
                configureTextView(for: cell.textView, with: sectionItem.memoText, isSwitchOn: cell.switchButton.isOn)
                updateFooterLabel(with: uncompletedItemListCount, isOn : cell.switchButton.isOn)
                categories = instance.getCategoriesFromUserDefaults()
                tableView.reloadData()
            }
            
        }
        
        cell.contentTextFieldAction = { [weak self] in
            guard let self = self, let text = cell.textView.text else { return }
            if self.presentedViewController != nil { return }
            print("contentText button@@@@@@@@@@@@@@")
            if let item = self.findSectionItem(with: text) {
                let MemoWriteVC = MemoWriteViewController()
                if let presentationController = MemoWriteVC.presentationController as? UISheetPresentationController {
                    presentationController.detents = [.medium()]
                    presentationController.prefersGrabberVisible = true
                }
                MemoWriteVC.titleLabel.text = UISheetPaperType.update.typeValue
                MemoWriteVC.category = item.category
                MemoWriteVC.selectedItem = item.item
                MemoWriteVC.textContent.text = text
                self.present(MemoWriteVC, animated: true)
            }
        }
        return cell
    }
    func updateFooterLabel(with count: Int, isOn : Bool) {
        uncompletedItemListCount = isOn ? uncompletedItemListCount - 1 : uncompletedItemListCount + 1
        let text = "총 \(uncompletedItemListCount)개 항목이 완료되지 않았습니다."
        if let footerLabel = tableView.tableFooterView?.subviews.first as? UILabel {
            footerLabel.text = text
            footerLabel.sizeToFit()
        }
    }
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    //MARK : 스와이프시 삭제
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {  [weak self] (_, _, completionHandler) in
            guard let self = self else { return }
            
            DispatchQueue.main.async{ [weak self] in
                guard let self = self else {return }
                let category = self.categories[indexPath.section]
                let sectionItem = category.items[indexPath.row]
                instance.deleteData(category: category.name, content: sectionItem.memoText)
                categories = instance.getCategoriesFromUserDefaults()
                tableView.reloadData()
                completionHandler(true)
                
            }
        }
        deleteAction.image = UIImage(systemName: "trash")
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
class MemoListViewController : UIViewController{
    lazy var tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.showsVerticalScrollIndicator = false
        tableView.register(TodoListCell.self, forCellReuseIdentifier: "TodoListCell")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    let instance = LocalDBManager.instance
    var uncompletedItemListCount = 0
    
    var categories : [Category] = []
    override func viewDidLoad() {
        super.viewDidLoad()
    
        categories = instance.getCategoriesFromUserDefaults()
        print(categories)
        uncompletedItemListCount = categories.reduce(0) { (count, category) in
            let categoryCount = category.items.reduce(0) { (itemCount, sectionItem) in
                return itemCount + (sectionItem.isSwitchOn == false  ? 1 : 0)
            }
            return count + categoryCount
        }

        setupNavigationBar()
        setupSubviews()
        setupLayout()
        setupTableFHView()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(DidReceiveTextChangeCommitStatus),
            name: .textChangeStatus,
            object: nil
        )
    }
    @objc func DidReceiveTextChangeCommitStatus(_ notification: Notification) {
        if let status = notification.object as? TextChangeCommitStatus {
            if status == .Success
            {
                //Toast.showToast(message: "요청이 성공적으로 처리되었습니다.", errorMessage: [], font: UIFont.systemFont(ofSize: 14.0), controllerView: self)
                categories = instance.getCategoriesFromUserDefaults()
                tableView.reloadData()
            }
        }
    }
    
    func setupTableFHView(){
        //테이블뷰 헤더
        let tableViewHeader = UIView(frame: CGRect(x: 0, y: 0 , width: view.bounds.width, height: headerHeight))
        tableViewHeader.backgroundColor = .white
        let headerLabel = UILabel()
        headerLabel.setupCustomLabelFont(text: "Todo List", isBold: true, textSize: 30)
        headerLabel.sizeToFit()
        headerLabel.center.x = tableViewHeader.center.x
        headerLabel.center.y = tableViewHeader.frame.size.height / 2
        tableViewHeader.addSubview(headerLabel)
        tableView.tableHeaderView = tableViewHeader
        
        //테이블뷰 푸터
        let tableViewFooter = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: footerHeight))
        tableViewFooter.backgroundColor = .gray
        let footerLabel = UILabel()
        footerLabel.setupCustomLabelFont(text: "총 \(uncompletedItemListCount)개 항목이 완료되지 않았습니다.", isBold: true, textSize: 20)
        print(uncompletedItemListCount)
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
