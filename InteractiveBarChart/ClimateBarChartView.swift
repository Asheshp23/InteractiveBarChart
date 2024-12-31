//
//  ClimateBarChartView.swift
//  InteractiveBarChart
//
//  Created by Ashesh Patel on 2024-12-30.
//
import SwiftUI
import Charts

struct ClimateBarChartView: View {
  @State private var selectedCountry: String? = nil
  @State private var showDetails: Bool = false
  var emissionValue: Double? { Co2Emission.data.first(where: { $0.countryName == selectedCountry })?.co2EmissionsPerCapita }
  
  var body: some View {
    ZStack {
      VStack {
        Text("CO₂ Emissions Per Capita (2021)")
          .font(.title)
          .padding(.all)
        Chart {
          if let selectedCountry {
            RuleMark(x: .value("Country name", selectedCountry))
              .foregroundStyle(.secondary.opacity(0.3))
              .annotation(position: .top, overflowResolution: .init(x: .fit(to: .chart), y: .disabled)) {
                VStack(spacing: 5) {
                  Text(selectedCountry)
                    .font(.headline)
                    .foregroundColor(.primary)
                  if let emissionValue {
                    Text("\(emissionValue, specifier: "%.2f") tons")
                      .font(.subheadline)
                      .foregroundColor(.secondary)
                  } else {
                    Text("No data")
                      .font(.subheadline)
                      .foregroundColor(.gray)
                  }
                }
                .padding(8)
                .background(
                  RoundedRectangle(cornerRadius: 10)
                    .fill(Color(.systemBackground))
                    .shadow(radius: 5)
                )
              }
          }

          ForEach(Co2Emission.data) { item in
            BarMark(x: .value("Country name", item.countryName), y: .value("CO2 emissions", item.co2EmissionsPerCapita))
              .foregroundStyle(item.co2EmissionsPerCapita > 10 ? Color.red : Color.green)
              .opacity(selectedCountry == item.countryName || selectedCountry == nil ? 1.0 : 0.5)
          }
        }
        .chartXScale(domain: Co2Emission.data.map { $0.countryName })
        .chartXSelection(value: $selectedCountry.animation(.easeInOut))
        .padding(.bottom)
        
        HStack {
          RoundedRectangle(cornerRadius: 5)
            .fill(Color.red)
            .frame(width: 20, height: 20)
          Text("High Emissions (> 10 tons)")
            .font(.caption)
          RoundedRectangle(cornerRadius: 5)
            .fill(Color.green)
            .frame(width: 20, height: 20)
          Text("Low Emissions")
            .font(.caption)
        }
        .padding(.top)
      }
    }
    .padding()
  }
}

#Preview {
  ClimateBarChartView()
}
