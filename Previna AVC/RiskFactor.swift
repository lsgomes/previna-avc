//
//  RiskFactors.swift
//  Previna AVC
//
//  Created by Lucas Dos Santos Gomes on 3/30/17.
//  Copyright © 2017 Lucas Dos Santos Gomes. All rights reserved.
//

enum RiskFactor: String {
    
    // MARK: Non-modifiable risk factors
    case MALE = "http://www.semanticweb.org/lucas/ontologies/2016/9/stroke#Male"
    case HYPERTENSION = "http://www.semanticweb.org/lucas/ontologies/2016/9/stroke#Hypertension"
    case DIABETES = "http://www.semanticweb.org/lucas/ontologies/2016/9/stroke#Diabetes"
    case RENAL_DISEASE = "http://www.semanticweb.org/lucas/ontologies/2016/9/stroke#Renal_disease"
    case PERIPHERAL_DISEASE = "http://www.semanticweb.org/lucas/ontologies/2016/9/stroke#Peripheral_arterial_disease"
    case HEART_FAILURE = "http://www.semanticweb.org/lucas/ontologies/2016/9/stroke#Congestive_heart_failure"
    case ISCHEMIC_HEART_DISEASE = "http://www.semanticweb.org/lucas/ontologies/2016/9/stroke#Ischemic_heart_disease"
    
    // MARK: Physical_activity
    case INACTIVE = "http://www.semanticweb.org/lucas/ontologies/2016/9/stroke#Inactive"
    case ACTIVE = "http://www.semanticweb.org/lucas/ontologies/2016/9/stroke#Active"
    case VERY_ACTIVE = "http://www.semanticweb.org/lucas/ontologies/2016/9/stroke#Very_active"
    
    
    // MARK: Alcohol_consumption
    case ABSTAIN = "http://www.semanticweb.org/lucas/ontologies/2016/9/stroke#Abstain"
    case DRINKER = "http://www.semanticweb.org/lucas/ontologies/2016/9/stroke#Drinker"
    case FORMER_ALCOHOLIC = "http://www.semanticweb.org/lucas/ontologies/2016/9/stroke#Former_alcoholic"
    case DRINK_IN_MODERATION = "http://www.semanticweb.org/lucas/ontologies/2016/9/stroke#Drink_in_moderation"
    
    // MARK: Smoking_status
    case SMOKER = "http://www.semanticweb.org/lucas/ontologies/2016/9/stroke#Smoker"
    case FORMER_SMOKER = "http://www.semanticweb.org/lucas/ontologies/2016/9/stroke#Former_smoker"
    case NEVER_SMOKED = "http://www.semanticweb.org/lucas/ontologies/2016/9/stroke#Never_smoked"
    
    // MARK: Education
    case HIGH_SCHOOL_DIPLOMA = "http://www.semanticweb.org/lucas/ontologies/2016/9/stroke#High_school_diploma_and_some_college"
    case NO_HIGH_SCHOOL_DIPLOMA = "http://www.semanticweb.org/lucas/ontologies/2016/9/stroke#No_high_school_diploma"
    
    // MARK: Psychological_factors
    case CRY_EASILY = "http://www.semanticweb.org/lucas/ontologies/2016/9/stroke#Cry_easily"
    case CRITICAL_OF_OTHERS = "http://www.semanticweb.org/lucas/ontologies/2016/9/stroke#Critical_of_others"
    case FEARFUL = "http://www.semanticweb.org/lucas/ontologies/2016/9/stroke#Fearful"
    
    case NOT_CRYING_EASILY = "http://www.semanticweb.org/lucas/ontologies/2016/9/stroke#Not_crying_easily"
    case NOT_CRITICAL_OF_OTHERS = "http://www.semanticweb.org/lucas/ontologies/2016/9/stroke#Not_critical_of_others"
    case NOT_FEARFUL = "http://www.semanticweb.org/lucas/ontologies/2016/9/stroke#Not_fearful"

}
