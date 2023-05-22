//
//  VerticalBarChartViewModelTests.swift
//  ChartsSwiftUI_Example
//
//  Created by rsingh26 on 09/11/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation

import XCTest
import SwiftUI

@testable import ChartsSwiftUI

internal class VerticalBarChartViewModelTests: XCTestCase {
    var mockViewModel: VerticalBarChartViewModel?
    
    override func setUp() {
        super.setUp()
        let barEntries: [VerticalBarChartView.BarEntry] = [
            VerticalBarChartView.BarEntry(id: 0, xTopLabel: VerticalBarChartView.AttributedString(text: "Earned", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold), alignment: .leading), xBottomLabel: VerticalBarChartView.AttributedString(text: "$3000 of $5000", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold), alignment: .leading), backgroundValue: 5000.0, foregroundValue: 3000.0, backgroundColor: Color.white.opacity(0.5), foregroundColor: .white, dashedBackgroundColor: .white, dashedForegroundColor: .gray),
            VerticalBarChartView.BarEntry(id: 1, xTopLabel: VerticalBarChartView.AttributedString(text: "Spent", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold), alignment: .trailing), xBottomLabel: VerticalBarChartView.AttributedString(text: "$738 of $900", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold), alignment: .trailing), backgroundValue: 900.0, foregroundValue: 738.0, backgroundColor: .pink.opacity(0.5), foregroundColor: .pink, dashedBackgroundColor: .pink, dashedForegroundColor: .green)
        ]
        
        self.mockViewModel = VerticalBarChartViewModel(dataLoaded: true, barEntries: barEntries)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetBarsScaleFactor() {
        mockViewModel!.updateXLabelsMaxHeight(to: 13.0, atIndex: .xTopLabel)
        mockViewModel!.updateXLabelsMaxHeight(to: 146.0, atIndex: .xBottomLabel)
        XCTAssertEqual(mockViewModel!.xLabelsMaxHeight[0], 13.0, "X Top Label Max Height is wrong")
        XCTAssertEqual(mockViewModel!.xLabelsMaxHeight[1], 146.0, "X Bottom Label Max Height is wrong")
        XCTAssertEqual(mockViewModel!.barsScaleFactor, 1.0, "Bar scale factor is wrong")
    }
}
