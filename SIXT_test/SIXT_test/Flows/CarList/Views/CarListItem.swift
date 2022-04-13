//
//  CarListItem.swift
//  SIXT_test
//
//  Created by Igor Kulik on 12.04.2022.
//

import SwiftUI
import Model

struct CarListItem: View {
    
    // MARK: - Properties
    
    let presentation: CarListPresentation
    
    // MARK: - View
    
    var body: some View {
        VStack(spacing: 0.0) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 8.0) {
                    Text("\(presentation.make) \(presentation.modelName)")
                    Text("\(presentation.licensePlate)")
                        .padding(4.0)
                        .foregroundColor(.black)
                        .font(.system(size: 14.0, weight: .bold, design: .monospaced))
                        .background(Color.white)
                        .cornerRadius(4.0)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4.0)
                                .stroke(Color.black, lineWidth: 2.0)
                        )
                    
                }
                .padding(.top, 12.0)
                Spacer()
                
                WebImage(url: presentation.carImageUrl,
                         placeholder: {
                    Image(uiImage: #imageLiteral(resourceName: "carPlaceholder"))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                })
                .aspectRatio(contentMode: .fill)
                .frame(width: 128.0, height: 128.0)
                .padding(.trailing, 16.0)
            }
            .padding(.horizontal, 16.0)
            
            Color.secondary
                .opacity(0.5)
                .frame(height: 1.0)
        }
        .listRowInsets(EdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0))
        .listRowBackground(Color(ColorAsset.background))
        
    }
}

struct CarListItem_Previews: PreviewProvider {
    static var previews: some View {
        CarListItem(presentation: CarListPresentation(model: Car.mockModel))
    }
}
