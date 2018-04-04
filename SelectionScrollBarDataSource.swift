//
//  SelectionScrollBarDataSource.swift
//  SelectionScrollBar
//
//  Created by AJ Bartocci on 4/2/18.
//

import Foundation

public protocol SelectionScrollBarDataSource: class {
    
    /// The amount of predictions that there are
    func selectionScrollBarSelectionCount(for scrollBar: SelectionScrollBar) -> Int
    
    /// The button for provided index, position is ignored
    func selectionScrollBar(_ scrollBar: SelectionScrollBar, buttonForIndex index: Int) -> UIButton
}
