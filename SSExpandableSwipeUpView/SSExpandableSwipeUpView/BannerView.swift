//
//  BannerView.swift
//  SSExpandableSwipeUpView
//
//  Created by Darshan Gujarati on 06/12/23.
//

import SwiftUI

struct BannerView: View {
    @Binding var swipeViewContent: SwipeViewContent

    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .foregroundColor(Color("grayBackground").opacity(0.8))
                .blur(radius: 1, opaque: false)
                .cornerRadius(22)
                .shadow(color: .black.opacity(0.8), radius: 4)

            HStack(spacing: 12) {
                Image(swipeViewContent.appImageName)
                    .frame(width: 40, height: 40)
                VStack(alignment: .leading, spacing: 4) {
                    Text(swipeViewContent.title)
                        .font(.title3)
                        .foregroundColor(Color("black").opacity(0.8))
                    Text(swipeViewContent.subtitle)
                        .font(.body)
                        .foregroundColor(Color("black").opacity(0.8))
                        .multilineTextAlignment(.leading)
                }
            }
            .padding()
        }

    }
}

struct BannerGroupView: View {
    @Binding var sectionContent: SectionContent

    var body: some View {
        if sectionContent.isSectionExpanded {
            VStack() {
                ForEach(0..<$sectionContent.swipeViewContents.count, id: \.self) { index in
                    BannerView(swipeViewContent: $sectionContent.swipeViewContents[index])
                }
            }
        } else {
            ZStack(alignment: .top) {
                ForEach(0..<$sectionContent.swipeViewContents.count, id: \.self) { index in
                    VStack {
                        BannerView(swipeViewContent: $sectionContent.swipeViewContents[index])
                            .onTapGesture {
                                withAnimation {
                                    sectionContent.isSectionExpanded.toggle()
                                }
                            }
                            .zIndex(Double(index))
                        Spacer(minLength: CGFloat(index) * collapsedGroupRowOffSet)
                    }
                }
            }
        }
    }
}

struct BannerView_Previews: PreviewProvider {
    @State private static var swipeViewContent: SwipeViewContent =
            SwipeViewContent(appImageName: "googlePay", title: "Section 1 - Notification 1", subtitle: "Content 1, Content 1 Content 1 Content 1 Content 1")
    static var previews: some View {
        VStack {
            BannerView(swipeViewContent: $swipeViewContent)
                .padding()
        }
    }
}
