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
    @IBOutlet weak var healthTrackerContainerView: UIView!
    @IBOutlet weak var experienceTrackerContainerView: UIView!
    @IBOutlet weak var genericTrackerContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCounters()
    }
  
    func counterValueDidChange(value: Int, sender: CounterView) {
        
    }
    
    func setupCounters() {
        setupHealthCounterView()
        setupExperienceCounterView()
        setupGenericCounterView()
    }
    
    
    //MARK: - Setup Child Views
    func setupHealthCounterView() {
        let healthCounterView = Bundle.main.loadNibNamed("HorizontalCounterView", owner: self, options: nil)?.first as? CounterView
        healthCounterView?.frame = healthTrackerContainerView.bounds
        healthCounterView?.setupCounter(startingValue: 15, type: CounterType.health, maxValue: 15)
        healthTrackerContainerView.addSubview(healthCounterView!)
        healthCounterView?.delegate = self
    }
    
    func setupExperienceCounterView() {
        let experienceCounterView = Bundle.main.loadNibNamed("HorizontalCounterView", owner: self, options: nil)?.first as? CounterView
        experienceCounterView?.frame = experienceTrackerContainerView.bounds
        experienceCounterView?.setupCounter(startingValue: 0, type: CounterType.experience)
        experienceTrackerContainerView.addSubview(experienceCounterView!)
        experienceCounterView?.delegate = self
    }
    
    func setupGenericCounterView() {
        let genericCounterView = Bundle.main.loadNibNamed("VerticalCounterView", owner: self, options: nil)?.first as?CounterView
        genericCounterView?.frame = genericTrackerContainerView.bounds
        genericCounterView?.setupCounter(startingValue: 0, type: CounterType.generic)
        genericTrackerContainerView.addSubview(genericCounterView!)
        genericCounterView?.delegate = self
    }
    
}




