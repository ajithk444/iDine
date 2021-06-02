//
//  CheckoutView.swift
//  iDine
//
//  Created by Ajith Kumar on 31/05/21.
//

import SwiftUI

struct CheckoutView: View {
    
    @EnvironmentObject var order:Order
    @State private var paymentType = "Cash"
    @State private var addLoyaltyDetails = false
    @State private var loyaltyNumber = ""
    @State private var tipAmount = 5
    @State private var showAlert = false
    
    let paymentTypes = ["Cash","Credit Card","iDine Points"]
    let tipAmounts = [5,10,15,20,25,0]
    
    var totalPrice:String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        let total=Double(order.total)
        let tipValue = total/100 * Double(tipAmount)
        
        return formatter.string(from: NSNumber(value:total+tipValue)) ?? "$0"
    }
    
    var body: some View {
        Form{
            Section{
                Picker("Select your payment mode ",selection:$paymentType){
                    ForEach(paymentTypes,id: \.self){
                     Text($0)
                    }
                }
                Toggle("Add iDine Loyalty Card?",isOn: $addLoyaltyDetails.animation())
                if addLoyaltyDetails{
                    TextField("Enter your iDine Number",text: $loyaltyNumber)
                }
                
            }
            
            Section(header:Text("Pickup Time")){
                Text(order.pickUpMode)
            }.padding().font(.caption)
            
            Section(header: Text("Add a tip?")){
                Picker("Percentage ", selection:$tipAmount){
                    ForEach(tipAmounts,id: \.self){
                        Text("\($0)%")
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }
            
            
            Section(header: Text("Total: \(totalPrice)").font(.largeTitle)){
                Button("Confirm Order"){
                    //place order code here
                    showAlert.toggle()
                }
            }
        }
        .navigationTitle("Payment")
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $showAlert){
            Alert(title: Text("Order Confirmed!"), message: Text("Order total is \(totalPrice)"), dismissButton: .default(Text("OK")))
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
        CheckoutView().environmentObject(Order())
     }
    }
}
