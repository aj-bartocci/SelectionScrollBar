//
//  SelectionScrollBarTestDataSource.swift
//  SelectionScrollBar_Tests
//
//  Created by AJ Bartocci on 4/2/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import SelectionScrollBar

class SelectionScrollBarTestDataSource: SelectionScrollBarDataSource {
    
    var buttons: [UIButton]
    init(buttons: [UIButton]) {
        self.buttons = buttons
    }
    
    
    func selectionScrollBarSelectionCount(for scrollBar: SelectionScrollBar) -> Int {
        return self.buttons.count
    }
    
    func selectionScrollBar(_ scrollBar: SelectionScrollBar, buttonForIndex index: Int) -> UIButton {
        return self.buttons[index]
    }
    
    
}
