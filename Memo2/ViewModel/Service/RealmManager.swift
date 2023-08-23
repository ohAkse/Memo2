//
//  RealmManager.swift
//  Memo2
//
//  Created by 박유경 on 2023/08/22.
//

import Foundation
//수정 예정..
//import RealmSwift
//final class RealmManager
//{
//    static let Instance = RealmManager()
//    
//    func createMemo(memo: Memo) -> Void {
//        do {
//            let realm = try Realm()
//            try realm.write {
//                realm.add(memo)
//            }
//        } catch {
//            print("Error saving data: \(error)")
//        }
//    }
//    //텍스트 변경시 업데이트 용도
//    func updateMemo(index : Int, content : String, updateDate : Date = Date()){
//        do {
//            let realm = try Realm()
//            let memos = realm.objects(Memo.self)
//            
//            guard index >= 0 && index < memos.count else {
//                print("Invalid index")
//                return
//            }
//            let memoToUpdate = memos[index]
//            
//            try realm.write {
//                memoToUpdate.content = content
//                memoToUpdate.insertDate = updateDate
//            }
//        } catch {
//            print("Error updating memo: \(error)")
//        }
//    }
//    //커스텀셀에서 스위치 바꼈을때 업데이트용도
//    func updateMemo(index: Int, isOn: Bool, updateDate : Date = Date()) {
//        do {
//            let realm = try Realm()
//            let memos = realm.objects(Memo.self)
//            
//            guard index >= 0 && index < memos.count else {
//                print("Invalid index")
//                return
//            }
//            let memoToUpdate = memos[index]
//            
//            try realm.write {
//                memoToUpdate.switchIsOn = isOn
//                memoToUpdate.insertDate = updateDate
//            }
//        } catch {
//            print("Error updating memo: \(error)")
//        }
//    }
//    func deleteMemo(index : Int) {
//        do {
//            let realm = try Realm()
//            let memos = realm.objects(Memo.self)
//            guard index >= 0 && index < memos.count else {
//                print("Invalid index")
//                return
//            }
//            
//            let memoToDelete = memos[index]
//            
//            try realm.write {
//                realm.delete(memoToDelete)
//                ShowMemoListInfo()
//            }
//        } catch {
//            print("Error reading data: \(error)")
//        }
//    }
//    func getMemoList() -> [Memo] {
//        do {
//            let realm = try Realm()
//            let memoObjects = realm.objects(Memo.self)
//            let memoArray = Array(memoObjects) //
//            return memoArray
//        } catch {
//            print("Error reading data: \(error)")
//            return []
//        }
//    }
//    func ShowMemoListInfo(){
//        do {
//            let realm = try Realm()
//            let memos = realm.objects(Memo.self)
//            for memo in memos {
//                print("Content: \(memo.content), Insert Date: \(memo.insertDate), Switch Is On: \(memo.switchIsOn)")
//            }
//        } catch {
//            print("Error reading data: \(error)")
//        }
//    }
//}
