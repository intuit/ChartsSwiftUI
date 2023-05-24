//
//  LineShape.swift
//  ChartsSwiftUI
//
//  Created by rsingh26 on 09/11/21.
//

import SwiftUI

public struct Line: Shape {
    public init() { }
    
    public func path(in rect: CGRect) -> Path {
        var path: Path = .init()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}
