//
//  Memo.swift
//  Memo2
//
//  Created by 박유경 on 2023/08/22.
//

import Foundation
struct Category {
    var name: String
    var items: [SectionItem]
}
struct SectionItem {
    var memoText: String
    var isSwitchOn: Bool
}
