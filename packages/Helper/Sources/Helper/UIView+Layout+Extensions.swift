//
//  File.swift
//  
//
//  Created by Serhan Aksut on 18.07.2021.
//

import UIKit

// MARK: - Align Edge
public extension UIView {
    @discardableResult
    func alignFitEdges(insetedBy: CGFloat = .zero) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            leadingAnchor.constraint(
                equalTo: superview!.leadingAnchor,
                constant: insetedBy
            ),
            trailingAnchor.constraint(
                equalTo: superview!.trailingAnchor,
                constant: -insetedBy
            ),
            topAnchor.constraint(
                equalTo: superview!.topAnchor,
                constant: insetedBy
            ),
            bottomAnchor.constraint(
                equalTo: superview!.bottomAnchor,
                constant: -insetedBy
            )
        ]
        return constraints
    }
    
    @discardableResult
    func alignEdges(
        leading: CGFloat = .zero,
        trailing: CGFloat = .zero,
        top: CGFloat = .zero,
        bottom: CGFloat = .zero
    ) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            leadingAnchor.constraint(
                equalTo: superview!.leadingAnchor,
                constant: leading
            ),
            trailingAnchor.constraint(
                equalTo: superview!.trailingAnchor,
                constant: trailing
            ),
            topAnchor.constraint(
                equalTo: superview!.topAnchor,
                constant: top
            ),
            bottomAnchor.constraint(
                equalTo: superview!.bottomAnchor,
                constant: bottom
            )
        ]
        return constraints
    }
}

// MARK: - Align Directions
public extension UIView {
    @discardableResult
    func alignLeading(
        to view: UIView,
        offset: CGFloat = .zero
    ) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let isSuperviewRelation = view == superview
        let anchor = isSuperviewRelation
            ? view.leadingAnchor
            : view.trailingAnchor
        
        let constraint = leadingAnchor.constraint(
            equalTo: anchor,
            constant: offset
        )
        return constraint
    }
    
    @discardableResult
    func alignTrailing(
        to view: UIView,
        offset: CGFloat = .zero
    ) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let isSuperviewRelation = view == superview
        let anchor = isSuperviewRelation
            ? view.trailingAnchor
            : view.leadingAnchor
        
        let constraint = trailingAnchor.constraint(
            equalTo: anchor,
            constant: offset
        )
        return constraint
    }
    
    @discardableResult
    func alignTop(
        to view: UIView,
        offset: CGFloat = .zero
    ) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let isSuperviewRelation = view == superview
        let anchor = isSuperviewRelation
            ? view.topAnchor
            : view.bottomAnchor
        
        let constraint = topAnchor.constraint(
            equalTo: anchor,
            constant: offset
        )
        return constraint
    }
    
    @discardableResult
    func alignBottom(
        to view: UIView,
        offset: CGFloat = .zero
    ) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let isSuperviewRelation = view == superview
        let anchor = isSuperviewRelation
            ? view.bottomAnchor
            : view.topAnchor
        
        let constraint = bottomAnchor.constraint(
            equalTo: anchor,
            constant: offset
        )
        return constraint
    }
}

// MARK: - Centering
public extension UIView {
    @discardableResult
    func center(in view: UIView, offset: CGPoint = .zero) -> [NSLayoutConstraint] {
        let centerXConstraint = centerXWith(
            centerXAnchor,
            view.centerXAnchor,
            constant: offset.x
        )
        let centerYConstraint = centerYWith(
            centerYAnchor,
            view.centerYAnchor,
            constant: offset.y
        )
        let constraints: [NSLayoutConstraint] = [
            centerXConstraint,
            centerYConstraint
        ]
        return constraints
    }
    
    @discardableResult
    func centerX(in view: UIView, offset: CGFloat = .zero) -> NSLayoutConstraint {
        let constraint = centerXWith(
            centerXAnchor,
            view.centerXAnchor,
            constant: offset
        )
        return constraint
    }
    
    @discardableResult
    func centerY(in view: UIView, offset: CGFloat = .zero) -> NSLayoutConstraint {
        let constraint = centerYWith(
            centerYAnchor,
            view.centerYAnchor,
            constant: offset
        )
        return constraint
    }
}

// MARK: - Sizing
public extension UIView {
    @discardableResult
    func alignWidth(_ constant: CGFloat) -> NSLayoutConstraint {
        sizeWith(widthAnchor, constant: constant)
    }
    
    @discardableResult
    func alignHeight(_ constant: CGFloat) -> NSLayoutConstraint {
        sizeWith(heightAnchor, constant: constant)
    }
    
    @discardableResult
    func alignSize(width: CGFloat, height: CGFloat) -> [NSLayoutConstraint] {
        let widthConstraint = sizeWith(widthAnchor, constant: width)
        let heightConstraint = sizeWith(heightAnchor, constant: height)
        let constraints = [widthConstraint, heightConstraint]
        return constraints
    }
    
    @discardableResult
    func equalWidth(
        with view: UIView,
        difference: CGFloat = .zero
    ) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        return widthAnchor.constraint(
            equalTo: view.widthAnchor,
            constant: difference
        )
    }
    
    @discardableResult
    func equalHeight(
        with view: UIView,
        difference: CGFloat = .zero
    ) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        return heightAnchor.constraint(
            equalTo: view.heightAnchor,
            constant: difference
        )
    }
}

// MARK: - Internal Workers
public extension UIView {
    func sizeWith(
        _ dimension: NSLayoutDimension,
        constant: CGFloat
    ) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = dimension.constraint(
            equalToConstant: constant
        )
        return constraint
    }
    
    func centerXWith(
        _ referanceDimesion: NSLayoutXAxisAnchor,
        _ relationDimension: NSLayoutXAxisAnchor,
        constant: CGFloat
    ) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = referanceDimesion.constraint(
            equalTo: relationDimension,
            constant: constant
        )
        return constraint
    }
    
    func centerYWith(
        _ referanceDimesion: NSLayoutYAxisAnchor,
        _ relationDimension: NSLayoutYAxisAnchor,
        constant: CGFloat
    ) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = referanceDimesion.constraint(
            equalTo: relationDimension,
            constant: constant
        )
        return constraint
    }
}

// MARK: - Activation
public extension Array where Element == NSLayoutConstraint {
    func activate() {
        NSLayoutConstraint.activate(self)
    }
}

public extension NSLayoutConstraint {
    func activate() {
        NSLayoutConstraint.activate([self])
    }
}

// MARK: - Safe Area
public extension UIView {
    var safeAreaTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.topAnchor
        } else {
            return self.topAnchor
        }
    }

    var safeAreaLeftAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.leadingAnchor
        } else {
            return self.leftAnchor
        }
    }

    var safeAreaRightAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.trailingAnchor
        } else {
            return self.rightAnchor
        }
    }

    var safeAreaBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.bottomAnchor
        } else {
            return self.bottomAnchor
        }
    }
}
