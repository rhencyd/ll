//
//  IntroView.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/14/23.
//

import SwiftUI

struct IntroView: View {
    
    @AppStorage("signed_in") var isCurrentUserSignedIn: Bool = false
    @StateObject var navigationStateManager = NavigationStateManager()
    @StateObject var vm = DownloadingDishesViewModel()
    @StateObject var contentViewModel: ContentViewModel = ContentViewModel()
    
    
    var body: some View {
        
        NavigationStack(path: $navigationStateManager.selectionPath) {
            
                if isCurrentUserSignedIn {
                    Home()

                } else if !isCurrentUserSignedIn && navigationStateManager.guestModeOn {
                    Home()
                    
                } else {
                    Welcome()
                }
        }
        .preferredColorScheme(.light)
        .environmentObject(navigationStateManager)
        .environmentObject(contentViewModel)
    }
    
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
