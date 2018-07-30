//
//  Settings.swift
//  ColorBall
//
//  Created by Emily Kolar on 12/27/17.
//  Copyright © 2017 Emily Kolar. All rights reserved.
//

import Foundation
import UIKit

struct Settings {
    // interval for giving presents
    // 21600 == 6 hours in seconds (6 * 60 * 60)
    static let PRESENT_INTERVAL: Double = 21600

    static let CURRENT_STAGE_KEY = "CURRENT_STAGE"
    static let CURRENT_STAGE_KEY_MEMORY = "CURRENT_STAGE_MEMORY"
    static let CURRENT_STAGE_KEY_ENDLESS = "CURRENT_STAGE_ENDLESS"

    static let HIGH_SCORE_KEY = "HIGH_SCORE"
    static let HIGH_SCORE_KEY_MEMORY = "HIGH_SCORE_MEMORY"
    static let HIGH_SCORE_KEY_ENDLESS = "HIGH_SCORE_ENDLESS"
    
    static let PLAYS_PER_GAME = "PLAYS_PER_GAME"
    static let LAST_AD_TIME = "LAST_AD_TIME"
    static let VOLUME_ON_KEY = "VOLUME_ON_KEY"
    
    static let GAME_MODE_KEY = "GAME_MODE_KEY"
    static let GAME_MODE_STAGE = "GAME_MODE_STAGE"
    static let GAME_MODE_ENDLESS = "GAME_MODE_ENDLESS"
    static let GAME_MODE_MEMORY = "GAME_MODE_MEMORY"
    
    static let TEXTURE_KEY = "TEXTURE_KEY"
    static let TEXTURE_COLORS = "TEXTURE_COLORS"
    static let TEXTURE_FRUITS = "TEXTURE_FRUITS"
    static let TEXTURE_POOL = "TEXTURE_POOL"
    
    static let TEXTURE_KEY_MODE = "TEXTURE_KEY_MODE"
    static let TEXTURE_KEY_STAGE = "TEXTURE_KEY_STAGE"
    static let TEXTURE_KEY_ENDLESS = "TEXTURE_KEY_ENDLESS"
    static let TEXTURE_KEY_MEMORY = "TEXTURE_KEY_MEMORY"
    
    static let LAUNCHED_BEFORE_KEY = "LAUNCHED_BEFORE_KEY"
    
    static let PresentGameControllerNotification = Notification.Name("PresentGameController")

    static let TutorialTapsCompletedNotification = Notification.Name("TutorialTapsCompleted")
    static let TutorialStageOneCompletedNotification = Notification.Name("TutorialStageOneCompleted")
    
    static let TutorialSpinsCompletedNotification = Notification.Name("TutorialSpinsCompleted")
    static let TutorialStageTwoCompletedNotification = Notification.Name("TutorialStageTwoCompleted")
    
    static let ResetTutorialLevelNotification = Notification.Name("ResetTutorialLevel")
    
    static let RewardMessagesConfigKey = "rewardMessages"
    
    static var isIphoneX: Bool {
        get {
            if UIDevice().userInterfaceIdiom == .phone {
                switch UIScreen.main.nativeBounds.height {
                    case 2436:
                        return true
                    default:
                        return false
                    }
            }
            return false
        }
    }
}
