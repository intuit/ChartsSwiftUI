//
//  ContentView.swift
//  ChartsSwiftUI_Example
//
//  Created by rsingh26 on 08/11/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import SwiftUI
import ChartsSwiftUI

internal struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(Graphs.allCases) { graph in
                    Section(header: Text(graph.displayName)) {
                        ForEach(graph.rowItems, id: \.self) { row in
                            NavigationLink {
                                NavigationLazyView(row.detailView)
                            } label: {
                                Text(row.displayName)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Charts SwiftUI")
            .navigationBarTitleDisplayMode(.inline)
        }
        .listStyle(InsetGroupedListStyle())
    }
}
