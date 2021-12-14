class TwilioCallResource < ApplicationRecord
  class << self
    def call!(client:, **call_options)
      resource = client.calls.create(**call_options)
      create!(
        call_sid: resource.sid,
        call_options_json: call_options.to_json
      )
    end
  end

  def call_options
    JSON.parse(call_options_json).symbolize_keys
  end

  def can_recall?
    called_count < 3
  end

  def recall!(client:)
    raise "リコールできません" if can_recall?

    resource = client.calls.create(**call_options)
    update!(
      call_sid: resource.sid,
      called_count: called_count + 1
    )
  end
end
