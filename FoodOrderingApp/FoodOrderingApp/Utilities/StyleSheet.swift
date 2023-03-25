//
//  TextStyles.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/8/23.
//

import Foundation
import SwiftUI

extension TextField {
    
    func normalTextInput() -> some View {
        self.font(Font.custom("Karla-Regular", size: 16))
            .foregroundColor(Color("HighlightColor2"))
            .padding(12)
            .background(Color("HighlightColor1"))
            .cornerRadius(8)
            .disableAutocorrection(true)
    }
    
    func emailTextInput() -> some View {
        self.font(Font.custom("Karla-Regular", size: 16))
            .foregroundColor(Color("HighlightColor2"))
            .padding(12)
            .background(Color("HighlightColor1"))
            .cornerRadius(8)
            .disableAutocorrection(true)
            .keyboardType(.emailAddress)
    }
    
    func numberTextInput() -> some View {
        self.font(Font.custom("Karla-Regular", size: 16))
            .foregroundColor(Color("HighlightColor2"))
            .padding(12)
            .background(Color("HighlightColor1").cornerRadius(8))
    }
    
}

extension TextEditor {
    
    func normalTextInput() -> some View {
        self.font(Font.custom("Karla-Regular", size: 16))
            .foregroundColor(Color("HighlightColor2"))
            .frame(height: 38)
            .colorMultiply(Color("HighlightColor1"))
            .cornerRadius(8)
            .disableAutocorrection(true)
    }
    
    func emailTextInput() -> some View {
        self.font(Font.custom("Karla-Regular", size: 16))
            .foregroundColor(Color("HighlightColor2"))
            .frame(height: 38)
            .colorMultiply(Color("HighlightColor1"))
            .cornerRadius(8)
            .disableAutocorrection(true)
            .keyboardType(.emailAddress)
    }
    
    func numberTextInput() -> some View {
        self.font(Font.custom("Karla-Regular", size: 16))
            .foregroundColor(Color("HighlightColor2"))
            .frame(height: 38)
            .colorMultiply(Color("HighlightColor1"))
            .cornerRadius(8)
    }
    
}

extension Text {
    
    
    func formHeaderSection() -> some View {
        self.font(Font.custom("Karla-ExtraBold", size: 16))
            .padding(.top)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
    }
    
    func paragraphText() -> some View {
        self.tint(Color("HighlightColor2"))
            .font(Font.custom("Karla-Regular", size: 16))
    }
    
    func primaryButton() -> some View {
        self.font(Font.custom("Karla-Bold", size: 18))
            .foregroundColor(Color("HighlightColor2"))
            .frame(maxWidth: .infinity)
            .frame(height: 45)
            .background(Color("PrimaryColor2").cornerRadius(16))
            .padding(.horizontal,20)
    }
    
    func categoryButton(isButtonSelected: Bool) -> some View {
        self.font(Font.custom("Karla-ExtraBold", size: 16))
            .foregroundColor(!isButtonSelected ? Color("PrimaryColor1") : Color("SecundaryColor3"))
            .frame(width: 80, height: 40)
            .background(!isButtonSelected ? Color("SecundaryColor3") : Color("PrimaryColor1"))
            .cornerRadius(16)
    }
    
    func secondaryButton() -> some View {
        self.font(Font.custom("Karla-Bold", size: 18))
            .foregroundColor(Color("HighlightColor2"))
            .frame(maxWidth: .infinity)
            .frame(height: 45)
            .background(Color("HighlightColor1").cornerRadius(16))
            .padding(.horizontal,20)
    }
    
    func cardTitle() -> some View {
        self.font(Font.custom("Karla-Bold", size: 18))
    }
    
    func sectionTitle() -> some View {
        self.font(Font.custom("Karla-ExtraBold", size: 20))
    }
    
    func leadText() -> some View {
        self.font(Font.custom("Karla-Medium", size: 18))
    }
    
    func subTitle() -> some View {
        self.font(Font.custom("MarkaziText-Regular", size: 40))
    }
    
    func displayText() -> some View {
        self.font(Font.custom("MarkaziText-Medium", size: 64))
    }
    
    func sectionCategory() -> some View {
        self.font(Font.custom("Karla-ExtraBold", size: 16))
    }
}

extension String {
 func convertToInternationalFormat() -> String {
    let isMoreThanTenDigit = self.count > 10
    _ = self.startIndex
    var newstr = ""
    if isMoreThanTenDigit {
        newstr = "\(self.dropFirst(self.count - 10))"
    }
    else if self.count == 10{
        newstr = "\(self)"
    }
    else {
        return "number has only \(self.count) digits"
    }
    if  newstr.count == 10 {
        let internationalString = "(\(newstr.dropLast(7))) \(newstr.dropLast(4).dropFirst(3)) \(newstr.dropFirst(6).dropLast(2)) \(newstr.dropFirst(8))"
        newstr = internationalString
    }
    return newstr
 }
 }
