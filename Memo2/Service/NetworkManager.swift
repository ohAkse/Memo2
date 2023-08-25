//
//  NetworkManager.swift
//  Memo2
//
//  Created by 박유경 on 2023/08/25.
//

import Foundation
import UIKit

final class NetworkManager{
    static let instance = NetworkManager()
    //강아지 버전은 Async/Await으로 처리(IOS 15버전 이상)
    func fetchRandomImageAsync(imageUrl: String) async throws -> UIImage {
        let session = URLSession(configuration: .default)
        let (data, _) = try await session.data(from: URL(string: imageUrl)!)//URLResponse는 별 쓸모없는거같음
        do {
            let decoder = JSONDecoder()
            let cats = try decoder.decode([Dog].self, from: data)
            let imageUrl = cats[0].url
            return await getImageAsync(imageUrl: imageUrl)
        } catch {
            print("Error decoding JSON: \(error)")
        }
        return UIImage()
    }
    
    func getImageAsync(imageUrl: String) async -> UIImage {
        if let imageUrl = URL(string: imageUrl) {
            do {
                let (data, _) = try await URLSession.shared.data(from: imageUrl)
                if let image = UIImage(data: data) {
                    return image
                } else {
                    return UIImage()
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        return UIImage()
    }
    
    func fetchRandomImage(imageUrl: String, completion: @escaping (UIImage?) -> Void) {
        if let imageUrl = URL(string: imageUrl) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: imageUrl) { (data, response, error) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    completion(nil)
                    return
                }
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode != 200 {
                        print("HTTP Error: \(httpResponse.statusCode)")
                        completion(nil)
                        return
                    }
                }
                if let data = data, let image = UIImage(data: data) {
                    completion(image)
                } else {
                    completion(nil)
                }
            }
            task.resume()
        }
    }
    
    
//    func fetchDogImage(url: String, completion: @escaping ([Dog]?) -> Void) {
//        if let imageUrl = URL(string: url) {
//            let session = URLSession(configuration: .default)
//            let task = session.dataTask(with: imageUrl) { [weak self] (data, response, error) in
//                if let error = error {
//                    print("Error: \(error.localizedDescription)")
//                    completion(nil) // 실패 시 nil을 전달
//                    return
//                }
//                if let httpResponse = response as? HTTPURLResponse {
//                    if httpResponse.statusCode != 200 {
//                        print("HTTP Error: \(httpResponse.statusCode)")
//                        completion(nil) // 실패 시 nil을 전달
//                        return
//                    }
//                }
//                if let data = data {
//                    do {
//                        print(data)
//
//                        let decoder = JSONDecoder()
//                        let dog = try decoder.decode(Dog.self, from: data)
//                        completion([dog]) // 성공 시 디코딩된 Dog 객체를 전달
//                    } catch {
//                        print("Error decoding JSON: \(error)")
//                        completion(nil) // 디코딩 실패 시 nil을 전달
//                    }
//                } else {
//                    completion(nil) // 데이터가 없을 경우 nil을 전달
//                }
//            }
//            task.resume()
//        } else {
//            completion(nil) // 잘못된 URL이면 nil을 전달
//        }
//    }
//
//    func fetchCatImage(url: String, completion: @escaping ([Cat]?) -> Void) {
//        if let imageUrl = URL(string: url) {
//            let session = URLSession(configuration: .default)
//            let task = session.dataTask(with: imageUrl) { (data, response, error) in
//                if let error = error {
//                    print("Error: \(error.localizedDescription)")
//                    completion(nil)
//                    return
//                }
//                if let httpResponse = response as? HTTPURLResponse {
//                    if httpResponse.statusCode != 200 {
//                        print("HTTP Error: \(httpResponse.statusCode)")
//                        completion(nil)
//                        return
//                    }
//                }
//                if let data = data {
//                    do {
//                        let decoder = JSONDecoder()
//                        let cats = try decoder.decode([Cat].self, from: data)
//                        completion(cats)
//                    } catch {
//                        print("Error decoding JSON: \(error)")
//                        completion(nil)
//                    }
//                } else {
//                    completion(nil)
//                }
//            }
//            task.resume()
//        } else {
//            completion(nil)
//        }
//    }
    
}
