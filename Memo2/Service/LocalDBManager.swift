//
//  LocalDBManager.swift
//  Memo2
//
//  Created by 박유경 on 2023/08/23.
//

import Foundation

class LocalDBManager{
    static let instance = LocalDBManager()
    func createData(category: String, item: SectionItem) {
        var categories = getCategoriesFromUserDefaults()
        print(categories)
        if let index = categories.firstIndex(where: { $0.name == category }) {
            categories[index].items.append(item)
         
            saveCategoriesToUserDefaults(categories)
        } else {
            print("Category not found: \(category)")
        }
    }

    func getCategoriesFromUserDefaults() -> [Category] {
        if let data = UserDefaults.standard.data(forKey: "categories"),
            let categories = try? JSONDecoder().decode([Category].self, from: data) {
            return categories
        } else {
            return []
        }
    }

    func saveCategoriesToUserDefaults(_ categories: [Category]) {
        do {
            print("*****************saveCategoriesToUserDefaults**************")
            print(categories)
            let data = try JSONEncoder().encode(categories)
            UserDefaults.standard.set(data, forKey: "categories")
          
        } catch {
            print("Error encoding categories: \(error)")
        }
    }
    
    func initializeCategoriesIfNeeded() {
        if UserDefaults.standard.object(forKey: "categories") == nil {
            let initialData: [Category] = [
                Category(name: "운동", items: [
                ]),
                Category(name: "공부", items: [
                ]),
                Category(name: "모임", items: [
                ])
            ]
            saveCategoriesToUserDefaults(initialData)
        }
    }
    
   //텍스트 변경시
    func updateData(category: String, originText: String, changeText: String) {
        var updatedCategories = getCategoriesFromUserDefaults()
        if let categoryIndex = updatedCategories.firstIndex(where: { $0.name == category }) {
            updatedCategories[categoryIndex].items = updatedCategories[categoryIndex].items.map { item in
                var updatedItem = item
                if item.memoText == originText {
                    updatedItem.memoText = changeText
                }
                return updatedItem
            }
            saveCategoriesToUserDefaults(updatedCategories)
        }
    }
    //스위치 눌렀을때
    func updateData(category: String, cellIndex: Int, content: String, isSwitchOn: Bool) {
        var updatedCategories = getCategoriesFromUserDefaults()
        if let categoryIndex = updatedCategories.firstIndex(where: { $0.name == category }) {
            if cellIndex < updatedCategories[categoryIndex].items.count {
                updatedCategories[categoryIndex].items[cellIndex].memoText = content
                updatedCategories[categoryIndex].items[cellIndex].isSwitchOn = isSwitchOn
                print(updatedCategories)
                saveCategoriesToUserDefaults(updatedCategories)
            }
        }
    }
    
    func deleteData(category: String, content: String) {
        var updatedCategories = getCategoriesFromUserDefaults()
        if let categoryIndex = updatedCategories.firstIndex(where: { $0.name == category }) {
            updatedCategories[categoryIndex].items.removeAll { $0.memoText == content }
            saveCategoriesToUserDefaults(updatedCategories)
        }
    }

    func readData(category: CategoryType) -> [SectionItem] {
        let categories = getCategoriesFromUserDefaults()
        if let matchingCategory = categories.first(where: { $0.name == category.typeValue }) {
            return matchingCategory.items
        } else {
            return []
        }
    }
}
