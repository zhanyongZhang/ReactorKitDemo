//
//  ViewReactor.swift
//  ReactorKitDemo
//
//  Created by allen_zhang on 2019/4/1.
//  Copyright © 2019 com.mljr. All rights reserved.
//

import ReactorKit
import RxSwift

class ViewReactor: Reactor {
    
    enum Action {
        case updateQuery(String?)
    }
    
    enum Mutation {
        case setQuery(String?)
        case setLoading(Bool)
        case setRepos(GitHubRepositories)
    }
    
    struct State {
        var query: String?
        var loading: Bool = false
        var results: [GitHubRepository] = []
        var totalCount: Int = 0
        var title: String {
            get {
                
                if query == nil || query!.isEmpty {
                    return "ReactorDemo"
                } else {
                    return "共有 \(totalCount) 个结果"
                }
            }
        }
    }
    
    let initialState: State
    let networkService = GitHubNetworkService()
    init() {
        self.initialState = State()
    }
    
    func mutate(action: ViewReactor.Action) -> Observable<ViewReactor.Mutation> {
        
        switch action {
        case .updateQuery(let query):
    
            guard !query!.isEmpty else {
                return Observable.just(Mutation.setQuery(query))
            }
            return Observable.concat([
                
                Observable.just(Mutation.setQuery(query)),
                Observable.just(Mutation.setLoading(true)),
                networkService.searchRepositories(query: query!).takeUntil(self.action.filter(isUpdateQueryAction)).map(Mutation.setRepos),
                Observable.just(Mutation.setLoading(false))
                
                ])
        }
    }
    
    func reduce(state: ViewReactor.State, mutation: ViewReactor.Mutation) -> ViewReactor.State {
        var state = state
        switch mutation {
        case let .setLoading(value):
            state.loading = value
        case let .setQuery(query):
            state.query = query
            
            if  state.query!.isEmpty {
                state.results = []
                state.totalCount = 0
            }
        case .setRepos(let repositories):
            state.results = repositories.items
            state.totalCount = repositories.totalCount
        }
        return state
    }
    
    private func isUpdateQueryAction(_ action: Action) -> Bool {
        
        if case .updateQuery = action {
            return true
        } else {
            return false
        }
    }
}


