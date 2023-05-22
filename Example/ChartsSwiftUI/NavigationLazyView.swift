//
//  NavigationLazyView.swift
//  ChartsSwiftUI_Example
//
//  Created by rsingh26 on 11/11/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import SwiftUI

/**
    Reference: https://stackoverflow.com/questions/57594159/swiftui-navigationlink-loads-destination-view-immediately-without-clicking
 */

internal struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    
    var body: Content {
        build()
    }
}
