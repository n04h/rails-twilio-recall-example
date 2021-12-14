module TwilioApi
  class CallsController < ApplicationController
    def create
      TwilioCallResource.call!(client: client, **call_options)
    end

    private

    def client
      Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
    end

    def call_options
      {
        twiml: '<Response><Say>Hello world!</Say></Response>',
        status_callback: status_callback_url,
        status_callback_event: ['answered', 'completed'],
        status_callback_method: 'POST',
        from: '+8105012345678',
        to: '+8109012345678',
        timeout: 30 # デフォルトは60秒なので2回コールされてしまうのを防ぐ
      }
    end

    def status_callback_url
      "#{ENV["HOST_URL"]}/twilio_api/callback"
    end
  end
end
