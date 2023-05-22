//
//  VerticalBarChartExampleViewModel.swift
//  ChartsSwiftUI_Example
//
//  Created by rsingh26 on 11/11/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import SwiftUI
import ChartsSwiftUI

internal final class VerticalBarChartExampleViewModel: ObservableObject {
    @Published var graphViewModel: VerticalBarChartViewModel!
    let loading: [VerticalBarChartView.BarEntry]
    let loaded: [VerticalBarChartView.BarEntry]
    let seperator: VerticalBarChartView.SeperatorData?
    
    init(loading: [VerticalBarChartView.BarEntry], loaded: [VerticalBarChartView.BarEntry], seperator: VerticalBarChartView.SeperatorData?) {
        self.loading = loading
        self.loaded = loaded
        self.seperator = seperator
        resetState()
    }
    
    func resetState() {
        self.graphViewModel = VerticalBarChartViewModel(dataLoaded: false, barEntries: loading, seperator: seperator, barChartStyle: VerticalBarChartStyle(), audioGraphsAccessibilityProps: VerticalBarChartDefaultAccessibilityProps())
    }
    
    func updateState() {
        graphViewModel.updateState(dataLoaded: true, barEntries: loaded)
    }
    
    func updateSeperator() {
        guard let seperator: VerticalBarChartView.SeperatorData = seperator else {
            return
        }
        graphViewModel.updateSeperator(value: seperator.value + 1000.0)
    }
}

internal struct VerticalBarChartDefaultAccessibilityProps: VerticalBarChartAudioGraphsAccessibilityProps {
    var graphTitle: String = "Vertical Bar Chart"
    var xAxisTitle: String = "Labels"
    var yAxisTitle: String = "Values"
}
