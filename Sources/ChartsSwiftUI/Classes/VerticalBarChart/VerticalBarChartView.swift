//
//  VerticalBarChartView.swift
//  ChartsSwiftUI
//
//  Created by rsingh26 on 08/11/21.
//

#if !os(macOS)

import Foundation
import SwiftUI
import Accessibility

// Note: VoiceOver accessibility could use some work here. Because of how the top stack and bottom stack are added independent of one another, it is difficult to group the entire element together. As a work around for now, I am just grouping the labels together without the bar, and adding a button attribute if the bar should be tappable. Ideal state would be that we could group everything for each bar together. Currently, if a bar has labels both above and below it, these are read separately and often out of order.

public struct VerticalBarChartView: View {
    @ObservedObject var viewModel: VerticalBarChartViewModel
    
    private let didTapBar: ((Int, [String: Any]?) -> (Void))?
    
    public init(viewModel: VerticalBarChartViewModel, didTapBar: ((Int, [String: Any]?) -> (Void))? = nil) {
        self.viewModel = viewModel
        self.didTapBar = didTapBar
    }
    
    public var body: some View {
    /// A problem with the latest Xcode 13.2.1 when compiling SwiftUI if-#available structure. When building with Release Mode, the app always crashes on an older system iOS 14. We will look back once it's fixed.
        if #available(iOS 14.0, *) {
            getBarChartOnAndAboveiOS14()
        } else {
            getBarChartBelowiOS14()
        }
        //        if #available(iOS 15.0, *) {
        //            getBarChart()
        //            if let audioGraphsAccessibilityProps = viewModel.audioGraphsAccessibilityProps {
        //                getBarChart()
        //                    .accessibilityElement()
        //                    .accessibilityLabel(audioGraphsAccessibilityProps.graphTitle)
        //                    .accessibilityChartDescriptor(self)
        //            } else {
        //                getBarChart()
        //            }
        //        } else {
        //            getBarChart()
        //        }
    }
    
    
    @available(iOS 14.0, *)
    private func getBarChartOnAndAboveiOS14() -> some View {
        getBarChartBaseView()
            .redactedIfApplicable(dataLoaded: viewModel.dataLoaded)
            .shimmering(active: !viewModel.dataLoaded, duration: 2.0)
    }
    
    private func getBarChartBelowiOS14() -> some View {
        getBarChartBaseView()
            .shimmering(active: !viewModel.dataLoaded, duration: 2.0)
    }
    
    private func getBarChartBaseView() -> some View {
        GeometryReader { proxy in
            ScrollView(viewModel.barChartStyle.scrollViewHorizontalBounce ? .horizontal : [], showsIndicators: false) {
                ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
                    HStack(alignment: .bottom, spacing: 0.0) {
                        VStack(spacing: 0.0) {
                            getTopHorizontalStack()
                            getBottomHorizontalStack()
                        }
                        .padding(.horizontal, viewModel.barChartStyle.barSpacing)
                        
                        /// Adding a fake view in-place to contribute towards seperator height
                        if let seperator: VerticalBarChartView.SeperatorData = viewModel.seperator {
                            Color.clear
                                .frame(width: 1.0, height: (abs(seperator.value * viewModel.barsScaleFactor)) + viewModel.markerSubtitleHeight)
                        }
                        
                        getSeperatorMarkerView()
                    }
                    
                    getXAxisView()
                    getSeperatorView()
                }
                .frame(height: proxy.size.height)
                .frame(minWidth: proxy.size.width)
                .flipHorizontally()
            }
            .flipHorizontally()
        }
    }
    
    private func getTopHorizontalStack() -> some View {
        HStack(alignment: .bottom, spacing: viewModel.barChartStyle.barSpacing) {
            ForEach(viewModel.barEntries.indices, id: \.self) { index in
                let barEntry: BarEntry = viewModel.barEntries[index]
                
                let barBackgroundScaledHeight: CGFloat = barEntry.backgroundValue * viewModel.barsScaleFactor
                
                let barForegroundScaledHeight: CGFloat = barEntry.foregroundValue * viewModel.barsScaleFactor
                
                VStack(spacing: 0.0) {
                    if barBackgroundScaledHeight >= 0, barEntry.xBottomLabel != nil || barEntry.xTopLabel != nil {
                        VStack(spacing: 0) {
                            if let xTopLabel: AttributedString = barEntry.xTopLabel {
                                getBarXLabel(label: xTopLabel, atIndex: .xTopLabel, column: index)
                                Spacer()
                                    .frame(height: viewModel.barChartStyle.xTopLabelSpacing)
                            }
                            if let xBottomLabel: AttributedString = barEntry.xBottomLabel {
                                getBarXLabel(label: xBottomLabel, atIndex: .xBottomLabel, column: index)
                                Spacer()
                                    .frame(height: viewModel.barChartStyle.xBottomLabelSpacing)
                            }
                        }
                        .accessibilityElement(children: .combine)
                        .accessibility(addTraits: didTapBar == nil ? [] : .isButton)
                    }
                    
                    ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
                        if barBackgroundScaledHeight < 0, barEntry.yBottomLabel != nil || barEntry.yTopLabel != nil {
                            VStack(spacing: 0.0) {
                                if let yBottomLabel: AttributedString = barEntry.yBottomLabel {
                                    getBarYLabel(label: yBottomLabel, atIndex: .yBottomLabel, column: index)
                                    Spacer()
                                        .frame(height: viewModel.barChartStyle.yBottomLabelSpacing)
                                }
                                if let yTopLabel: AttributedString = barEntry.yTopLabel {
                                    getBarYLabel(label: yTopLabel, atIndex: .yTopLabel, column: index)
                                    Spacer()
                                        .frame(height: viewModel.barChartStyle.yTopLabelSpacing)
                                }
                            }
                            .accessibilityElement(children: .combine)
                            .accessibility(addTraits: didTapBar == nil ? [] : .isButton)
                        }
                        
                        if barBackgroundScaledHeight >= 0 {
                            BarViewSolid(width: viewModel.barChartStyle.barWidth, height: barBackgroundScaledHeight, fillColor: barEntry.backgroundColor, cornerRadius: viewModel.barChartStyle.barCornerRadius)
                        }
                        
                        if barForegroundScaledHeight >= 0 {
                            BarViewSolid(width: viewModel.barChartStyle.barWidth, height: barForegroundScaledHeight, fillColor: barEntry.foregroundColor, cornerRadius: barForegroundScaledHeight < barBackgroundScaledHeight - viewModel.barChartStyle.barCornerRadius ? 0.0 : viewModel.barChartStyle.barCornerRadius)
                            
                            if barBackgroundScaledHeight >= 0, barForegroundScaledHeight > barBackgroundScaledHeight {
                                Stripes(config: StripesConfig(background: barEntry.dashedBackgroundColor, foreground: barEntry.dashedForegroundColor, cornerRadius: viewModel.barChartStyle.barCornerRadius))
                                    .frame(width: viewModel.barChartStyle.barWidth, height: barForegroundScaledHeight - barBackgroundScaledHeight)
                                    .padding(.bottom, barBackgroundScaledHeight)
                                
                                SeparatorView(separatorColor: barEntry.dashedForegroundColor, strokeStyle: StrokeStyle(lineWidth: 2, dash: [5, 4]))
                                    .frame(width: viewModel.barChartStyle.barWidth, height: 1.0)
                                    .offset(y: -1*barBackgroundScaledHeight)
                            }
                        }
                        
                        if barBackgroundScaledHeight >= 0 {
                            let borderedBarScaledHeight: CGFloat = max(barForegroundScaledHeight, barBackgroundScaledHeight)
                            
                            switch barEntry.border {
                            case .solid(let borderColor):
                                BarViewWithBorder(width: viewModel.barChartStyle.barWidth, height: borderedBarScaledHeight, fillColor: .clear, borderColor: borderColor, borderStyle: .solid, cornerRadius: viewModel.barChartStyle.barCornerRadius)
                                
                            case .dashed(let borderColor):
                                BarViewWithBorder(width: viewModel.barChartStyle.barWidth, height: borderedBarScaledHeight, fillColor: .clear, borderColor: borderColor, borderStyle: .dashed, cornerRadius: viewModel.barChartStyle.barCornerRadius)
                                
                            case .none:
                                EmptyView()
                            }
                        }
                    }
                }
                .frame(width: viewModel.barChartStyle.barWidth)
                .onTapGesture {
                    self.didTapBar?(barEntry.id, nil)
                }
            }
        }
    }
    
    private func getBottomHorizontalStack() -> some View {
        HStack(alignment: .top, spacing: viewModel.barChartStyle.barSpacing) {
            ForEach(viewModel.barEntries.indices, id: \.self) { index in
                let barEntry: BarEntry = viewModel.barEntries[index]
                
                let barBackgroundScaledHeight: CGFloat = barEntry.backgroundValue * viewModel.barsScaleFactor
                
                let barForegroundScaledHeight: CGFloat = barEntry.foregroundValue * viewModel.barsScaleFactor
                
                VStack(spacing: 0.0) {
                    ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
                        if barBackgroundScaledHeight >= 0, barEntry.yBottomLabel != nil || barEntry.yTopLabel != nil {
                            VStack(spacing: 0.0) {
                                if let yTopLabel: AttributedString = barEntry.yTopLabel {
                                    Spacer()
                                        .frame(height: viewModel.barChartStyle.yTopLabelSpacing)
                                    getBarYLabel(label: yTopLabel, atIndex: .yTopLabel, column: index)
                                }
                                if let yBottomLabel: AttributedString = barEntry.yBottomLabel {
                                    Spacer()
                                        .frame(height: viewModel.barChartStyle.yBottomLabelSpacing)
                                    getBarYLabel(label: yBottomLabel, atIndex: .yBottomLabel, column: index)
                                }
                            }
                            .accessibilityElement(children: .combine)
                            .accessibility(addTraits: didTapBar == nil ? [] : .isButton)
                        }
                        
                        if barBackgroundScaledHeight < 0 {
                            BarViewSolid(width: viewModel.barChartStyle.barWidth, height: -1*barBackgroundScaledHeight, fillColor: barEntry.backgroundColor, cornerRadius: viewModel.barChartStyle.barCornerRadius, corners: [.bottomLeft, .bottomRight])
                        }
                        
                        if barForegroundScaledHeight < 0 {
                            BarViewSolid(width: viewModel.barChartStyle.barWidth, height: -1*barForegroundScaledHeight, fillColor: barEntry.foregroundColor, cornerRadius: barForegroundScaledHeight <= barBackgroundScaledHeight + viewModel.barChartStyle.barCornerRadius ? viewModel.barChartStyle.barCornerRadius : 0.0, corners: [.bottomLeft, .bottomRight])
                            
                            if barBackgroundScaledHeight < 0, barForegroundScaledHeight < barBackgroundScaledHeight {
                                Stripes(config: StripesConfig(background: barEntry.dashedBackgroundColor, foreground: barEntry.dashedForegroundColor, cornerRadius: viewModel.barChartStyle.barCornerRadius, corners: [.bottomLeft, .bottomRight]))
                                    .frame(width: viewModel.barChartStyle.barWidth, height: -1 * (barForegroundScaledHeight - barBackgroundScaledHeight))
                                    .padding(.top, -1*barBackgroundScaledHeight)
                                
                                SeparatorView(separatorColor: barEntry.dashedForegroundColor, strokeStyle: StrokeStyle(lineWidth: 1, dash: [3, 3]))
                                    .frame(width: viewModel.barChartStyle.barWidth, height: 0.5)
                                    .offset(y: -1*barBackgroundScaledHeight)
                            }
                        }
                        
                        if barBackgroundScaledHeight < 0 {
                            let borderedBarScaledHeight: CGFloat = min(barForegroundScaledHeight, barBackgroundScaledHeight)
                            
                            switch barEntry.border {
                            case .solid(let borderColor):
                                BarViewWithBorder(width: viewModel.barChartStyle.barWidth, height: -1*borderedBarScaledHeight, fillColor: .clear, borderColor: borderColor, borderStyle: .solid, cornerRadius: viewModel.barChartStyle.barCornerRadius, corners: [.bottomLeft, .bottomRight])
                                
                            case .dashed(let borderColor):
                                BarViewWithBorder(width: viewModel.barChartStyle.barWidth, height: -1*borderedBarScaledHeight, fillColor: .clear, borderColor: borderColor, borderStyle: .dashed, cornerRadius: viewModel.barChartStyle.barCornerRadius, corners: [.bottomLeft, .bottomRight])
                                
                            case .none:
                                EmptyView()
                            }
                        }
                    }
                    
                    if barBackgroundScaledHeight < 0, barEntry.xBottomLabel != nil || barEntry.xTopLabel != nil {
                        VStack(spacing: 0) {
                            if let xBottomLabel: AttributedString = barEntry.xBottomLabel {
                                Spacer()
                                    .frame(height: viewModel.barChartStyle.xBottomLabelSpacing)
                                getBarXLabel(label: xBottomLabel, atIndex: .xBottomLabel, column: index)
                            }
                            if let xTopLabel: AttributedString = barEntry.xTopLabel {
                                Spacer()
                                    .frame(height: viewModel.barChartStyle.xTopLabelSpacing)
                                getBarXLabel(label: xTopLabel, atIndex: .xTopLabel, column: index)
                            }
                        }
                        .accessibilityElement(children: .combine)
                        .accessibility(addTraits: didTapBar == nil ? [] : .isButton)
                    }
                }
                .frame(width: viewModel.barChartStyle.barWidth)
                .onTapGesture {
                    self.didTapBar?(barEntry.id, nil)
                }
            }
        }
    }
    
    private func getXAxisView() -> some View {
        SeparatorView(strokeStyle: StrokeStyle())
            .frame(height: 1.0)
            .offset(y: -1*viewModel.xAxisPosition)
            .opacity(viewModel.barChartStyle.showXAxis ? 1.0 : 0.0)
    }
    
    private func getSeperatorView() -> AnyView {
        guard let seperator: VerticalBarChartView.SeperatorData = viewModel.seperator else {
            return AnyView(EmptyView())
        }
        return AnyView(SeparatorView(separatorColor: seperator.separatorColor)
                        .frame(height: 1.0)
                        .offset(y: -1*viewModel.seperatorPosition))
    }
    
    private func getSeperatorMarkerView() -> AnyView {
        guard let seperator: VerticalBarChartView.SeperatorData = viewModel.seperator else {
            return AnyView(EmptyView())
        }
        return AnyView(
            HStack(spacing: 0.0) {
                Spacer()
                    .frame(width: viewModel.barChartStyle.barSpacing)
                VStack(spacing: 0.0) {
                    getSeperatorMarkerTitle(label: seperator.title)
                    getSeperatorMarkerSubtitle(label: seperator.subtitle)
                }
                .offset(y: -1*viewModel.seperatorPosition + viewModel.markerSubtitleHeight)
                .padding(.trailing)
                .accessibilityElement(children: .combine)
            }
        )
    }
}

