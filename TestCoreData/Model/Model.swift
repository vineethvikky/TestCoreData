//
//  Model.swift
//  TestCoreData
//
//  Created by Vineeth on 04/07/24.
//

import Foundation

struct DocResponse: Codable {
    var response: Documents
}

struct Documents: Codable {
    var docs = [Document]()
}

struct Document: Codable {
    var abstract: String
    private var multimedia = [Multimedia]()
    private var headline: Headline
    private var pubDate: String
    
    var formattedDate: String? {
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: pubDate) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM yyyy"
            return dateFormatter.string(from: date)
        }
        return nil
    }
    
    var mediaUrl: URL? {
        if let media = multimedia.first {
            return URL(string: media.url)
        }
        return nil
    }
    
    var title: String {
        headline.main
    }
}

struct Multimedia: Codable {
    var url: String
}

struct Headline: Codable {
    var main: String
}
