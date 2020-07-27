//
//  DispatchTime+Extension.swift
//  BossJob
//
//  Created by zhaoyuanjing on 2017/09/29.
//  Copyright © 2017年 zhaoyuanjing. All rights reserved.
//

import Foundation
extension DispatchTime: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self = DispatchTime.now() + .seconds(value)
    }
}
extension DispatchTime: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self = DispatchTime.now() + .milliseconds(Int(value * 1000))
    }
}

