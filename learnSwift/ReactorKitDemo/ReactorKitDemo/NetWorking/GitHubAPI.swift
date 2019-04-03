//
//  GitHubAPI.swift
//  ReactorKitDemo
//
//  Created by allen_zhang on 2019/4/1.
//  Copyright © 2019 com.mljr. All rights reserved.
//

import Foundation
import Moya
import MoyaSugar


enum GitHubAPI {
    case repositories(String)
}
extension GitHubAPI: SugarTargetType {
    
    var route: Route {
        switch self {
        case .repositories:
            return .get("/search/repositories")
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .repositories(let query):
            var params: [String : Any] = [:]
            params["q"] = query
            params["sort"] = "stars"
            params["order"] = "desc"
            return Parameters(encoding: URLEncoding(), values: params)
        }
    }
    
    var url: URL {
        
        return self.defaultURL
    }
    
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }

    var task: Task {
        
        return .requestParameters(parameters: parameters?.values ?? [ : ], encoding: URLEncoding())
    }
    
    var headers: [String : String]? {
          return ["Accept": "application/json"]
    }
}
