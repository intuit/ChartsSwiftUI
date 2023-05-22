//
//  Stripes.swift
//  ChartsSwiftUI
//
//  Created by rsingh26 on 09/11/21.
//

import Foundation
import SwiftUI

/**
        Reference: https://github.com/eneko/Stripes
 */

public struct StripesConfig {
    var background: Color
    var foreground: Color
    var degrees: Double
    var barWidth: CGFloat
    var barSpacing: CGFloat
    var cornerRadius: CGFloat
    var corners: UIRectCorner

    public init(background: Color = Color.clear, foreground: Color = Color.gray, degrees: Double = 45, barWidth: CGFloat = 2.0, barSpacing: CGFloat = 4.0, cornerRadius: CGFloat = 8.0, corners: UIRectCorner = [.topLeft, .topRight]) {
        self.background = background
        self.foreground = foreground
        self.degrees = degrees
        self.barWidth = barWidth
        self.barSpacing = barSpacing
        self.cornerRadius = cornerRadius
        self.corners = corners
    }

    public static let `default`: StripesConfig = StripesConfig()
}


public struct Stripes: View {
    var config: StripesConfig

    public init(config: StripesConfig) {
        self.config = config
    }

    public var body: some View {
        GeometryReader { geometry in
            let longSide: CGFloat = max(geometry.size.width, geometry.size.height)
            let itemWidth: CGFloat = config.barWidth + config.barSpacing
            let items: Int = Int(2 * longSide / itemWidth)
            HStack(spacing: config.barSpacing) {
                ForEach(0..<items) { index in
                    config.foreground
                        .frame(width: config.barWidth, height: 2 * longSide)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .rotationEffect(Angle(degrees: config.degrees), anchor: .center)
            .offset(x: -longSide / 2, y: -longSide / 2)
            .background(config.background)
        }
        .clipped()
        .cornerRadius(config.cornerRadius, corners: config.corners)
    }
}
