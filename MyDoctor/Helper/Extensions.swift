//
//  Extensions.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 31.01.26.
//

import UIKit

extension UIViewController {
    func showMessage(title: String?, message: String?, buttonTitle: String = "Ok") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .destructive, handler: {
            [weak self] _ in
            guard let self else {return}
            self.dismiss(animated: true)
        }))
        present(alert, animated: true)
    }
}

extension UIView {
    @discardableResult
    func top(_ anchor: NSLayoutYAxisAnchor, _ constant: CGFloat = .zero, _ isActive: Bool = true) -> (UIView, NSLayoutConstraint) {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = topAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.isActive = isActive
        return (self, constraint)
    }
    
    @discardableResult
    func bottom(_ anchor: NSLayoutYAxisAnchor, _ constant: CGFloat = .zero, _ isActive: Bool = true) -> (UIView, NSLayoutConstraint) {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = bottomAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.isActive = isActive
        return (self, constraint)
    }
    
    @discardableResult
    func centerY(_ anchor: NSLayoutYAxisAnchor, _ constant: CGFloat = .zero, _ isActive: Bool = true) -> (UIView, NSLayoutConstraint) {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = centerYAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.isActive = isActive
        return (self, constraint)
    }
    
    @discardableResult
    func leading(_ anchor: NSLayoutXAxisAnchor, _ constant: CGFloat = .zero, _ isActive: Bool = true) -> (UIView, NSLayoutConstraint) {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = leadingAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.isActive = isActive
        return (self, constraint)
    }
    
    @discardableResult
    func trailing(_ anchor: NSLayoutXAxisAnchor, _ constant: CGFloat = .zero, _ isActive: Bool = true) -> (UIView, NSLayoutConstraint) {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = trailingAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.isActive = isActive
        return (self, constraint)
    }
    
    @discardableResult
    func centerX(_ anchor: NSLayoutXAxisAnchor, _ constant: CGFloat = .zero, _ isActive: Bool = true) -> (UIView, NSLayoutConstraint) {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = centerXAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.isActive = isActive
        return (self, constraint)
    }
    
    @discardableResult
    func width(_ anchor: NSLayoutDimension, _ constant: CGFloat = .zero, _ isActive: Bool = true) -> (UIView, NSLayoutConstraint) {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = widthAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.isActive = isActive
        return (self, constraint)
    }
    @discardableResult
    func width(_ anchor: NSLayoutDimension, multiplier: CGFloat, _ constant: CGFloat = .zero, _ isActive: Bool = true) -> (UIView, NSLayoutConstraint) {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = widthAnchor.constraint(equalTo: anchor,multiplier: multiplier, constant: constant)
        constraint.isActive = isActive
        return (self, constraint)
    }
    
    @discardableResult
    func width( _ constant: CGFloat = .zero, _ isActive: Bool = true) -> (UIView, NSLayoutConstraint) {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = widthAnchor.constraint(equalToConstant: constant)
        constraint.isActive = isActive
        return (self, constraint)
    }
    
    @discardableResult
    func height(_ anchor: NSLayoutDimension, _ constant: CGFloat = .zero, _ isActive: Bool = true) -> (UIView, NSLayoutConstraint) {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = heightAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.isActive = isActive
        return (self, constraint)
    }
    
    @discardableResult
    func height( _ constant: CGFloat = .zero, _ isActive: Bool = true) -> (UIView, NSLayoutConstraint) {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = heightAnchor.constraint(equalToConstant: constant)
        constraint.isActive = isActive
        return (self, constraint)
    }
    
    func fillSuperview(padding: UIEdgeInsets = .zero) {
        guard let superview else { return }
        top(superview.topAnchor, padding.top)
        bottom(superview.bottomAnchor, padding.bottom)
        leading(superview.leadingAnchor, padding.left)
        trailing(superview.trailingAnchor, padding.right)
    }
    func fillSuperviewSafeArea(padding: UIEdgeInsets = .zero) {
        guard let superview else { return }
        top(superview.safeAreaLayoutGuide.topAnchor, padding.top)
        bottom(superview.safeAreaLayoutGuide.bottomAnchor, padding.bottom)
        leading(superview.safeAreaLayoutGuide.leadingAnchor, padding.left)
        trailing(superview.safeAreaLayoutGuide.trailingAnchor, padding.right)
    }
    
    func addSubviews(_ views: UIView...) {
        for i in views {
            addSubview(i)
        }
    }
    
    func showLoader() {
        let loader = UIActivityIndicatorView(style: .large)
        addSubview(loader)
        loader.fillSuperviewSafeArea()
        loader.startAnimating()
    }
    
    func hideLoader() {
        for i in subviews {
            if i is UIActivityIndicatorView {
                i.removeFromSuperview()
            }
        }
    }
    
}

extension UIImageView {
    func setImage(urlString: String?) {
        guard let urlString, let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url, completionHandler: {
            [weak self] data, _, _ in
            DispatchQueue.main.async {
                guard let self, let data else {return}
                self.image = UIImage(data: data)
            }
        }).resume()
    }
}

extension UIImage {
    func resizeImage(newWidth: CGFloat) -> UIImage? {
        
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        self.draw(in: CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

extension Notification.Name {
    static let watchListUpdated = Notification.Name("watchListUpdated")// new
}
