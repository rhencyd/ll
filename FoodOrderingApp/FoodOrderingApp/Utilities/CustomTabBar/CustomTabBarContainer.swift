//
//  CustomTabBarContainer.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/8/23.
//

import SwiftUI


struct CustomTabBarContainer<Content:View>: View {
    
    @Binding var selection: TabBarITem
    @State private var tabs: [TabBarITem] = []
    
    let content: Content
    
    init (selection: Binding<TabBarITem>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            CustomTabBarView(tabs: tabs, selection: $selection)
            ZStack {
                content
            }
            
        }.onPreferenceChange(TabBarItemsPreferenceKey.self) { value in
            self.tabs = value
        }
    }
}

struct CustomTabBarContainer_Previews: PreviewProvider {
    
    static let tabs: [TabBarITem] = [
        TabBarITem(title: "sing in"),
        TabBarITem(title: "sing up")
    ]
    
    static var previews: some View {
        CustomTabBarContainer(selection: .constant(tabs.first!)) {
            Color.red
        }
    }
}
