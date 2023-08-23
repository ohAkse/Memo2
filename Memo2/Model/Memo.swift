//
//  Memo.swift
//  Memo2
//
//  Created by 박유경 on 2023/08/22.
//

import Foundation

//수정 예정..
//struct Memo {
//    var content: String
//    var insertDate: Date
//    var switchIsOn: Bool
//     init() {
//        self.content = ""
//        self.insertDate = Date()
//        self.switchIsOn = false
//
//    }
//
//    init(content: String, insertDate: Date = Date(), switchIsOn: Bool) {
//        self.content = content
//        self.insertDate = insertDate
//        self.switchIsOn = switchIsOn
//    }
//
//    init(updatedContent: String, switchIsOn: Bool) {
//        self.init(content: updatedContent, switchIsOn: switchIsOn)
//    }
//}

struct SectionItem {
    var memoText: String
    var isSwitchOn: Bool
}

struct Category {
    var name: String
    var items: [SectionItem]
}
