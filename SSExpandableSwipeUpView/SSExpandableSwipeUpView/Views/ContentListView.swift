//
//  ContentListView.swift
//  SSExpandableSwipeUpView
//
//  Created by Darshan Gujarati on 07/12/23.
//

import SwiftUI

// View combining Section's header and list of banners
struct ContentListView: View {
    @StateObject var viewModel: SectionContentsViewModel
    var constants: CustomConstants

    var body: some View {
        VStack {
            ForEach(viewModel.sectionContents) { sectionContent in
                VStack {
                    // Section header view with title and Expand/Remove button
                    SectionHeaderView(sectionContent: $viewModel.sectionContents[viewModel.getIndexOfSection(for: sectionContent)], viewModel: viewModel, constants: constants)
                    // Banner list view
                    // Manages the expansion and collaps using index of content
                    BannerGroupView(sectionContent: $viewModel.sectionContents[viewModel.getIndexOfSection(for: sectionContent)], constants: constants)
                        .animation(.easeIn, value: sectionContent.isSectionExpanded)
                }
                .onTapGesture {
                    withAnimation {
                        // Toggles section expansion/collaps on tap of section
                        viewModel.toggleSectionExpansion(for: sectionContent)
                    }
                }
                .background(.clear)
                .padding()
            }
        }
    }
}

struct ContentListView_Previews: PreviewProvider {
    static var previews: some View {
        ContentListView(viewModel: SectionContentsViewModel(), constants: CustomConstants())
            .background(Color("black"))
    }
}
