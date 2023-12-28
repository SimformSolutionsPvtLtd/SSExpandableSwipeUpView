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

struct SectionContent: Identifiable {
    let id: UUID = UUID()
    let sectionTitle: String
    var isSectionExpanded: Bool
    var swipeViewContents: [SwipeViewContent]
}

struct SwipeViewContent: Identifiable, Equatable {
    let id: UUID = UUID()
    let appImageName: String
    let title: String
    var subtitle: String
    var createdDate: Date
}

class SectionContentsViewModel: ObservableObject {

    @Published var sectionContents: [SectionContent] = []

    func addSection(title: String, isExpanded: Bool, swipeViewContents: [SwipeViewContent]) {
        let newSection = SectionContent(sectionTitle: title, isSectionExpanded: isExpanded, swipeViewContents: swipeViewContents.sorted(by: {$0.createdDate > $1.createdDate}))
          sectionContents.append(newSection)
      }

    func addSwipeViewContent(toSection sectionTitle: String, swipeViewContent: SwipeViewContent) {
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
