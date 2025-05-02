class Api::V1::TimeZoneController < ApplicationController
  def convert
    from_time_str = params[:time]
    from_zone     = params[:from_zone]
    to_zone       = params[:to_zone]

    begin
      from_time = ActiveSupport::TimeZone[from_zone].parse(from_time_str)
      converted_time = from_time.in_time_zone(to_zone)

      render json: {
        converted_time: converted_time.strftime("%Y-%m-%d %H:%M:%S %Z")
      }
    rescue => e
      render json: { error: "Invalid input: #{e.message}" }, status: :unprocessable_entity
    end
  end
end
