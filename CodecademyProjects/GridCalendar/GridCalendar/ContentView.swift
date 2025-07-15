//
//  ContentView.swift
//  GridCalendar
//
//  Created by Joe L Barr on 1/16/24.
//

import SwiftUI

struct Day: Identifiable {
    let id = UUID()
    let value : Int
}

struct Month {
    let name: String
    let numberOfDays: Int
    var days: [Day]
    
    init(name: String, numberOfDays: Int) {
        self.name = name
        self.numberOfDays = numberOfDays
        self.days = []
        
        for n in 1...numberOfDays {
            self.days.append(Day(value: n))
        }
    }
}

let year = [
    Month(name: "January", numberOfDays: 31),
    Month(name: "February", numberOfDays: 28),
    Month(name: "March", numberOfDays: 31),
    Month(name: "April", numberOfDays: 30),
    Month(name: "May", numberOfDays: 31),
    Month(name: "June", numberOfDays: 31),
    Month(name: "July", numberOfDays: 31),
    Month(name: "August", numberOfDays: 31),
    Month(name: "September", numberOfDays: 31),
    Month(name: "October", numberOfDays: 31),
    Month(name: "November", numberOfDays: 31),
    Month(name: "December", numberOfDays: 31)
]

struct ContentView: View {
    let layout = [
        GridItem(.flexible(minimum: 40)),
        GridItem(.flexible(minimum: 40)),
        GridItem(.flexible(minimum: 40)),
        GridItem(.flexible(minimum: 40)),
        GridItem(.flexible(minimum: 40)),
        GridItem(.flexible(minimum: 40)),
        GridItem(.flexible(minimum: 40))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: layout, pinnedViews: [.sectionHeaders]) {
                ForEach(year, id:\.name) { month in
                    Section(header: Text(month.name).font(.headline)) {
                        ForEach(month.days) { day in
                            Capsule()
                                .overlay(Text("\(day.value)").foregroundStyle(.white))
                                .foregroundStyle(.blue)
                                .frame(height: 40)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
