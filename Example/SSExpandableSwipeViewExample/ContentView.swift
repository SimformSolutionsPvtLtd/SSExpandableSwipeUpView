//
//  ContentView.swift
//  SSExpandableSwipeViewExample
//
//  Created by Purva Rupareliya on 30/01/24.
//

import SwiftUI
import SSExpandableSwipeUpView

struct ContentView: View {
    var viewModel = SectionContentsViewModel()

    init() {
        setupViewModel()
    }

    private func setupViewModel() {
        let gPayContents = [
            SwipeViewContent(appImageName: "googlePay", title: "Payment Received", subtitle: "Alex, You have received $10M in your account!", createdDate: Date()),
            SwipeViewContent(appImageName: "googlePay", title: "Payment Received", subtitle: "Alex, You have received $5M in your account!", createdDate: Date())]

        let teamsContents = [
            SwipeViewContent(appImageName: "teams", title: "Gotham Steve", subtitle: "Hey, Alex", createdDate: Date()),
            SwipeViewContent(appImageName: "teams", title: "Gotham Steve", subtitle: "What is the progress?", createdDate: Date()),
            SwipeViewContent(appImageName: "teams", title: "Gotham Steve", subtitle: "Are you on timeline?", createdDate: Date())]

        viewModel.addSection(title: "Google Pay", isExpanded: true, swipeViewContents: gPayContents)
        viewModel.addSection(title: "Teams", isExpanded: true, swipeViewContents: teamsContents)
    }

    var body: some View {
        SSExpandableSwipeUpView(viewModel: viewModel, backgroundWallpaper: Image("wallpaper"))
    }
}

#Preview {
    ContentView()
}
