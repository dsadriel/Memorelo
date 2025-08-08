//
//  Extensions.swift
//  Memorelo
//
//  Created by Adriel de Souza on 08/08/25.
//

import SwiftUI

extension Date {
    var ageString: String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: self, to: Date())

        if let years = components.year, let months = components.month, years + months != 0 {
            return "\((years != 0) ? "\(years) anos" : "") \(months != 0 ? "\(months) meses" : "")"
        }

        return "Menos de 1 mês"
    }
}

extension Image {
    init?(_ data: Data) {
        if let uiImage = UIImage(data: data) {
            self.init(uiImage: uiImage)
        } else {
            return nil
        }
    }
}
