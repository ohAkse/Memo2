//
//  MemoHomeViewController.swift
//  Memo2
//
//  Created by 박유경 on 2023/08/22.
//

import UIKit

class MemoHomeViewController : UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }
    
}

//class MemoHomeViewController: UIViewController {
//    @IBOutlet weak var memoListButton: UIButton!
//    @IBOutlet weak var memoCompleteButton: UIButton!
//
//    @IBAction func MoveCompletButtonClicked(_ sender: Any) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//          if let memoCompleteVC = storyboard.instantiateViewController(withIdentifier: "MemoCompleteVC") as? MemoCompleteViewController {
//              self.navigationController?.pushViewController(memoCompleteVC, animated: true)
//          }
//    }
//    @IBAction func MoveListButtonClicked(_ sender: Any) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//          if let memoListVC = storyboard.instantiateViewController(withIdentifier: "MemoListVC") as? MemoListViewController {
//              self.navigationController?.pushViewController(memoListVC, animated: true)
//          }
//    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//}
