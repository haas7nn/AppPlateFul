//
//  UserCellDelegate.swift
//  AppPlateFul
//
//  Created by Hassan Fardan on 25/12/2025.
//

import Foundation

protocol UserCellDelegate: AnyObject {
    func didTapInfoButton(at indexPath: IndexPath)
    func didTapStarButton(at indexPath: IndexPath)
}
