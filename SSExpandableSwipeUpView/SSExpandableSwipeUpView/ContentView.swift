//
//  ContentView.swift
//  SSExpandableSwipeUpView
//
//  Created by Darshan Gujarati on 06/12/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = SectionContentsViewModel()
    
    var body: some View {
        SSExpandableSwipeUpView(viewModel: viewModel, constants: CustomConstants())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
