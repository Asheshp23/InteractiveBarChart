//
//  Co2Emission.swift
//  InteractiveBarChart
//
//  Created by Ashesh Patel on 2024-12-30.
//
import Foundation

struct Co2Emission: Identifiable {
  let id = UUID()
  let countryName: String
  let co2EmissionsPerCapita: Double
  
  static let data: [Co2Emission] = [
    .init(countryName: "USA", co2EmissionsPerCapita: 16.5),
    .init(countryName: "India", co2EmissionsPerCapita: 1.8),
    .init(countryName: "China", co2EmissionsPerCapita: 8.2),
    .init(countryName: "EU", co2EmissionsPerCapita: 6.8),
    .init(countryName: "World avg", co2EmissionsPerCapita: 4.5)
  ]
}
