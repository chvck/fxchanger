module FxchangerHarvest
  class EcbSourceConverter < DataSourceConverter

    def convert(data)
      data_source = data["Envelope"]["Sender"]["name"]

      ecb_rates = []
      data["Envelope"]["Cube"]["Cube"].each do |date_rate|
        time = date_rate["time"]
        date_rate["Cube"].each do |rate|
          ecb_rates << Rate.new(rate["rate"], rate["currency"], time, data_source)
        end
      end

      ecb_rates
    end
  end
end
