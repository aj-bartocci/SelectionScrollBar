//
//  ViewController.swift
//  SelectionScrollBar
//
//  Created by AJ Bartocci on 04/03/2018.
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
import SelectionScrollBar

class ViewController: UIViewController {
    
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var selectionLabel: UILabel!
    @IBOutlet private weak var contentSwitch: UISwitch!
    // because it will be used as the textfield's input view
    // the width doesn't matter since the textfield will size it
    private var selectionScrollBar = SelectionScrollBar(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
    fileprivate var selectionTitles: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.textField.inputAccessoryView = self.selectionScrollBar
        self.textField.autocorrectionType = .no
        self.textField.delegate = self
        
        self.makeMultipleSelection()
        self.selectionScrollBar.backgroundColor = .lightGray
        self.selectionScrollBar.dataSource = self
        self.selectionScrollBar.delegate = self
        self.selectionScrollBar.refresh()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actToggleSwitch(target: UISwitch) {
        if target.isOn {
            // make multiple selections
            self.makeMultipleSelection()
        } else {
            // make single selection
            self.makeSingleSelection()
        }
        self.selectionScrollBar.refresh()
    }
    
    private func makeMultipleSelection() {
        self.selectionTitles = ["selection one", "selection two", "selection three", "selection four", "selection five", "selection six", "selection seven", "selection eight", "selection nine", "selection ten"]
    }
    
    private func makeSingleSelection() {
        self.selectionTitles = ["selection one"]
    }
    
}

extension ViewController: SelectionScrollBarDelegate {
    
    func selectionScrollBar(_ scrollBar: SelectionScrollBar, didSelectButtonAtIndex index: Int) {
        let selection = self.selectionTitles[index]
        self.selectionLabel.text = selection
        print("selected index: \(index)")
    }
    
    func selectionScrollBar(_ scrollBar: SelectionScrollBar, didSelectTitle title: String?) {
        self.textField.text = title
        print("selected title: \(title ?? "")")
    }
}

extension ViewController: SelectionScrollBarDataSource {
    
    func selectionScrollBarSelectionCount(for scrollBar: SelectionScrollBar) -> Int {
        return self.selectionTitles.count
    }
    
    func selectionScrollBar(_ scrollBar: SelectionScrollBar, buttonForIndex index: Int) -> UIButton {
        let title = self.selectionTitles[index]
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
        button.setTitle(title, for: .normal)
        button.sizeToFit()
        button.titleLabel?.textColor = .white
        button.backgroundColor = .clear
        return button
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
