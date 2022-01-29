//
//  String+dateFormatter.swift
//  marvel
//
//  Created by Kagan Girgin on 1/29/22.
//

import Foundation

extension String {
    func dateFormatter() -> String
    {
        return self.count < 2 ? "0\(self)" : self
    }
}
