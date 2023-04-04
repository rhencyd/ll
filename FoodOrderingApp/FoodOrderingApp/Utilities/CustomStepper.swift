//
//  CustomStepper.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/16/23.
//

import SwiftUI

struct CustomStepper: View {
    
    @Binding var stepperValue: Int
    let needStroke: Bool
    let fillColor: Color
    
    var body: some View {
        
        ZStack {
            
            if needStroke {
                Capsule(style: .circular)
                    .stroke(Color.black)
                    .frame(width: 100, height: 35)
            } else {
                Capsule(style: .circular)
                    .foregroundColor(fillColor)
                    .frame(width: 100, height: 35)
            }
            
            
            HStack {
                
                Text("-")
                    .sectionCategory()
                    .onTapGesture {
                        if stepperValue > 0 {
                            stepperValue -= 1
                        }
                    }
                
                Spacer()
                
                if stepperValue > 0 {
                    Text("\(stepperValue)")
                        .sectionCategory()
                } else {
                    Image(systemName: "square")
                }
                
                
                Spacer()
                
                Text("+")
                    .sectionCategory()
                    .onTapGesture {
                        if stepperValue < 10 {
                            stepperValue += 1
                        }
                    }
            }
            .padding(.horizontal, 12)
            
            
        }
        
        .frame(width: 100, height: 35)
        
    }
}

struct CustomStepper2: View {
    
    @Binding var stepperValue: Int
    let needStroke: Bool
    let fillColor: Color
    
    var body: some View {
        
        ZStack {
            
            if needStroke {
                Capsule(style: .circular)
                    .stroke(Color.black)
                    .frame(width: 145, height: 35)
            } else {
                Capsule(style: .circular)
                    .foregroundColor(fillColor)
                    .frame(width: 145, height: 35)
            }
            
            
            HStack {
                
                Text("-")
                    .sectionTitle()
                    .onTapGesture {
                        if stepperValue > 1 {
                            stepperValue -= 1
                        }
                    }
                
                Spacer()
                
                
                Text("\(stepperValue)")
                    .sectionTitle()
                
                
                
                Spacer()
                
                Text("+")
                    .sectionTitle()
                    .onTapGesture {
                        if stepperValue < 10 {
                            stepperValue += 1
                        }
                    }
            }
            .padding(.horizontal, 12)
            
            
        }
        
        .frame(width: 145, height: 36)
        
    }
}

struct CustomStepper_Previews: PreviewProvider {
    @State static var stepperValue: Int = 0
    
    static var previews: some View {
        CustomStepper2(stepperValue: $stepperValue, needStroke: false, fillColor: Color("SecundaryColor3"))
    }
}
