//
//  DynamicIsActivityAttributes.swift
//  HYFDynamicIsland
//
//  Created by 贺亚飞 on 2025/3/19.
//

import Foundation
import ActivityKit
struct DynamicIsActivityAttributes: ActivityAttributes {
    public typealias dynamicIsActivityStatus = ContentState

    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
//        var emoji: String
        var driverName: String
        var driverStatus : Int //1待接单， 2配送中 3已完成
        var deliveryTimer: ClosedRange<Date>
    }

    // Fixed non-changing properties about your activity go here!
//    var name: String
    var numberOfPizzas: Int
    var totalAmount: String
    var orderNumber: String
}
