//
//  ContentView.swift
//  SSExpandableSwipeUpView
//
//  Created by Darshan Gujarati on 06/12/23.
//

import SwiftUI

let collapsedGroupRowOffSet: CGFloat = 10
let sectionTitleHight: CGFloat = 30
let expandedSectionRowHightFactor: CGFloat = 1.1

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

struct ContentView: View {

    var body: some View {
            ContentListView()
                .background(
                    Image("wallpaper")
                    .frame(maxWidth: UIScreen.main.bounds.width))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
