//
//  ChartsSwiftUI_ExampleUITests.swift
//  ChartsSwiftUI_ExampleUITests
//

import XCTest
import SnapshotTesting
import ChartsSwiftUI
import SwiftUI

internal class ChartsSwiftUI_ExampleUITests: XCTestCase {
    func testVerticalBarChartView() {
        let devices: [String:ViewImageConfig] = SnapshotTestsHelper.getDevicesList()
        
        let mocks: [VerticalBarChartHelper.Mock] = VerticalBarChartHelper.getMocks()
        
        for (idx, mock) in mocks.enumerated() {
            let viewController: UIViewController = VerticalBarChartExampleView(viewModel: VerticalBarChartExampleViewModel(loading: mock.loading, loaded: mock.loaded, seperator: mock.seperator)).toVC()
            
            for device in devices {
                assertSnapshot(matching: viewController,
                               as: .image(on: device.value),
                               named: "\(idx).Loading.\(device.key)")
            }
            
            let expectation: XCTestExpectation = self.expectation(description: "")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                for device in devices {
                    assertSnapshot(matching: viewController, as: .image(on: device.value), named: "\(idx).Loaded.\(device.key)")
                }
                expectation.fulfill()
            }
            
            waitForExpectations(timeout: 5.0, handler: nil)
        }
    }
}
