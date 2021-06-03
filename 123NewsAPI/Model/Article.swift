//
//  Article.swift
//  123NewsAPI
//
//  Created by Admin on 11.05.2021.
//

import Foundation

struct Article {
    var author: String
    var title: String
    var description: String
    var url: String
    let urlToImage: String
    var publishedAt: String
    var content: String
    var sourseName: String
    
    init(dictionary: Dictionary<String, Any>) {
        author = dictionary["author"] as? String ?? ""
        title  = dictionary["title"] as? String ?? ""
        description = dictionary["description"] as? String ?? ""
        url = dictionary["url"] as? String ?? ""
        urlToImage = dictionary["urlToImage"] as? String ?? ""
        publishedAt = dictionary["publishedAt"] as? String ?? ""
        content = dictionary["content"] as? String ?? ""
        sourseName = (dictionary["source"] as? Dictionary<String, Any> ?? ["":""])["name"] as? String ?? ""
    }
    
}

struct Source {
    var id: String
    var name: String
    
    init(dictionary: Dictionary<String, Any>) {
        id = dictionary["id"] as? String ?? ""
        name = dictionary["name"] as? String ?? ""
         }
}
