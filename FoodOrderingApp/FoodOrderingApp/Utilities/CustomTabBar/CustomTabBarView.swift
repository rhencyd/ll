//
//  CustomTabBarView.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/8/23.
//

import SwiftUI

struct CustomTabBarView: View {
    
    let tabs: [TabBarITem]
    @Binding var selection: TabBarITem
    @Namespace private var namespace
    
    var body: some View {
        tabBarVersion2
    }
}

struct CustomTabBarView_Previews: PreviewProvider {
    
    static let tabs: [TabBarITem] = [
        TabBarITem(title: "sing in"),
        TabBarITem(title: "sing up")
    ]
    
    static var previews: some View {
        VStack {
            CustomTabBarView(tabs: tabs, selection: .constant(tabs.first ?? TabBarITem(title: "sing in")))
            Spacer()
        }
    }
}


extension CustomTabBarView {
    
    private func tabView(tab: TabBarITem) -> some View {
        VStack {
            Text(tab.title.uppercased())
                .font(Font.custom("Karla-ExtraBold", size: 20))
            Rectangle()
                .frame(width: 100 ,height: 2)
                .opacity(selection == tab ? 1 : 0.0)
        }
        .foregroundColor(selection == tab ? .black : .gray.opacity(0.5))
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
    }
    
    private var tabBarVersion1: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                tabView(tab: tab)
                    .onTapGesture {
                        switchTotab(tab: tab)
                    }
            }
        }
        .padding(6)
        .background(Color.white)
    }
    
    private func switchTotab(tab: TabBarITem) {
        withAnimation(.easeInOut) {
            selection = tab
        }
    }
}


struct TabBarITem: Hashable {
    let title: String
}

extension CustomTabBarView {
    
    private func tabView2(tab: TabBarITem) -> some View {
        VStack {
            Text(tab.title.uppercased())
                .font(Font.custom("Karla-ExtraBold", size: 20))
            if selection == tab {
                Rectangle()
                    .frame(width: 100 ,height: 2)
                    .matchedGeometryEffect(id: "line_transition", in: namespace)
            }
        }
        .foregroundColor(selection == tab ? .black : .gray.opacity(0.5))
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
    }
    
    private var tabBarVersion2: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                tabView2(tab: tab)
                    .onTapGesture {
                        switchTotab(tab: tab)
                    }
            }
        }
        .padding(6)
        .background(Color.white)
    }
}
