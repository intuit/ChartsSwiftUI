//
//  VerticalBarChartAccessibility.swift
//  ChartsSwiftUI
//
//  Created by rsingh26 on 16/12/21.
//

import Foundation

public protocol VerticalBarChartAudioGraphsAccessibilityProps {
    var graphTitle: String { get }
    var xAxisTitle: String { get }
    var yAxisTitle: String { get }
}

public extension VerticalBarChartAudioGraphsAccessibilityProps {
    var graphTitle: String {
        return "Vertical Bar Chart"
    }
    
    var xAxisTitle: String {
        return "Labels"
    }
    
    var yAxisTitle: String {
        return "Values"
    }
}
