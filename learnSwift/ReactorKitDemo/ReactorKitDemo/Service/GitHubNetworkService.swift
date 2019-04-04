//
//  GitHubNetworkService.swift
//  ReactorKitDemo
//
//  Created by allen_zhang on 2019/4/1.
//  Copyright © 2019 com.mljr. All rights reserved.
//

import Moya
import RxSwift
import Result

typealias GitHubRepositorResult = Result<(GitHubRepositories), GitErrorType>

let netWorking = GitHubAPINetworking()
class GitHubNetworkService {
    
    func searchRepositories(query: String) -> Observable<GitHubRepositorResult> {
        return netWorking.request(.repositories(query)).map(GitHubRepositories.self).map { .scueess($0) }.asObservable().catchError({ error in
            
            Observable.just(.failue(.notKnow))
        })
    }
    
}
