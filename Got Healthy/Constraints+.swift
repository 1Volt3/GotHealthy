//
//  Constraints+.swift
//  Got Healthy
//
//  Created by Josh Rosenzweig on 3/17/17.
//  Copyright © 2017 Volt. All rights reserved.
//

import UIKit


struct Constraint{
    var identifier: String?
    
    var attribute: NSLayoutAttribute = .centerX
    var secondAttribute: NSLayoutAttribute = .notAnAttribute
    var constant: CGFloat = 0
    var multiplier: CGFloat = 1
    var relation: NSLayoutRelation = .equal
}

func attributes(_ attrs:NSLayoutAttribute...) -> [NSLayoutAttribute]{
    return attrs
}

//infix operator >>- { associativity left precedence 160 }
infix operator >>- : DefaultPrecedence


@discardableResult func >>- <T: UIView> (lhs: (T,T), apply: (inout Constraint) -> () ) -> NSLayoutConstraint {
    var const = Constraint()
    apply(&const)
    
    const.secondAttribute = .notAnAttribute == const.secondAttribute ? const.attribute : const.secondAttribute
    
    let constraint = NSLayoutConstraint(item: lhs.0,
                                        attribute: const.attribute,
                                        relatedBy: const.relation,
                                        toItem: lhs.1,
                                        attribute: const.secondAttribute,
                                        multiplier: const.multiplier,
                                        constant: const.constant)
    
    constraint.identifier = const.identifier
    
    NSLayoutConstraint.activate([constraint])
    return constraint
}


@discardableResult  func >>- <T: UIView> (lhs: T, apply: (inout Constraint) -> () ) -> NSLayoutConstraint {
    var const = Constraint()
    apply(&const)
    
    let constraint = NSLayoutConstraint(item: lhs,
                                        attribute: const.attribute,
                                        relatedBy: const.relation,
                                        toItem: nil,
                                        attribute: const.attribute,
                                        multiplier: const.multiplier,
                                        constant: const.constant)
    constraint.identifier = const.identifier
    
    NSLayoutConstraint.activate([constraint])
    return constraint
}



func >>- <T:UIView> (lhs: (T,T),attributes: [NSLayoutAttribute]){
    for attribute in attributes{
        lhs >>- { (i: inout Constraint) in
            i.attribute = attribute
        }
    }
}


func >>- <T:UIView> (lhs: T, attributes: [NSLayoutAttribute]){
    for attribute in attributes{
        lhs >>- { (i: inout Constraint) in
            i.attribute = attribute
        }
    }
}

