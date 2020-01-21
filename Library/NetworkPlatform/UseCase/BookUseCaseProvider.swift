//
//  BookUseCaseProvider.swift
//  NetworkPlatform
//
//  Created by 이동영 on 2020/01/21.
//  Copyright © 2020 이동영. All rights reserved.
//

import Foundation
import Domain

public class UseCaseProvider: Domain.UseCaseProvider {
    public init() {}
    
    public func makeBookUseCase() -> Domain.BookUseCase {
        return BookUseCase()
    }
}

