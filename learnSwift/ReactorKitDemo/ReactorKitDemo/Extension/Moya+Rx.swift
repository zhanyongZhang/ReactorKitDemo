//
//  Moya+Rx.swift
//  ReactorKitDemo
//
//  Created by allen_zhang on 2019/4/1.
//  Copyright © 2019 com.mljr. All rights reserved.
//

import Moya
import RxSwift

extension PrimitiveSequence where TraitType == SingleTrait, Element == Moya.Response {
    
    func map<T: ModelType>(_ type: T.Type) -> PrimitiveSequence<TraitType, T> {
        return self.map(T.self, using: T.decoder)
    }
    
}
