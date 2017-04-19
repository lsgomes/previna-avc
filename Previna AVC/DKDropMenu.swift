//The DKDropMenu License
//
//Copyright (c) 2015-2016 David Kopec
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//SOFTWARE.

//
//  DKDropMenu.swift
//  DKDropMenu
//
//  Created by David Kopec on 6/5/15.
//  Copyright (c) 2015 Oak Snow Consulting. All rights reserved.
//

import UIKit

/// Delegate protocol for receiving change in list selection
@objc public protocol DKDropMenuDelegate {
    func itemSelected(_ withIndex: Int, name:String, dropMenu: DKDropMenu)
    @objc optional func collapsedChangedForNewRect(_ NewRect: CGRect, _ collapsed: Bool, _ dropMenu :DKDropMenu)
    //@objc optional func collapsedChanged(_ dropMenu: DKDropMenu, _ collapsed: Bool)
}

/// A simple drop down list like expandable menu for iOS
@IBDesignable
open class DKDropMenu: UIView {
    
    @IBInspectable open var itemHeight: CGFloat = 44
    @IBInspectable open var selectedFontName: String = "HelveticaNeue-Thin"
    @IBInspectable open var listFontName: String = "HelveticaNeue-Thin"
    @IBInspectable open var textColor: UIColor = UIColor.darkGray
    @IBInspectable open var outlineColor: UIColor = UIColor.lightGray
    @IBInspectable open var selectedColor: UIColor = UIColor.green
    weak open var delegate: DKDropMenuDelegate? = nil  //notified when a selection occurs
    fileprivate var items: [String] = [String]()
    open var selectedItem: String? = nil {
        didSet {
            setNeedsDisplay()
        }
    }
    open var collapsed: Bool = true {
        didSet {

            print(self.bounds)
            print(self.frame)
            
//            delegate?.collapsedChanged?(self, collapsed)
//            //animate collapsing or opening
//            UIView.animate(withDuration: 0.5, delay: 0, options: .transitionCrossDissolve, animations: {
//                var tempFrame = self.frame
//                if (self.collapsed) {
//                    tempFrame.size.height = self.itemHeight
//                } else {
//                    if (self.items.count > 1 && self.selectedItem != nil) {
//                        tempFrame.size.height = self.itemHeight * CGFloat(self.items.count)
//                    } else if (self.items.count > 0 && self.selectedItem == nil) {
//                        tempFrame.size.height = self.itemHeight * CGFloat(self.items.count) + self.itemHeight
//                    }
//                }
//                self.frame = tempFrame
//                self.invalidateIntrinsicContentSize()
//            }, completion: nil)
//            setNeedsDisplay()
            

            var tempFrame = self.frame
            var tempBounds = self.bounds
            _ = self.layer.bounds
            if (self.collapsed) {
                tempFrame.size.height = self.itemHeight
                tempBounds = CGRect(x: 0, y: 0, width: 139, height: 31)
               //tempLayerBounds = CGRect(x: 0, y: 0, width: 139, height: 31)

            } else {
                if (self.items.count > 1 && self.selectedItem != nil) {
                    let height = self.itemHeight * CGFloat(self.items.count)
                    tempFrame.size.height = height
                    tempBounds = CGRect(x: 0, y: 0, width: 139, height: height)
                    //tempLayerBounds = CGRect(x: 0, y: 0, width: 139, height: height)
                } else if (self.items.count > 0 && self.selectedItem == nil) {
                    let height = self.itemHeight * CGFloat(self.items.count) + self.itemHeight
                    tempFrame.size.height = height
                    tempBounds = CGRect(x: 0, y: 0, width: 139, height: height)
                    //tempLayerBounds = CGRect(x: 0, y: 0, width: 139, height: height)

                }
            }
            //delegate?.collapsedChanged?(self, collapsed)
            delegate?.collapsedChangedForNewRect!(tempFrame, collapsed, self)
            //animate collapsing or opening
//            UIView.animate(withDuration: 0.5, delay: 0, options: .transitionCrossDissolve, animations: {
//            
//            self.frame = tempFrame
//                //self.bounds = tempBounds
//                //self.layer.bounds = tempLayerBounds
//            self.invalidateIntrinsicContentSize()
//            }, completion: nil)
            self.frame = tempFrame
            self.invalidateIntrinsicContentSize()
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init!(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NotificationCenter.default.addObserver(self, selector: #selector(DKDropMenu.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)

    }
    
    func rotated()
    {
        self.invalidateIntrinsicContentSize()
        setNeedsDisplay()
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "rotated"), object: nil)
    }
    
    // MARK: Overridden standard UIView methods
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        if (items.count < 2 || collapsed) {
            return CGSize(width: size.width, height: itemHeight)
        } else {
            return CGSize(width: size.width, height: (itemHeight * CGFloat(items.count)))
        }
    }
    
    override open var intrinsicContentSize: CGSize {
        if (items.count < 2 || collapsed) {
            return CGSize(width: bounds.size.width, height: itemHeight)
        } else {
            return CGSize(width: bounds.size.width, height: (itemHeight * CGFloat(items.count)))
        }
    }
    
