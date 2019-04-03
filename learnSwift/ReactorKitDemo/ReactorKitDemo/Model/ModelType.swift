//
//  ModelType.swift
//  ReactorKitDemo
//
//  Created by allen_zhang on 2019/4/1.
//  Copyright © 2019 com.mljr. All rights reserved.
//

import UIKit

protocol ModelType: Codable {
     static var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy { get }
}

extension ModelType {
    
    static var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy {
        return .iso8601
    }
    static var decoder: JSONDecoder {
     
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = self.dateDecodingStrategy
        return decoder
    }
}
