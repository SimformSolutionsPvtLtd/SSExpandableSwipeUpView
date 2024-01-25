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
    var constants: CustomConstants

    var body: some View {
        // Zstack to show the banner while swipping outside of container
        // Contatins Banner Zstack and swipe action Zstack
        // While swipping banner Zstack changes the position and Swipe action Zstack comes in to the action
        ZStack {
            // Banner View
            ZStack(alignment: .leading) {
                // Banner Background View
                // For color and blur effect
                Rectangle()
                    .foregroundColor(Color("grayBackground").opacity(constants.bannerOpacity))
                    .blur(radius: 1, opaque: false)
                    .cornerRadius(constants.bannerCornerRadius)
                    .shadow(color: .black.opacity(constants.bannerOpacity), radius: 4)

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
                            .foregroundColor(Color("black").opacity(constants.bannerOpacity))
                        // Banner Description
                        Text(swipeViewContent.subtitle)
                            .font(.body)
                            .foregroundColor(Color("black").opacity(constants.bannerOpacity))
                            .multilineTextAlignment(.leading)
                    }
                }
                .padding()
            }
            // Sets banner's X offset while swipping right to left
            .offset(x: swipeButtonWidth)
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
            ZStack(alignment: .leading) {
                // Background for swipe action
                Rectangle()
                    .foregroundColor(.red.opacity(constants.bannerOpacity))
                    .shadow(color: .black.opacity(constants.bannerOpacity), radius: 4)
                // Swipe action title
                Text("Remove")
                    .padding()
                    .font(.body)
                    .foregroundColor(Color("black").opacity(constants.bannerOpacity))
                    .multilineTextAlignment(.leading)
            }
            .cornerRadius(constants.bannerCornerRadius)
            .offset(x: ((UIScreen.main.bounds.width - 32) + swipeButtonWidth))
            .frame(width: swipeButtonWidth > 0 ? 0 : (-swipeButtonWidth + 80))
            .onTapGesture {
                swipeButtonWidth = 0
            }
            .animation(.spring)
        }
        .gesture(DragGesture(minimumDistance: 0)
            .onChanged { drageValue in
                withAnimation {
                    if -drageValue.translation.width.rounded() < UIScreen.main
                        .bounds.width / 2  && isSectionExpanded && drageValue.translation.width.rounded() < 0 {
                        swipeButtonWidth = drageValue.translation.width.rounded()
                    }
                }
            }
        )
    }
}

struct BannerView_Previews: PreviewProvider {
    @State private static var swipeViewContent: SwipeViewContent =
            SwipeViewContent(appImageName: "googlePay", title: "Section 1 - Notification 1", subtitle: "Content 1")
    @State private static var isSectionExpanded = true
    static var previews: some View {
        VStack {
            BannerView(swipeViewContent: $swipeViewContent, isSectionExpanded: $isSectionExpanded, constants: CustomConstants())
                .padding()
        }
    }
}
