////
////  SelectionScrollBarTests.swift
////  SelectionScrollBar_Example
////
////  Created by AJ Bartocci on 4/2/18.
////  Copyright © 2018 CocoaPods. All rights reserved.
////
//
//import Quick
//import Nimble
//@testable import SelectionScrollBar
//
//class SelectionScrollBarSpec: QuickSpec {
//    override func spec() {
//        describe("SelectionScrollBar") {
//            
//            var sut: SelectionScrollBar!
//            beforeEach {
//                sut = SelectionScrollBar(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
//            }
//            
//            context("nil datasource", {
//                
//                beforeEach {
//                    sut.dataSource = nil
//                }
//                
//                describe("refresh", {
//                    
//                    it("has no content", closure: {
//                        sut.refresh()
//                        expect(sut.contentSize).to(equal(0))
//                    })
//                })
//                
//            })
//            
//            context("non nil datasource", {
//                
//                var dataSource: SelectionScrollBarTestDataSource!
//                beforeEach {
//                    dataSource = SelectionScrollBarTestDataSource(buttons: [])
//                    sut.dataSource = dataSource
//                }
//                
//                describe("refresh", {
//                    context("no selections", {
//                        it("has 0 contentSize", closure: {
//                            dataSource.buttons = []
//                            sut.refresh()
//                            expect(sut.contentSize).to(equal(0))
//                        })
//                    })
//                    
//                    context("selections", {
//                        context("one selection", {
//                            
//                            var button: UIButton!
//                            beforeEach {
//                                button = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
//                                dataSource.buttons = [button]
//                                sut.frame.size.width = 100
//                            }
//                            
//                            it("has content size equal to button width", closure: {
//                                button.frame.size.width = 150
//                                sut.refresh()
//                                expect(sut.contentSize).to(equal(button.frame.width))
//                                
//                                button.frame.size.width = 120
//                                sut.refresh()
//                                expect(sut.contentSize).to(equal(button.frame.width))
//                            })
//                        })
//                        
//                        context("multiple selections", {
//                            
//                            var spacing: CGFloat = 0.0
//                            var buttons: [UIButton]!
//                            beforeEach {
//                                buttons = []
//                                spacing = 0.0
//                            }
//                            
//                            context("spacing equal to 0", {
//                                beforeEach {
//                                    spacing = 0.0
//                                }
//                                
//                                it("combines buttons and content size", closure: {
//                                    sut.selectionSpacing = spacing
//                                    let buttonOne = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 50))
//                                    let buttonTwo = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
//                                    buttons = [buttonOne, buttonTwo]
//                                    testWithSpacing(spacing: spacing, buttons: buttons)
//                                    
//                                    let buttonThree = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 40))
//                                    buttons.append(buttonThree)
//                                    testWithSpacing(spacing: spacing, buttons: buttons)
//                                })
//                                
//                                it("shifts buttons x value", closure: {
//                                    sut.selectionSpacing = spacing
//                                    let buttonOne = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 50))
//                                    let buttonTwo = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
//                                    let buttonThree = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 40))
//                                    buttons = [buttonOne, buttonTwo, buttonThree]
//                                    dataSource.buttons = buttons
//                                    sut.refresh()
//                                    
//                                    expect(buttonOne.frame.origin.x).to(equal(0.0))
//                                    expect(buttonTwo.frame.origin.x).to(equal(buttonOne.frame.width + spacing))
//                                    expect(buttonThree.frame.origin.x).to(equal(buttonTwo.frame.origin.x + buttonTwo.frame.width + spacing))
//                                })
//                            })
//                            
//                            context("spacing equal to 10", {
//                                beforeEach {
//                                    spacing = 10.0
//                                }
//                                
//                                it("combines buttons and content size", closure: {
//                                    sut.selectionSpacing = spacing
//                                    let buttonOne = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 50))
//                                    let buttonTwo = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
//                                    buttons = [buttonOne, buttonTwo]
//                                    testWithSpacing(spacing: spacing, buttons: buttons)
//                                    
//                                    let buttonThree = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 40))
//                                    buttons.append(buttonThree)
//                                    testWithSpacing(spacing: spacing, buttons: buttons)
//                                })
//                                
//                                it("shifts buttons x value", closure: {
//                                    sut.selectionSpacing = spacing
//                                    let buttonOne = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 50))
//                                    let buttonTwo = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
//                                    let buttonThree = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 40))
//                                    buttons = [buttonOne, buttonTwo, buttonThree]
//                                    dataSource.buttons = buttons
//                                    sut.refresh()
//                                    
//                                    expect(buttonOne.frame.origin.x).to(equal(0.0))
//                                    expect(buttonTwo.frame.origin.x).to(equal(buttonOne.frame.width + spacing))
//                                    expect(buttonThree.frame.origin.x).to(equal(buttonTwo.frame.origin.x + buttonTwo.frame.width + spacing))
//                                })
//                            })
//                            
//                            func testWithSpacing(spacing: CGFloat, buttons: [UIButton]) {
//                                dataSource.buttons = buttons
//                                let count = CGFloat(buttons.count - 1)
//                                let space = spacing * count
//                                var expected = space
//                                for but in buttons {
//                                    expected += but.frame.width
//                                }
//                                sut.refresh()
//                                expect(sut.contentSize).to(equal(expected))
//                            }
//                        })
//                    })
//                })
//            })
//        }
//    }
//}
//
