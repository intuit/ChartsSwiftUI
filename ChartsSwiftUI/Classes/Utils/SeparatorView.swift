//
//  SeparatorView.swift
//  ChartsSwiftUI
//
//  Created by rsingh26 on 09/11/21.
//

import Foundation
import SwiftUI

internal struct SeparatorView: View {
    var separatorColor: Color
    var strokeStyle: StrokeStyle

    init(separatorColor: Color = .gray, strokeStyle: StrokeStyle = StrokeStyle(lineWidth: 1, dash: [3, 3])) {
        self.separatorColor = separatorColor
        self.strokeStyle = strokeStyle
    }

    var body: some View {
        Line()
            .stroke(separatorColor, style: strokeStyle)
    }
}
