//
//  SnapshotTestsHelper.swift
//  ChartsSwiftUI_ExampleUITests
//
//  Created by rsingh26 on 10/11/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import SnapshotTesting

internal final class SnapshotTestsHelper {
    static func getDevicesList() -> [String:ViewImageConfig] {
        return ["iPhoneX": .iPhoneX,
                "iPhoneXr": .iPhoneXr,
                "iPadPro11": .iPadPro11]
    }
}
