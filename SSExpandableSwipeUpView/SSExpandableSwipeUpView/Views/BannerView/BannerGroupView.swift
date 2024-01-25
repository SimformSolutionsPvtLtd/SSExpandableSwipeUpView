//
//  BannerGroupView.swift
//  SSExpandableSwipeUpView
//
//  Created by Darshan Gujarati on 15/12/23.
//

import SwiftUI

struct BannerGroupView: View {
    
    @Binding var sectionContent: SectionContent
    var constants: CustomConstants

    var body: some View {
        if sectionContent.isSectionExpanded {
            // Used Vstack if section is expanded
            VStack(spacing: constants.expandSectionLineSpacing) {
                ForEach(0..<$sectionContent.swipeViewContents.count, id: \.self) { index in
                    VStack {
                        // Banner View
                        // Swipe actions enabled while section is expanded
                        BannerView(swipeViewContent: $sectionContent.swipeViewContents[index], isSectionExpanded: $sectionContent.isSectionExpanded, constants: constants)
                    }
                }
            }
        } else {
            // Used Zstack while section is collapsed to show all others behind first effect
            // Managed with spacer at bottom to make this effect
            ZStack(alignment: .top) {
                ForEach(0..<$sectionContent.swipeViewContents.count, id: \.self) { index in
                    VStack {
                        BannerView(swipeViewContent: $sectionContent.swipeViewContents[index], isSectionExpanded: $sectionContent.isSectionExpanded, constants: constants)
                            .onTapGesture {
                                withAnimation {
                                    sectionContent.isSectionExpanded.toggle()
                                }
                            }
                            .zIndex(Double(index))
                        Spacer(minLength: CGFloat(index) * constants.collapsedGroupRowOffset)
                    }
                }
            }
        }
    }
}

struct BannerGroupView_Previews: PreviewProvider {
    @State static var viewModel = SectionContentsViewModel()

    static var previews: some View {
        BannerGroupView(sectionContent: $viewModel.sectionContents.first!, constants: CustomConstants())
            .padding()
            .background(.black)

    }
}
