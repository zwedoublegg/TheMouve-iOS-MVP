//
//  String.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 4/2/24.
//

import Foundation
import UIKit

extension String {
    func heightWithConstrainedWidth(_ width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                            attributes: [NSAttributedString.Key.font : font], 
                                            context: nil)
        
        return ceil(boundingBox.height)
    }
}
