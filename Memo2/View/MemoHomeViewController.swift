//
//  MemoHomeViewController.swift
//  Memo2
//
//  Created by 박유경 on 2023/08/22.
//

import UIKit
import SnapKit

class MemoHomeViewController : UIViewController{
    
    lazy var mainImageView : UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "book"))
        return imageView
    }()
    
    lazy var moveToListButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("리스트로 이동하기", for: .normal)
        button.addTarget(self, action: #selector(moveToListButtonTapped), for: .touchUpInside)
        button.setupCustomButtonUI()
        button.setupCustomButtonFont()
        return button
    }()
    
    lazy var moveToCompleteButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("완료 목록 이동하기", for: .normal)
        button.addTarget(self, action: #selector(moveToCompletsButtonTapped), for: .touchUpInside)
        button.setupCustomButtonUI()
        button.setupCustomButtonFont()
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupLayout()
    }
    func setupSubviews(){
        view.addSubview(mainImageView)
        view.addSubview(moveToListButton)
        view.addSubview(moveToCompleteButton)
    }
    
    func setupLayout(){
        mainImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.width.equalTo(250)
        }
        moveToListButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(mainImageView.snp.bottom).offset(60)
            make.width.equalTo(250)
            make.height.equalTo(100)
        }
        moveToCompleteButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(moveToListButton.snp.bottom).offset(30)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-60) //
            make.width.equalTo(250)
            make.height.equalTo(100)
        }
    }
    @objc func moveToListButtonTapped(){
        let memoListVC = MemoListViewController()
        UIView.transition(with: navigationController!.view, duration: 0.5, options: .transitionFlipFromBottom, animations: {
            self.navigationController?.pushViewController(memoListVC, animated: false)
        }, completion: nil)
    }
    @objc func moveToCompletsButtonTapped(){
        let memoListVC = MemoCompleteViewController()
        present(memoListVC, animated: true, completion: nil)
    }
}



