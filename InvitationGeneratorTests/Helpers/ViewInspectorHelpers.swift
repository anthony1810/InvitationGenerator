//
//  ViewInspectorHelpers.swift
//  Jamtime
//
//  Created by Anthony on 21/9/25.
//  Copyright © 2025 Appetiser Pty Ltd. All rights reserved.
//
import SwiftUI
import ViewInspector

// MARK: - Text
func textFromLabel(_ label: InspectableView<ViewType.Text>) throws -> String {
  return try label.string()
}

func fontFromLabel(_ label: InspectableView<ViewType.Text>) throws -> Font {
  return try label.attributes().font()
}

func foregroundColorFromLabel(_ label: InspectableView<ViewType.Text>) throws -> Color {
  return try label.attributes().foregroundColor()
}

func foregroundStyleFromLabel(_ label: InspectableView<ViewType.Text>) throws -> Color {
  return try label.foregroundStyleShapeStyle(Color.self)
}

// MARK: - Views
func backgroundColorFromView(_ view: InspectableView<ViewType.ClassifiedView>) throws -> Color {
  return try view.background().color().value()
}

func foregroundStyleFromFromView(_ view: InspectableView<ViewType.ClassifiedView>) throws -> Color {
  return try view.foregroundStyleShapeStyle(Color.self)
}

func roundedRectangleCornerRadiusFromView(_ view: InspectableView<ViewType.ClassifiedView>) throws -> CGFloat {
  return try view.clipShape(RoundedRectangle.self).cornerSize.height
}

// MARK: - Buttons
func textFromButton(_ button: InspectableView<ViewType.Button>) throws -> String {
  return try button.labelView().text().string()
}

func fontFromButton(_ button: InspectableView<ViewType.Button>) throws -> Font {
  return try button.labelView().text().attributes().font()
}

func foregroundColorFromButton(_ button: InspectableView<ViewType.Button>) throws -> Color {
    return try button.labelView().text().attributes().foregroundColor()
}

func backgroundColorFromButton(_ button: InspectableView<ViewType.Button>) throws -> Color {
  return try button.labelView().background().color().value()
}

func backgroundColorFromButtonV2(_ button: InspectableView<ViewType.Button>) throws -> Color {
  return try button.background().color().value()
}


