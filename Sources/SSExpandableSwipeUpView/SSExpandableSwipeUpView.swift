//
//  SSExpandableSwipeUpView.swift
//  SSExpandableSwipeUpView
//
//  Created by Darshan Gujarati on 18/12/23.
//

import SwiftUI

public struct SSExpandableSwipeUpView: View {
    @State public var viewModel: SectionContentsViewModel
    @State var activeBanner: SwipeViewContent?
    @State public var backgroundWallpaper: Image?
    var onOptions: (SwipeViewContent) -> Void

    public init(viewModel: SectionContentsViewModel, activeBanner: SwipeViewContent? = nil, backgroundWallpaper: Image? = nil, onOptions: @escaping (SwipeViewContent) -> Void) {
           self._viewModel = State(initialValue: viewModel)
           self._activeBanner = State(initialValue: activeBanner)
           self._backgroundWallpaper = State(initialValue: backgroundWallpaper)
            self.onOptions = onOptions
       }

    public var body: some View {
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
                          ContentListView(activeBanner: $activeBanner, onOptions: { swipeViewContent in
                              onOptions(swipeViewContent)
                          } )
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
    SSExpandableSwipeUpView(viewModel: SectionContentsViewModel(), onOptions: {_ in})
}
