//
//  GraphExamples.swift
//  ChartsSwiftUI_Example
//
//  Created by rsingh26 on 09/11/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import SwiftUI

internal struct RowItem: Hashable {
    let displayName: String
    let detailView: AnyView
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(displayName)
    }
    
    static func == (lhs: RowItem, rhs: RowItem) -> Bool {
        lhs.displayName == rhs.displayName
    }
}

internal enum Graphs: Hashable, Identifiable, CaseIterable {
    case verticalBarChart
    
    var id : String { UUID().uuidString }

    var displayName: String {
        switch self {
        case .verticalBarChart:
            return "Vertical Bar Chart"
        }
    }
    
    var rowItems: [RowItem] {
        switch self {
        case .verticalBarChart:
            let mocks: [VerticalBarChartHelper.Mock] = VerticalBarChartHelper.getMocks()
            
            let rowItems: [RowItem] = mocks.map { mock in
                RowItem(displayName: mock.displayName, detailView: AnyView(VerticalBarChartExampleView(viewModel: VerticalBarChartExampleViewModel(loading: mock.loading, loaded: mock.loaded, seperator: mock.seperator))))
            }
            
            return rowItems            
        }
    }
}
