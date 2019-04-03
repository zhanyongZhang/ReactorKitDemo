//
//  Networking.swift
//  BJPark-Swift
//
//  Created by allen_zhang on 2018/12/3.
//  Copyright © 2018 com.mljr. All rights reserved.
//

import Moya
import MoyaSugar
import RxSwift

typealias GitHubAPINetworking = Networking<GitHubAPI>

final class Networking<Target: SugarTargetType>: MoyaSugarProvider<Target> {
        init(plugins: [PluginType]  = []) {
    
            let configuration = URLSessionConfiguration.default
            configuration.httpAdditionalHeaders = Manager.defaultHTTPHeaders
            configuration.timeoutIntervalForRequest = 10
            
            let manager = Manager(configuration: configuration)
            manager.startRequestsImmediately = false
            super.init(manager: manager, plugins: plugins)
    }
    
    func request(_ target: Target, file: StaticString = #file,
                 function: StaticString = #function,
                 line: UInt = #line) -> Single<Response> {
        let requestString = "\(target.baseURL)\(target.path)"
        return self.rx.request(target).filterSuccessfulStatusCodes().do(onSuccess: { value in
            
            let message = String.init(data: value.data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) ?? ""
            log.debug(message,file: file, function: function, line: line)
        }, onError: {  error in
            if let response = (error as? MoyaError)?.response {
                if let jsonObject = try? response.mapJSON(failsOnEmptyData: false) {
                    let message = "FAILURE: \(requestString) (\(response.statusCode))\n\(jsonObject)"
                     log.warning(message, file: file, function: function, line: line)
                } else if let rawString = String(data: response.data, encoding: .utf8) {
                    let message = "FAILURE: \(requestString) (\(response.statusCode))\n\(rawString)"
                     log.warning(message, file: file, function: function, line: line)
                } else {
                    let message = "FAILURE: \(requestString) (\(response.statusCode))"
                     log.warning(message, file: file, function: function, line: line)
                }
            } else {
                let message = "FAILURE: \(requestString)\n\(error)"
                 log.warning(message, file: file, function: function, line: line)
            }

        }, onSubscribe: {
            let message = "REQUEST: \(requestString)"
            log.debug(message, file: file, function: function, line: line)
        })
    }
}
