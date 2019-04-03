//
//  GitHubModel.swift
//  ReactorKitDemo
//
//  Created by allen_zhang on 2019/4/1.
//  Copyright © 2019 com.mljr. All rights reserved.
//

import UIKit

struct GitHubRepository: Codable {
    
    var id: Int
    var name: String
    var fullName: String
    var htmlUrl: String
    var description: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case fullName = "full_name"
        case htmlUrl = "html_url"
        case description = "description"
    }
}

struct GitHubRepositories: ModelType {
    
    var totalCount: Int
    var items: [GitHubRepository]
    
    init() {
        self.totalCount = 0
        self.items = []
    }
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items = "items"
    }
}