    override open func draw(_ rect: CGRect) {
        // Drawing code
        //draw first box regardless
        let context = UIGraphicsGetCurrentContext()
        outlineColor.setStroke()
        context?.setLineWidth(1.0)
        context?.move(to: CGPoint(x: 0, y: itemHeight))
        context?.addLine(to: CGPoint(x: 0, y: 0.5))
        context?.addLine(to: CGPoint(x: frame.size.width, y: 0.5))
        context?.addLine(to: CGPoint(x: frame.size.width, y: itemHeight))
        context?.strokePath()
        if let sele = selectedItem {
            //draw item text
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            let attrs = [NSFontAttributeName: UIFont(name: selectedFontName, size: 14)!, NSParagraphStyleAttributeName: paragraphStyle, NSForegroundColorAttributeName: textColor]
            if (collapsed) {
                let tempS = "\(sele)"  //put chevron down facing here if right unicode found
                tempS.draw(in: CGRect(x: 20, y: itemHeight / 2 - 10, width: frame.size.width - 40, height: 20), withAttributes: attrs)
            } else {
                let tempS = "\(sele)"  //put chevron up facing here if right unicode found
                tempS.draw(in: CGRect(x: 20, y: itemHeight / 2 - 10, width: frame.size.width - 40, height: 20), withAttributes: attrs)
            }
            //draw selected line
            selectedColor.setStroke()
            context?.move(to: CGPoint(x: 0, y: itemHeight - 2))
            context?.setLineWidth(4.0)
            context?.addLine(to: CGPoint(x: frame.width, y: itemHeight - 2))
            context?.strokePath()
        } else {
            context?.move(to: CGPoint(x: 0, y: itemHeight - 1))
            context?.setLineWidth(1.0)
            context?.addLine(to: CGPoint(x: frame.width, y: itemHeight - 1))
            context?.strokePath()
        }
        //draw lower boxes
        if (!collapsed && items.count > 1) {
            var currentY = itemHeight
            for item in items {
                if item == selectedItem {
                    continue
                }
                //draw box
                outlineColor.setStroke()
                context?.setLineWidth(1.0)
                context?.move(to: CGPoint(x: 0, y: currentY))
                context?.addLine(to: CGPoint(x: 0, y: currentY + itemHeight))
                context?.strokePath()
                context?.setLineWidth(0.5)
                context?.move(to: CGPoint(x: 0, y: currentY + itemHeight - 1))
                context?.addLine(to: CGPoint(x: frame.size.width, y: currentY + itemHeight - 1))
                context?.strokePath()
                context?.setLineWidth(1.0)
                context?.move(to: CGPoint(x: frame.size.width, y: currentY + itemHeight))
                context?.addLine(to: CGPoint(x: frame.size.width, y: currentY))
                context?.strokePath()
                //draw item text
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = .center
                let attrs = [NSFontAttributeName: UIFont(name: listFontName, size: 14)!, NSParagraphStyleAttributeName: paragraphStyle, NSForegroundColorAttributeName: textColor]
                item.draw(in: CGRect(x: 20, y: currentY + (itemHeight / 2 - 10), width: frame.size.width - 40, height: 20), withAttributes: attrs)
                currentY += itemHeight
            }
        }
    }
    
    // MARK: Add or remove items
    /// Add an array of items to the menu
    open func add(_ names: [String]) {
        for name in names {
            add(name: name)
        }
    }
    
    /// Add a single item to the menu
    open func add(name: String) {
        //if we have no selected items, we'll take it
        if items.isEmpty {
            selectedItem = name
        }
        
        items.append(name)
        
        //animate change
        if (!collapsed && items.count > 1) {
            UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseOut, animations: {
                var tempFrame = self.frame
                tempFrame.size.height = self.itemHeight * CGFloat(self.items.count)
                self.frame = tempFrame
            }, completion: nil)
        }
        
        //refresh display
        setNeedsDisplay()
    }
    
    /// Remove a single item from the menu
    open func remove(at index: Int) {
        if (items[index] == selectedItem) {
            selectedItem = nil
        }
        items.remove(at: index)
        //animate change
        if (!collapsed && items.count > 1) {
            UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseOut, animations: {
                var tempFrame = self.frame
                tempFrame.size.height = self.itemHeight * CGFloat(self.items.count)
                self.frame = tempFrame
            }, completion: nil)
        } else if (!collapsed) {
            UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseOut, animations: {
                var tempFrame = self.frame
                tempFrame.size.height = self.itemHeight
                self.frame = tempFrame
            }, completion: nil)
        }
        
        setNeedsDisplay()
    }
    
    /// Remove the first occurence of item named *name*
    open func remove(_ name: String) {
        if let index = items.index(of: name) {
            remove(at: index)
        }
    }
    
    /// Remove all items
    open func removeAll() {
        selectedItem = nil
        items.removeAll()
        if (!collapsed) {
            UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseOut, animations: {
                var tempFrame = self.frame
                tempFrame.size.height = self.itemHeight
                self.frame = tempFrame
            }, completion: nil)
        }
        
        setNeedsDisplay()
    }
    
    // MARK: Events
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = touches.first!
        let point: CGPoint = touch.location(in: self)
        if point.y > itemHeight {
            if let dele = delegate {
                var thought = Int(point.y / itemHeight) - 1
                if let sele = selectedItem {
                    if items.index(of: sele)! <= thought {
                        thought += 1
                    }
                }
                dele.itemSelected(thought, name: items[thought], dropMenu: self)
                selectedItem = items[thought]
            }
        }
        collapsed = !collapsed
    }
    
//    override open func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//        if (!self.clipsToBounds && !self.isHidden && self.alpha > 0.0) {
//            let subviews = self.subviews.reversed()
//            for member in subviews {
//                let subPoint = member.convert(point, from: self)
//                if let result:UIView = member.hitTest(subPoint, with:event) {
//                    return result;
//                }
//            }
//        }
//        return nil
//    }
}
