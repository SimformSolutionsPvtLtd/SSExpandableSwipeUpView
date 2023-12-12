//
//  SectionContentsViewModel.swift
//  SSExpandableSwipeUpView
//
//  Created by Darshan Gujarati on 15/12/23.
//

import Foundation

// Constants
struct CustomConstants {
    // Offset for banners while section is collapsed
    var collapsedGroupRowOffset: CGFloat

    // Line spacing between banners while section is expanded
    var expandSectionLineSpacing: CGFloat

    // Section title height
    var sectionTitleHeight: CGFloat

    // Corner radius for banners/Views
    var bannerCornerRadius: CGFloat

    // Opacity for banners/Views
    var bannerOpacity: CGFloat

    init(collapsedGroupRowOffset: CGFloat = 10,
         expandSectionLineSpacing: CGFloat = 10,
         sectionTitleHeight: CGFloat = 30,
         bannerCornerRadius: CGFloat = 22,
         bannerOpacity: CGFloat = 0.8) {
        self.collapsedGroupRowOffset = collapsedGroupRowOffset
        self.expandSectionLineSpacing = expandSectionLineSpacing
        self.sectionTitleHeight = sectionTitleHeight
        self.bannerCornerRadius = bannerCornerRadius
        self.bannerOpacity = bannerOpacity
    }
}

struct SectionContent: Identifiable {
    let id: UUID = UUID()
    let sectionTitle: String
    var isSectionExpanded: Bool
    var swipeViewContents: [SwipeViewContent]
}

struct SwipeViewContent: Identifiable {
    let id: UUID = UUID()
    let appImageName: String
    let title: String
    var subtitle: String
}

class SectionContentsViewModel: ObservableObject {

    @Published var sectionContents: [SectionContent] = [
        SectionContent(sectionTitle: "Google Pay", isSectionExpanded: true, swipeViewContents: [
            SwipeViewContent(appImageName: "googlePay", title: "Payment Received", subtitle: "Darshan, You have received $10M in your account!"),
            SwipeViewContent(appImageName: "googlePay", title: "Payment Received", subtitle: "Darshan, You have received $5M in your account!")]),
        SectionContent(sectionTitle: "WhatsApp", isSectionExpanded: false, swipeViewContents: [
            SwipeViewContent(appImageName: "whatsapp", title: "Adam", subtitle: "Hello"),
            SwipeViewContent(appImageName: "whatsapp", title: "Adam", subtitle: "How are you!"),
            SwipeViewContent(appImageName: "whatsapp", title: "Adam", subtitle: "Let's have some fresh air!"),
            SwipeViewContent(appImageName: "whatsapp", title: "Adam", subtitle: "Coming?"),
            SwipeViewContent(appImageName: "whatsapp", title: "Adam", subtitle: "Coming?????")]),

        SectionContent(sectionTitle: "Teams", isSectionExpanded: false, swipeViewContents: [
            SwipeViewContent(appImageName: "teams", title: "Gotham Steve", subtitle: "Hey, Darshan"),
            SwipeViewContent(appImageName: "teams", title: "Gotham Steve", subtitle: "What is the progress?"),
            SwipeViewContent(appImageName: "teams", title: "Gotham Steve", subtitle: "Are you on timeline?"),
            SwipeViewContent(appImageName: "teams", title: "Gotham Steve", subtitle: "Okay, great!")]),

        SectionContent(sectionTitle: "Twitter", isSectionExpanded: false, swipeViewContents: [
            SwipeViewContent(appImageName: "twitter", title: "Hi Darshan,", subtitle: "You have 32 new replies on your recent tweet"),
            SwipeViewContent(appImageName: "twitter", title: "New reply", subtitle: "Steve replied your tweet")])
    ]

    // Returns the index of section in array using SectionContent id.
    func getIndexOfSection(for section: SectionContent) -> Int {
        if let index = sectionContents.firstIndex(where: { $0.id == section.id }) {
            return index
        }
        return 0
    }

    // Toogles selected section expansion
    func toggleSectionExpansion(for section: SectionContent) {
        sectionContents[getIndexOfSection(for: section)].isSectionExpanded.toggle()
    }

    // Remove SectionContent from ViewModel array
    func removeSection(for section: SectionContent) {
        sectionContents.remove(at: getIndexOfSection(for: section))
    }
}
