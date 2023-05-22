//
//  VerticalBarChartExampleView.swift
//  ChartsSwiftUI_Example
//
//  Created by rsingh26 on 09/11/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import SwiftUI
import ChartsSwiftUI

internal struct VerticalBarChartExampleView: View {
    
    let viewModel: VerticalBarChartExampleViewModel
    
    init(viewModel: VerticalBarChartExampleViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VerticalBarChartView(viewModel: viewModel.graphViewModel)
            .background(LinearGradient(gradient: Gradient(colors: [.green.opacity(1.0), .green.opacity(0.5)]), startPoint: .leading, endPoint: .trailing))
            .onAppear(perform: delayFunction)
    }
    
    private func delayFunction() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            viewModel.updateState()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            viewModel.updateSeperator()
        }
    }
}

internal struct VerticalBarChartStyle: VerticalBarChartStyleGuide {
    var barWidth: CGFloat = 60.0
    var barSpacing: CGFloat = 60.0
    var barChartHeight: CGFloat? = 350.0
    var scrollViewHorizontalBounce: Bool = true
}
