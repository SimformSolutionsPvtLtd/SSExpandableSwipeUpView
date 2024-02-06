//
//  BannerView.swift
//  SSExpandableSwipeUpView
//
//  Created by Darshan Gujarati on 06/12/23.
//

import SwiftUI

struct BannerView: View {
    @Binding var swipeViewContent: SwipeViewContent
    @Binding var isSectionExpanded: Bool
    @State var swipeButtonWidth: CGFloat = 0
    @Binding var activeBanner: SwipeViewContent?
    @State var isFullSwipe: Bool = false
    var onDelete: (SwipeViewContent) -> Void
    var onOptions: (SwipeViewContent) -> Void

    let index: Int

    var body: some View {
        // Zstack to show the banner while swipping outside of container
        // Contatins Banner Zstack and swipe action Zstack
        // While swipping banner Zstack changes the position and Swipe action Zstack comes in to the action
        ZStack(alignment: .trailing) {
            // Banner View
            ZStack(alignment: .leading) {
                // Banner Background View
                // For color and blur effect
                Rectangle()
                    .foregroundColor(Color("grayBackground", bundle: .module).opacity(AppConstants.bannerOpacity))
                    .blur(radius: 1, opaque: false)
                    .cornerRadius(AppConstants.bannerCornerRadius)
                    .shadow(color: .black.opacity(AppConstants.bannerOpacity), radius: 4)

                // Banner Content View
                // Contains banner image, title and description
                // Resizes as per the size of content
                HStack(spacing: 10) {
                    // Banner content image
                    Image(uiImage: (UIImage(named: swipeViewContent.appImageName) ?? UIImage(named: "no_image", in: .module, with: nil))!)
                    .resizable()
                    .frame(width: 60, height: 60)
                    // Banner text content
                    VStack(alignment: .leading, spacing: 4) {
                        // Banner Title
                        Text(swipeViewContent.title)
                            .customFont(name: swipeViewContent.titleFontStyle.font, size: swipeViewContent.titleFontStyle.size ?? 20, color: swipeViewContent.titleFontStyle.color ?? Color("black", bundle: .module).opacity(AppConstants.bannerOpacity))
                            .bold()
                        // Banner Description
                        Text(swipeViewContent.subtitle)
                            .customFont(name: swipeViewContent.subtitleFontStyle.font, size: swipeViewContent.subtitleFontStyle.size ?? 16, color: swipeViewContent.subtitleFontStyle.color ?? Color("black", bundle: .module).opacity(AppConstants.bannerOpacity))
                            .multilineTextAlignment(.leading)
                    }
                }
                .padding()
            }
            // Sets banner's X offset while swipping right to left
            .offset(x: activeBanner == swipeViewContent ? swipeButtonWidth : 0)
            .onTapGesture {
                withAnimation {
                    // perform action while no swipe action triggered
                    // Currently no action added
                    // Can update as per the requirement
                    if swipeButtonWidth == 0 {
                        isSectionExpanded.toggle()
                    }
                    swipeButtonWidth = 0
                }
            }
            // Swipe Action View
            HStack {
                createRectangleWithOverlay(text: "Options") {
                    onOptions(swipeViewContent)
                }
                ZStack {
                    createRectangleWithOverlay(text: "Remove") {
                        withAnimation {
                            onDelete(swipeViewContent)
                            swipeButtonWidth = 0
                        }
                    }
                }
                .frame(width: isFullSwipe ? max(-swipeButtonWidth - 10, 0) : nil)
            }
            .opacity(swipeButtonWidth < 0 ? 1.0 : 0.0)
            .animation(.easeInOut, value: swipeButtonWidth)
            .frame(width: activeBanner == swipeViewContent ? max(-swipeButtonWidth - 10, 0) : 0)
        }

        .gesture(
            DragGesture()
                .onChanged { value in
                    if (!isSectionExpanded && index == 0) || isSectionExpanded {
                        let translation = value.translation.width
                        if translation < 0 && abs(translation) > (UIScreen.main.bounds.width / 2) {
                            // Full swipe action to the left
                            withAnimation {
                                isFullSwipe = true
                                swipeButtonWidth = -UIScreen.main.bounds.width + 10
                            }

                        } else if abs(value.translation.width) > CGFloat(20) {
                            // Partial swipe action
                            withAnimation {
                                swipeButtonWidth = value.translation.width > 0 ? 0 : -190
                                activeBanner = swipeViewContent
                                isFullSwipe = false
                            }
                        } else {
                            // Reset to default position
                            withAnimation {
                                swipeButtonWidth = 0
                                isFullSwipe = false
                            }
                        }
                    }
                }
                .onEnded({ value in
                    if (!isSectionExpanded && index == 0) || isSectionExpanded {
                        let translation = value.translation.width
                        if translation < 0 && abs(translation) > (UIScreen.main.bounds.width / 2) {
                            onDelete(swipeViewContent)
                            swipeButtonWidth = 0
                            isFullSwipe = false
                        }
                    }
                })
        )
    }

    func createRectangleWithOverlay(text: String, onTap: @escaping () -> Void) -> some View {
        return Rectangle()
            .foregroundColor(Color("grayBackground", bundle: .module).opacity(AppConstants.bannerOpacity))
            .blur(radius: 1, opaque: false)
            .cornerRadius(AppConstants.bannerCornerRadius)
            .shadow(color: .black.opacity(AppConstants.bannerOpacity), radius: 4)
            .overlay(
                Text(text)
                    .foregroundColor(Color("black", bundle: .module).opacity(AppConstants.bannerOpacity))
                    .font(.body)
            )
            .onTapGesture(perform: onTap)
    }

}

struct BannerView_Previews: PreviewProvider {
    @State private static var swipeViewContent: SwipeViewContent =
    SwipeViewContent(appImageName: "googlePay", title: "Section 1 - Notification 1", subtitle: "Content 1", createdDate: Date())
    @State private static var isSectionExpanded = true
    static var previews: some View {
        VStack {
            BannerView(swipeViewContent: $swipeViewContent, isSectionExpanded: $isSectionExpanded, activeBanner: .constant(nil), onDelete: {_ in }, onOptions: {_ in }, index: 0)
                .padding()
        }
    }
}
