//
//  ContentListView.swift
//  SSExpandableSwipeUpView
//
//  Created by Darshan Gujarati on 07/12/23.
//

import SwiftUI

// View combining Section's header and list of banners
struct ContentListView: View {
    @EnvironmentObject var viewModel: SectionContentsViewModel
    @Binding var activeBanner: SwipeViewContent?
    var onOptions: (SwipeViewContent) -> Void

    var body: some View {
        VStack {
            ForEach(viewModel.sectionContents) { sectionContent in
                VStack {
                    // Section header view with title and Expand/Remove button
                    SectionHeaderView(sectionContent: $viewModel.sectionContents[viewModel.getIndexOfSection(for: sectionContent)])
                    // Banner list view
                    // Manages the expansion and collapse using index of content
                    BannerGroupView(sectionContent: $viewModel.sectionContents[viewModel.getIndexOfSection(for: sectionContent)], activeBanner: $activeBanner){ swipeViewContent in
                        onOptions(swipeViewContent)
                    }
                        .animation(.easeIn, value: sectionContent.isSectionExpanded)
                }
                .onTapGesture {
                    withAnimation {
                        // Toggles section expansion/collapse on tap of section
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
        ContentListView(activeBanner: .constant(nil), onOptions: {_ in})
            .background(Color("black", bundle: .module))
    }
}
