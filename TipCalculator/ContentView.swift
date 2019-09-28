//
//  ContentView.swift
//  TipCalculator
//
//  Created by Sebastian Carlberg on 2019-09-21.
//  Copyright © 2019 Sebastian Carlberg. All rights reserved.
//

import SwiftUI
import Foundation

var headingColor = Color(red: 75 / 255, green: 215 / 255, blue: 217 / 255)
var textColor = Color.white
var backgroundColor = Color(red: 27 / 255, green: 31 / 255, blue: 37 / 255)
var rowBackgroundColor = Color(red: 34 / 255, green: 40 / 255, blue: 47 / 255)
var buttonBackground = Color(red: 55 / 255, green: 58 / 255, blue: 68 / 255)

struct ContentView: View {
    
    @ObservedObject var tipVM = TipViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                VenueInput(tipVM: tipVM)
                AmountInput(tipVM: tipVM)
                PercentagePicker(tipVM: tipVM)
                PeopleInput(tipVM: tipVM)
                TipResult(tipVM: tipVM)
                Spacer()
//                HStack {
//                    SaveButton()
//                    CancelButton()
//                }.padding()
            }
            Spacer()
        }
        .background(backgroundColor)
        .edgesIgnoringSafeArea(.all)
        .statusBar(hidden: true)
        .colorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct AmountInput: View {
    @ObservedObject var tipVM: TipViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Bill amount")
            .font(.callout) //footnote
                .foregroundColor(headingColor)
            TextField(" ", text: $tipVM.amount)
                .foregroundColor(Color.white)
                .keyboardType(.numberPad)
        }
        .padding()
        .background(rowBackgroundColor)
    }
}

struct VenueInput: View {
    @ObservedObject var tipVM: TipViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Venue")
                .font(.callout)
                .foregroundColor(headingColor)
            TextField(" ", text: $tipVM.venue)
                .foregroundColor(Color.white)
        }
        .padding(.top, 40)
        .padding()
        .background(rowBackgroundColor)
    }
}

struct PercentagePicker: View {
    @ObservedObject var tipVM: TipViewModel

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Tip")
                    .font(.callout)
                    .padding(.trailing, 100)
                    .foregroundColor(headingColor)
                Picker(selection: $tipVM.tipPrecentage, label: Text("Pick your tip percentage")) {
                    ForEach(tipVM.tipChoices, id: \.self) { choice in
                        Text("\(choice) %")
                            .tag(choice)
                        
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            Text(tipVM.tip == nil ? " " : "$\(String(format: "%.2f", tipVM.tip!))")
                .font(.subheadline)
                .foregroundColor(Color.white)
        }
        .padding()
        .background(rowBackgroundColor)
    }
}


struct PeopleInput: View {
    @ObservedObject var tipVM: TipViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("People")
                .font(.callout) //footnote
                    .foregroundColor(headingColor)
                Spacer()
                
                Button(action: {
                    self.tipVM.calculatePeople(delta: -1)
                }) {
                    HStack {
                        Image(systemName: "minus")
                            .font(.callout)
                    }
                    .frame(width: 60, height: 30)
                    .foregroundColor(.white)
                    .background(buttonBackground)
                    .cornerRadius(10)
                }
                
                Button(action: {
                    self.tipVM.calculatePeople(delta: 1)
                }) {
                    HStack {
                        Image(systemName: "plus")
                            .font(.callout)
                    }
                    .frame(width: 60, height: 30)
                    .foregroundColor(.white)
                    .background(buttonBackground)
                    .cornerRadius(8)
                }
                
            }
            
            
            Text("\(tipVM.nbrPeople)")
            
            
            
        }
        .padding()
        .background(rowBackgroundColor)
    }
}

// 27 31 37

struct TipResult: View {
    @ObservedObject var tipVM: TipViewModel

    var body: some View {
        VStack {
            HStack {
                Text("Total")
                    .font(.callout)
                    .foregroundColor(headingColor)
                Spacer()
                Text("Per person")
                    .font(.callout)
                    .foregroundColor(headingColor)
            }
            .padding()
            HStack {
                Text(tipVM.tip == nil ? " " : "$\(String(format: "%.2f", tipVM.total!))")
                    .font(.headline)
                    .foregroundColor(Color.white)
                    .padding(.top, -20)
                Spacer()
                Text(tipVM.total == nil ? " " : "$\(String(format: "%.2f", tipVM.totalPerPerson!))")
                    .font(.headline)
                    .foregroundColor(Color.white)
                    .padding(.top, -20)
            }
            .padding()
            
            
        }
    }
}

struct SaveButton: View {
    var body: some View {
        Button(action: {}) {
            Text("Save")
                .font(.headline)
                .foregroundColor(Color.white)
                .padding()
                .frame(width: 150, height: 55)
                .background(buttonBackground)
                .cornerRadius(15.0)
        }
    }
}

struct CancelButton: View {
    var body: some View {
        Button(action: {}) {
            Text("Cancel")
                .font(.headline)
                .foregroundColor(Color.white)
                .padding()
                .frame(width: 150, height: 55)
                .background(buttonBackground)
                .cornerRadius(15.0)
        }
        
    }
}
