# app/controllers/api/v1/time_converter_controller.rb
class Api::V1::TimeConverterController < ApplicationController
  # POST or GET request depending on your needs
  def convert_time
    # Parameters: time, from_zone, to_zone
    time_string = params[:time]
    from_zone = params[:from_zone]
    to_zone = params[:to_zone]

    # Ensure time, from_zone, and to_zone are provided
    if time_string.blank? || from_zone.blank? || to_zone.blank?
      render json: { error: 'Please provide all required parameters: time, from_zone, to_zone' }, status: :bad_request
      return
    end

    # Parse the time string to a valid Time object
    begin
      time = Time.zone.parse(time_string)
    rescue ArgumentError => e
      render json: { error: 'Invalid time format. Please use YYYY-MM-DD HH:MM' }, status: :bad_request
      return
    end

    # Convert to the from_zone time zone
    from_time_zone = ActiveSupport::TimeZone[from_zone]
    to_time_zone = ActiveSupport::TimeZone[to_zone]

    if from_time_zone.nil? || to_time_zone.nil?
      render json: { error: 'Invalid time zone provided' }, status: :bad_request
      return
    end

    # Convert the time to the "from_zone" time zone and then to the "to_zone" time zone
    converted_time = from_time_zone.local_time(time).in_time_zone(to_time_zone)

    # Return the converted time
    render json: { converted_time: converted_time.strftime('%Y-%m-%d %H:%M') }
  end
end