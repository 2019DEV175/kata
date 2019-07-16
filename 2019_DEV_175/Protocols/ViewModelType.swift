//
//  ViewModelProtocol.swift
//  2019_DEV_175
//

import Foundation

protocol ViewModelType {
    associatedtype ProtocolDelegate
    var delegate: ProtocolDelegate? { get set }
}
