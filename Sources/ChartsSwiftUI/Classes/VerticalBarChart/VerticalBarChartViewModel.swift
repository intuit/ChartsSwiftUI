//
//  VerticalBarChartViewModel.swift
//  ChartsSwiftUI
//
//  Created by rsingh26 on 08/11/21.
//

#if !os(macOS)

import Foundation
import SwiftUI

public final class VerticalBarChartViewModel: ObservableObject {
    enum XAxisLabels: Int, CaseIterable {
        case xTopLabel = 0
        case xBottomLabel = 1
    }
    
    enum YAxisLabels: Int, CaseIterable {
        case yTopLabel = 0
        case yBottomLabel = 1
    }
    
    var barEntries: [VerticalBarChartView.BarEntry]

    var audioGraphsAccessibilityProps: VerticalBarChartAudioGraphsAccessibilityProps?
    
    @Published var seperator: VerticalBarChartView.SeperatorData?
    
    @Published var dataLoaded: Bool = false
    
    @Published var barChartStyle: VerticalBarChartStyleGuide

    @Published var barsScaleFactor: CGFloat = 1.0

    @Published var xAxisPosition: CGFloat = 0.0

    @Published var seperatorPosition: CGFloat = 0.0

    @Published var xLabelsMaxHeight: [CGFloat]

    @Published var yLabelsMaxHeight: [CGFloat]

    @Published var markerTitleHeight: CGFloat

    @Published var markerSubtitleHeight: CGFloat
    
    public init(dataLoaded: Bool, barEntries: [VerticalBarChartView.BarEntry], seperator: VerticalBarChartView.SeperatorData? = nil, barChartStyle: VerticalBarChartStyleGuide? = nil, audioGraphsAccessibilityProps: VerticalBarChartAudioGraphsAccessibilityProps? = nil) {
        self.dataLoaded = dataLoaded
        self.barEntries = barEntries
        self.seperator = seperator
        self.barChartStyle = barChartStyle ?? VerticalBarChartDefaultStyle()
        self.xLabelsMaxHeight = [CGFloat](repeating: 0.0, count: XAxisLabels.allCases.count)
        self.yLabelsMaxHeight = [CGFloat](repeating: 0.0, count: YAxisLabels.allCases.count)
        self.markerTitleHeight = 0.0
        self.markerSubtitleHeight = 0.0
        self.audioGraphsAccessibilityProps = audioGraphsAccessibilityProps
        self.updateOffsets()
    }
    
    public func updateState(dataLoaded: Bool, barEntries: [VerticalBarChartView.BarEntry]) {
        self.dataLoaded = dataLoaded
        self.barEntries = barEntries
        self.xLabelsMaxHeight = [CGFloat](repeating: 0.0, count: XAxisLabels.allCases.count)
        self.yLabelsMaxHeight = [CGFloat](repeating: 0.0, count: YAxisLabels.allCases.count)
        self.updateOffsets()
    }
    
    public func updateSeperator(value: CGFloat) {
        guard var seperator: VerticalBarChartView.SeperatorData = self.seperator else {
            return
        }
        
        seperator.value = value
        self.seperator = seperator
        self.updateOffsets()
    }

    internal final func updateXLabelsMaxHeight(to value: CGFloat, atIndex index: XAxisLabels) {
        self.xLabelsMaxHeight[index.rawValue] = value
        self.updateOffsets()
    }
    
    internal final func updateYLabelsMaxHeight(to value: CGFloat, atIndex index: YAxisLabels) {
        self.yLabelsMaxHeight[index.rawValue] = value
        self.updateOffsets()
    }
    
    internal final func updateMarkerSubtitleHeight(to value: CGFloat) {
        self.markerSubtitleHeight = value
        self.updateOffsets()
    }
    
    internal final func updateMarkerTitleHeight(to value: CGFloat) {
        self.markerTitleHeight = value
        self.updateOffsets()
    }
    
    private final func updateOffsets() {
        self.setBarsScaleFactor()
        self.setXAxisPosOffset()
        self.setSeperatorOffset()
    }
}

