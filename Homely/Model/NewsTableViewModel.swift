//
//  NewsTableViewModel.swift
//  Homely
//
//  Created by Nurmukhanbet Sertay on 07.05.2023.
//

import Foundation

class NewsTableViewModel {
    
    let title: String
    let subtitle: String
    let imageURL: URL?
    let url: String
    var imageData: Data? = nil
    
    init(title: String, subtitle: String, url: String, imageURL: URL?) {
        self.title = title
        self.subtitle = subtitle
        self.url = url
        self.imageURL = imageURL
    
    }
}
