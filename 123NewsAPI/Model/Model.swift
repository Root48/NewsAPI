//
//  Model.swift
//  123NewsAPI
//
//  Created by Admin on 10.05.2021.
//

import Foundation


//var articles: [Article] = []

func loadNews() {
    guard let url = URL(string: "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=f00b74ce128e4777ae26d87b3a211bbe") else { return }
    let session = URLSession.shared
    session.dataTask(with: url) { (data, response, error) in
//            if let response = response {
//                print(response)
//            }
//
        guard let data = data else { return }
//            print(data)
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String, Any>
            
            print(json)
        } catch {
            print(error)
        }
    }.resume()
}



