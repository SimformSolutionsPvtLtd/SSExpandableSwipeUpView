//
//  SectionHeaderView.swift
//  SSExpandableSwipeUpView
//
//  Created by Darshan Gujarati on 15/12/23.
//

import SwiftUI

struct SectionHeaderView: View {
    @Binding var sectionContent: SectionContent
    @StateObject var viewModel: SectionContentsViewModel
    var constants: CustomConstants

    var body: some View {
        HStack {
            // Title of the section
            Text(sectionContent.sectionTitle)
                .padding(5)
                .foregroundColor(Color("white"))
                .fontWeight(.semibold)
                .font(.title)
            Spacer()
                .onTapGesture {
                    withAnimation {
                        viewModel.toggleSectionExpansion(for: sectionContent)
                    }
                }
            // Expand/Remove button
            // Sets using isSectionExpanded
            Button(action: {
                if (sectionContent.swipeViewContents.count < 2) || sectionContent.isSectionExpanded {
                    withAnimation {
                        viewModel.removeSection(for: sectionContent)
                    }
                } else {
                    withAnimation {
                        viewModel.toggleSectionExpansion(for: sectionContent)
                    }
                }
            }) {
                if !$viewModel.sectionContents.isEmpty {
                    ExpandButtonView(sectionContent: $viewModel.sectionContents[viewModel.getIndexOfSection(for: sectionContent)])
                }
            }
        }
        .frame(height: constants.sectionTitleHeight)
    }
}

// Expand/Remove button image
// Sets button's image using isSectionExpanded
// If number of banners is 1, no expansion needed
struct ExpandButtonView: View {
    @Binding var sectionContent: SectionContent
    var constants = CustomConstants()

    var body: some View {
        Image(sectionContent.swipeViewContents.count > 1 ? (sectionContent.isSectionExpanded ? "close" : "dropDown") : "close")
            .frame(width: constants.sectionTitleHeight, height: constants.sectionTitleHeight)
            .foregroundColor(Color("white"))
            .padding(5)
    }
}
