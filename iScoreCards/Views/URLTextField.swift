//
//  URLTextField.swift
//  iScoreCards
//
//  Created by Michael DHaem on 6/23/21.
//

import Foundation
import SwiftUI

struct URLTextField: UIViewRepresentable {
    func makeUIView(context: Context) -> UITextField {
            let textField = UITextField()
            //textField.selectAll(<#T##sender: Any?##Any?#>)
            textField.borderStyle = .roundedRect
            textField.placeholder = "URL"

            textField.autocapitalizationType = .none
            textField.autocorrectionType = .no
            textField.spellCheckingType = .no
            textField.keyboardType = .URL

            return textField
        }

        func updateUIView(_ view: UITextField, context: Context) {

        }
}
