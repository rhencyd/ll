//
//  TabBarItemsPreferenceKey.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/8/23.
//

import Foundation

import SwiftUI

struct TabBarItemsPreferenceKey: PreferenceKey {
    static var defaultValue: [TabBarITem] = []
    
    static func reduce(value: inout [TabBarITem], nextValue: () -> [TabBarITem]) {
        value += nextValue()
    }
}


struct TabBarItemViewModifier: ViewModifier {
    
    let tab: TabBarITem
    @Binding var selection: TabBarITem
    
    func body(content: Content) -> some View {
        content
            .opacity(selection == tab ? 1.0 : 0.0)
            .preference(key: TabBarItemsPreferenceKey.self, value: [tab])
    }
}

extension View {
    func tabBarItem(tab: TabBarITem, selection: Binding<TabBarITem>) -> some View {
        modifier(TabBarItemViewModifier(tab: tab, selection: selection))
    }
}
