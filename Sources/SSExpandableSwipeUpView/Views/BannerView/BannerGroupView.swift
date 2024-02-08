//
//  BannerGroupView.swift
//  SSExpandableSwipeUpView
//
//  Created by Darshan Gujarati on 15/12/23.
//

import SwiftUI

struct BannerGroupView: View {
    @Binding var sectionContent: SectionContent
    @EnvironmentObject var viewModel: SectionContentsViewModel
    @Binding var activeBanner: SwipeViewContent?
    var onOptions: (SwipeViewContent) -> Void

    var body: some View {
        Group {
            if sectionContent.isSectionExpanded {
                expandedView
            } else {
                collapsedView
                    .onTapGesture {
                        withAnimation {
                            sectionContent.isSectionExpanded.toggle()
                        }
                    }
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
                    BannerViewRow(index: (sectionContent.swipeViewContents.count - 1) - index)
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
                isSectionExpanded: $sectionContent.isSectionExpanded, activeBanner: $activeBanner, onDelete: { deletedSwipeViewContent in
                    withAnimation {
                        handleBannerDeletion(deletedSwipeViewContent: deletedSwipeViewContent)
                    }
                }, onOptions: { swipeViewContent in
                    onOptions(swipeViewContent)
                }, index: index
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
        BannerGroupView(sectionContent: $viewModel.sectionContents.first!, activeBanner: .constant(nil), onOptions: {_ in })
            .padding()
            .background(Color.black)
    }
}
