//
//  SelectionScrollBarTestDelegate.swift
//  SelectionScrollBar_Tests
//
//  Created by AJ Bartocci on 4/3/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import SelectionScrollBar

class SelectionScrollBarTestDelegate: SelectionScrollBarDelegate {
    
    var selectedIndex: Int?
    var selectedTitle: String?
    
    func selectionScrollBar(_ scrollBar: SelectionScrollBar, didSelectButtonAtIndex index: Int) {
        self.selectedIndex = index
    }
    
    func selectionScrollBar(_ scrollBar: SelectionScrollBar, didSelectTitle title: String?) {
        self.selectedTitle = title
    }
    
}
