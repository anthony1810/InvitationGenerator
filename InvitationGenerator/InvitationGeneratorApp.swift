//
//  InvitationGeneratorApp.swift
//  InvitationGenerator
//
//  Created by Anthony on 29/9/25.
//

import SwiftUI

@main
struct InvitationGeneratorApp: App {
    var body: some Scene {
        WindowGroup {
            AddStudentSUView(
                viewState: AddStudentSUViewState(),
                viewModel: AddStudentSUViewModel(
                    teacherService: MockTeacherService()
                )
            )
        }
    }
}
