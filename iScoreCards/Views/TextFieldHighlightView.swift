//
//  TextFieldHighlightView.swift
//  iScoreCards
//
//  Created by Michael DHaem on 12/23/21.
//

import SwiftUI
//import Combine

struct TextFieldHighlightView: View {
    var body: some View {
        TextField("Placeholder", text: .constant("This is text data"))
            .onReceive(NotificationCenter.default.publisher(for: UITextField.textDidBeginEditingNotification)) { obj in
                if let textField = obj.object as? UITextField {
                    textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument)
                }
            }
    }
}

struct TextFieldHighlightView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldHighlightView()
    }
}
