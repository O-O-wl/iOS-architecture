//
//  UseCaseProvider.swift
//  Domain
//
//  Created by 이동영 on 2020/01/21.
//  Copyright © 2020 이동영. All rights reserved.
//

import Foundation

public protocol UseCaseProvider {
    func makeBookUseCase() -> BookUseCase
}
