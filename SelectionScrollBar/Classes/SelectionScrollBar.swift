//
//  SelectionScrollBar.swift
//  SelectionScrollBar
//
//  Created by AJ Bartocci on 4/2/18.
//  Copyright (c) 2018 AJ Bartocci <bartocci.aj@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit

public class SelectionScrollBar: UIView {
    
    // TODO: add ability for arrows on each side
    
    // TODO: add seperators like the default implementation?
    
    //MARK: --- Public ---
    /// DataSource that supplies the selections available in the srollable area
    public weak var dataSource: SelectionScrollBarDataSource?
    /// Delegate that sends interaction events
    public weak var delegate: SelectionScrollBarDelegate?
    /// The amount of spacing between each selection button
    public var selectionSpacing: CGFloat = 15
    /// The margin amount on the sides of the scrollview
    public var sideMargin: CGFloat = 15.0 {
        didSet {
            self.setScrollInsets()
        }
    }
    /// The size of the scrollable selections 
    public var contentSize: CGFloat {
        return self.contentView.frame.width
    }
    
    //MARK: --- Internal ---
    /// The scrollview for scrolling through selection buttons
    var scrollView = UIScrollView()
    /// The view containing the selection buttons
    var contentView = UIView()
    
    //MARK: --- Private ---
    private var needsCenterAlign: Bool {
        if self.contentView.frame.width < self.frame.width {
            return true
        } else {
            return false
        }
    }
    /// For deciding whether or not to relayout
    private var lastFrameWidth: CGFloat = 0.0
    /// Dictionary mapping buttons to index
    private var buttonHashTable: [Int: Int] = [:]
    
    
    //MARK: --- Functionality ---
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    private func setup() {
        self.addSubview(scrollView)
        self.scrollView.constrainToBounds(of: self)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if self.lastFrameWidth != self.frame.width {
            self.reloadLayout()
        }
    }
}

extension SelectionScrollBar {
    
    /// Refreshes the available selections in the scroll bar
    public func refresh() {
        let count = dataSource?.selectionScrollBarSelectionCount(for: self) ?? 0
        self.createButtons(count: count)
        self.reloadLayout()
    }
    
    private func reloadLayout() {
        self.lastFrameWidth = self.frame.width
        self.positionContentView()
        self.setScrollInsets()
    }
    
    private func setScrollInsets() {
        let margin: CGFloat
        if self.needsCenterAlign {
            margin = 0.0
        } else {
            margin = self.sideMargin
        }
        self.scrollView.contentInset.left = margin
        self.scrollView.contentInset.right = margin
        self.scrollView.contentOffset.x = -margin
    }
    
    private func positionContentView() {
        if self.needsCenterAlign {
            self.contentView.center.x = self.frame.width * 0.5
        } else {
            self.contentView.frame.origin.x = 0.0
        }
    }
    
    private func createButtons(count: Int) {
        contentView.removeFromSuperview()
        contentView = UIView()
        
        guard let source = self.dataSource else {
            return
        }
        
        guard count > 0 else {
            return
        }
        
        var spacing: CGFloat = 0.0
        for i in 0..<count {
            let button = source.selectionScrollBar(self, buttonForIndex: i)
            button.center.y = self.frame.height * 0.5
            button.frame.origin.x = spacing
            self.contentView.addSubview(button)
            spacing += button.frame.width
            let lastIndex = count - 1
            if i != lastIndex {
                spacing += self.selectionSpacing
            }
            self.set(button: button, for: i)
            button.addTarget(self, action: #selector(tappedButton(button:)), for: .touchUpInside)
        }
        self.contentView.frame.size.width = spacing
        self.contentView.frame.size.height = self.frame.height
        self.scrollView.addSubview(self.contentView)
        self.scrollView.contentSize = CGSize(width: self.contentSize, height: self.contentView.frame.height)
    }
    
    private func set(button: UIButton, for index: Int) {
        self.buttonHashTable[button.hash] = index
    }
    
    private func getIndex(for button: UIButton) -> Int {
        return self.buttonHashTable[button.hash]!
    }

    @objc func tappedButton(button: UIButton) {
        let index = self.getIndex(for: button)
        self.delegate?.selectionScrollBar(self, didSelectButtonAtIndex: index)
        self.delegate?.selectionScrollBar(self, didSelectTitle: button.titleLabel?.text)
    }
}

private extension UIView {
    
    func constrainToBounds(of view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        let attrs: [NSLayoutAttribute] = [.top, .right, .bottom, .left]
        for attr in attrs {
            let c = NSLayoutConstraint(item: self, attribute: attr, relatedBy: .equal, toItem: view, attribute: attr, multiplier: 1.0, constant: 0)
            view.addConstraint(c)
        }
    }
}
