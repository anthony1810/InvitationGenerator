//
//  Closures.swift
//  Jamtime
//
//  Created by Team Appetiser ( https://appetiser.com.au )
//  Copyright © 2020 Appetiser Pty Ltd. All rights reserved.
//

import Foundation

// MARK: - Typealias > Base

typealias EmptyResult<ReturnType> = () -> ReturnType
typealias SingleResultWithReturn<T, ReturnType> = (T) -> ReturnType
typealias DoubleResultWithReturn<T1, T2, ReturnType> = (T1, T2) -> ReturnType
typealias TripleResultWithReturn<T1, T2, T3, ReturnType> = (T1, T2, T3) -> ReturnType
// DO NOT ADD here anymore. Create a struct instead to encapsulate all the values you need to pass


// MARK: - Typealias > Void Return

typealias SingleResult<T> = SingleResultWithReturn<T, Void>
typealias DoubleResult<T1, T2> = DoubleResultWithReturn<T1, T2, Void>
typealias TripleResult<T1, T2, T3> = TripleResultWithReturn<T1, T2, T3, Void>
// DO NOT ADD here anymore. Create a struct instead to encapsulate all the values you need to pass

// MARK: Typealias > Most Used

// () -> Void
typealias VoidResult = EmptyResult<Void>
// (Error) -> Void
typealias ErrorResult = SingleResult<Error>
// (Bool) -> Void
typealias BoolResult = SingleResult<Bool>

// MARK: - Default Closure Values

enum DefaultClosure {
  static func voidResult() -> VoidResult { {} }
  static func singleResult<T>() -> SingleResult<T> { { _ in } }
  static func doubleResult<T1, T2>() -> DoubleResult<T1, T2> { { _, _ in } }
  static func tripleResult<T1, T2, T3>() -> TripleResult<T1, T2, T3> { { _, _, _ in } }
}
