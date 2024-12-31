import SwiftUI
import Charts

struct ClimateBarChartView: View {
  @State private var selectedCountry: String? = nil
  @State private var chartHeight: CGFloat = 400
  @State private var isShowingLegend: Bool = true
  
  private var sortedCountries: [String] {
    let latest2023Data = Co2Emission.data.filter { $0.year == 2023 }
    return latest2023Data.sorted { $0.co2EmissionsPerCapita > $1.co2EmissionsPerCapita }
      .map { $0.countryName }
  }
  
  private func getEmissionData(for country: String, year: Int) -> Co2Emission? {
    Co2Emission.data.first { $0.countryName == country && $0.year == year }
  }
  
  private var selectedCountryData: (current: Co2Emission?, previous: Co2Emission?)? {
    guard let country = selectedCountry else { return nil }
    let current = getEmissionData(for: country, year: 2023)
    let previous = getEmissionData(for: country, year: 2013)
    return (current, previous)
  }
  
  var body: some View {
    ScrollView {
      VStack(spacing: 16) {
        headerSection
        chartControls
        chartSection
          .frame(height: chartHeight)
          .animation(.easeInOut, value: chartHeight)
        
        if isShowingLegend {
          legendSection
        }
        
        if let (current, _) = selectedCountryData {
          if let current {
            detailsSection(for: current)
          }
        }
      }
      .padding()
    }
    .navigationTitle("CO₂ Emissions Tracker")
  }
  
  private var headerSection: some View {
    VStack(spacing: 8) {
      Text("CO₂ Emissions Per Capita")
        .font(.title2)
        .fontWeight(.bold)
      
      Text("Comparing 2013 vs 2023")
        .font(.subheadline)
        .foregroundColor(.secondary)
    }
  }
  
  private var chartControls: some View {
    HStack {
      Button {
        chartHeight = min(800, chartHeight + 100)
      } label: {
        Label("Increase Size", systemImage: "plus.magnifyingglass")
      }
      
      Button {
        chartHeight = max(200, chartHeight - 100)
      } label: {
        Label("Decrease Size", systemImage: "minus.magnifyingglass")
      }
      
      Spacer()
      
      Toggle(isOn: $isShowingLegend) {
        Text("Legend")
      }
      .toggleStyle(.button)
    }
    .buttonStyle(.bordered)
  }
  
  private var chartSection: some View {
    Chart {
      ForEach(sortedCountries, id: \.self) { country in
        if let data2013 = getEmissionData(for: country, year: 2013),
           let data2023 = getEmissionData(for: country, year: 2023) {
          BarMark(
            x: .value("Country", country),
            y: .value("CO₂ Emissions", data2013.co2EmissionsPerCapita)
          )
          .foregroundStyle(.blue.opacity(0.7))
          .opacity(selectedCountry == country || selectedCountry == nil ? 1.0 : 0.5)
          
          BarMark(
            x: .value("Country", country),
            y: .value("CO₂ Emissions", data2023.co2EmissionsPerCapita)
          )
          .foregroundStyle(.red.opacity(0.7))
          .opacity(selectedCountry == country || selectedCountry == nil ? 1.0 : 0.5)
        }
      }
      
      if let selectedCountry {
        RuleMark(x: .value("Country", selectedCountry))
          .foregroundStyle(.secondary.opacity(0.3))
          .annotation(position: .top) {
            selectionAnnotation(for: selectedCountry)
          }
      }
    }
    .chartForegroundStyleScale([
      "2013": Color.blue.opacity(0.7),
      "2023": Color.red.opacity(0.7)
    ])
    .chartXAxis {
      AxisMarks(values: .automatic) { value in
        AxisGridLine()
        AxisValueLabel(centered: true) {
          if let country = value.as(String.self) {
            Text(country)
              .font(.footnote)
              .offset(y: 10)
          }
        }
      }
    }
    .chartYAxis {
      AxisMarks(position: .leading) { value in
        AxisGridLine()
        AxisValueLabel {
          if let emission = value.as(Double.self) {
            Text(String(format: "%.1f", emission))
          }
        }
      }
    }
    .chartXSelection(value: $selectedCountry)
    .chartPlotStyle { plot in
      plot
        .background(.gray.opacity(0.1))
        .border(.gray.opacity(0.2))
    }
  }
  
  private var legendSection: some View {
    HStack(spacing: 20) {
      legendItem(color: .blue.opacity(0.7), text: "2013")
      legendItem(color: .red.opacity(0.7), text: "2023")
    }
    .padding(.vertical)
  }
  
  private func legendItem(color: Color, text: String) -> some View {
    Label(
      title: { Text(text).font(.caption) },
      icon: { Circle().fill(color).frame(width: 12, height: 12) }
    )
  }
  
  private func selectionAnnotation(for country: String) -> some View {
    VStack(spacing: 5) {
      Text(country)
        .font(.headline)
      
      if let (current, previous) = selectedCountryData, let current {
        HStack(spacing: 12) {
          VStack(alignment: .leading) {
            Text("2023:")
              .font(.caption)
              .foregroundColor(.secondary)
            Text(String(format: "%.1f", current.co2EmissionsPerCapita))
              .font(.subheadline)
              .foregroundColor(.red)
          }
          
          VStack(alignment: .leading) {
            Text("2013:")
              .font(.caption)
              .foregroundColor(.secondary)
            Text(String(format: "%.1f", previous?.co2EmissionsPerCapita ?? ""))
              .font(.subheadline)
              .foregroundColor(.blue)
          }
        }
      }
    }
    .padding(8)
    .background(
      RoundedRectangle(cornerRadius: 10)
        .fill(Color(uiColor: .systemBackground))
        .shadow(radius: 5)
    )
  }
  
  private func detailsSection(for emission: Co2Emission) -> some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("Details for \(emission.countryName)")
        .font(.headline)
      
      VStack(alignment: .leading, spacing: 8) {
        detailRow(
          title: "2023 Emissions:",
          value: String(format: "%.2f kg CO₂", emission.co2EmissionsPerCapita)
        )
        
        if let change = emission.change {
          let color: Color = change < 0 ? .green : .red
          detailRow(
            title: "Change since 2013:",
            value: String(format: "%+.1f%%", change),
            valueColor: color
          )
        }
        
        if let previous = getEmissionData(for: emission.countryName, year: 2013) {
          detailRow(
            title: "2013 Emissions:",
            value: String(format: "%.2f kg CO₂", previous.co2EmissionsPerCapita)
          )
        }
      }
      .padding()
      .background(Color(uiColor: .systemBackground))
      .cornerRadius(10)
      .shadow(radius: 2)
    }
  }
  
  private func detailRow(title: String, value: String, valueColor: Color = .primary) -> some View {
    HStack {
      Text(title)
        .foregroundColor(.secondary)
      Spacer()
      Text(value)
        .foregroundColor(valueColor)
        .fontWeight(.medium)
    }
  }
}

#Preview {
  NavigationView {
    ClimateBarChartView()
  }
}
