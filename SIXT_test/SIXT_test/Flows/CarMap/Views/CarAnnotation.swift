//
//  CarAnnotation.swift
//  SIXT_test
//
//  Created by Igor Kulik on 13.04.2022.
//

import SwiftUI
import Model


struct CarAnnotation: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: CarAnnotationViewModel
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            if viewModel.state != .hidden {
                AnnotationBubble(calloutIndicatorSize: Geometry.calloutIndicatorSize)
                    .fill(Style.fillColor(expanded: viewModel.isExpanded))
                    .transition(.scale)
                
                contentView
                    .transition(.scale)
            }
        }
        .offset(Geometry.contentOffset(expanded: viewModel.isExpanded))
        .frame(width: Geometry.size(expanded: viewModel.isExpanded).width, height: Geometry.size(expanded: viewModel.isExpanded).height)
        .animation(.easeInOut, value: viewModel.state)
        .shadow(radius: 4.0)
    }
    
    // MARK: - Subviews
    
    @ViewBuilder
    private var contentView: some View {
        if viewModel.isExpanded {
            VStack(spacing: 0.0) {
                HStack {
                    Text("\(viewModel.make) \(viewModel.modelName)")
                        .font(.system(size: 12.0))
                    
                    Spacer()
                }
                
                HStack(alignment: .top) {
                    Text("\(viewModel.licensePlate)")
                        .padding(2.0)
                        .foregroundColor(.black)
                        .font(.system(size: 10.0, weight: .bold, design: .monospaced))
                        .background(Color.white)
                        .cornerRadius(4.0)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4.0)
                                .stroke(Color.black, lineWidth: 2.0)
                        )
                    Spacer()
                    
                    WebImage(url: viewModel.carImageUrl,
                             placeholder: {
                        Image(uiImage: #imageLiteral(resourceName: "carPlaceholder"))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    })
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 48.0, height: 48.0)
                    .padding(.top, -8.0)
                    .padding(.bottom, 8.0)
                }
            }
            .padding(.horizontal, 8.0)
        } else {
            Image(systemName: SFSymbols.Car.fill)
                .foregroundColor(.white)
                .padding(.bottom, Geometry.calloutIndicatorSize.height)
        }
    }
}

struct CarAnnotation_Previews: PreviewProvider {
    static var previews: some View {
        CarAnnotation(viewModel: CarAnnotationViewModel(model: Car.mockModel))
    }
}

// MARK: - Custom shape

fileprivate struct AnnotationBubble: Shape {
    
    // MARK: - Properties
    
    var calloutIndicatorSize: CGSize
    
    // MARK: - Shape
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: .zero)
            path.addLine(to: CGPoint(x: rect.size.width,
                                     y: 0.0))
            path.addLine(to: CGPoint(x: rect.size.width,
                                     y: rect.size.height - calloutIndicatorSize.height))
            path.addLine(to: CGPoint(x: (rect.size.width + calloutIndicatorSize.width) / 2.0,
                                     y: rect.size.height - calloutIndicatorSize.height))
            path.addLine(to: CGPoint(x: rect.size.width / 2.0,
                                     y: rect.size.height))
            path.addLine(to: CGPoint(x: (rect.size.width - calloutIndicatorSize.width) / 2.0,
                                     y: rect.size.height - calloutIndicatorSize.height))
            path.addLine(to: CGPoint(x: 0.0,
                                     y: rect.size.height - calloutIndicatorSize.height))
        }
    }
}

// MARK: - View model extensions

fileprivate extension CarAnnotationViewModel {
    var isExpanded: Bool { state == .expanded}
}

// MARK: - Geometry & Style

private struct Geometry {
    static func size(expanded: Bool) -> CGSize {
        return expanded ? CGSize(width: 128.0, height: 64.0) : CGSize(width: 44.0, height: 44.0)
    }
    
    static var calloutIndicatorSize: CGSize {
        return CGSize(width: 16.0, height: 8.0)
    }
    
    static func contentOffset(expanded: Bool) -> CGSize {
        if expanded {
            return CGSize(width: 0.0, height: -(size(expanded: true).height - size(expanded: false).height) / 2.0)
        } else {
            return .zero
        }
    }
}

private struct Style {
    static func fillColor(expanded: Bool) -> Color {
        return Color(expanded ? ColorAsset.sixtOrange : ColorAsset.mapAnnotationFill)
    }
}
