import UIKit

struct ColorConstants {
    
    // CounterView Colors for counters
    static let healthBackgroundColor = UIColor.flatRedColorDark()
    static let healthCounterColor = UIColor.flatWatermelon().lighten(byPercentage: 0.9)
    static let experienceBackgroundColor = UIColor.flatSkyBlueColorDark()
    static let experienceCounterColor = UIColor.flatSkyBlue().lighten(byPercentage: 0.9)
    static let genericBackgroundColor = UIColor.flatMagentaColorDark()
    static let genericCounterColor = UIColor.flatMagenta().lighten(byPercentage: 0.75)
    
    // ScenarioVC Colors
    static let disconnectedPlayerBackground = UIColor.flatGray()
    static let disconnectedPlayerText = UIColor.flatGrayColorDark().darken(byPercentage: 0.1)
    static let connectedPlayerBackground = UIColor.flatMintColorDark()
    static let connectedPlayerText = UIColor.flatYellowColorDark()
    
}
