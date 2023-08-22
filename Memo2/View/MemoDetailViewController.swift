//
//  MemoDetailViewController.swift
//  Memo2
//
//  Created by 박유경 on 2023/08/22.
//

import UIKit

class MemoDetailViewController : UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
    
}

//protocol EditMemoDelegate : AnyObject{
//    func didEditPerformd(_ content : String)
//}
//
//class MemoDetailViewController: UIViewController,UITextViewDelegate {
//
//    @IBOutlet weak var backButton: UIBarButtonItem!
//    @IBOutlet weak var textView: UITextView!
//    var content = ""
//    weak var EditDelegate : EditMemoDelegate?
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        textView.delegate = self
//        if content != ""{
//            textView.text = content
//        }
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//        view.addGestureRecognizer(tapGesture)
//    }
//    @objc func dismissKeyboard(){
//        view.endEditing(true)
//    }
//
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        if text == "\n" {
//            textView.resignFirstResponder()
//            return false
//        }
//        return true
//    }
//
//    @IBAction func editbuttonClicked(_ sender: Any) {
//        let text = textView.text
//        if let text = text{
//            EditDelegate?.didEditPerformd(text)
//            self.navigationController?.popViewController(animated: true)
//        }else{
//            self.showAlert(title: "에러", message: "텍스트값이 nil입니다. 다시 시도 해주셍쇼")
//        }
//    }
//
//    @IBAction func backbuttonClicked(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
//    }
//}

