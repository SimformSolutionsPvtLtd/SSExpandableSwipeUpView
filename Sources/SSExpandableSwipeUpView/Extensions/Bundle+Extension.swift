//
//  Bundle+Extension.swift
//  SSExpandableSwipeUpView
//
//  Created by Purva Ruparelia on 06/02/24.
//

import Foundation

#if !SPM
extension Bundle {
  static var module: Bundle {
      Bundle(for: BundleFinder.self)
  }
}

private class BundleFinder {
    private init() { }
}
#endif
