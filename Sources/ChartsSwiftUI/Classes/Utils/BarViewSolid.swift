//
//  BarViewSolid.swift
//  ChartsSwiftUI
//
//  Created by rsingh26 on 08/11/21.
//

#if !os(macOS)

import Foundation
import SwiftUI

internal struct BarViewSolid: View {
    var width: CGFloat
    var height: CGFloat
    var fillColor: Color
    var cornerRadius: CGFloat
    var corners: UIRectCorner

    init(width: CGFloat, height: CGFloat, fillColor: Color, cornerRadius: CGFloat = 8.0, corners: UIRectCorner = [.topLeft, .topRight]) {
        self.width = width
        self.height = height
        self.fillColor = fillColor
        self.cornerRadius = cornerRadius
        self.corners = corners
    }

    var body: some View {
        Rectangle()
            .fill(fillColor)
            .frame(width: width, height: height)
            .cornerRadius(cornerRadius, corners: corners)
    }
}

#endif
