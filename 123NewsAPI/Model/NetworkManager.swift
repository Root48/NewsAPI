//
//  NetworkManager.swift
//  123NewsAPI
//
//  Created by Admin on 28.05.2021.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    func loadNews(q:String, selectedCountry: String, selectedCategory: String, selectedSources: String, page: Int, pageSize: Int, completion: (([Article]) -> Void)? = nil) {
        
        var urlString = "https://newsapi.org/v2/top-headlines?apiKey=f00b74ce128e4777ae26d87b3a211bbe"
        if !q.isEmpty {
            urlString.append("&q=\(q)")
        } else {
            if selectedCountry.isEmpty {
                urlString.append("&country=us")
            } else {
                urlString.append("&country=\(selectedCountry)")
            }
            
            if !selectedCategory.isEmpty {
                urlString.append("&category=\(selectedCategory)")
            }
            
            if !selectedSources.isEmpty {
                urlString.append("&sources=\(selectedCategory)")
            }
            
            urlString.append("&page=\(page)")
            urlString.append("&pageSize=\(pageSize)")
        }
        
        guard let url = URL(string: urlString) else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
    //            if let response = response {
    //                print(response)
    //            }
    //
            guard let data = data else { return }
                print(data)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String, Any>
                guard let array = json["articles"] as? [Dictionary<String, Any>] else { return }
                
                
                var returnArray: [Article] = []
                for dict in array {
                    let newArticle = Article(dictionary: dict)
                    returnArray.append(newArticle)
                    
                }
                
                completion?(returnArray)
            } catch {
                print(error)
            }
            
        }.resume()
    }
}
