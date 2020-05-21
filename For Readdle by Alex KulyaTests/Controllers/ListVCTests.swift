//
//  ListVCTests.swift
//  For Readdle by Alex KulyaTests
//
//  Created by Alexandr Kulya on 20.05.2020.
//  Copyright © 2020 Alexandr Kulya. All rights reserved.
//

import XCTest
@testable import For_Readdle_by_Alex_Kulya

class ListVCTests: XCTestCase {

    override func setUpWithError() throws {
        super.setUp()
        
    }

    override func tearDownWithError() throws {
        
        super.tearDown()
    }


    func testWhenViewIsLoadedTableViewIsNotNil() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyBoard.instantiateViewController(withIdentifier: "TableController") as! TableController
        sut.loadViewIfNeeded()
        XCTAssertNotNil(sut.tableView)
    }


}
