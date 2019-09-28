//
//  TipViewModel.swift
//  TipCalculator
//
//  Created by Sebastian Carlberg on 2019-09-21.
//  Copyright © 2019 Sebastian Carlberg. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class TipViewModel: ObservableObject {
    
    var amount: String = ""
    var venue: String = ""
    var tip: Double?
    var total: Double?
    var totalPerPerson: Double?
    let tipChoices = [15,18,20]
    @Published var nbrPeople: Int = 1 {
        didSet {
            calculateTip()
        }
    }
    @Published var tipPrecentage: Int = 0 {
        didSet {
            calculateTip()
        }
    }
    
    func calculateTip() {
        guard let amount = Double(amount) else {
            return
        }
        self.tip = (amount * Double(tipPrecentage) / 100)
        self.total = tip! + amount
        self.totalPerPerson = total! / Double(nbrPeople);
    }
    
    func calculatePeople(delta: Int) {
        if (delta == -1 && nbrPeople <= 1) {
            
        } else {
            nbrPeople = nbrPeople + delta;
        }
    }
}
