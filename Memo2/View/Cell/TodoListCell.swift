//
//  TodoListCell.swift
//  Memo2
//
//  Created by 박유경 on 2023/08/22.
//

import UIKit

class TodoListCell : UITableViewCell{
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.font = UIFont.systemFont(ofSize: 30)
        return textView
    }()
    
    lazy var switchButton : UISwitch = {
        let switchButton = UISwitch()
        switchButton.isOn = false
        switchButton.onTintColor = UIColor.blue
        switchButton.tintColor = UIColor.red
        return switchButton
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupLayout()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("음뭬에에에")
    }
    func setupSubviews(){
        contentView.addSubview(textView)
        contentView.addSubview(switchButton)
    }
    
    func setupLayout() {
        textView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
            make.width.equalTo(contentView.snp.width).multipliedBy(0.7)
        }
        switchButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
            make.width.equalTo(contentView.snp.width).multipliedBy(0.15) 
        }
    }
    
}
