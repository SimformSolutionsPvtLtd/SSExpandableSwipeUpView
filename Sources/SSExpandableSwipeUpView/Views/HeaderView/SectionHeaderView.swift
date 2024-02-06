//
//  SectionHeaderView.swift
//  SSExpandableSwipeUpView
//
//  Created by Darshan Gujarati on 15/12/23.
//

import SwiftUI

struct SectionHeaderView: View {
    @Binding var sectionContent: SectionContent
    @EnvironmentObject var viewModel: SectionContentsViewModel

    var body: some View {
        HStack {
            // Title of the section
            Text(sectionContent.sectionTitle)
                .padding(5)
                .customFont(name: sectionContent.titleFontStyle.font, size: sectionContent.titleFontStyle.size ?? 30, color: sectionContent.titleFontStyle.color ?? Color("white", bundle: .module))
                .fontWeight(.semibold)
            Spacer()
                .onTapGesture {
                    withAnimation {
                        viewModel.toggleSectionExpansion(for: sectionContent)
                    }
                }

            // Collapse button
            // Visible only when the group is expanded i.e isSectionExpanded is true
            if sectionContent.isSectionExpanded {
                Button(action: {
                    withAnimation {
                        viewModel.toggleSectionExpansion(for: sectionContent)
                    }
                }) {
                    HStack {
                        Image(systemName: "chevron.down")
                            .frame(width: AppConstants.sectionTitleHeight - 30, height: AppConstants.sectionTitleHeight)
                            .symbolRenderingMode(.hierarchical)
                            .foregroundStyle(Color("black", bundle: .module))
                            .padding(5)
                        Text("Show less")
                            .font(.system(size: 14))
                            .foregroundColor(Color("black", bundle: .module))
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                .background(Color("grayBackground", bundle: .module).opacity(AppConstants.bannerOpacity))
                .cornerRadius(.infinity)
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
                    ExpandButtonView(sectionContent: viewModel.sectionContents[viewModel.getIndexOfSection(for: sectionContent)])
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width - 20, height: AppConstants.sectionTitleHeight)
    }
}

// Expand/Remove button image
// Sets button's image using isSectionExpanded
// If number of banners is 1, no expansion needed
struct ExpandButtonView: View {
    var sectionContent: SectionContent

    var body: some View {
        Image(systemName: sectionContent.isSectionExpanded ? "xmark.circle" : "chevron.down")
            .frame(width: AppConstants.sectionTitleHeight, height: AppConstants.sectionTitleHeight)
            .foregroundStyle(Color("white", bundle: .module))
            .padding(5)
    }
}
