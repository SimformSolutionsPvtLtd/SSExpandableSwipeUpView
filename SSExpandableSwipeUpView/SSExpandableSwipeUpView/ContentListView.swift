//
//  ContentListView.swift
//  SSExpandableSwipeUpView
//
//  Created by Darshan Gujarati on 07/12/23.
//

import SwiftUI

struct ContentListView: View {

    @State private var sectionContents: [SectionContent] = [
        SectionContent(sectionTitle: "WhatsApp", isSectionExpanded: false, swipeViewContents: [
            SwipeViewContent(appImageName: "whatsapp", title: "Adam", subtitle: "Hello"),
            SwipeViewContent(appImageName: "whatsapp", title: "Adam", subtitle: "How are you!"),
            SwipeViewContent(appImageName: "whatsapp", title: "Adam", subtitle: "Let's have some fresh air!"),
            SwipeViewContent(appImageName: "whatsapp", title: "Adam", subtitle: "Coming?")]),

        SectionContent(sectionTitle: "Google Pay", isSectionExpanded: false, swipeViewContents: [
            SwipeViewContent(appImageName: "googlePay", title: "Payment Received", subtitle: "Darshan, You have received $10M in your account!")]),

        SectionContent(sectionTitle: "Teams", isSectionExpanded: true, swipeViewContents: [
            SwipeViewContent(appImageName: "teams", title: "Gotham Steve", subtitle: "Hey, Darshan"),
            SwipeViewContent(appImageName: "teams", title: "Gotham Steve", subtitle: "What is the progress?"),
            SwipeViewContent(appImageName: "teams", title: "Gotham Steve", subtitle: "Are you on timeline?"),
            SwipeViewContent(appImageName: "teams", title: "Gotham Steve", subtitle: "Okay, great!")]),

        SectionContent(sectionTitle: "Twitter", isSectionExpanded: false, swipeViewContents: [
            SwipeViewContent(appImageName: "twitter", title: "Hi Darshan,", subtitle: "You have 32 new replies on your recent tweet"),
            SwipeViewContent(appImageName: "twitter", title: "New reply", subtitle: "Steve replied your tweet")])
    ]

    var body: some View {
        ScrollView {
            Spacer(minLength: UIScreen.main.bounds.height - 120)
            VStack {
                Text("• \(sectionContents.count) Notifications")
                    .foregroundColor(Color("black"))
                    .fontWeight(.bold)
            }
            .padding(10)
            .background(Color("grayBackground").opacity(0.8))
            .cornerRadius(20)

            VStack(spacing: 0) {
                ForEach(0..<$sectionContents.count, id: \.self) { index in
                    VStack(alignment: .leading) {
                        HStack {
                            Text(sectionContents[index].sectionTitle)
                                .padding(5)
                                .foregroundColor(Color("white"))
                                .fontWeight(.semibold)
                                .font(.title)
                            Spacer()
                                .onTapGesture {
                                    withAnimation {
                                        toggleSectionExpansion(section: &sectionContents[index])
                                    }
                                }
                            Button(action: {
                                if (sectionContents[index].swipeViewContents.count < 2) || sectionContents[index].isSectionExpanded {
                                    withAnimation {
                                        sectionContents.remove(at: index)
                                    }
                                } else {
                                    withAnimation {
                                        toggleSectionExpansion(section: &sectionContents[index])
                                    }
                                }
                            }) {
                                ExpandButtonView(sectionContent: $sectionContents[index])
                            }
                        }
                        .frame(height: sectionTitleHight)
                        BannerGroupView(sectionContent: $sectionContents[index])
                            .animation(.easeIn, value: sectionContents[index].isSectionExpanded)
                    }
                    .onTapGesture {
                        withAnimation {
                            toggleSectionExpansion(section: &sectionContents[index])
                        }
                    }
                    .padding()
                }
            }
        }
        .scrollIndicators(.hidden)
    }

    func toggleSectionExpansion(section: inout SectionContent) {
        if section.swipeViewContents.count > 1 {
            section.isSectionExpanded.toggle()
        }
    }
}

struct ExpandButtonView: View {
    @Binding var sectionContent: SectionContent

    var body: some View {
        Image(sectionContent.swipeViewContents.count > 1 ? (sectionContent.isSectionExpanded ? "close" : "dropDown") : "close")
            .frame(width: sectionTitleHight, height: sectionTitleHight)
            .foregroundColor(Color("white"))
            .padding(5)
    }
}

struct ContentListView_Previews: PreviewProvider {
    static var previews: some View {
        ContentListView()
            .background(Color("black"))
    }
}
