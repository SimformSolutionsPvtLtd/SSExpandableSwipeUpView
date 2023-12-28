//
//  SSExpandableSwipeUpView.swift
//  SSExpandableSwipeUpView
//
//  Created by Darshan Gujarati on 18/12/23.
//

import SwiftUI

struct SSExpandableSwipeUpView: View {
    @State var viewModel: SectionContentsViewModel
    @State var activeBanner: SwipeViewContent?
    @State var backgroundWallpaper: Image?

    var body: some View {
        ScrollViewReader { proxy in
              ScrollView {
                  VStack {
                      // Spacer for starting content from bottom
                      Spacer(minLength: UIScreen.main.bounds.height - 120)
                      // Content counter
                      ContentCountView()
                          .environmentObject(viewModel)
                      // Show content list if content is not empty
                      if !viewModel.sectionContents.isEmpty {
                          ContentListView(activeBanner: $activeBanner)
                              .environmentObject(viewModel)
                      }
                  }
                  .background(GeometryReader { geometry in
                      Color.clear
                          .onChange(of: geometry.frame(in: .global).minY) { newOffset in
                              withAnimation {
                                  activeBanner = nil
                              }
                          }
                  })
              }
              .background(
                   backgroundWallpaper
                        .frame(maxWidth: UIScreen.main.bounds.width))
              .scrollIndicators(.hidden)
          }
    }
}

#Preview {
    SSExpandableSwipeUpView(viewModel: SectionContentsViewModel())
}
