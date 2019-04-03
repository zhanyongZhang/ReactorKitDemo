//
//  AuthPlugin.swift
//  BJPark-Swift
//
//  Created by allen_zhang on 2018/12/4.
//  Copyright © 2018 com.mljr. All rights reserved.
//

import Moya

struct AuthPlugin: PluginType {

    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        
        return request
    }
}
