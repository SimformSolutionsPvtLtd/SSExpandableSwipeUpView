//
//  ContentCountView.swift
//  SSExpandableSwipeUpView
//
//  Created by Darshan Gujarati on 15/12/23.
//

import SwiftUI

// Sections count view
// Shows number of sections available in current list
// While removing any section from the list, will update the count
struct ContentCountView: View {
    @EnvironmentObject var viewModel: SectionContentsViewModel

    var body: some View {
        VStack {
            Text("• \($viewModel.sectionContents.count) Notifications")
                .foregroundColor(Color("black", bundle: .main))
                .fontWeight(.bold)
        }
        .padding(10)
        .background(Color("grayBackground", bundle: .main).opacity(AppConstants.bannerOpacity))
        .cornerRadius(AppConstants.bannerCornerRadius)
    }
}

#Preview {
    ContentCountView()
}
