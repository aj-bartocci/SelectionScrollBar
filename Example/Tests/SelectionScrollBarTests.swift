//
//  SelectionScrollBarTests.swift
//  SelectionScrollBar_Example
//
//  Created by AJ Bartocci on 4/2/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import SelectionScrollBar

class SelectionScrollBarSpec: QuickSpec {
    override func spec() {
        describe("SelectionScrollBar") {
            
            var sut: SelectionScrollBar!
            beforeEach {
                sut = SelectionScrollBar(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
            }
            
            context("Delegate", {
                var dataSource: SelectionScrollBarTestDataSource!
                var delegate = SelectionScrollBarTestDelegate()
                beforeEach {
                    dataSource = SelectionScrollBarTestDataSource(buttons: [])
                    delegate.selectedTitle = nil
                    delegate.selectedIndex = nil
                    sut.dataSource = dataSource
                    sut.delegate = delegate
                }
                
                context("1 button", {
                    var button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
                    beforeEach {
                        dataSource.buttons = [button]
                        sut.refresh()
                    }
                    
                    it("sends index 0 when tapped", closure: {
                        sut.tappedButton(button: button)
                        expect(delegate.selectedIndex) == 0
                    })
                    
                    it("sends the title of the button", closure: {
                        let title = "button title"
                        button.setTitle(title, for: .normal)
                        sut.tappedButton(button: button)
                        expect(delegate.selectedTitle) == title
                    })
                })
                
                context("Multiple buttons", {
                    var buttonOne = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
                    var buttonTwo = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
                    var buttonThree = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
                    beforeEach {
                        dataSource.buttons = [buttonOne, buttonTwo, buttonThree]
                        sut.refresh()
                    }
                    
                    it("sends correct index for button", closure: {
                        testButtonTap(button: buttonOne, for: 0)
                        testButtonTap(button: buttonTwo, for: 1)
                        testButtonTap(button: buttonThree, for: 2)
                    })
                    
                    func testButtonTap(button: UIButton, for index: Int) {
                        sut.tappedButton(button: button)
                        expect(delegate.selectedIndex) == index
                    }
                })
            })
            
            context("DataSource", {
                context("nil", {
                    
                    beforeEach {
                        sut.dataSource = nil
                    }
                    
                    describe("refresh", {
                        
                        it("has no content", closure: {
                            sut.refresh()
                            expect(sut.contentSize).to(equal(0))
                        })
                    })
                    
                })
                
                context("non nil", {
                    
                    var dataSource: SelectionScrollBarTestDataSource!
                    beforeEach {
                        dataSource = SelectionScrollBarTestDataSource(buttons: [])
                        sut.dataSource = dataSource
                    }
                    
                    describe("sideMargin", {
                        
                        context("content greater than frame", {
                            beforeEach {
                                sut.frame.size.width = 100
                                sut.contentView.frame.size.width = 150
                            }
                            
                            it("sets margins to 0", closure: {
                                testMargins(setTo: 0.0)
                            })
                            
                            it("sets margins to 10", closure: {
                                testMargins(setTo: 10.0)
                            })
                        })
                        
                        context("content smaller than frame", {
                            beforeEach {
                                sut.frame.size.width = 200
                                sut.contentView.frame.size.width = 150
                            }
                            
                            it("ignores margin", closure: {
                                sut.sideMargin = 20.0
                                expect(sut.scrollView.contentInset.left) == 0.0
                                expect(sut.scrollView.contentInset.right) == 0.0
                            })
                        })
                        
                        func testMargins(setTo value: CGFloat) {
                            sut.sideMargin = value
                            expect(sut.scrollView.contentInset.left) == value
                            expect(sut.scrollView.contentInset.right) == value
                        }
                        
                    })
                    
                    describe("refresh", {
                        context("no selections", {
                            it("has 0 contentSize", closure: {
                                dataSource.buttons = []
                                sut.refresh()
                                expect(sut.contentSize).to(equal(0))
                            })
                        })
                        
                        context("has selections", {
                            context("one selection", {
                                
                                var button: UIButton!
                                beforeEach {
                                    button = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
                                    dataSource.buttons = [button]
                                    sut.frame.size.width = 100
                                }
                                
                                it("has content size equal to button width", closure: {
                                    button.frame.size.width = 150
                                    sut.refresh()
                                    expect(sut.contentSize).to(equal(button.frame.width))
                                    
                                    button.frame.size.width = 120
                                    sut.refresh()
                                    expect(sut.contentSize).to(equal(button.frame.width))
                                })
                                
                                it("centers contentView horizontally", closure: {
                                    button.frame.size.width = 150
                                    sut.frame.size.width = 200
                                    sut.refresh()
                                    expect(sut.contentView.center.x).to(equal(sut.frame.width / 2.0))
                                    
                                    sut.frame.size.width = 350
                                    sut.refresh()
                                    expect(sut.contentView.center.x).to(equal(sut.frame.width / 2.0))
                                })
                                
                                it("sets content inset to zero", closure: {
                                    button.frame.size.width = 150
                                    sut.frame.size.width = 200
                                    sut.refresh()
                                    expect(sut.scrollView.contentInset.left).to(equal(0.0))
                                    expect(sut.scrollView.contentInset.right).to(equal(0.0))
                                })
                            })
                            
                            context("multiple selections", {
                                
                                var spacing: CGFloat = 0.0
                                var buttons: [UIButton]!
                                beforeEach {
                                    buttons = []
                                    spacing = 0.0
                                }
                                
                                context("spacing equal to 0", {
                                    beforeEach {
                                        spacing = 0.0
                                    }
                                    
                                    it("combines buttons and content size", closure: {
                                        sut.selectionSpacing = spacing
                                        let buttonOne = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 50))
                                        let buttonTwo = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
                                        buttons = [buttonOne, buttonTwo]
                                        testWithSpacing(spacing: spacing, buttons: buttons)
                                        
                                        let buttonThree = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 40))
                                        buttons.append(buttonThree)
                                        testWithSpacing(spacing: spacing, buttons: buttons)
                                    })
                                    
                                    it("shifts buttons x value", closure: {
                                        sut.selectionSpacing = spacing
                                        let buttonOne = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 50))
                                        let buttonTwo = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
                                        let buttonThree = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 40))
                                        buttons = [buttonOne, buttonTwo, buttonThree]
                                        dataSource.buttons = buttons
                                        sut.refresh()
                                        
                                        expect(buttonOne.frame.origin.x).to(equal(0.0))
                                        expect(buttonTwo.frame.origin.x).to(equal(buttonOne.frame.width + spacing))
                                        expect(buttonThree.frame.origin.x).to(equal(buttonTwo.frame.origin.x + buttonTwo.frame.width + spacing))
                                    })
                                })
                                
                                context("spacing equal to 10", {
                                    beforeEach {
                                        spacing = 10.0
                                    }
                                    
                                    it("combines buttons and content size", closure: {
                                        sut.selectionSpacing = spacing
                                        let buttonOne = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 50))
                                        let buttonTwo = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
                                        buttons = [buttonOne, buttonTwo]
                                        testWithSpacing(spacing: spacing, buttons: buttons)
                                        
                                        let buttonThree = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 40))
                                        buttons.append(buttonThree)
                                        testWithSpacing(spacing: spacing, buttons: buttons)
                                    })
                                    
                                    it("shifts buttons x value", closure: {
                                        sut.selectionSpacing = spacing
                                        let buttonOne = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 50))
                                        let buttonTwo = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
                                        let buttonThree = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 40))
                                        buttons = [buttonOne, buttonTwo, buttonThree]
                                        dataSource.buttons = buttons
                                        sut.refresh()
                                        
                                        expect(buttonOne.frame.origin.x).to(equal(0.0))
                                        expect(buttonTwo.frame.origin.x).to(equal(buttonOne.frame.width + spacing))
                                        expect(buttonThree.frame.origin.x).to(equal(buttonTwo.frame.origin.x + buttonTwo.frame.width + spacing))
                                    })
                                })
                                
                                func testWithSpacing(spacing: CGFloat, buttons: [UIButton]) {
                                    dataSource.buttons = buttons
                                    let count = CGFloat(buttons.count - 1)
                                    let space = spacing * count
                                    var expected = space
                                    for but in buttons {
                                        expected += but.frame.width
                                    }
                                    sut.refresh()
                                    expect(sut.contentSize).to(equal(expected))
                                }
                            })
                        })
                    })
                })
            })
        }
    }
}

