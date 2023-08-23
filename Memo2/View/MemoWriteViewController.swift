//
//  MemoWriteViewController.swift
//  Memo2
//
//  Created by 박유경 on 2023/08/23.
//

import UIKit
enum UISheetPaperType {
    case create
    case update
    case category
    case none
    var typeValue: String {
        switch self {
        case .none: return ""
        case .create: return "할일 작성"
        case .update: return "할일 수정"
        case .category: return "카테 고리"
        }
    }
}
enum CategoryType {
    case workout
    case study
    case meeting
    case none
    var typeValue: String {
        switch self {
        case .workout: return "운동"
        case .study: return "공부"
        case .meeting: return "모임"
        case .none: return ""
        }
    }
}

class MemoWriteViewController : UIViewController, UITextViewDelegate
{
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.setupCustomLabelFont(text: UISheetPaperType.none.typeValue, isBold: true)
        label.textAlignment = .center
        return label
    }()
    
    //textField의 contentEdgeInsets은 Deprecated됨
    lazy var textContent : UITextView = {
        let textView = UITextView()
        textView.delegate = self
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.textContainerInset = UIEdgeInsets(top: 20, left: 10, bottom: 0, right : 0)
        textView.layer.cornerRadius = 10.0
        textView.backgroundColor = .lightGray
        return textView
    }()
    lazy var confirmButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("완료", for: .normal)
        button.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        button.setupCustomButtonUI(red: 0.0, green: 0.48, blue: 1.0, alpha: 1.0)
        button.setupCustomButtonFont()
        return button
    }()
    
    var category : String = ""
    var contentTextFieldAction : (()-> Void)?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print(category)
        setupSubviews()
        setupLayout()
    }
    
    func setupSubviews(){
        view.addSubview(titleLabel)
        view.addSubview(textContent)
        view.addSubview(confirmButton)
    }
    
    func setupLayout() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview() // 수평 가운데 정렬
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.width.equalTo(200)
            make.height.equalTo(100)
        }
        textContent.snp.makeConstraints { make in
            make.centerX.equalToSuperview() // 수평 가운데 정렬
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.height.equalTo(300)
        }
        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(textContent.snp.bottom).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
            make.width.equalTo(100)
        }
    }
    @objc func confirmButtonTapped(){
        if textContent.text != ""{
            if titleLabel.text == UISheetPaperType.update.typeValue{
                self.dismiss(animated: true)
                self.contentTextFieldAction?()
            }else{
                self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                self.contentTextFieldAction?()
            }
        }else{
            self.showAlert(title: "에러", message: "내용을 추가해주세요")
        }
    }
    
    
}
