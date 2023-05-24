//
//  RoundedCorner.swift
//  ChartsSwiftUI
//
//  Created by rsingh26 on 09/11/21.
//

#if !os(macOS)

import Foundation
import SwiftUI

internal struct RoundedCorner: InsettableShape {
    var insetAmount: CGFloat = 0.0
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path: UIBezierPath = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var roundedCorner: RoundedCorner = self
        roundedCorner.insetAmount += amount
        return roundedCorner
    }
}

#endif
