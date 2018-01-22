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
        healthContainerView.addSubview(healthCounterView!)
        healthCounterView?.frame = healthContainerView.bounds
        healthCounterView?.delegate = self
    }
    
    func setupExperienceCounterView() {
        let experienceCounterView = Bundle.main.loadNibNamed("CounterView", owner: self, options: nil)?.first as? CounterView
        experienceContainerView.addSubview(experienceCounterView!)
        experienceCounterView?.frame = healthContainerView.bounds
        experienceCounterView?.delegate = self
    }
    
    
}




