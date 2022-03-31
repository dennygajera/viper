//
//  Reusable.swift
//  ViPER
//
//  Created by Darshan Gajera on 30/03/22.
//

import Foundation
import UIKit

protocol ReusableView: AnyObject {}

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UIViewController: ReusableView { }

extension UIStoryboard {
    
    static var main : UIStoryboard{
        return UIStoryboard(name: "Main", bundle: nil)
    }

    func instantiateViewController<T>() -> T where T: ReusableView {
        return instantiateViewController(withIdentifier: T.reuseIdentifier) as! T
    }
}

extension UITableViewCell: ReusableView { }
extension UITableView {
    func dequeueReusableCell<T>(for index : IndexPath) -> T where T : ReusableView {
        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: index) as! T
    }
}
