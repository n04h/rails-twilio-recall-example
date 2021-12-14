module TwilioApi
  class CallbacksController < ApplicationController
    def create
      if need_recall?
        call_resource.recall!(client: client)
      else
        call_resource.destroy!
      end
    end

    private

    def client
      Twilio::REST::Client.new(ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"])
    end

    def call_resource
      TwilioCallResource.find_by!(call_sid: params[:CallSid])
    end

    def need_recall?
      %w[completed busy failed no-answer].include?(params[:CallStatus])
    end
  end
end
