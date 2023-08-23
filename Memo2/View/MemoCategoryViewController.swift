//
//  MemoCategoryViewController.swift
//  Memo2
//
//  Created by 박유경 on 2023/08/23.
//

import UIKit

class MemoCategoryViewController : UIViewController
{
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.setupCustomLabelFont(text: UISheetPaperType.category.typeValue, isBold: true)
        label.textAlignment = .center
        return label
    }()
    lazy var workoutButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(CategoryType.workout.typeValue, for: .normal)
        button.addTarget(self, action: #selector(workoutButtonTapped), for: .touchUpInside)
        button.setupCustomButtonUI(blue : 0.2)
        button.setupCustomButtonFont()
        return button
    }()
    lazy var studytButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(CategoryType.study.typeValue, for: .normal)
        button.addTarget(self, action: #selector(studytButtonTapped), for: .touchUpInside)
        button.setupCustomButtonUI(red : 0.2)
        button.setupCustomButtonFont()
        return button
    }()
    lazy var meetingButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(CategoryType.meeting.typeValue, for: .normal)
        button.addTarget(self, action: #selector(meetingButtonTapped), for: .touchUpInside)
        button.setupCustomButtonUI(green: 0.4)
        button.setupCustomButtonFont()
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubviews()
        setupLayout()
        
    }
    func setupSubviews(){
        view.addSubview(titleLabel)
        view.addSubview(workoutButton)
        view.addSubview(studytButton)
        view.addSubview(meetingButton)
    }
    func setupLayout() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview() // 수평 가운데 정렬
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.width.equalTo(200)
            make.height.equalTo(100)
        }
        
        workoutButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview() // 수평 가운데 정렬
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.width.equalTo(200)
            make.height.equalTo(90)
        }
        
        studytButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview() // 수평 가운데 정렬
            make.top.equalTo(workoutButton.snp.bottom).offset(30)
            make.width.equalTo(200)
            make.height.equalTo(90)
        }
        
        meetingButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview() // 수평 가운데 정렬
            make.top.equalTo(studytButton.snp.bottom).offset(30)
            make.width.equalTo(200)
            make.height.equalTo(90)
        }
    }
    
    @objc func workoutButtonTapped(){
        let MemoWriteVC = MemoWriteViewController()
        if let presentationController = MemoWriteVC.presentationController as? UISheetPresentationController {
            presentationController.detents = [
                .medium(),
            ]
            presentationController.prefersGrabberVisible = true
        }
        MemoWriteVC.titleLabel.text = UISheetPaperType.create.typeValue
        MemoWriteVC.category = CategoryType.workout.typeValue
        self.present(MemoWriteVC, animated: true)
    }
    @objc func studytButtonTapped(){
        let MemoWriteVC = MemoWriteViewController()
        if let presentationController = MemoWriteVC.presentationController as? UISheetPresentationController {
            presentationController.detents = [
                .medium(),
            ]
            presentationController.prefersGrabberVisible = true
        }
        MemoWriteVC.titleLabel.text = UISheetPaperType.create.typeValue
        MemoWriteVC.category = CategoryType.study.typeValue
        self.present(MemoWriteVC, animated: true)
    }
    @objc func meetingButtonTapped(){
        let MemoWriteVC = MemoWriteViewController()
        if let presentationController = MemoWriteVC.presentationController as? UISheetPresentationController {
            presentationController.detents = [
                .medium(),
            ]
            presentationController.prefersGrabberVisible = true
        }
        MemoWriteVC.titleLabel.text = UISheetPaperType.create.typeValue
        MemoWriteVC.category = CategoryType.meeting.typeValue
        self.present(MemoWriteVC, animated: true)
    }
}