extension VerticalBarChartViewModel {
    private func setBarsScaleFactor() {
        
        var barsHeight: [CGFloat] = barEntries.map { $0.backgroundValue }
        barsHeight.append(contentsOf: barEntries.map { $0.foregroundValue })
        
        /// Seperator position is taken into consideration while calculating scale factor
        if let seperator: VerticalBarChartView.SeperatorData = seperator {
            if seperator.value >= 0 {
                barsHeight.append(seperator.value + markerTitleHeight)
            } else {
                barsHeight.append(seperator.value + markerSubtitleHeight)
            }
        }
        
        guard let barChartHeight: CGFloat = barChartStyle.barChartHeight else {
            self.barsScaleFactor = 1.0
            self.xAxisPosition = 0.0
            return
        }

        guard let maxHeight: CGFloat = barsHeight.max() else {
            self.barsScaleFactor = 1.0
            self.xAxisPosition = 0.0
            return
        }

        guard let minHeight: CGFloat = barsHeight.min() else {
            self.barsScaleFactor = 1.0
            self.xAxisPosition = 0.0
            return
        }
        
        let additionalYOffset: CGFloat = yLabelsMaxHeight.reduce(0, +) + barChartStyle.yTopLabelSpacing + barChartStyle.yBottomLabelSpacing

        let additionalXOffset: CGFloat = xLabelsMaxHeight.reduce(0, +) + barChartStyle.xTopLabelSpacing + barChartStyle.xBottomLabelSpacing
        
        var additionalElementsBufferHeight: CGFloat
        var scaleFactor: CGFloat
        
        if minHeight >= 0 {
            /// Case when all bars of graph are in positive direction
            /// To prevent divide by zero error
            
            additionalElementsBufferHeight = additionalXOffset + additionalYOffset
            let heightAvailableForGraph: CGFloat = barChartHeight - additionalElementsBufferHeight
                        
            let scaleDivideFactor: CGFloat = maxHeight
            if scaleDivideFactor == 0 {
                scaleFactor = 1.0
            } else {
                scaleFactor = heightAvailableForGraph / scaleDivideFactor
            }
        } else if maxHeight <= 0 {
            /// Case when all bars of graph are in negative direction
            /// To prevent divide by zero error
            additionalElementsBufferHeight = additionalXOffset + additionalYOffset
            let heightAvailableForGraph: CGFloat = barChartHeight - additionalElementsBufferHeight
            
            let scaleDivideFactor: CGFloat = abs(minHeight)
            if scaleDivideFactor == 0 {
                scaleFactor = 1.0
            } else {
                scaleFactor = heightAvailableForGraph / scaleDivideFactor
            }
        } else {
            /// Case when all bars of graph are in both positive and negative direction
            additionalElementsBufferHeight = additionalXOffset * 2
            let heightAvailableForGraph: CGFloat = barChartHeight - additionalElementsBufferHeight
            
            let scaleDivideFactor: CGFloat = maxHeight + abs(minHeight)
            if scaleDivideFactor == 0 {
                scaleFactor = 1.0
            } else {
                scaleFactor = heightAvailableForGraph / scaleDivideFactor
            }
        }
        
        self.barsScaleFactor = scaleFactor
    }
    
    /**
     Function to calculate the additional offset for XAxis line:
     1. For positive bars, take those values without changing anything
     2. For negative bars, add in the offset for x top and bottom labels to get the effective height of the bar
     3. For seperator, take the seperator value including the subtitle height to get the effective height of the seperator
     */
    private final func setXAxisPosOffset() {
        let scaleFactor: CGFloat = self.barsScaleFactor
        
        let additionalYOffset: CGFloat = yLabelsMaxHeight.reduce(0, +) + barChartStyle.yTopLabelSpacing + barChartStyle.yBottomLabelSpacing

        let additionalXOffset: CGFloat = xLabelsMaxHeight.reduce(0, +) + barChartStyle.xTopLabelSpacing + barChartStyle.xBottomLabelSpacing
        
        var effectiveBarsHeights: [CGFloat] = barEntries.map { $0.backgroundValue >= 0 ? additionalYOffset : abs($0.backgroundValue*scaleFactor) + additionalXOffset }
        effectiveBarsHeights.append(contentsOf: barEntries.map { $0.foregroundValue >= 0 ? additionalYOffset : abs($0.foregroundValue*scaleFactor) + additionalXOffset })
        
        /// Seperator position is taken into consideration while calculating scale factor
        if let seperator: VerticalBarChartView.SeperatorData = seperator, seperator.value < 0 {
            effectiveBarsHeights.append(abs(seperator.value*scaleFactor) + markerSubtitleHeight)
        }
        
        self.xAxisPosition = effectiveBarsHeights.max() ?? 0.0
    }
    
    private final func setSeperatorOffset() {
        guard let seperator: VerticalBarChartView.SeperatorData = seperator else {
            self.seperatorPosition = self.xAxisPosition
            return
        }
        
        self.seperatorPosition = self.xAxisPosition + (seperator.value * barsScaleFactor)
    }
}

#endif
