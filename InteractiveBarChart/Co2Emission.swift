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
  let year: Int
  let change: Double?
  
  static let data: [Co2Emission] = [
    .init(countryName: "Palau", co2EmissionsPerCapita: 62.59, year: 2023, change: -43.0),
    .init(countryName: "Palau", co2EmissionsPerCapita: 66.86, year: 2013, change: nil),
    .init(countryName: "Qatar", co2EmissionsPerCapita: 43.55, year: 2023, change: -19.0),
    .init(countryName: "Qatar", co2EmissionsPerCapita: 45.42, year: 2013, change: nil),
    .init(countryName: "Kuwait", co2EmissionsPerCapita: 24.90, year: 2023, change: -6.0),
    .init(countryName: "Kuwait", co2EmissionsPerCapita: 28.13, year: 2013, change: nil),
    .init(countryName: "Brunei", co2EmissionsPerCapita: 21.12, year: 2023, change: 16.0),
    .init(countryName: "Brunei", co2EmissionsPerCapita: 18.90, year: 2013, change: nil),
    .init(countryName: "New Caledonia", co2EmissionsPerCapita: 20.90, year: 2023, change: 105.0),
    .init(countryName: "New Caledonia", co2EmissionsPerCapita: 16.58, year: 2013, change: nil),
    .init(countryName: "Bahrain", co2EmissionsPerCapita: 20.70, year: 2023, change: -23.0),
    .init(countryName: "Bahrain", co2EmissionsPerCapita: 23.45, year: 2013, change: nil),
    .init(countryName: "United Arab Emirates", co2EmissionsPerCapita: 20.22, year: 2023, change: -28.0),
    .init(countryName: "United Arab Emirates", co2EmissionsPerCapita: 23.30, year: 2013, change: nil),
    .init(countryName: "Trinidad and Tobago", co2EmissionsPerCapita: 19.71, year: 2023, change: 31.0),
    .init(countryName: "Trinidad and Tobago", co2EmissionsPerCapita: 16.98, year: 2013, change: nil),
    .init(countryName: "Canada", co2EmissionsPerCapita: 14.91, year: 2023, change: nil),
    .init(countryName: "Canada", co2EmissionsPerCapita: 15.93, year: 2013, change: nil),
    .init(countryName: "USA", co2EmissionsPerCapita: 14.9, year: 2023, change: nil),
    .init(countryName: "USA", co2EmissionsPerCapita: 16.34, year: 2013, change: nil),
    .init(countryName: "Russia", co2EmissionsPerCapita: 14.45, year: 2023, change: nil),
    .init(countryName: "Russia", co2EmissionsPerCapita: 12.50, year: 2013, change: nil),
    .init(countryName: "Australia", co2EmissionsPerCapita: 15.1, year: 2023, change: nil),
    .init(countryName: "Australia", co2EmissionsPerCapita: 16.34, year: 2013, change: nil),
    .init(countryName: "China", co2EmissionsPerCapita: 8.89, year: 2023, change: nil),
    .init(countryName: "China", co2EmissionsPerCapita: 7.25, year: 2013, change: nil),
    .init(countryName: "EU", co2EmissionsPerCapita: 5.66, year: 2023, change: -32.0),
    .init(countryName: "EU", co2EmissionsPerCapita: 7.31, year: 2013, change: nil),
    .init(countryName: "India", co2EmissionsPerCapita: 1.89, year: 2023, change: nil),
    .init(countryName: "India", co2EmissionsPerCapita: 1.59, year: 2013, change: nil)
  ]
}
