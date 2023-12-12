//
//  SSExpandableSwipeUpView.swift
//  SSExpandableSwipeUpView
//
//  Created by Darshan Gujarati on 18/12/23.
//

import SwiftUI

struct SSExpandableSwipeUpView: View {
    @StateObject var viewModel: SectionContentsViewModel
    var constants: CustomConstants

    var body: some View {
        ScrollView {
            // Spacer for starting content from bottom
            Spacer(minLength: UIScreen.main.bounds.height - 120)
            // Content counter
            ContentCountView(viewModel: viewModel, constants: constants)
            // Show content list if content is not empty
            if !$viewModel.sectionContents.isEmpty {
                ContentListView(viewModel: viewModel, constants: constants)
            }
        }
        // Background image as a wallpaper
        .background(
            Image("wallpaper")
                .frame(maxWidth: UIScreen.main.bounds.width))
        .scrollIndicators(.hidden)
    }
}

#Preview {
    SSExpandableSwipeUpView(viewModel: SectionContentsViewModel(), constants: CustomConstants())
}
