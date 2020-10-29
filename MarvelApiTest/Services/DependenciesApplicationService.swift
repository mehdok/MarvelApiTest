//
//  DependenciesApplicationService.swift
//  MarvelApiTest
//
//  Created by Mehdok on 10/29/20.
//

import DataLayer
import DomainLayer
import NetworkLayer

class DependenciesApplicationService: ApplicationService {
    private let dependencies = Dependencies {
        Module { DomainModule() as DomainModuleType }
        Module { NetworkModule(keys: KeyUtil.apiKeys) as NetworkModule }
        Module { DataModule() as DataModuleType }
    }
    
    func initialize() {
        dependencies.build()
        Log.i("build dependencies")
    }
}
