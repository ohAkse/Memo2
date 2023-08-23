//
//  LocalDBManager.swift
//  Memo2
//
//  Created by 박유경 on 2023/08/23.
//

import Foundation

struct LocalDBManager{
    static let instance = LocalDBManager()
    func createData(category : String, item : SectionItem){
        categories = categories.map { Category in
            if Category.name == category{
                var updateCategory = Category
                updateCategory.items.append(item)
                return updateCategory
            }else{
                return Category
            }
        }
    }
    func updateData(category : String, cellIndex : Int, content : String,isSwitchOn : Bool){
        categories = categories.map { Category in
            if Category.name == category{
                var updateCategory = Category
                updateCategory.items[cellIndex].isSwitchOn = isSwitchOn
                updateCategory.items[cellIndex].memoText = content
                return updateCategory
            }else{
                return Category
            }
        }
    }
    func updateData(category: String, originText: String, changeText: String) {
        categories = categories.map { Category -> Category in
            guard Category.name == category else { return Category }
            var updatedCategory = Category
            updatedCategory.items = updatedCategory.items.map { item -> SectionItem in
                var updatedItem = item
                if item.memoText == originText {
                    updatedItem.memoText = changeText
                }
                return updatedItem
            }
            return updatedCategory
        }
    }
    func deleteData(category : String, content : String){
        categories = categories.map { Category in
            var updatedCategory = Category
            if Category.name == category {
                updatedCategory.items = Category.items.filter { $0.memoText != content }
            }
            return updatedCategory
        }
    }
    func readData(category: CategoryType) -> [SectionItem] {
        var sectionItemsByCategory: [CategoryType: [SectionItem]] = [:]

        for aCategory in categories {
            if aCategory.name == category.typeValue {
                sectionItemsByCategory[category] = aCategory.items
            }
        }

        if let itemsForCategory = sectionItemsByCategory[category] {
            return itemsForCategory
        } else {
            return []
        }
    }
}
