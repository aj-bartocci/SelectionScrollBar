//
//  SelectionScrollBar.swift
//  SelectionScrollBar
//
//  Created by AJ Bartocci on 4/2/18.
//

import UIKit

public class SelectionScrollBar: UIView {
    
    // TODO: add ability for arrows on each side
    
    // TODO: add seperators like the default implementation?
    
    var somethingThatIsNotPrivate = 0.0
    
    // Private
    /// The scrollview for scrolling through selection buttons
    private var scrollView = UIScrollView()
    /// The view containing the selection buttons
    private var contentView = UIView()
    /// The underlying margin property
//    private var _sideMargin: CGFloat = 15.0
    private var needsCenterAlign: Bool {
        if self.contentView.frame.width < self.frame.width {
            return true
        } else {
            return false
        }
    }
    private var lastFrameWidth: CGFloat = 0.0
    
    
    // Public
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
    /// DataSource that supplies the selections available in the srollable area
    public weak var dataSource: SelectionScrollBarDataSource?
    /// Delegate that sends interaction events from within scrollable area
    public weak var delegate: SelectionScrollBarDelegate?
    
    
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
        }
        self.contentView.frame.size.width = spacing
        self.contentView.frame.size.height = self.frame.height
        self.scrollView.addSubview(self.contentView)
        self.scrollView.contentSize = CGSize(width: self.contentSize, height: self.contentView.frame.height)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if self.lastFrameWidth != self.frame.width {
            self.reloadLayout()
        }
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
