//
//  MemoCompleteViewController.swift
//  Memo2
//
//  Created by 박유경 on 2023/08/22.
//

import UIKit

extension MemoCompleteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListCell") as? TodoListCell {
            cell.selectionStyle = .none
            cell.textView.text = filterData[indexPath.row].memoText
            cell.textView.isUserInteractionEnabled = false
            cell.switchButton.isHidden = true
            return cell
        }else{
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
class MemoCompleteViewController : UIViewController{
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.setupCustomLabelFont(text: "완료 리스트", isBold: true)
        label.textAlignment = .center
        return label
    }()
    lazy var tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.showsVerticalScrollIndicator = false
        tableView.register(TodoListCell.self, forCellReuseIdentifier: "TodoListCell")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    lazy var ascendingButton : UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(ascendingButtonTapped), for: .touchUpInside)
        button.setImage(UIImage(named: "ascending"), for: .normal)
        return button
    }()
    lazy var decendingButton : UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(descendingButtonTapped), for: .touchUpInside)
        button.setImage(UIImage(named: "descending"), for: .normal)
        return button
    }()
    lazy var categoryButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "category1"), for: .normal)
        button.isUserInteractionEnabled = true
        return button
    }()
    var categoryMenu = UIMenu(title: "", children: [])
    var category : String = ""
    let instance = LocalDBManager.instance
    var filterData : [SectionItem] = []
    
    deinit{
        print("MemoCompleteViewController deinit called")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        filterData = instance.readCompleteData(category: .workout).filter{$0.isSwitchOn == true} //초기데이터 설정
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubviews()
        setupLayout()
        setupCategoryMenu()
        
    }
    func setupCategoryMenu(){
        var menuItems: [UIMenuElement] = []
        menuItems.append(UIAction(title: CategoryType.workout.typeValue, image: UIImage(systemName: "figure.walk")) { [weak self] _ in
            guard let self = self else {
                return
            }
            filterData = instance.readCompleteData(category: .workout).filter{$0.isSwitchOn == true}
            tableView.reloadData()
        })
        menuItems.append(UIAction(title: CategoryType.study.typeValue, image: UIImage(systemName: "sum")) { [weak self] _ in
            guard let self = self else {
                return
            }
            filterData = instance.readCompleteData(category: .study).filter{$0.isSwitchOn == true}
            tableView.reloadData()
        })
        menuItems.append(UIAction(title: CategoryType.meeting.typeValue, image: UIImage(systemName: "person.3.sequence.fill")) { [weak self] _ in
            guard let self = self else {
                return
            }
            filterData = instance.readCompleteData(category: .meeting).filter{$0.isSwitchOn == true}
            tableView.reloadData()
        })
        let menu = UIMenu(title: "", children: menuItems)
        self.categoryMenu = menu
        self.categoryButton.showsMenuAsPrimaryAction = true
        self.categoryButton.menu = menu
    }
    
    func setupSubviews(){
        view.addSubview(tableView)
        view.addSubview(titleLabel)
        view.addSubview(ascendingButton)
        view.addSubview(decendingButton)
        view.addSubview(categoryButton)
    }
    
    func setupLayout() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-10)
            make.height.equalTo(50)
        }
        categoryButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(titleLabel.snp.leading)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        ascendingButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.trailing.equalTo(titleLabel.snp.trailing)
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
        decendingButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.trailing.equalTo(ascendingButton.snp.leading).offset(-10)
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(decendingButton.snp.bottom).offset(30)
            make.leading.equalTo(categoryButton.snp.leading).offset(-10) // 카테고리 이미지사진의 흰색배경때문에 살짝 안맞아서 조정..
            make.trailing.equalTo(ascendingButton.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
    }
    @objc func ascendingButtonTapped(){
        filterData.sort { $0.memoText < $1.memoText }
        tableView.reloadData()
    }
    @objc func descendingButtonTapped(){
        filterData.sort { $0.memoText > $1.memoText }
        tableView.reloadData()
    }
}