extension VerticalBarChartView {
    private func getBarXLabel(label: VerticalBarChartView.AttributedString, atIndex index: VerticalBarChartViewModel.XAxisLabels, column: Int) -> some View {
        Text(label.text)
            .foregroundColor(label.color)
            .lineLimit(1)
            .minimumScaleFactor(0.80)
            .font(Font(label.uiFont))
            .heightPreference()
            .frame(width: viewModel.barChartStyle.barWidth, alignment: label.alignment)
            .background(Color.clear)
            .onPreferenceChange(VerticalHeightPreference.self) { newValue in
                viewModel.updateXLabelsMaxHeight(to: newValue.values.first!, atIndex: index)
            }
            .accessibility(label: Text(label.accessibilityLabel))
    }
    
    private func getBarYLabel(label: VerticalBarChartView.AttributedString, atIndex index: VerticalBarChartViewModel.YAxisLabels, column: Int) -> some View {
        Text(label.text)
            .foregroundColor(label.color)
            .lineLimit(1)
            .minimumScaleFactor(0.80)
            .font(Font(label.uiFont))
            .heightPreference()
            .frame(width: viewModel.barChartStyle.barWidth, alignment: label.alignment)
            .background(Color.clear)
            .onPreferenceChange(VerticalHeightPreference.self) { newValue in
                viewModel.updateYLabelsMaxHeight(to: newValue.values.first!, atIndex: index)
            }
            .accessibility(label: Text(label.accessibilityLabel))
    }
    
