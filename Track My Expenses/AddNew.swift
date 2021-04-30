//  AddNew.swift
//  Track My Expenses

import SwiftUI

struct AddNew: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var expenses: Expenses
    
    @State private var newName = ""
    @State private var newType = "Personal"
    @State private var newAmount = ""
    
    static let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField ("Name", text: $newName)
                Picker("Type", selection: $newType) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", text: $newAmount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add New Expense")
            .navigationBarItems(trailing: Button("Save") {
                if let actualAmount = Int(self.newAmount) {
                    let item = ExpenseItem(name: self.newName, type: self.newType, amount: actualAmount)
                    self.expenses.items.append(item)
                    self.presentationMode.wrappedValue.dismiss()
                }
            })
        }
    }
}

struct AddNew_Previews: PreviewProvider {
    static var previews: some View {
        AddNew(expenses: Expenses())
    }
}

