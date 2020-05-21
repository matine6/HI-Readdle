//
//  PersonTests.swift
//  For Readdle by Alex KulyaTests
//
//  Created by Alexandr Kulya on 19.05.2020.
//  Copyright © 2020 Alexandr Kulya. All rights reserved.
//

import XCTest
@testable import For_Readdle_by_Alex_Kulya

class PersonTests: XCTestCase {

    override func setUpWithError() throws {
        super.setUp()
        
    }

    override func tearDownWithError() throws {

        super.tearDown()
    }

    func testInitStatusWithDefaultValues() {
        let online = Person.Status.online
        let offline = Person.Status.offline
        XCTAssertEqual(online.rawValue, 1)
        XCTAssertEqual(offline.rawValue, 0)
    }
    
    func testInitPerson() {
        let person = Person(name: "Foo",
                            avatarUrl: "Bar",
                            email: "Baz",
                            status: .offline,
                            identifireForHero: "Boo")
        XCTAssertNotNil(person)
    }
    
    func testInitPersonWithSetsProperties() {
        let person = Person(name: "Foo",
                            avatarUrl: "Bar",
                            email: "Baz",
                            status: .offline,
                            identifireForHero: "Boo")
        XCTAssertEqual(person.name, "Foo")
        XCTAssertEqual(person.avatarUrl, "Bar")
        XCTAssertEqual(person.email, "Baz")
        XCTAssertEqual(person.status, .offline)
        XCTAssertEqual(person.identifireForHero, "Boo")
        
    }
    
    func testCountOfPersonsInCreatePersonsMethod() {
        let persons = Person.createPersons()
        XCTAssert(persons.count >= 70 && persons.count <= 90)
    }

}
