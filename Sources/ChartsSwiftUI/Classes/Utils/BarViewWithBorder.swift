//
//  BarViewWithBorder.swift
//  ChartsSwiftUI
//
//  Created by rsingh26 on 23/11/21.
//

#if !os(macOS)
import Foundation
import SwiftUI

internal struct BarViewWithBorder: View {
    enum BorderStyle {
        case solid
        case dashed
    }

    var width: CGFloat
    var height: CGFloat
    var fillColor: Color
    var borderColor: Color
    var borderWidth: CGFloat
    var borderStyle: BorderStyle
    var cornerRadius: CGFloat
    var corners: UIRectCorner

    init(width: CGFloat, height: CGFloat, fillColor: Color, borderColor: Color? = nil, borderWidth: CGFloat = 3.0, borderStyle: BorderStyle = .dashed, cornerRadius: CGFloat, corners: UIRectCorner = [.topLeft, .topRight]) {
        self.width = width
        self.height = height
        self.fillColor = fillColor
        self.borderColor = borderColor ?? fillColor
        self.borderWidth = borderWidth
        self.cornerRadius = cornerRadius
        self.corners = corners
        self.borderStyle = borderStyle
    }

    var body: some View {
        switch borderStyle {
        case .solid:
            RoundedCorner(radius: cornerRadius, corners: corners)
                .strokeBorder(borderColor, style: StrokeStyle(lineWidth: borderWidth))
                .background(Rectangle().foregroundColor(fillColor))
                .frame(width: width, height: height)
                .cornerRadius(cornerRadius, corners: corners)

        case .dashed:
            RoundedCorner(radius: cornerRadius, corners: corners)
                .strokeBorder(borderColor, style: StrokeStyle(lineWidth: borderWidth, dash: [3, 3]))
                .background(Rectangle().foregroundColor(fillColor))
                .frame(width: width, height: height)
                .cornerRadius(cornerRadius, corners: corners)
        }
    }
}
#endif
