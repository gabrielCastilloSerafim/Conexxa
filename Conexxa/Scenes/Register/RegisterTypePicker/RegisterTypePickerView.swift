//
//  RegisterTypePickerView.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 3/12/23.
//

import SwiftUI

struct RegisterTypePickerView: View {
    
    @Binding var isRegistrationPickerPresented: Bool
    @Binding var userRegistrationType: UserRegistrationType?
    
    var body: some View {
        
        VStack {
            
            title
            Spacer()
            
            VStack(spacing: 30) {
                explanationCallout
                bandButton
                contractorButton
            }
            .padding(.bottom, 60)
        }
        .onAppear {
            userRegistrationType = nil
        }
    }
}

private extension RegisterTypePickerView {
    
    var title: some View {
        
        HStack {
            Text("registerTypeModalTitle".localized)
                .font(.system(.title, weight: .heavy))
                .padding(EdgeInsets(top: 45, leading: 20, bottom: 20, trailing: 20))
            Spacer()
        }
    }
    
    var explanationCallout: some View {
            
        Text("explanationCallout".localized)
            .frame(width: 296, height: 90, alignment: .leading)
            .font(.body)
            .padding()
            .background(alignment: .leading) {
                ConexxaColor.lightGray()
                    .cornerRadius(15)
                    .opacity(0.3)
            }
    }
    
    var bandButton: some View {
        
        Button {
            userRegistrationType = .band
            isRegistrationPickerPresented.toggle()
        } label: {
            Text("band".localized)
                .fontWeight(.bold)
                .frame(width: 330, height: 50)
                .foregroundColor(ConexxaColor.white())
                .background(ConexxaColor.blue())
                .cornerRadius(10)
        }
    }
    
    var contractorButton: some View {
        
        Button {
            userRegistrationType = .contractor
            isRegistrationPickerPresented.toggle()
        } label: {
            Text("contractor".localized)
                .fontWeight(.bold)
                .frame(width: 330, height: 50)
                .foregroundColor(ConexxaColor.white())
                .background(ConexxaColor.black())
                .cornerRadius(10)
        }
    }
}

#Preview {
    RegisterTypePickerView(isRegistrationPickerPresented: .constant(true), userRegistrationType: .constant(.band))
}
