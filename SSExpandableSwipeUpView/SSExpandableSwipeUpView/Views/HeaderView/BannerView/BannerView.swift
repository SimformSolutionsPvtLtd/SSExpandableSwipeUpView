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
    var onDelete: (SwipeViewContent) -> Void
    @Binding var activeBanner: SwipeViewContent?

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
                    .foregroundColor(Color("grayBackground").opacity(AppConstants.bannerOpacity))
                    .blur(radius: 1, opaque: false)
                    .cornerRadius(AppConstants.bannerCornerRadius)
                    .shadow(color: .black.opacity(AppConstants.bannerOpacity), radius: 4)
                    .frame(width: UIScreen.main.bounds.width - 20)

                // Banner Content View
                // Contains banner image, title and description
                // Resizes as per the size of content
                HStack(spacing: 10) {
                    // Banner content image
                    Image(swipeViewContent.appImageName)
                        .frame(width: 40, height: 40)
                    // Banner text content
                    VStack(alignment: .leading, spacing: 4) {
                        // Banner Title
                        Text(swipeViewContent.title)
                            .font(.title3)
                            .foregroundColor(Color("black").opacity(AppConstants.bannerOpacity))
                        // Banner Description
                        Text(swipeViewContent.subtitle)
                            .font(.body)
                            .foregroundColor(Color("black").opacity(AppConstants.bannerOpacity))
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
                        // add action for options button
                    }
                createRectangleWithOverlay(text: "Remove") {
                        withAnimation {
                            onDelete(swipeViewContent)
                            swipeButtonWidth = 0
                        }
                    }

            }
            .opacity(swipeButtonWidth < 0 ? 1.0 : 0.0)
            .animation(.easeInOut, value: swipeButtonWidth)
            .offset(x: 10)
            .frame(width: activeBanner == swipeViewContent ? swipeButtonWidth > 0 ? 0 : -swipeButtonWidth : 0)
        }

        .gesture(
            DragGesture()
                .onChanged { value in
                    let translation = value.translation.width
                    if translation < 0 && abs(translation) > (UIScreen.main.bounds.width / 2) {
                        // Full swipe action to the left
                        withAnimation {
                            swipeButtonWidth = -UIScreen.main.bounds.width - 30
                        }

                    } else if abs(value.translation.width) > CGFloat(20) {
                        // Partial swipe action
                        withAnimation {
                            swipeButtonWidth = value.translation.width > 0 ? 0 : -190
                            activeBanner = swipeViewContent
                        }
                    } else {
                        // Reset to default position
                        withAnimation {
                            swipeButtonWidth = 0
                        }
                    }
                }
                .onEnded({ value in
                    let translation = value.translation.width
                    if translation < 0 && abs(translation) > (UIScreen.main.bounds.width / 2) {
                        onDelete(swipeViewContent)
                        swipeButtonWidth = 0
                    }
                })
        )
    }

    func createRectangleWithOverlay(text: String, onTap: @escaping () -> Void) -> some View {
        return Rectangle()
            .foregroundColor(Color("grayBackground").opacity(AppConstants.bannerOpacity))
            .blur(radius: 1, opaque: false)
            .cornerRadius(AppConstants.bannerCornerRadius)
            .shadow(color: .black.opacity(AppConstants.bannerOpacity), radius: 4)
            .overlay(
                Text(text)
                    .foregroundColor(Color("black").opacity(AppConstants.bannerOpacity))
                    .font(.body)
            )
            .onTapGesture(perform: onTap)
    }

}

struct BannerView_Previews: PreviewProvider {
    @State private static var swipeViewContent: SwipeViewContent =
            SwipeViewContent(appImageName: "googlePay", title: "Section 1 - Notification 1", subtitle: "Content 1")
    @State private static var isSectionExpanded = true
    static var previews: some View {
        VStack {
            BannerView(swipeViewContent: $swipeViewContent, isSectionExpanded: $isSectionExpanded, onDelete: {_ in }, activeBanner: .constant(nil))
                .padding()
        }
    }
}
