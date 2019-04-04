//
//  Result.swift
//  ReactorKitDemo
//
//  Created by allen_zhang on 2019/4/4.
//  Copyright © 2019 com.mljr. All rights reserved.
//

import Foundation

enum Result<T,E: Error> {
    case scueess(T)
    case failue(E)
}

enum GitErrorType: Error {
    
    case notReach
    case limitRequest
    case notKnow
}

extension GitErrorType {
    
    var errorMessage: String {
        
        switch self {
        case .limitRequest:
            return "请稍后。。。"
        case .notReach:
            return "请检查网络。。。"
        case .notKnow:
            return "未知错误"
        }
    }
}
