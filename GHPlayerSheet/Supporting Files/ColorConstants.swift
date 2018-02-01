import UIKit

struct ColorConstants {
    
    // CharacterSheetVC Colors
    static let characterNameText = UIColor.flatMagenta()
    static let defaultEnterNameText = UIColor.lightGray
    
    // CounterView Colors for counters
    static let healthBackgroundColor = UIColor.flatRedColorDark()
    static let healthCounterColor = UIColor.flatWatermelon().lighten(byPercentage: 0.9)
    static let experienceBackgroundColor = UIColor.flatSkyBlueColorDark()
    static let experienceCounterColor = UIColor.flatPowderBlue()
    static let genericBackgroundColor = UIColor.flatPurpleColorDark()
    static let genericCounterColor = UIColor.flatMagenta().lighten(byPercentage: 0.8)
    
    // ScenarioVC Colors
    static let disconnectedPlayerBackground = UIColor.flatGray()
    static let disconnectedPlayerText = UIColor.flatGrayColorDark().darken(byPercentage: 0.1)
    static let connectedPlayerBackground = UIColor.flatMintColorDark()
    static let connectedPlayerText = UIColor.flatYellowColorDark()
    
    // CheckmarksView Colors
    static let checkmarksViewBackground = UIColor.flatMint().lighten(byPercentage: 0.2)
}
