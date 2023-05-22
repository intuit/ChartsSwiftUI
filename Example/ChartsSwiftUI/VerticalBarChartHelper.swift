//
//  VerticalBarChartHelper.swift
//  ChartsSwiftUI
//
//  Created by rsingh26 on 23/11/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import SwiftUI
import ChartsSwiftUI

internal final class VerticalBarChartHelper {
    internal struct Mock {
        let displayName: String
        let loading: [VerticalBarChartView.BarEntry]
        let loaded: [VerticalBarChartView.BarEntry]
        let seperator: VerticalBarChartView.SeperatorData?
        
        internal init(displayName: String, loading: [VerticalBarChartView.BarEntry], loaded: [VerticalBarChartView.BarEntry], seperator: VerticalBarChartView.SeperatorData? = nil) {
            self.displayName = displayName
            self.loading = loading
            self.loaded = loaded
            self.seperator = seperator
        }
    }
    
    static func getMocks() -> [Mock] {
        var mocks: [Mock] = []
        
        /// Mock 1
        let mock1: Mock = Mock(displayName: "Positive Bars",
                   loading: [
                    VerticalBarChartView.BarEntry(id: 0, xTopLabel: VerticalBarChartView.AttributedString(text: "Earned", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold), alignment: .leading), xBottomLabel: VerticalBarChartView.AttributedString(text: "$----", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold), alignment: .leading), backgroundValue: 5000.0, foregroundValue: 0.0, backgroundColor: Color.white.opacity(0.8), foregroundColor: .white, dashedBackgroundColor: .white, dashedForegroundColor: .gray),
                    VerticalBarChartView.BarEntry(id: 1, xTopLabel: VerticalBarChartView.AttributedString(text: "Spent", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold), alignment: .trailing), xBottomLabel: VerticalBarChartView.AttributedString(text: "$----", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold), alignment: .trailing), backgroundValue: 3000.0, foregroundValue: 0.0, backgroundColor: Color.white.opacity(0.8), foregroundColor: .pink, dashedBackgroundColor: .pink, dashedForegroundColor: .green)
                ],
                    loaded: [
                        VerticalBarChartView.BarEntry(id: 0, xTopLabel: VerticalBarChartView.AttributedString(text: "Earned", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold), alignment: .leading), xBottomLabel: VerticalBarChartView.AttributedString(text: "$3000 of $5000", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold), alignment: .leading), backgroundValue: 5000.0, foregroundValue: 3000.0, backgroundColor: Color.white.opacity(0.5), foregroundColor: .white, dashedBackgroundColor: .white, dashedForegroundColor: .gray),
                        VerticalBarChartView.BarEntry(id: 1, xTopLabel: VerticalBarChartView.AttributedString(text: "Spent", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold), alignment: .trailing), xBottomLabel: VerticalBarChartView.AttributedString(text: "$738 of $900", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold), alignment: .trailing), backgroundValue: 900.0, foregroundValue: 1738.0, backgroundColor: .pink.opacity(0.5), foregroundColor: .pink, dashedBackgroundColor: .pink, dashedForegroundColor: .green)
                    ])
        
        mocks.append(mock1)
        
        /// Mock 2
        let mock2: Mock = Mock(displayName: "Positive Bars with X and Y Labels",
                               loading: [
                                VerticalBarChartView.BarEntry(id: 0, xBottomLabel: VerticalBarChartView.AttributedString(text: "$----", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold), alignment: .leading), yTopLabel: VerticalBarChartView.AttributedString(text: "Earned", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold), alignment: .leading), backgroundValue: 5000.0, foregroundValue: 0.0, backgroundColor: Color.white.opacity(0.8), foregroundColor: .white, dashedBackgroundColor: .white, dashedForegroundColor: .gray),
                                VerticalBarChartView.BarEntry(id: 1, xBottomLabel: VerticalBarChartView.AttributedString(text: "$----", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold), alignment: .trailing), yTopLabel: VerticalBarChartView.AttributedString(text: "Earned", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold), alignment: .leading), backgroundValue: 3000.0, foregroundValue: 0.0, backgroundColor: Color.white.opacity(0.8), foregroundColor: .pink, dashedBackgroundColor: .pink, dashedForegroundColor: .green)
                            ],
                               loaded: [
                                VerticalBarChartView.BarEntry(id: 0, xBottomLabel: VerticalBarChartView.AttributedString(text: "$3000 of $5000", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold), alignment: .leading), yTopLabel: VerticalBarChartView.AttributedString(text: "Earned", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold), alignment: .leading), backgroundValue: 5000.0, foregroundValue: 3000.0, backgroundColor: Color.white.opacity(0.5), foregroundColor: .white, dashedBackgroundColor: .white, dashedForegroundColor: .gray),
                                VerticalBarChartView.BarEntry(id: 1, xBottomLabel: VerticalBarChartView.AttributedString(text: "$738 of $900", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold), alignment: .trailing), yTopLabel: VerticalBarChartView.AttributedString(text: "Earned", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold), alignment: .leading), backgroundValue: 900.0, foregroundValue: 1738.0, backgroundColor: .pink.opacity(0.5), foregroundColor: .pink, dashedBackgroundColor: .pink, dashedForegroundColor: .green)
                            ])
        mocks.append(mock2)
        
        /// Mock 3
        let mock3: Mock = Mock(displayName: "Positive And Negative Bars with X and Y Labels",
                               loading: [
                                VerticalBarChartView.BarEntry(id: 0, xBottomLabel: VerticalBarChartView.AttributedString(text: "$----", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold), alignment: .leading), yTopLabel: VerticalBarChartView.AttributedString(text: "Earned", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold), alignment: .leading), backgroundValue: 5000.0, foregroundValue: 0.0, backgroundColor: Color.white.opacity(0.8), foregroundColor: .white, dashedBackgroundColor: .white, dashedForegroundColor: .gray),
                                VerticalBarChartView.BarEntry(id: 1, xBottomLabel: VerticalBarChartView.AttributedString(text: "$----", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold), alignment: .trailing), yTopLabel: VerticalBarChartView.AttributedString(text: "Earned", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold), alignment: .leading), backgroundValue: 3000.0, foregroundValue: 0.0, backgroundColor: Color.white.opacity(0.8), foregroundColor: .pink, dashedBackgroundColor: .pink, dashedForegroundColor: .green)
                            ],
                               loaded: [
                                VerticalBarChartView.BarEntry(id: 0, xBottomLabel: VerticalBarChartView.AttributedString(text: "$3000 of $5000", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold)), yTopLabel: VerticalBarChartView.AttributedString(text: "Y Top", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold)), yBottomLabel: VerticalBarChartView.AttributedString(text: "Y Bottom", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold)), backgroundValue: 5000.0, foregroundValue: 3000.0, backgroundColor: Color.white.opacity(0.5), foregroundColor: .white, dashedBackgroundColor: .white, dashedForegroundColor: .gray, border: .dashed(color: .red)),
                                VerticalBarChartView.BarEntry(id: 1, xBottomLabel: VerticalBarChartView.AttributedString(text: "$738 of $900", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold)), yTopLabel: VerticalBarChartView.AttributedString(text: "Y Top", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold)), yBottomLabel: VerticalBarChartView.AttributedString(text: "Y Bottom", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold)), backgroundValue: -900.0, foregroundValue: -738.0, backgroundColor: .pink.opacity(0.5), foregroundColor: .pink, dashedBackgroundColor: .pink, dashedForegroundColor: .green, border: .solid(color: .green))
                            ])
        mocks.append(mock3)
        
        /// Mock 4
        let mock4: Mock = Mock(displayName: "Negative Bars",
                   loading: [
                    VerticalBarChartView.BarEntry(id: 0, xTopLabel: VerticalBarChartView.AttributedString(text: "Earned", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold), alignment: .leading), xBottomLabel: VerticalBarChartView.AttributedString(text: "$----", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold), alignment: .leading), backgroundValue: 5000.0, foregroundValue: 0.0, backgroundColor: Color.white.opacity(0.8), foregroundColor: .white, dashedBackgroundColor: .white, dashedForegroundColor: .gray),
                    VerticalBarChartView.BarEntry(id: 1, xTopLabel: VerticalBarChartView.AttributedString(text: "Spent", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold), alignment: .trailing), xBottomLabel: VerticalBarChartView.AttributedString(text: "$----", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold), alignment: .trailing), backgroundValue: 3000.0, foregroundValue: 0.0, backgroundColor: Color.white.opacity(0.8), foregroundColor: .pink, dashedBackgroundColor: .pink, dashedForegroundColor: .green)
                ],
                    loaded: [
                        VerticalBarChartView.BarEntry(id: 0, xTopLabel: VerticalBarChartView.AttributedString(text: "Earned", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold), alignment: .leading), xBottomLabel: VerticalBarChartView.AttributedString(text: "$3000 of $5000", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold), alignment: .leading), backgroundValue: -5000.0, foregroundValue: -3000.0, backgroundColor: Color.white.opacity(0.5), foregroundColor: .white, dashedBackgroundColor: .white, dashedForegroundColor: .gray),
                        VerticalBarChartView.BarEntry(id: 1, xTopLabel: VerticalBarChartView.AttributedString(text: "Spent", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold), alignment: .trailing), xBottomLabel: VerticalBarChartView.AttributedString(text: "$738 of $900", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold), alignment: .trailing), backgroundValue: -900.0, foregroundValue: -1738.0, backgroundColor: .pink.opacity(0.5), foregroundColor: .pink, dashedBackgroundColor: .pink, dashedForegroundColor: .green)
                    ])
        
        mocks.append(mock4)
        
        /// Mock 5
        let mock5: Mock = Mock(displayName: "Chart with overall seperator",
                   loading: [
                    VerticalBarChartView.BarEntry(id: 0, xTopLabel: VerticalBarChartView.AttributedString(text: "Earned", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold), alignment: .leading), xBottomLabel: VerticalBarChartView.AttributedString(text: "$----", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold), alignment: .leading), backgroundValue: 5000.0, foregroundValue: 0.0, backgroundColor: Color.white.opacity(0.8), foregroundColor: .white, dashedBackgroundColor: .white, dashedForegroundColor: .gray),
                    VerticalBarChartView.BarEntry(id: 1, xTopLabel: VerticalBarChartView.AttributedString(text: "Spent", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold), alignment: .trailing), xBottomLabel: VerticalBarChartView.AttributedString(text: "$----", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold), alignment: .trailing), backgroundValue: 3000.0, foregroundValue: 0.0, backgroundColor: Color.white.opacity(0.8), foregroundColor: .pink, dashedBackgroundColor: .pink, dashedForegroundColor: .green)
                ],
                    loaded: [
                        VerticalBarChartView.BarEntry(id: 0, xTopLabel: VerticalBarChartView.AttributedString(text: "Earned", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold), alignment: .leading), xBottomLabel: VerticalBarChartView.AttributedString(text: "-$3000 of -$5000", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold), alignment: .leading), backgroundValue: -5000.0, foregroundValue: -3000.0, backgroundColor: Color.white.opacity(0.5), foregroundColor: .white, dashedBackgroundColor: .white, dashedForegroundColor: .gray),
                        VerticalBarChartView.BarEntry(id: 1, xTopLabel: VerticalBarChartView.AttributedString(text: "Spent", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold), alignment: .trailing), xBottomLabel: VerticalBarChartView.AttributedString(text: "$738 of $1000", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold), alignment: .trailing), backgroundValue: 1000.0, foregroundValue: 738.0, backgroundColor: .pink.opacity(0.5), foregroundColor: .pink, dashedBackgroundColor: .pink, dashedForegroundColor: .green)
                    ],
                               seperator: VerticalBarChartView.SeperatorData(title: VerticalBarChartView.AttributedString(text: "Marker Title", color: .black, uiFont: .systemFont(ofSize: 16.0, weight: .bold)), subtitle: VerticalBarChartView.AttributedString(text: "Marker Subtitle", color: .black, uiFont: .systemFont(ofSize: 24.0, weight: .bold)), value: -4000.0))
        
        mocks.append(mock5)
        
        /// Mock 6
        let mock6: Mock = Mock(displayName: "Chart with positive seperator",
                   loading: [
                    VerticalBarChartView.BarEntry(id: 0, xTopLabel: VerticalBarChartView.AttributedString(text: "Earned", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold), alignment: .leading), xBottomLabel: VerticalBarChartView.AttributedString(text: "$----", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold), alignment: .leading), yTopLabel: VerticalBarChartView.AttributedString(text: "Dec", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold)), backgroundValue: 5000.0, foregroundValue: 0.0, backgroundColor: Color.white.opacity(0.8), foregroundColor: .white, dashedBackgroundColor: .white, dashedForegroundColor: .gray),
                    VerticalBarChartView.BarEntry(id: 1, xTopLabel: VerticalBarChartView.AttributedString(text: "Spent", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold), alignment: .trailing), xBottomLabel: VerticalBarChartView.AttributedString(text: "$----", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold), alignment: .trailing), yTopLabel: VerticalBarChartView.AttributedString(text: "Dec", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold)), backgroundValue: 3000.0, foregroundValue: 0.0, backgroundColor: Color.white.opacity(0.8), foregroundColor: .pink, dashedBackgroundColor: .pink, dashedForegroundColor: .green)
                ],
                    loaded: [
                        VerticalBarChartView.BarEntry(id: 0, xTopLabel: VerticalBarChartView.AttributedString(text: "Earned", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold), alignment: .leading), xBottomLabel: VerticalBarChartView.AttributedString(text: "-$3000 of -$5000", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold), alignment: .leading), yTopLabel: VerticalBarChartView.AttributedString(text: "Nov", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold)), backgroundValue: -5000.0, foregroundValue: -3000.0, backgroundColor: Color.white.opacity(0.5), foregroundColor: .white, dashedBackgroundColor: .white, dashedForegroundColor: .gray),
                        VerticalBarChartView.BarEntry(id: 1, xTopLabel: VerticalBarChartView.AttributedString(text: "Spent", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold), alignment: .trailing), xBottomLabel: VerticalBarChartView.AttributedString(text: "$738 of $1000", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold), alignment: .trailing), yTopLabel: VerticalBarChartView.AttributedString(text: "Dec", color: .black, uiFont: .systemFont(ofSize: 12.0, weight: .bold)), backgroundValue: 1000.0, foregroundValue: 738.0, backgroundColor: .pink.opacity(0.5), foregroundColor: .pink, dashedBackgroundColor: .pink, dashedForegroundColor: .green)
                    ],
                               seperator: VerticalBarChartView.SeperatorData(title: VerticalBarChartView.AttributedString(text: "Marker Title", color: .black, uiFont: .systemFont(ofSize: 16.0, weight: .bold)), subtitle: VerticalBarChartView.AttributedString(text: "Marker Subtitle", color: .black, uiFont: .systemFont(ofSize: 24.0, weight: .bold)), value: 738.0))
        
        mocks.append(mock6)
        
        return mocks
    }
}

