//
//  PerkSymbolListViewController.swift
//  GHPlayerSheet
//
//  Created by Paul Hise on 1/28/18.
//  Copyright © 2018 Paul Hise. All rights reserved.
//

import UIKit

class PerkSymbolListView: UIView {
    
    
    @IBOutlet weak var leftListTextView:    UITextView! {
        didSet {
            leftListTextView.text = ("negativeTwo: (-2)\n"  +  "negativeOne: (-1)\n" +   "plusZero: (+0)\n" +   "plusOne: (+1)\n" +   "plusTwo: (+2)\n" +   "plusThree: (+3)\n" +   "rollingModifier:   ↷\n" +   "push:   ⇢\n" +   "pull:   ⇠\n" +   "pierce:   ⤁\n" +   "stun:   💫\n" +   "disarm:   👋🏽\n" +   "muddle:   ❓\n" +   "addTarget:   ◎")
        }
    }
    @IBOutlet weak var rightListTextView:    UITextView! {
        didSet {
            rightListTextView.text = ("shield:   🛡\n" + "immobilize:   🚷\n" + "curse:   ⚡️\n" + "wound:   🚑\n" + "poison:   ☠️\n" + "invisible:   👤\n" + "heal:   ❣️\n" + "fire:   🔥\n" + "earth:   🍃\n" + "air:   💨\n" + "ice:   ❄️\n" + "light:   🔆\n" + "dark:   🌑")
        }
    }
    
    func viewDidLoad() {


        leftListTextView.text = ("negativeOne:   (-1)"  +   "negativeTwo:   (-2)" +   "plusZero:   (+0)" +   "plusOne:   (+1)" +   "plusTwo:   (+2)" +   "plusThree:   (+3)" +   "rollingModifier:   ↷" +   "push:   ⇢" +   "pull:   ⇠" +   "pierce:   ⤁" +   "stun:   💫" +   "disarm:   👋🏽" +   "muddle:   ❓" +   "addTarget:   ◎")
        rightListTextView.text = ("shield:   🛡" + "immobilize:   🚷" + "curse:   ⚡️" + "wound:   🚑" + "poison:   ☠️" + "invisible:   👤" + "heal:   ❣️" + "fire:   🔥" + "earth:   🍃" + "air:   💨" + "ice:   ❄️" + "light:   🔆" + "dark:   🌑")
    }

    func widthForAlignment() -> CGFloat {
        return leftListTextView.frame.size.width
    }
}
