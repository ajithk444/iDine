//
//  OrderView.swift
//  iDine
//
//  Created by Ajith Kumar on 31/05/21.
//

import SwiftUI

struct OrderView: View {
    @EnvironmentObject var order : Order
    @State private var pickupTime = "Now"
    
    
    let pickupTimes = ["Now","Tonight","Tomorrow Morning"]
    
    var body: some View {
        NavigationView{
            List{
                Section{
                    ForEach(order.items){item in
                        HStack{
                            Text(item.name)
                            Spacer()
                            Text("$\(item.price)")
                        }
                    }.onDelete(perform: deleteItems)
                }
                
                Section(header: Text("Choose a Pickup Time")){
                    Picker("Pickup Time ", selection:$pickupTime){
                        ForEach(pickupTimes,id: \.self){pickupTime in
                            Text(pickupTime)
                        }
                    }.pickerStyle(MenuPickerStyle())
//                    .onReceive([self.pickupTime].publisher.first()){ value in
//                        setPickupMode(mode: value)
//                    }
                }.disabled(order.items.isEmpty)
                
                Section{
                    NavigationLink(destination: CheckoutView()){
                        Text("Place Order")
                    }
                }.disabled(order.items.isEmpty)
            }.navigationTitle("Order").listStyle(InsetGroupedListStyle()).toolbar(content: {
                EditButton()
            })
        }
    }
    
    func setPickupMode(mode:String){
        order.pickUpMode = mode
    }
    
    func deleteItems(at offsets:IndexSet){
        order.items.remove(atOffsets: offsets)
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView().environmentObject(Order())
    }
}
