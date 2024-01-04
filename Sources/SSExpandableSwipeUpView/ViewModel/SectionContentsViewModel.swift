//
//  SectionContentsViewModel.swift
//  SSExpandableSwipeUpView
//
//  Created by Darshan Gujarati on 15/12/23.
//

import Foundation

enum AppConstants {
    static let collapsedGroupRowOffset: CGFloat = 10
    static let expandSectionLineSpacing: CGFloat = 10
    static let sectionTitleHeight: CGFloat = 30
    static let bannerCornerRadius: CGFloat = 22
    static let bannerOpacity: CGFloat = 0.8
}

public struct SectionContent: Identifiable {
    public let id: UUID = UUID()
    public let sectionTitle: String
    public var isSectionExpanded: Bool
    public var swipeViewContents: [SwipeViewContent]

    // Custom initializer
    public init(sectionTitle: String, isSectionExpanded: Bool, swipeViewContents: [SwipeViewContent]) {
        self.sectionTitle = sectionTitle
        self.isSectionExpanded = isSectionExpanded
        self.swipeViewContents = swipeViewContents
    }
}

public struct SwipeViewContent: Identifiable, Equatable {
    public let id: UUID = UUID()
    public let appImageName: String
    public let title: String
    public var subtitle: String
    public var createdDate: Date

    // Custom initializer
    public init(appImageName: String, title: String, subtitle: String, createdDate: Date) {
        self.appImageName = appImageName
        self.title = title
        self.subtitle = subtitle
        self.createdDate = createdDate
    }
}

public class SectionContentsViewModel: ObservableObject {

    public init() {}

    @Published var sectionContents: [SectionContent] = []

    public func addSection(title: String, isExpanded: Bool, swipeViewContents: [SwipeViewContent]) {
        let newSection = SectionContent(sectionTitle: title, isSectionExpanded: isExpanded, swipeViewContents: swipeViewContents.sorted(by: {$0.createdDate > $1.createdDate}))
          sectionContents.append(newSection)
      }

    public func addSwipeViewContent(toSection sectionTitle: String, swipeViewContent: SwipeViewContent) {
            if let sectionIndex = sectionContents.firstIndex(where: { $0.sectionTitle == sectionTitle }) {
                sectionContents[sectionIndex].swipeViewContents.insert(swipeViewContent, at: 0)
            }
        }

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
