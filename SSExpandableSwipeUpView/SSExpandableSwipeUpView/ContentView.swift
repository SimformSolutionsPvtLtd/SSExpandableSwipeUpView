//
//  ContentView.swift
//  SSExpandableSwipeUpView
//
//  Created by Darshan Gujarati on 06/12/23.
//

import SwiftUI

struct ContentView: View {
    var viewModel = SectionContentsViewModel()

    init() {
        setupViewModel()
    }

    private func setupViewModel() {
        let gPayContents = [
            SwipeViewContent(appImageName: "googlePay", title: "Payment Received", subtitle: "Alex, You have received $10M in your account!", createdDate: Date()),
            SwipeViewContent(appImageName: "googlePay", title: "Payment Received", subtitle: "Alex, You have received $5M in your account!", createdDate: Date())]

        let whatsAppContents = [
            SwipeViewContent(appImageName: "whatsapp", title: "Adam", subtitle: "Hello", createdDate: Date()),
            SwipeViewContent(appImageName: "whatsapp", title: "Adam", subtitle: "How are you!", createdDate: Date()),
            SwipeViewContent(appImageName: "whatsapp", title: "Adam", subtitle: "Let's have some fresh air!", createdDate: Date()),
            SwipeViewContent(appImageName: "whatsapp", title: "Adam", subtitle: "Coming?", createdDate: Date())]

        let teamsContents = [
            SwipeViewContent(appImageName: "teams", title: "Gotham Steve", subtitle: "Hey, Alex", createdDate: Date()),
            SwipeViewContent(appImageName: "teams", title: "Gotham Steve", subtitle: "What is the progress?", createdDate: Date()),
            SwipeViewContent(appImageName: "teams", title: "Gotham Steve", subtitle: "Are you on timeline?", createdDate: Date())]

        viewModel.addSection(title: "Google Pay", isExpanded: true, swipeViewContents: gPayContents)
        viewModel.addSection(title: "WhatsApp", isExpanded: false, swipeViewContents: whatsAppContents)
        viewModel.addSection(title: "Teams", isExpanded: true, swipeViewContents: teamsContents)

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let newContent = SwipeViewContent(appImageName: "googlePay", title: "New Payment", subtitle: "You received a new payment!", createdDate: Date())
            self.viewModel.addSwipeViewContent(toSection: "Google Pay", swipeViewContent: newContent)
        }
    }

    var body: some View {
        SSExpandableSwipeUpView(viewModel: viewModel, backgroundWallpaper: Image("wallpaper"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
