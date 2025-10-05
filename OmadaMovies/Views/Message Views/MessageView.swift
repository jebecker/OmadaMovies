//
//  MessageView.swift
//  OmadaMovies
//
//  Created by Jayme Becker on 10/3/25.
//

import SwiftUI

// MARK: - Message View

/// A reusable view that displays a title, message, and system image using
/// `ContentUnavailableView` for consistent empty or error state presentation.
struct MessageView: View {
    /// The headline text displayed prominently.
    let title: String
    /// The descriptive message shown below the title.
    let message: String
    /// The SF Symbols name used as the leading visual indicator.
    let systemImage: String
    
    /// Creates a new message view.
    /// - Parameters:
    ///   - title: A short, prominent title.
    ///   - message: A longer description of the situation.
    ///   - systemImage: An SF Symbols name to visually represent the message.
    init(title: String = "", message: String, systemImage: String) {
        self.title = title
        self.message = message
        self.systemImage = systemImage
    }
    
    /// The view hierarchy presenting the message centered within a scroll view.
    var body: some View {
        // Wrap in a scroll view so long messages can scroll while staying centered.
        ScrollView {
            // System-provided view for empty/error states with title, icon, and description.
            ContentUnavailableView(
                title,
                systemImage: systemImage,
                description: Text(message)
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        // Center the content vertically when possible.
        .defaultScrollAnchor(.center)
    }
}
