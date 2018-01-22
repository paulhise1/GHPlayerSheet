//
//  ScenarioViewController.swift
//  GHPlayerSheet
//
//  Created by Paul Hise on 1/21/18.
//  Copyright © 2018 Paul Hise. All rights reserved.
//

import UIKit

class ScenarioViewController: UIViewController, CounterViewDelegate {
    
    @IBOutlet weak var scenarioTitleLabel: UILabel!
    @IBOutlet weak var scenarioGoalLabel: UILabel!
    @IBOutlet weak var healthContainerView: UIView!
    @IBOutlet weak var experienceContainerView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupHealthCounterView()
        setupExperienceCounterView()
    }
  
    func valueDidChange(value: Int) {
        
    }
    
    //MARK: - Setup Child Views
    func setupHealthCounterView() {
        let healthCounterView = Bundle.main.loadNibNamed("CounterView", owner: self, options: nil)?.first as? CounterView
        healthCounterView?.frame = healthContainerView.bounds
        healthCounterView?.setupCounter(startingValue: 15, type: CounterType.health, maxValue: 15)
        healthContainerView.addSubview(healthCounterView!)
        healthCounterView?.delegate = self
    }
    
    func setupExperienceCounterView() {
        let experienceCounterView = Bundle.main.loadNibNamed("CounterView", owner: self, options: nil)?.first as? CounterView
        experienceCounterView?.frame = experienceContainerView.bounds
        experienceCounterView?.setupCounter(startingValue: 0, type: CounterType.experience)
        experienceContainerView.addSubview(experienceCounterView!)
        experienceCounterView?.delegate = self
    }
    
    
}