    private func getSeperatorMarkerTitle(label: VerticalBarChartView.AttributedString) -> some View {
        Text(label.text)
            .foregroundColor(label.color)
            .lineLimit(1)
            .minimumScaleFactor(0.80)
            .font(Font(label.uiFont))
            .heightPreference()
            .frame(alignment: label.alignment)
            .background(Color.clear)
            .onPreferenceChange(VerticalHeightPreference.self) { newValue in
                viewModel.updateMarkerTitleHeight(to: newValue.values.first!)
            }
            .accessibility(label: Text(label.accessibilityLabel))
    }
    
    private func getSeperatorMarkerSubtitle(label: VerticalBarChartView.AttributedString) -> some View {
        Text(label.text)
            .foregroundColor(label.color)
            .lineLimit(1)
            .minimumScaleFactor(0.80)
            .font(Font(label.uiFont))
            .heightPreference()
            .frame(alignment: label.alignment)
            .background(Color.clear)
            .onPreferenceChange(VerticalHeightPreference.self) { newValue in
                viewModel.updateMarkerSubtitleHeight(to: newValue.values.first!)
            }
            .accessibility(label: Text(label.accessibilityLabel))
    }
}

@available(iOS 15.0, *)
extension VerticalBarChartView: AXChartDescriptorRepresentable {
    public func makeChartDescriptor() -> AXChartDescriptor {
        guard let audioGraphsAccessibilityProps = viewModel.audioGraphsAccessibilityProps else {
            /// This function won't be invoked when audioGraphsAccessibilityProps are not set by the consumer. In this case, it means that audio graph is not enabled by the consumer.
            return AXChartDescriptor(attributedTitle: nil, summary: nil, xAxis: AXCategoricalDataAxisDescriptor(title: "", categoryOrder: []), additionalAxes: [], series: [])
        }
        
        let xAxis = AXCategoricalDataAxisDescriptor(
            title: audioGraphsAccessibilityProps.xAxisTitle,
            categoryOrder: viewModel.barEntries.map { ($0.xTopLabel?.text ?? "") + " " + ($0.xBottomLabel?.text ?? "") }
        )
        
        let min = viewModel.barEntries.map(\.backgroundValue).min() ?? 0.0
        let max = viewModel.barEntries.map(\.backgroundValue).max() ?? 0.0

        let yAxis = AXNumericDataAxisDescriptor(
            title: audioGraphsAccessibilityProps.yAxisTitle,
            range: min...max,
            gridlinePositions: []
        ) { value in "\(value)" }
        
        let dataPoints: [AXDataPoint] = viewModel.barEntries.map {
            AXDataPoint(x: ($0.xTopLabel?.text ?? "") + " " + ($0.xBottomLabel?.text ?? ""), y: $0.backgroundValue)
        }
         
        let series = AXDataSeriesDescriptor(
            name: "",
            isContinuous: false,
            dataPoints: dataPoints
        )

        return AXChartDescriptor(
            title: audioGraphsAccessibilityProps.graphTitle,
            summary: nil,
            xAxis: xAxis,
            yAxis: yAxis,
            additionalAxes: [],
            series: [series]
        )
    }
}

#endif
