module Api
  module V1
    class TimeZoneController < ApplicationController
      def convert
        time_param = params[:time]
        from_zone_param = params[:from_zone]
        to_zone_param = params[:to_zone]
      
        Rails.logger.debug "Received params: time=#{time_param}, from_zone=#{from_zone_param}, to_zone=#{to_zone_param}"
      
        from_zone = ActiveSupport::TimeZone[from_zone_param]
        to_zone = ActiveSupport::TimeZone[to_zone_param]
      
        if from_zone.nil? || to_zone.nil?
          render json: { error: "Invalid time zone(s)" }, status: :bad_request and return
        end
      
        begin
          time = Time.parse(time_param)
          converted_time = time.in_time_zone(from_zone).in_time_zone(to_zone)
          render json: { converted_time: converted_time.strftime('%Y-%m-%d %H:%M:%S %Z') }
        rescue => e
          Rails.logger.error "Time conversion error: #{e.message}"
          render json: { error: "Time conversion failed" }, status: :internal_server_error
        end
      end
    end 
  end
end
