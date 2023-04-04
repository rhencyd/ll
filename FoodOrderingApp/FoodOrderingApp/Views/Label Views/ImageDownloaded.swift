//
//  ImageDownloaded.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/18/23.
//

import SwiftUI

struct ImageDownloaded: View {
    
    @StateObject var loader: ImageDownloadedViewModel
    
    init (url: String, key: String) {
        _loader = StateObject(wrappedValue: ImageDownloadedViewModel(url: url, key: key))
    }
    
    
    var body: some View {
        ZStack {
            if loader.isLoading {
                ProgressView()
            } else if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
            }
        }
    }
}

struct ImageDownloaded_Previews: PreviewProvider {
    static var previews: some View {
        ImageDownloaded(url: "https://github.com/Meta-Mobile-Developer-PC/Working-With-Data-API/blob/main/images/greekSalad.jpg?raw=true", key: "1")
            .previewLayout(.sizeThatFits)
    }
}
