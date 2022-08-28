//
//  CustomViewModifers.swift
//  TweekLabs
//
//  Created by Hitesh Suthar on 28/08/22.
//

import Foundation
import SwiftUI

struct OverlayBg : ViewModifier {
    func body (content: Content) -> some View {
        content
        
            .blur(radius: 2)
            .overlay(Rectangle().fill(Color("Black 1"))).opacity(0.62)
    }
}
