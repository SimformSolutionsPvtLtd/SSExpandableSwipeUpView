//
//  BannerGroupView.swift
//  SSExpandableSwipeUpView
//
//  Created by Darshan Gujarati on 15/12/23.
//

import SwiftUI

struct BannerGroupView: View {
    @Binding var sectionContent: SectionContent
    @StateObject var viewModel: SectionContentsViewModel
    @Binding var activeBanner: SwipeViewContent?

    var body: some View {
        Group {
            if sectionContent.isSectionExpanded {
                expandedView
            } else {
                collapsedView
            }
        }
    }

    private var expandedView: some View {
        VStack(spacing: AppConstants.expandSectionLineSpacing) {
            ForEach(sectionContent.swipeViewContents.indices, id: \.self) { index in
                BannerViewRow(index: index)
            }
        }
    }

    private var collapsedView: some View {
        ZStack(alignment: .top) {
            ForEach(sectionContent.swipeViewContents.indices, id: \.self) { index in
                VStack {
                    BannerViewRow(index: index).allowsHitTesting(index == sectionContent.swipeViewContents.count - 1 ? true : false)
                        .zIndex(Double(index))
                        Spacer(minLength: CGFloat(index) * AppConstants.collapsedGroupRowOffset)
                }
            }
        }
    }

    private func BannerViewRow(index: Int) -> some View {
        VStack {
            BannerView(
                swipeViewContent: $sectionContent.swipeViewContents[index],
                isSectionExpanded: $sectionContent.isSectionExpanded,
                onDelete: { deletedSwipeViewContent in
                    withAnimation {
                        handleBannerDeletion(deletedSwipeViewContent: deletedSwipeViewContent)
                    }
                }, activeBanner: $activeBanner
            )
        }
    }

    private func handleBannerDeletion(deletedSwipeViewContent: SwipeViewContent) {
        if let index = sectionContent.swipeViewContents.firstIndex(of: deletedSwipeViewContent) {
            sectionContent.swipeViewContents.remove(at: index)
            if sectionContent.swipeViewContents.isEmpty {
                viewModel.removeSection(for: sectionContent)
            }
        }
    }
}

struct BannerGroupView_Previews: PreviewProvider {
    @State static var viewModel = SectionContentsViewModel()

    static var previews: some View {
        BannerGroupView(sectionContent: $viewModel.sectionContents.first!, viewModel: viewModel, activeBanner: .constant(nil))
            .padding()
            .background(Color.black)
    }
}
