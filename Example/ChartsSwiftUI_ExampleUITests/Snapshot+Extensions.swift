//
//  Snapshot+Extensions.swift
//  ChartsSwiftUI_ExampleUITests
//
//  Created by rsingh26 on 10/11/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import SwiftUI

extension SwiftUI.View {
    func toVC() -> UIViewController {
        let vc = UIHostingController(rootView: self)
        vc.view.frame = UIScreen.main.bounds
        return vc
    }
}
